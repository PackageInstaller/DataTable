using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/模糊 (Blur)/高斯模糊 (Gaussian Blur)")]
public class GaussianBlur : VolumeSetting
{
	public FloatParameter BlurRadius = new ClampedFloatParameter(0f, 0f, 5f);

	public IntParameter Iteration = new ClampedIntParameter(6, 1, 15);

	public FloatParameter RTDownScaling = new ClampedFloatParameter(1f, 1f, 8f);

	public override bool IsActive()
	{
		return BlurRadius.value > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Blur/GaussianBlur";
	}
}
