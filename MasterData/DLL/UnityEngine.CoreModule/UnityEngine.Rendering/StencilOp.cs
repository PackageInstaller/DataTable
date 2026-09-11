using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/GfxDevice/GfxDeviceTypes.h")]
public enum StencilOp
{
	Keep,
	Zero,
	Replace,
	IncrementSaturate,
	DecrementSaturate,
	Invert,
	IncrementWrap,
	DecrementWrap
}
