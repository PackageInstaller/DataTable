using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace Unity.IO.LowLevel.Unsafe;

[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode]
[NativeAsStruct]
[NativeConditional("ENABLE_PROFILER")]
public class AsyncReadManagerMetricsFilters
{
	[NativeName("typeIDs")]
	internal ulong[] TypeIDs;

	[NativeName("states")]
	internal ProcessingState[] States;

	[NativeName("readTypes")]
	internal FileReadType[] ReadTypes;

	[NativeName("priorityLevels")]
	internal Priority[] PriorityLevels;

	[NativeName("subsystems")]
	internal AssetLoadingSubsystem[] Subsystems;
}
