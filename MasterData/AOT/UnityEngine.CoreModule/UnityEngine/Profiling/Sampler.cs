using System;
using Unity.Profiling.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Profiling;

[NativeHeader("Runtime/Profiler/ScriptBindings/Sampler.bindings.h")]
[UsedByNativeCode]
public class Sampler
{
	internal IntPtr m_Ptr;

	internal static Sampler s_InvalidSampler = new Sampler();

	public bool isValid => m_Ptr != IntPtr.Zero;

	internal Sampler()
	{
	}

	public Recorder GetRecorder()
	{
		ProfilerRecorderHandle handle = new ProfilerRecorderHandle((ulong)m_Ptr.ToInt64());
		return new Recorder(handle);
	}
}
