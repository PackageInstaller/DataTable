using System.Diagnostics;
using UnityEngine.Scripting;

namespace Unity.Profiling;

[UsedByNativeCode]
[DebuggerDisplay("Value = {Value}; Count = {Count}")]
public struct ProfilerRecorderSample
{
	private long value;

	private long count;

	private long refValue;

	public long Count => count;
}
