using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/ColorGamut.h")]
[UsedByNativeCode]
public enum ColorPrimaries
{
	Unknown = -1,
	Rec709,
	Rec2020,
	P3
}
