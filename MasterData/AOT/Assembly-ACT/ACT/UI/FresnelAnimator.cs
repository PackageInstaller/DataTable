using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

[ExecuteAlways]
public class FresnelAnimator : MonoBehaviour
{
	public Color fresnelColor;

	public float fresnelRange;

	public float fresnelSmooth;

	private MaterialPropertyBlock propertyBlock;

	private Renderer[] m_renderers;

	public void Start()
	{
		m_renderers = GetComponentsInChildren<Renderer>();
		propertyBlock = new MaterialPropertyBlock();
	}

	public void Update()
	{
		propertyBlock.SetColor(BattleConsts.SUB_EFFECT_FRESNEL_COLOR, fresnelColor);
		propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_RANGE, fresnelRange);
		propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_SMOOTH, fresnelSmooth);
		for (int i = 0; i < m_renderers.Length; i++)
		{
			m_renderers[i].SetPropertyBlock(propertyBlock);
		}
	}
}
