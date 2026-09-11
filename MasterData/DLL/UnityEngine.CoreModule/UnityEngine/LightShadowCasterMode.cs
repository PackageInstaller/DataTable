using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Camera/SharedLightData.h")]
public enum LightShadowCasterMode
{
	Default,
	NonLightmappedOnly,
	Everything
}
