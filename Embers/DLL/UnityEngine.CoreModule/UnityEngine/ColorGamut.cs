using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/ColorGamut.h")]
[UsedByNativeCode]
public enum ColorGamut
{
	sRGB,
	Rec709,
	Rec2020,
	DisplayP3,
	HDR10,
	DolbyHDR
}
