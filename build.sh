# sdk build

mkdir -p ~/devel/aws-sdk-cpp-install
cd /tmp
git clone --depth=1 https://github.com/aws/aws-sdk-cpp.git
cd aws-sdk-cpp
mkdir build
cd build
cmake .. -DBUILD_ONLY="s3" \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=OFF \
  -DCUSTOM_MEMORY_MANAGEMENT=OFF \
  -DCMAKE_INSTALL_PREFIX=~/devel/aws-sdk-cpp-install \
  -DENABLE_UNITY_BUILD=ON

make
make install

# build runtime
cd /tmp
git clone --depth=1 https://github.com/awslabs/aws-lambda-cpp-runtime.git
cd aws-lambda-cpp-runtime
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=OFF \
  -DCMAKE_INSTALL_PREFIX=~/devel/aws-sdk-cpp-install
make
make install

return;

# build application
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=~/devel/aws-sdk-cpp-install
make
make aws-lambda-package-encoder