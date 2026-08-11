using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Diagnostics;

[NativeHeader("Runtime/Export/Diagnostics/DiagnosticsUtils.bindings.h")]
public static class Utils
{
	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("DiagnosticsUtils_Bindings::ForceCrash", ThrowsException = true)]
	public static extern void ForceCrash(ForcedCrashCategory crashCategory);
}
