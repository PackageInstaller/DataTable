using System;
using System.Runtime.InteropServices;

namespace Lockstep.Core;

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate void KcpLog(IntPtr buf, int len, IntPtr kcp, IntPtr user);
