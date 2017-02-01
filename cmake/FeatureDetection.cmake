include(CheckCXXSourceCompiles)
include(CheckFunctionExists)

set(TMP_FLAGS ${CMAKE_REQUIRED_FLAGS})
if (UNIX)
    set(CMAKE_REQUIRED_FLAGS "${CMAKE_REQUIRED_FLAGS} -std=c++11")
endif ()

CHECK_CXX_SOURCE_COMPILES("int main() { thread_local int a = 0; return a; }" HAS_THREAD_LOCAL)
if (HAS_THREAD_LOCAL})
    add_definitions(-DHAS_THREAD_LOCAL)
endif ()
set(CMAKE_REQUIRED_FLAGS ${TMP_FLAGS})

CHECK_FUNCTION_EXISTS(openat HAS_OPENAT)
CHECK_FUNCTION_EXISTS(unlinkat HAS_UNLINKAT)
CHECK_FUNCTION_EXISTS(mkdirat HAS_MKDIRAT)
CHECK_FUNCTION_EXISTS(renameat HAS_RENAMEAT)
CHECK_FUNCTION_EXISTS(fstatat HAS_FSTATAT)
CHECK_FUNCTION_EXISTS(fchmodat HAS_FCHMODAT)
CHECK_FUNCTION_EXISTS(futimens HAS_FUTIMENS)
CHECK_FUNCTION_EXISTS(clock_gettime HAS_CLOCK_GETTIME)

if (HAS_OPENAT AND HAS_UNLINKAT AND HAS_MKDIRAT AND HAS_RENAMEAT AND HAS_FSTATAT AND HAS_FCHMODAT)
    add_definitions(-DHAS_AT_FUNCTIONS)
endif ()

if (HAS_FUTIMENS)
    add_definitions(-DHAS_FUTIMENS)
endif ()

if (HAS_CLOCK_GETTIME)
    add_definitions(-DHAS_CLOCK_GETTIME)
endif ()
