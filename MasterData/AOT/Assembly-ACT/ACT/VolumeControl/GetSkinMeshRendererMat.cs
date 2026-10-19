using ACT.Battle;
using UnityEngine;

namespace ACT.VolumeControl;

[ExecuteAlways]
public class GetSkinMeshRendererMat : MonoBehaviour
{
	public bool EmissionColorControl;

	public Color EmissionColor;

	public int controlMat;

	public Color m1_Fresnelcolor;

	public Color m2_Fresnelcolor;

	public Color m3_Fresnelcolor;

	public float m1_FresnelRange;

	public float m2_FresnelRange;

	public float m3_FresnelRange;

	public float m1_FresnelSmooth;

	public float m2_FresnelSmooth;

	public float m3_FresnelSmooth;

	private Renderer m_Renderer;

	private MaterialPropertyBlock m_Block;

	private int m_TempLen;

	private void Start()
	{
		m_Renderer = GetComponent<Renderer>();
		if (!(m_Renderer == null))
		{
			if (m_Block == null)
			{
				m_Block = new MaterialPropertyBlock();
			}
			controlMat = 0;
			m_TempLen = m_Renderer.sharedMaterials.Length;
			m1_FresnelRange = (m2_FresnelRange = (m3_FresnelRange = 0f));
			m1_FresnelSmooth = (m2_FresnelSmooth = (m3_FresnelSmooth = 0f));
			m1_Fresnelcolor = (m2_Fresnelcolor = (m3_Fresnelcolor = Color.clear));
			EmissionColorControl = false;
			EmissionColor = Color.clear;
		}
	}

	private void Update()
	{
		if (m_Renderer == null || m_Block == null)
		{
			Start();
			if (m_Renderer == null || m_Block == null)
			{
				return;
			}
		}
		if (EmissionColorControl)
		{
			GetMaterialPropertyBlock(0);
			m_Block.SetColor(BattleConsts.SHADER_EMISSION_COLOR, EmissionColor);
			m_Renderer.SetPropertyBlock(m_Block, 0);
		}
		if (controlMat != 0 && m_TempLen != 0)
		{
			if (m_TempLen == 1)
			{
				GetMaterialPropertyBlock(0);
				m_Block.SetColor(BattleConsts.SUB_EFFECT_FRESNEL_COLOR, m1_Fresnelcolor);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_RANGE, m1_FresnelRange);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_SMOOTH, m1_FresnelSmooth);
				m_Renderer.SetPropertyBlock(m_Block, 0);
			}
			if (m_TempLen == 2)
			{
				GetMaterialPropertyBlock(0);
				m_Block.SetColor(BattleConsts.SUB_EFFECT_FRESNEL_COLOR, m1_Fresnelcolor);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_RANGE, m1_FresnelRange);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_SMOOTH, m1_FresnelSmooth);
				m_Renderer.SetPropertyBlock(m_Block, 0);
				GetMaterialPropertyBlock(1);
				m_Block.SetColor(BattleConsts.SUB_EFFECT_FRESNEL_COLOR, m2_Fresnelcolor);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_RANGE, m2_FresnelRange);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_SMOOTH, m2_FresnelSmooth);
				m_Renderer.SetPropertyBlock(m_Block, 1);
			}
			if (m_TempLen == 3)
			{
				GetMaterialPropertyBlock(0);
				m_Block.SetColor(BattleConsts.SUB_EFFECT_FRESNEL_COLOR, m1_Fresnelcolor);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_RANGE, m1_FresnelRange);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_SMOOTH, m1_FresnelSmooth);
				m_Renderer.SetPropertyBlock(m_Block, 0);
				GetMaterialPropertyBlock(1);
				m_Block.SetColor(BattleConsts.SUB_EFFECT_FRESNEL_COLOR, m2_Fresnelcolor);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_RANGE, m2_FresnelRange);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_SMOOTH, m2_FresnelSmooth);
				m_Renderer.SetPropertyBlock(m_Block, 1);
				GetMaterialPropertyBlock(2);
				m_Block.SetColor(BattleConsts.SUB_EFFECT_FRESNEL_COLOR, m3_Fresnelcolor);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_RANGE, m3_FresnelRange);
				m_Block.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_SMOOTH, m3_FresnelSmooth);
				m_Renderer.SetPropertyBlock(m_Block, 2);
			}
		}
	}

	private void GetMaterialPropertyBlock(int materialIndex)
	{
		m_Block.Clear();
		m_Renderer.GetPropertyBlock(m_Block, materialIndex);
	}
}
