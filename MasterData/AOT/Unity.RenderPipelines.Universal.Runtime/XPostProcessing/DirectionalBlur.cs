using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/模糊 (Blur)/方向模糊 (Directional Blur)")]
public class DirectionalBlur : VolumeSetting
{
	public FloatParameter BlurRadius = new ClampedFloatParameter(0f, 0f, 1f);

	public IntParameter Iteration = new ClampedIntParameter(10, 2, 30);

	public FloatParameter Angle = new ClampedFloatParameter(0.5f, 0f, 6f);

	public FloatParameter RTDownScaling = new ClampedFloatParameter(1f, 1f, 10f);

	public override bool IsActive()
	{
		return BlurRadius.value > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Blur/DirectionalBlur";
	}
}
