using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle;

public class DitherPart : AniPart
{
	[HideInInspector]
	public bool useExtraCuve;

	public uint ditherThresholdCurveIndex = 3u;

	[HideInInspector]
	public AnimationCurve ditherCurve;

	internal override CharacterVisibilityEffect VisibilityEffect => CharacterVisibilityEffect.Dither;

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
		propertyBlock.SetFloat(BattleConsts.SUB_EFFECT_SHADER_DITHER, EvaluateCurve(ditherCurve));
	}

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		if (ditherThresholdCurveIndex != 0)
		{
			ditherCurve = GameLoader.meta.curveLibrary.GetCurve(ditherThresholdCurveIndex);
		}
		if (ditherCurve == null || ditherCurve.length == 0)
		{
			ditherCurve = AnimationCurve.Linear(0f, 1f, 1f, 0f);
		}
	}
}
