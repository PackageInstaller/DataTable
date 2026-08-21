using System;

namespace UnityEngine.InputSystem.LowLevel;

[Flags]
public enum InputUpdateType
{
	None = 0,
	Dynamic = 1,
	Fixed = 2,
	BeforeRender = 4,
	Editor = 8,
	Manual = 0x10,
	Default = Dynamic | Fixed | Editor
}
