using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class MaterialOverridePart : AniPart
{
	public enum MaterialOverridePartType
	{
		onlyChangeMaterial,
		materialAndAlphaAndFresnel,
		materialAndColorAndFresnel,
		materialAndCut
	}

	public Material material;

	public MaterialOverridePartType materialOverridePartType;

	public MaterialOverride materialOverride;

	public bool needSave;

	public uint colorRIndex;

	public uint colorGIndex;

	public uint colorBIndex;

	public uint alphaIndex;

	private AnimationCurve m_alphaCurve;

	private AnimationCurve m_colorRCurve;

	private AnimationCurve m_colorGCurve;

	private AnimationCurve m_colorBCurve;

	public uint fresnelRangeIndex;

	private AnimationCurve m_fresnelRangeCurve;

	public uint cutIndex;

	private AnimationCurve m_cutCurve;

	private static readonly int ColorPropertyId = Shader.PropertyToID("_Color");

	private static readonly int RangePropertyId = Shader.PropertyToID("_Range");

	protected override bool UsesMaterialPropertyBlock => false;

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		switch (materialOverridePartType)
		{
		case MaterialOverridePartType.materialAndAlphaAndFresnel:
			m_alphaCurve = curveLibrary.GetCurve(alphaIndex);
			m_fresnelRangeCurve = curveLibrary.GetCurve(fresnelRangeIndex);
			break;
		case MaterialOverridePartType.materialAndColorAndFresnel:
			m_colorRCurve = curveLibrary.GetCurve(colorRIndex);
			m_colorGCurve = curveLibrary.GetCurve(colorGIndex);
			m_colorBCurve = curveLibrary.GetCurve(colorBIndex);
			m_alphaCurve = curveLibrary.GetCurve(alphaIndex);
			m_fresnelRangeCurve = curveLibrary.GetCurve(fresnelRangeIndex);
			break;
		case MaterialOverridePartType.materialAndCut:
			m_cutCurve = curveLibrary.GetCurve(cutIndex);
			break;
		case MaterialOverridePartType.onlyChangeMaterial:
			break;
		}
	}

	protected override void SetMaterialParametersDirect()
	{
		if (!(material == null))
		{
			switch (materialOverridePartType)
			{
			case MaterialOverridePartType.materialAndAlphaAndFresnel:
			{
				Color color2 = material.GetColor(ColorPropertyId);
				color2.a = EvaluateCurve(m_alphaCurve);
				material.SetColor(ColorPropertyId, color2);
				material.SetFloat(RangePropertyId, EvaluateCurve(m_fresnelRangeCurve));
				break;
			}
			case MaterialOverridePartType.materialAndColorAndFresnel:
			{
				Color color = new Color(EvaluateCurve(m_colorRCurve), EvaluateCurve(m_colorGCurve), EvaluateCurve(m_colorBCurve), EvaluateCurve(m_alphaCurve));
				material.SetColor(ColorPropertyId, color);
				material.SetFloat(RangePropertyId, EvaluateCurve(m_fresnelRangeCurve));
				float num = Mathf.Pow(2f, 1f);
				color.r *= num;
				color.g *= num;
				color.b *= num;
				materialOverride._CustomBufferColor = color;
				break;
			}
			case MaterialOverridePartType.materialAndCut:
				material.SetFloat(BattleConsts.SHADER_ACT_NEW_DISSOLVE_CUT, EvaluateCurve(m_cutCurve));
				break;
			case MaterialOverridePartType.onlyChangeMaterial:
				break;
			}
		}
	}

	public override void OnForwardPlayStart(Entity entity)
	{
		if (!materialOverride._MatList.Contains(material))
		{
			materialOverride._MatList.Add(material);
		}
	}

	public override void OnForwardPlayEnd(Entity entity)
	{
		if (materialOverride._MatList.Contains(material) && !needSave)
		{
			materialOverride._MatList.Remove(material);
		}
	}

	public override void OnBackWardPlayStart(Entity entity)
	{
		if (!materialOverride._MatList.Contains(material))
		{
			materialOverride._MatList.Add(material);
		}
	}

	public override void OnBackWardPlayEnd(Entity entity)
	{
		if (materialOverride._MatList.Contains(material))
		{
			materialOverride._MatList.Remove(material);
		}
	}
}
