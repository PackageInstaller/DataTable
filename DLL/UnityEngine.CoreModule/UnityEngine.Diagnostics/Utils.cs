using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Diagnostics;

[NativeHeader("Runtime/Misc/GarbageCollectSharedAssets.h")]
[NativeHeader("Runtime/Export/Diagnostics/DiagnosticsUtils.bindings.h")]
public static class Utils
{
	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("DiagnosticsUtils_Bindings::ForceCrash", IsThreadSafe = true, ThrowsException = true)]
	public static extern void ForceCrash(ForcedCrashCategory crashCategory);
}
