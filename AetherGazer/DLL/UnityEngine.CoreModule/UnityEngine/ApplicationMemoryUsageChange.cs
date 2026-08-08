using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace UnityEngine;

public struct ApplicationMemoryUsageChange
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private ApplicationMemoryUsage _003CmemoryUsage_003Ek__BackingField;

	private ApplicationMemoryUsage memoryUsage
	{
		[CompilerGenerated]
		set
		{
			_003CmemoryUsage_003Ek__BackingField = value;
		}
	}

	public ApplicationMemoryUsageChange(ApplicationMemoryUsage usage)
	{
		memoryUsage = usage;
	}
}
