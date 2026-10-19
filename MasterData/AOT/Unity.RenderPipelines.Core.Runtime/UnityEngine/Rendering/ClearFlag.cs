using System;

namespace UnityEngine.Rendering;

[Flags]
public enum ClearFlag
{
	None = 0,
	Color = 1,
	Depth = 2,
	Stencil = 4,
	DepthStencil = Depth | Stencil,
	ColorStencil = Color | Stencil,
	All = DepthStencil | Color
}
