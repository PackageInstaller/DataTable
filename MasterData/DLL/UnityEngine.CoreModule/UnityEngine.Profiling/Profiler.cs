using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Profiling;

[NativeHeader("Runtime/Profiler/ScriptBindings/Profiler.bindings.h")]
[NativeHeader("Runtime/Profiler/MemoryProfiler.h")]
[NativeHeader("Runtime/Allocator/MemoryManager.h")]
[MovedFrom("UnityEngine")]
[UsedByNativeCode]
[NativeHeader("Runtime/Utilities/MemoryUtilities.h")]
[NativeHeader("Runtime/ScriptingBackend/ScriptingApi.h")]
[NativeHeader("Runtime/Profiler/Profiler.h")]
public sealed class Profiler
{
	[MethodImpl((MethodImplOptions)256)]
	[Conditional("ENABLE_PROFILER")]
	public static void BeginSample(string name)
	{
		ValidateArguments(name);
		BeginSampleImpl(name, null);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void ValidateArguments(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			throw new ArgumentException("Argument should be a valid string.", "name");
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "ProfilerBindings::BeginSample", IsFreeFunction = true, IsThreadSafe = true)]
	private static extern void BeginSampleImpl(string name, Object targetObject);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "ProfilerBindings::EndSample", IsFreeFunction = true, IsThreadSafe = true)]
	[Conditional("ENABLE_PROFILER")]
	public static extern void EndSample();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "ProfilerBindings::GetRuntimeMemorySizeLong", IsFreeFunction = true)]
	public static extern long GetRuntimeMemorySizeLong([NotNull("ArgumentNullException")] Object o);
}
