using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle;

public class DissolvePartNew : AniPart
{
	public uint scanLineCurveIndex = 11u;

	public uint dissolveEmmision1ColorId;

	public uint dissolveEmmision2ColorId = 1u;

	private AnimationCurve m_ScanLineCurve;

	private Color m_DissolveEmmision1Color;

	private Color m_DissolveEmmision2Color;

	internal override CharacterVisibilityEffect VisibilityEffect => CharacterVisibilityEffect.Dissolve2;

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		m_ScanLineCurve = GameLoader.meta.curveLibrary.GetCurve(scanLineCurveIndex);
		m_DissolveEmmision1Color = GameLoader.meta.curveLibrary.GetColor(dissolveEmmision1ColorId);
		m_DissolveEmmision2Color = GameLoader.meta.curveLibrary.GetColor(dissolveEmmision2ColorId);
	}

	public override void OnForwardPlayStart(Entity entity)
	{
		SetColorForAllTargets(BattleConsts.SHAER_EFFECT_DISSOLVEEMMISION1, m_DissolveEmmision1Color);
		SetColorForAllTargets(BattleConsts.SHAER_EFFECT_DISSOLVEEMMISION2, m_DissolveEmmision2Color);
	}

	public override void OnBackWardPlayStart(Entity entity)
	{
		SetColorForAllTargets(BattleConsts.SHAER_EFFECT_DISSOLVEEMMISION1, m_DissolveEmmision1Color);
		SetColorForAllTargets(BattleConsts.SHAER_EFFECT_DISSOLVEEMMISION2, m_DissolveEmmision2Color);
	}

	public override void OnBackWardPlayEnd(Entity entity = default(Entity))
	{
		RestoreDitherThreshold();
	}

	protected override void OnResetToVisible()
	{
		RestoreDitherThreshold();
	}

	protected override void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
		propertyBlock.SetFloat(BattleConsts.SHADER_DISSOLVE_NEW_SCAN_LINE, EvaluateCurve(m_ScanLineCurve));
	}
}
