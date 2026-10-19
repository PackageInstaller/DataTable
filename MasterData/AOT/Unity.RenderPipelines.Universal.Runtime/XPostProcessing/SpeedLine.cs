using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/技能 (Skill)/受击速度线")]
public class SpeedLine : VolumeSetting
{
	public ColorParameter Color = new ColorParameter(UnityEngine.Color.white, hdr: true, showAlpha: true, showEyeDropper: true);

	public Vector3Parameter CastDir = new Vector3Parameter(Vector3.zero);

	public BoolParameter CheckDir = new BoolParameter(value: true);

	public FloatParameter angle = new ClampedFloatParameter(1f, -1f, 1f);

	public FloatParameter Weight = new ClampedFloatParameter(0f, 0f, 1f);

	public FloatParameter Threshold = new ClampedFloatParameter(0f, 0f, 1f);

	public FloatParameter ThresholdRange = new ClampedFloatParameter(0.1f, 0f, 1f);

	public FloatParameter DissolveMapScale = new FloatParameter(1f);

	public TextureParameter LineTex = new TextureParameter(null);

	public Vector2Parameter NoiseScale = new Vector2Parameter(Vector2.one);

	public Vector2Parameter NoiseOffset = new Vector2Parameter(Vector2.zero);

	public Vector2Parameter FadeNoiseScale = new Vector2Parameter(Vector2.one);

	public Vector2Parameter FadeNoiseOffset = new Vector2Parameter(Vector2.zero);

	public FloatParameter FadeNoisePower = new FloatParameter(4f);

	public FloatParameter FadeRangeMin = new FloatParameter(0f);

	public FloatParameter FadeRangeMax = new FloatParameter(1f);

	public override bool IsActive()
	{
		return Weight.value > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Skill/SpeedLine";
	}
}
