using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle;

public class DissolvePart : AniPart
{
	public bool needChangeDissolveColorByAnim;

	public uint dissolveThreshold;

	public uint dissolveRIndex;

	public uint dissolveGIndex;

	public uint dissolveBIndex;

	public uint dissolveColorId;

	private AnimationCurve dissolveThresholdCurve;

	private AnimationCurve dissolveR;

	private AnimationCurve dissolveG;

	private AnimationCurve dissolveB;

	private Color m_DissolveColor;

	internal override CharacterVisibilityEffect VisibilityEffect => CharacterVisibilityEffect.Dissolve;

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		dissolveThresholdCurve = GameLoader.meta.curveLibrary.GetCurve(dissolveThreshold);
		if (needChangeDissolveColorByAnim)
		{
			dissolveR = GameLoader.meta.curveLibrary.GetCurve(dissolveRIndex);
			dissolveG = GameLoader.meta.curveLibrary.GetCurve(dissolveGIndex);
			dissolveB = GameLoader.meta.curveLibrary.GetCurve(dissolveBIndex);
		}
		else
		{
			m_DissolveColor = GameLoader.meta.curveLibrary.GetColor(dissolveColorId);
		}
	}

	public override void OnForwardPlayStart(Entity entity)
	{
		if (needChangeDissolveColorByAnim)
		{
			SetColorForAllTargets(value: new Color(Mathf.RoundToInt(EvaluateCurve(dissolveR) * 255f), Mathf.RoundToInt(EvaluateCurve(dissolveG) * 255f), Mathf.RoundToInt(EvaluateCurve(dissolveB) * 255f)), propertyId: BattleConsts.SHADER_DissolveEmmision);
			return;
		}
		SetColorForAllTargets(BattleConsts.SHADER_DissolveEmmision, m_DissolveColor);
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
		if (needChangeDissolveColorByAnim)
		{
			AniPart.SetHdrColor(value: new Color(Mathf.RoundToInt(EvaluateCurve(dissolveR) * 255f), Mathf.RoundToInt(EvaluateCurve(dissolveG) * 255f), Mathf.RoundToInt(EvaluateCurve(dissolveB) * 255f)), propertyBlock: propertyBlock, propertyId: BattleConsts.SHADER_DissolveEmmision);
			propertyBlock.SetFloat(BattleConsts.SHADER_DISSOLVE, EvaluateCurve(dissolveThresholdCurve));
			return;
		}
		AniPart.SetHdrColor(propertyBlock, BattleConsts.SHADER_DissolveEmmision, m_DissolveColor);
		propertyBlock.SetFloat(BattleConsts.SHADER_DISSOLVE, EvaluateCurve(dissolveThresholdCurve));
	}
}
