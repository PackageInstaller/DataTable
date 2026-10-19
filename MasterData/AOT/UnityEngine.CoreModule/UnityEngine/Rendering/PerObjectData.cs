using System;

namespace UnityEngine.Rendering;

[Flags]
public enum PerObjectData
{
	None = 0,
	LightProbe = 1,
	ReflectionProbes = 2,
	LightProbeProxyVolume = 4,
	Lightmaps = 8,
	LightData = 0x10,
	MotionVectors = 0x20,
	LightIndices = 0x40,
	ReflectionProbeData = 0x80,
	OcclusionProbe = 0x100,
	OcclusionProbeProxyVolume = 0x200,
	ShadowMask = 0x400
}
