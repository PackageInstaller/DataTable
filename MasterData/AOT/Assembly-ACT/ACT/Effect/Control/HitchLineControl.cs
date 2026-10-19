using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Effect.Control;

[ExecuteAlways]
public class HitchLineControl : ScreenEffectBase
{
	public Material material;

	public bool isOpen;

	public float Vector1_8BE496DA = 4f;

	[Range(0f, 1f)]
	public float Vector1_C1057843 = 0.738f;

	public float Vector1_D7C71E53 = 15f;

	public float Vector1_93425239 = 3f;

	public float Vector1_730CAA9A = 10f;

	public Color _Color = new Color(1.083f, 1.141f, 1.446f, 1f);

	public override void AddMat()
	{
		if ((bool)material && isOpen)
		{
			material.SetFloat("Vector1_8BE496DA", Vector1_8BE496DA);
			UltimetaSkillEffectPass.materials.Add(material);
			material.SetFloat("Vector1_C1057843", Vector1_C1057843);
			material.SetFloat("Vector1_D7C71E53", Vector1_D7C71E53);
			material.SetFloat("Vector1_93425239", Vector1_93425239);
			material.SetFloat("Vector1_730CAA9A", Vector1_730CAA9A);
			material.SetColor("_Color", _Color);
		}
	}
}
