using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[NativeHeader("Runtime/Graphics/ColorGamut.h")]
public enum TransferFunction
{
	Unknown = -1,
	sRGB,
	BT1886,
	PQ,
	Linear,
	Gamma22
}
