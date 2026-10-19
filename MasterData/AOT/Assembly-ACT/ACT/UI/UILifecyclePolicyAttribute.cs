using System;

namespace ACT.UI;

[AttributeUsage(AttributeTargets.Class, Inherited = false, AllowMultiple = false)]
public sealed class UILifecyclePolicyAttribute : Attribute
{
	public DeviceMemoryTier MemoryMinimumLevel { get; }

	public UILifetimePolicy LifetimePolicy { get; }

	public UILifecyclePolicyAttribute(DeviceMemoryTier memoryMinimumLevel, UILifetimePolicy policy)
	{
		MemoryMinimumLevel = memoryMinimumLevel;
		LifetimePolicy = policy;
	}

	public bool CanExecute(int deviceMemoryMb)
	{
		if (MemoryMinimumLevel != DeviceMemoryTier.Always)
		{
			return deviceMemoryMb <= (int)MemoryMinimumLevel;
		}
		return true;
	}
}
