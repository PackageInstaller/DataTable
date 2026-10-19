using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[NativeHeader("Runtime/Graphics/ColorGamut.h")]
public enum ColorGamut
{
	sRGB,
	Rec709,
	Rec2020,
	DisplayP3,
	HDR10,
	DolbyHDR,
	P3D65G22
}
