using System;
using System.Runtime.InteropServices;

namespace Lockstep.Core;

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
public delegate int KcpOutput(IntPtr buf, int len, IntPtr kcp, IntPtr user);
