using System;

namespace UnityEngine.InputSystem;

public enum InputDeviceChange
{
	Added,
	Removed,
	Disconnected,
	Reconnected,
	Enabled,
	Disabled,
	UsageChanged,
	ConfigurationChanged,
	SoftReset,
	HardReset,
	[Obsolete("Destroyed enum has been deprecated.")]
	Destroyed
}
