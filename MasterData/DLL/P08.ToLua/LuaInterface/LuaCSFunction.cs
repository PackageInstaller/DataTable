using System;
using System.Runtime.InteropServices;

namespace LuaInterface;

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate int LuaCSFunction(IntPtr luaState);
