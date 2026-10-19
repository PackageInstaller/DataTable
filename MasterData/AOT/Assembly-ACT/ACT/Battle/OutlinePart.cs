using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class OutlinePart : AniPart
{
	public uint strengthIndex;

	public uint widthIndex;

	public uint targetColorId;

	private AnimationCurve m_StrengthCurve;

	private AnimationCurve m_WidthCurve;

	private Color m_TargetColor;

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		m_StrengthCurve = curveLibrary.GetCurve(strengthIndex);
		m_WidthCurve = curveLibrary.GetCurve(widthIndex);
		m_TargetColor = curveLibrary.GetColor(targetColorId);
	}

	public override void OnForwardPlayStart(Entity entity)
	{
		SetColorForAllTargets(BattleConsts.SUB_EFFECT_OUTLINE_COLOR, m_TargetColor);
	}

	public override void OnBackWardPlayStart(Entity entity)
	{
		SetColorForAllTargets(BattleConsts.SUB_EFFECT_OUTLINE_COLOR, m_TargetColor);
	}

	protected override void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
		propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_OUTLINE, EvaluateCurve(m_StrengthCurve));
		propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_OUTLINE_WIDTH, EvaluateCurve(m_WidthCurve));
	}
}
