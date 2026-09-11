using System;

namespace UnityEngine.Rendering;

[Flags]
public enum RTClearFlags
{
	None = 0,
	Color = 1,
	Depth = 2,
	Stencil = 4,
	All = Color | Depth | Stencil,
	DepthStencil = 6,
	ColorDepth = 3,
	ColorStencil = 5
}
