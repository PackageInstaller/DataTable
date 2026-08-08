using System.Runtime.InteropServices;

namespace Mono.Btls;

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
internal delegate int MonoBtlsSelectCallback(string[] acceptableIssuers);
