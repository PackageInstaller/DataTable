using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/GfxDevice/GfxDeviceTypes.h")]
public enum CompareFunction
{
	Disabled,
	Never,
	Less,
	Equal,
	LessEqual,
	Greater,
	NotEqual,
	GreaterEqual,
	Always
}
