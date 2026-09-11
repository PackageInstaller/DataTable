using System;

namespace Unity.Profiling.LowLevel;

[Flags]
public enum MarkerFlags : ushort
{
	Default = 0,
	Script = 2,
	ScriptInvoke = 0x20,
	ScriptDeepProfiler = 0x40,
	AvailabilityEditor = 4,
	AvailabilityNonDevelopment = 8,
	Warning = 0x10,
	Counter = 0x80,
	SampleGPU = 0x100
}
