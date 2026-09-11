using System;

namespace UnityEngine;

[Flags]
public enum HDRDisplaySupportFlags
{
	None = 0,
	Supported = 1,
	RuntimeSwitchable = 2,
	AutomaticTonemapping = 4
}
