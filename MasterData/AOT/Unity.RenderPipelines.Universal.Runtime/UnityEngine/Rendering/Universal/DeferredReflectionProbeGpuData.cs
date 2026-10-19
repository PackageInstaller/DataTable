using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
public struct DeferredReflectionProbeGpuData
{
	public Vector4 capturePositionWSAtlasLayer;

	public Vector4 volumeCenterWSIntensity;

	public Vector4 worldToProbeLocalRow0;

	public Vector4 worldToProbeLocalRow1;

	public Vector4 worldToProbeLocalRow2;

	public Vector4 halfExtentsBlendDistance;

	public Vector4 reciprocalBlendBoxProjection;

	public Vector4 hdrDecodeInstructions;

	public const int Stride = 128;
}
