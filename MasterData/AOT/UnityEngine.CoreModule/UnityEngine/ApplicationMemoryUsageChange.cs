namespace UnityEngine;

public struct ApplicationMemoryUsageChange
{
	private ApplicationMemoryUsage memoryUsage { set; }

	public ApplicationMemoryUsageChange(ApplicationMemoryUsage usage)
	{
		memoryUsage = usage;
	}
}
