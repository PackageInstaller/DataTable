using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Profiling;

[NativeHeader("Runtime/ScriptingBackend/ScriptingApi.h")]
[UsedByNativeCode]
[NativeHeader("Runtime/Utilities/MemoryUtilities.h")]
[NativeHeader("Runtime/Allocator/MemoryManager.h")]
[MovedFrom("UnityEngine")]
[NativeHeader("Runtime/Profiler/Profiler.h")]
[NativeHeader("Runtime/Profiler/ScriptBindings/Profiler.bindings.h")]
public sealed class Profiler
{
	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "ProfilerBindings::GetRuntimeMemorySizeLong", IsFreeFunction = true)]
	public static extern long GetRuntimeMemorySizeLong([NotNull("ArgumentNullException")] Object o);
}
