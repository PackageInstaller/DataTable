using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/图像处理 (Image Processing)/Bloom")]
public class Bloom : VolumeSetting
{
	public static bool s_Enable = true;

	public BoolParameter UseOriginalBloom = new BoolParameter(value: true);

	public ClampedFloatParameter Intensity = new ClampedFloatParameter(1f, 0f, 1f);

	public BloomCompositeModeParameter CompositeMode = new BloomCompositeModeParameter(BloomCompositeMode.Add);

	public ClampedFloatParameter BloomSaturate = new ClampedFloatParameter(1f, 0f, 5f);

	public ClampedFloatParameter BrightPassReplacement = new ClampedFloatParameter(1f, 0f, 1f);

	public ClampedFloatParameter Threshold = new ClampedFloatParameter(0.89001f, 0f, 1f);

	public ClampedFloatParameter SoftKnee = new ClampedFloatParameter(0.445015f, 0.1f, 0.5f);

	public ClampedFloatParameter PrefilterScale = new ClampedFloatParameter(1f, 0f, 2f);

	public ClampedFloatParameter Scatter = new ClampedFloatParameter(0.41f, 0f, 1f);

	public ClampedIntParameter IterationCount = new ClampedIntParameter(9, 1, 9);

	[HideInInspector]
	public FloatParameter AddPower = new FloatParameter(0f);

	public ClampedFloatParameter BloomThreshold = new ClampedFloatParameter(1f, 0.2f, 1.5f);

	public FloatParameter BloomClamp = new FloatParameter(7777f);

	public ClampedFloatParameter BloomScatter = new ClampedFloatParameter(0.7f, 0f, 1f);

	public ClampedFloatParameter BloomType = new ClampedFloatParameter(1f, 0f, 1f);

	[HideInInspector]
	public ClampedFloatParameter BlendType = new ClampedFloatParameter(0f, 0f, 2f);

	public ClampedFloatParameter GenericBloomWeight = new ClampedFloatParameter(1f, 0f, 4f);

	public ClampedIntParameter iterateCount = new ClampedIntParameter(7, 1, 7);

	public override bool IsActive()
	{
		if (s_Enable && Intensity.overrideState)
		{
			return Intensity.value > 0f;
		}
		return false;
	}

	public override string GetShaderName()
	{
		return string.Empty;
	}
}
