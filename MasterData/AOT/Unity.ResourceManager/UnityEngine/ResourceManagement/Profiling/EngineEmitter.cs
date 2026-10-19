using System;
using UnityEngine.Profiling;
using UnityEngine.ResourceManagement.Util;

namespace UnityEngine.ResourceManagement.Profiling;

public class EngineEmitter : IProfilerEmitter
{
	public bool IsEnabled => Profiler.enabled;

	public void EmitFrameMetaData(Guid id, int tag, Array data)
	{
	}

	public void InitialiseCallbacks(Action<float> d)
	{
		ComponentSingleton<MonoBehaviourCallbackHooks>.Instance.OnLateUpdateDelegate += d;
	}
}
