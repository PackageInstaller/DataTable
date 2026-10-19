using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/故障效果 (Glitch)/RGB颜色分离V5 (RGB SplitV5)")]
public class GlitchRGBSplitV5 : VolumeSetting
{
	public FloatParameter Amplitude = new ClampedFloatParameter(0f, 0f, 5f);

	public FloatParameter Speed = new ClampedFloatParameter(0.1f, 0f, 1f);

	public override bool IsActive()
	{
		return Amplitude.value > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Glitch/RGBSplitV5";
	}
}
