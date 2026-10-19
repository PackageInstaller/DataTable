using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/模糊 (Blur)/柔光 (SoftLight)")]
public class SoftLight : VolumeSetting
{
	public static bool s_Enable = true;

	public ClampedFloatParameter BlendWeight = new ClampedFloatParameter(0.1f, 0f, 1f);

	public ClampedFloatParameter BlendType = new ClampedFloatParameter(0f, 0f, 1f);

	public FloatParameter BlurRadius = new ClampedFloatParameter(0f, 0f, 50f);

	public IntParameter Iteration = new ClampedIntParameter(6, 1, 15);

	public FloatParameter RTDownScaling = new ClampedFloatParameter(1f, 1f, 8f);

	public override bool IsActive()
	{
		if (s_Enable)
		{
			return BlurRadius.value > 0f;
		}
		return false;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Blur/SoftLight";
	}
}
