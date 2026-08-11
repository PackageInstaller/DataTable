using System;
using UnityEngine;
using UnityEngine.Rendering;

[Serializable]
[VolumeComponentMenu("KIIF_Feature/RadialBlur")]
public class RadialBlurVolume : VolumeComponent
{
	[Tooltip("模糊中心点")]
	public FloatParameter X = new FloatParameter(0.5f);

	public FloatParameter Y = new FloatParameter(0.5f);

	[Range(0f, 10f)]
	[Tooltip("模糊的迭代次数")]
	public IntParameter BlurTimes = new ClampedIntParameter(1, 1, 10);

	[Range(0f, 10f)]
	[Tooltip("模糊半径")]
	public FloatParameter BlurRange = new ClampedFloatParameter(1f, 0f, 10f);

	[Tooltip("降采样")]
	[Range(0f, 10f)]
	public IntParameter RTDownSampling = new ClampedIntParameter(1, 1, 10);

	[Range(0f, 10f)]
	[Tooltip("径向半径")]
	public FloatParameter BufferRadius = new ClampedFloatParameter(1f, 0f, 5f);

	public bool IsActive()
	{
		return (float)RTDownSampling.value > 0f;
	}

	public bool IsTileCompatible()
	{
		return false;
	}
}
