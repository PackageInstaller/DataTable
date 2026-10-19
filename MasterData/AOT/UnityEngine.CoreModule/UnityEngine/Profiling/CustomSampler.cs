using System;
using System.Diagnostics;
using Unity.Profiling;
using Unity.Profiling.LowLevel;
using Unity.Profiling.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Profiling;

[UsedByNativeCode]
[NativeHeader("Runtime/Profiler/Marker.h")]
[NativeHeader("Runtime/Profiler/ScriptBindings/Sampler.bindings.h")]
public sealed class CustomSampler : Sampler
{
	internal static CustomSampler s_InvalidCustomSampler = new CustomSampler();

	internal CustomSampler()
	{
	}

	internal CustomSampler(IntPtr ptr)
	{
		m_Ptr = ptr;
	}

	public static CustomSampler Create(string name, bool collectGpuData = false)
	{
		IntPtr intPtr = ProfilerUnsafeUtility.CreateMarker(name, 1, (MarkerFlags)(8 | (collectGpuData ? 256 : 0)), 0);
		if (intPtr == IntPtr.Zero)
		{
			return s_InvalidCustomSampler;
		}
		return new CustomSampler(intPtr);
	}

	[IgnoredByDeepProfiler]
	[Conditional("ENABLE_PROFILER")]
	public void Begin()
	{
		ProfilerUnsafeUtility.BeginSample(m_Ptr);
	}

	[Conditional("ENABLE_PROFILER")]
	[IgnoredByDeepProfiler]
	public void Begin(Object targetObject)
	{
		ProfilerUnsafeUtility.Internal_BeginWithObject(m_Ptr, targetObject);
	}

	[Conditional("ENABLE_PROFILER")]
	[IgnoredByDeepProfiler]
	public void End()
	{
		ProfilerUnsafeUtility.EndSample(m_Ptr);
	}
}
