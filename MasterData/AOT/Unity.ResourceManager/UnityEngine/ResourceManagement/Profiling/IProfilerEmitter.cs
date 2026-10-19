using System;

namespace UnityEngine.ResourceManagement.Profiling;

internal interface IProfilerEmitter
{
	bool IsEnabled { get; }

	void EmitFrameMetaData(Guid id, int tag, Array data);

	void InitialiseCallbacks(Action<float> onLateUpdateDelegate);
}
