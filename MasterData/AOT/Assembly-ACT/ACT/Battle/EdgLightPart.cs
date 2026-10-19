using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public class EdgLightPart : AniPart
{
	[Tooltip("边缘光颜色")]
	public uint index;

	private Gradient m_Gradient;

	public uint rangeIndex;

	public uint smoothIndex;

	private AnimationCurve m_RangeCurve;

	private AnimationCurve m_SmoothCurve;

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		m_RangeCurve = curveLibrary.GetCurve(rangeIndex);
		m_SmoothCurve = curveLibrary.GetCurve(smoothIndex);
		m_Gradient = curveLibrary.GetGradient(index);
	}

	protected override void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
		AniPart.SetHdrColor(propertyBlock, BattleConsts.SUB_EFFECT_FRESNEL_COLOR, m_Gradient.Evaluate(curVal));
		propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_RANGE, EvaluateCurve(m_RangeCurve));
		propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_FRESNEL_SMOOTH, EvaluateCurve(m_SmoothCurve));
	}
}
