using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Effect.Control;

[ExecuteAlways]
public class ScreenAdjustControl : ScreenEffectBase
{
	public Material material;

	public bool isOpen;

	[Range(-0.01f, 0.01f)]
	public float _DepthDistance = 0.0067f;

	public Color _DepthColor;

	public bool _DepthFlip = true;

	[Range(1f, 2f)]
	public float _Contrast = 1.757f;

	[Range(-0.01f, 0.01f)]
	public float _ContrastDistance = -0.0052f;

	public bool _ContrastFlip;

	public override void AddMat()
	{
		if ((bool)material && isOpen)
		{
			UltimetaSkillEffectPass.materials.Add(material);
			material.SetFloat("_DepthDistance", _DepthDistance);
			material.SetColor("_DepthColor", _DepthColor);
			material.SetFloat("_DepthFlip", _DepthFlip ? 1 : 0);
			material.SetFloat("_Contrast", _Contrast);
			material.SetFloat("_ContrastDistance", _ContrastDistance);
			material.SetFloat("_ContrastFlip", _ContrastFlip ? 1 : 0);
		}
	}
}
