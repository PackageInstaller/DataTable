using System;

namespace UnityEngine;

[Flags]
public enum DepthTextureMode
{
	None = 0,
	Depth = 1,
	DepthNormals = 2,
	MotionVectors = 4
}
