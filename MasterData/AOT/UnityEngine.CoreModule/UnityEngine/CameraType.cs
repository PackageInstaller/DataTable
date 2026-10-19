using System;

namespace UnityEngine;

[Flags]
public enum CameraType
{
	Game = 1,
	SceneView = 2,
	Preview = 4,
	VR = 8,
	Reflection = 0x10
}
