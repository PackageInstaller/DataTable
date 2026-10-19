using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Diagnostics;

[NativeHeader("Runtime/Export/Diagnostics/DiagnosticsUtils.bindings.h")]
[NativeHeader("Runtime/Misc/GarbageCollectSharedAssets.h")]
public static class Utils
{
	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("DiagnosticsUtils_Bindings::ForceCrash", IsThreadSafe = true, ThrowsException = true)]
	public static extern void ForceCrash(ForcedCrashCategory crashCategory);
}
