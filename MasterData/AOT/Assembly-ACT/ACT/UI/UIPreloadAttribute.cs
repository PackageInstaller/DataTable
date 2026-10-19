using System;

namespace ACT.UI;

[AttributeUsage(AttributeTargets.Class, Inherited = false, AllowMultiple = false)]
public sealed class UIPreloadAttribute : Attribute
{
	public DeviceMemoryTier MemoryMinimumLevel { get; }

	public UIPreloadAttribute(DeviceMemoryTier memoryMinimumLevel)
	{
		MemoryMinimumLevel = memoryMinimumLevel;
	}

	public bool CanPreload(int deviceMemoryMb)
	{
		return MemoryMinimumLevel == DeviceMemoryTier.Always;
	}
}
