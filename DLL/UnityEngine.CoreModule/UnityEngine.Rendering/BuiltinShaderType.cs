using System;

namespace UnityEngine.Rendering;

public enum BuiltinShaderType
{
	DeferredShading,
	DeferredReflections,
	[Obsolete("LegacyDeferredLighting has been removed.", false)]
	LegacyDeferredLighting,
	ScreenSpaceShadows,
	DepthNormals,
	MotionVectors,
	LightHalo,
	LensFlare
}
