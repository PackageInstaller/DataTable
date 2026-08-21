using System;

namespace Unity.Profiling;

[Flags]
public enum ProfilerRecorderOptions
{
	None = 0,
	StartImmediately = 1,
	KeepAliveDuringDomainReload = 2,
	CollectOnlyOnCurrentThread = 4,
	WrapAroundWhenCapacityReached = 8,
	SumAllSamplesInFrame = 0x10,
	GpuRecorder = 0x40,
	Default = WrapAroundWhenCapacityReached | SumAllSamplesInFrame
}
