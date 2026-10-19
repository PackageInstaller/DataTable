using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/模糊 (Blur)/径向模糊V2 (Radial BlurV2)")]
public class RadialBlurV2 : VolumeSetting
{
	public RadialBlurQualityParameter QualityLevel = new RadialBlurQualityParameter
	{
		value = RadialBlurQuality.RadialBlur_8Tap_Balance
	};

	public FloatParameter BlurRadius = new ClampedFloatParameter(0f, -1f, 1f);

	public FloatParameter RadialCenterX = new ClampedFloatParameter(0.5f, 0f, 1f);

	public FloatParameter RadialCenterY = new ClampedFloatParameter(0.5f, 0f, 1f);

	public override bool IsActive()
	{
		return BlurRadius.value != 0f;
	}

	public override void SetCenter(float x, float y)
	{
		RadialCenterX.value = x;
		RadialCenterY.value = y;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Blur/RadialBlurV2";
	}
}
