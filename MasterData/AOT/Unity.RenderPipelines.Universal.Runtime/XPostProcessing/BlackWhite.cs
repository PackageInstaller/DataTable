using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/色彩调整 (Color Adjustment)/黑白闪 (BlackWhite)")]
public class BlackWhite : VolumeSetting
{
	public BoolParameter Enable = new BoolParameter(value: false);

	public Vector2Parameter Center = new Vector2Parameter(new Vector2(0.5f, 0.5f));

	public ColorParameter TintColor = new ColorParameter(Color.white, hdr: true, showAlpha: true, showEyeDropper: true);

	public ClampedFloatParameter Threshold = new ClampedFloatParameter(0.51f, 0f, 0.99f);

	public ClampedFloatParameter Range = new ClampedFloatParameter(0f, 0f, 0.99f);

	public TextureParameter NoiseTex = new TextureParameter(null);

	public Vector4Parameter TextureTilling = new Vector4Parameter(new Vector4(1f, 1f, 0f, 0f));

	public FloatParameter StepScale = new FloatParameter(5f);

	public MinIntParameter StepCount = new MinIntParameter(2, 0);

	public MinFloatParameter Detail = new MinFloatParameter(0.1f, 0f);

	public MinFloatParameter NoisePower = new MinFloatParameter(0f, 0f);

	public MinFloatParameter MinPower = new MinFloatParameter(0f, 0f);

	public TextureParameter DissolveTex = new TextureParameter(null);

	public ClampedFloatParameter DissolveWeight = new ClampedFloatParameter(1f, 0f, 1f);

	public Vector4Parameter DissolveTilling = new Vector4Parameter(new Vector4(1f, 1f, 0f, 0f));

	public ClampedIntParameter Change = new ClampedIntParameter(0, 0, 1);

	public override bool IsActive()
	{
		return Enable.value;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Skill/BlackWhite";
	}
}
