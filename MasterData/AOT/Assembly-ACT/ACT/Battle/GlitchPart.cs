using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class GlitchPart : AniPart
{
	public uint glithWeight;

	private AnimationCurve glithWeightCurve;

	public override void Init(AniPartControl owner)
	{
		base.Init(owner);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		glithWeightCurve = curveLibrary.GetCurve(glithWeight);
	}

	public override void OnForwardPlayStart(Entity entity)
	{
		base.OnForwardPlayStart(entity);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		glithWeightCurve = curveLibrary.GetCurve(glithWeight);
		SetFloatForAllTargets(BattleConsts.SHADER_GLITCHWEIGHT, EvaluateCurve(glithWeightCurve));
	}

	public override void OnBackWardPlayStart(Entity entity)
	{
		base.OnBackWardPlayStart(entity);
		CurveLibrary curveLibrary = GameLoader.meta.curveLibrary;
		glithWeightCurve = curveLibrary.GetCurve(glithWeight);
		SetFloatForAllTargets(BattleConsts.SHADER_GLITCHWEIGHT, EvaluateCurve(glithWeightCurve));
	}

	protected override void SetMatParameters(MaterialPropertyBlock propertyBlock)
	{
		propertyBlock.SetFloat(BattleConsts.SHADER_GLITCHWEIGHT, EvaluateCurve(glithWeightCurve));
	}
}
