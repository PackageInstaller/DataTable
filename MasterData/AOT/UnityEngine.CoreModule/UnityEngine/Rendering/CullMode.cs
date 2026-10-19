using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/GfxDevice/GfxDeviceTypes.h")]
public enum CullMode
{
	Off,
	Front,
	Back
}
