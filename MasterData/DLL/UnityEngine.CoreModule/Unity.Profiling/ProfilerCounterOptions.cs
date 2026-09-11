using System;

namespace Unity.Profiling;

[Flags]
public enum ProfilerCounterOptions : ushort
{
	None = 0,
	FlushOnEndOfFrame = 2,
	ResetToZeroOnFlush = 4
}
