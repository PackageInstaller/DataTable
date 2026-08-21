using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/GfxDevice/GfxDeviceTypes.h")]
public enum BlendMode
{
	Zero,
	One,
	DstColor,
	SrcColor,
	OneMinusDstColor,
	SrcAlpha,
	OneMinusSrcColor,
	DstAlpha,
	OneMinusDstAlpha,
	SrcAlphaSaturate,
	OneMinusSrcAlpha
}
