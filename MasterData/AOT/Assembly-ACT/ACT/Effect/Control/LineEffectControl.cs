using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Effect.Control;

[ExecuteAlways]
public class LineEffectControl : ScreenEffectBase
{
	public Material material;

	public bool isOpen;

	[Range(-1f, 1f)]
	public float _Strength = -0.14f;

	[Range(0f, 1000f)]
	public float _detail = 364f;

	[Range(0f, 1f)]
	public float _AddValue;

	[Range(0f, 1f)]
	public float _maskstrenght = 0.5f;

	[Range(0f, 1f)]
	public float _Smooth = 1f;

	public override void AddMat()
	{
		if ((bool)material && isOpen)
		{
			UltimetaSkillEffectPass.materials.Add(material);
			material.SetFloat("_Strength", _Strength);
			material.SetFloat("_detail", _detail);
			material.SetFloat("_AddValue", _AddValue);
			material.SetFloat("_maskstrenght", _maskstrenght);
			material.SetFloat("_Smooth", _Smooth);
		}
	}
}
