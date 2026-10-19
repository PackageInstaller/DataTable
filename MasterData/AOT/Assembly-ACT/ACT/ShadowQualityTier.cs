using System;
using UnityEngine;

namespace ACT;

[Serializable]
public class ShadowQualityTier
{
	public bool SupportsMainLightShadows = true;

	public float ShadowDistance = 50f;

	[Range(1f, 3f)]
	public int CascadeCount = 2;

	[Range(0.05f, 0.95f)]
	public float Cascade2Split = 0.3f;

	public Vector2 Cascade3Split = new Vector2(0.15f, 0.4f);

	public int MainLightShadowmapResolution = 2048;

	public bool SupportsAdditionalLightShadows;

	public int AdditionalLightsShadowmapResolution = 2048;

	public int AdditionalLightsShadowSliceResolution = 512;

	public bool AdditionalShadowTimeSlicingEnabled = true;

	public int MaxAdditionalShadowTilesPerFrame = 3;

	public Vector3 GetCascadeSplits()
	{
		return CascadeCount switch
		{
			3 => new Vector3(Cascade3Split.x, Cascade3Split.y, 0f), 
			2 => new Vector3(Cascade2Split, 1f, 0f), 
			_ => new Vector3(1f, 0f, 0f), 
		};
	}
}
