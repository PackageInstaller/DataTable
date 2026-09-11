using System;

namespace UnityEngine.Rendering;

[Flags]
public enum CullingOptions
{
	None = 0,
	ForceEvenIfCameraIsNotActive = 1,
	OcclusionCull = 2,
	NeedsLighting = 4,
	NeedsReflectionProbes = 8,
	Stereo = 0x10,
	DisablePerObjectCulling = 0x20,
	ShadowCasters = 0x40
}
