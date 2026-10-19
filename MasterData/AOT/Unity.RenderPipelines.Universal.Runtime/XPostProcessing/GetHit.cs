using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/技能 (Skill)/角色受击综合")]
public class GetHit : VolumeSetting
{
	public FloatParameter indensity = new ClampedFloatParameter(0f, 0f, 4f);

	public FloatParameter splitR = new ClampedFloatParameter(0f, -1f, 1f);

	public FloatParameter splitB = new ClampedFloatParameter(0f, -1f, 1f);

	public ClampedIntParameter UseFocus = new ClampedIntParameter(0, 0, 1);

	public Vector2Parameter Focus = new Vector2Parameter(new Vector2(0.5f, 0.5f));

	public TextureParameter distortionTex = new TextureParameter(null);

	public Vector4Parameter distortionTexOffset = new Vector4Parameter(new Vector4(1f, 1f, 0f, 0f));

	public FloatParameter dIndensity = new ClampedFloatParameter(0f, -1f, 1f);

	public TextureParameter distortionMaskTex = new TextureParameter(null);

	public override bool IsActive()
	{
		return indensity.value != 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Skill/GetHit";
	}
}
