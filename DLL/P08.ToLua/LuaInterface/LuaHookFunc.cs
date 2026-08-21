using System;
using System.Runtime.InteropServices;

namespace LuaInterface;

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate void LuaHookFunc(IntPtr L, ref Lua_Debug ar);
