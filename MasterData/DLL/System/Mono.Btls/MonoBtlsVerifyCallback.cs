using System.Runtime.InteropServices;

namespace Mono.Btls;

[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
internal delegate int MonoBtlsVerifyCallback(MonoBtlsX509StoreCtx ctx);
