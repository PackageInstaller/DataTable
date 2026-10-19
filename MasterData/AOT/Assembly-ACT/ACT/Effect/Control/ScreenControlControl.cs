using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Effect.Control;

[ExecuteAlways]
public class ScreenControlControl : ScreenEffectBase
{
	public Material material;

	public bool isOpen;

	[Range(0f, 4f)]
	public float _Contrast = 2.38f;

	[Range(0f, 1f)]
	public float _Saturation = 0.893f;

	public bool _UseStep = true;

	[Range(0f, 1f)]
	public float _Step = 1f;

	public Vector2 _MaskScale = Vector2.one;

	public Vector2 _MaskOffset = Vector2.one;

	[Range(0f, 1f)]
	public float _StepStrength = 0.799f;

	public override void AddMat()
	{
		if ((bool)material && isOpen)
		{
			UltimetaSkillEffectPass.materials.Add(material);
			material.SetFloat("_Contrast", _Contrast);
			material.SetFloat("_Saturation", _Saturation);
			material.SetFloat("_UseStep", _UseStep ? 1 : 0);
			material.SetFloat("_Step", _Step);
			material.SetTextureScale("_Mask", _MaskScale);
			material.SetTextureOffset("_Mask", _MaskOffset);
			material.SetFloat("_StepStrength", _StepStrength);
		}
	}
}
