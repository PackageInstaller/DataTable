using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill6_BroomRing : SkillSimpleBase
{
	private const string ComboKeyP1P2 = "Skill6_BroomRing";

	private const string ComboKeyP3 = "Skill6_BroomRing_Fly";

	private const string AreaEffectP1 = "AreaEffect_70061WuYu_Skill6_BroomAct";

	private const string AreaEffectP2 = "AreaEffect_70061WuYu_Skill6_BroomAct_Plus";

	private const string AreaEffectP3_Plus = "AreaEffect_70061WuYu_Skill6_BroomAct_Plus";

	private const string AreaEffectP3_CenterMax = "AreaEffect_70061WuYu_Skill6_BroomAct_Max";

	private const string AreaEffectP3_Spread = "AreaEffect_70061WuYu_Skill6_BroomSpread";

	private const string StartFxAlias = "fx_70061WuYu_base_Attack13_broom_start";

	private static readonly FP RepositionDelay = 1.5;

	private static readonly FP StartFxDelay = 1.7;

	private static readonly FP SpreadDelay = 1.3;

	public const string AreaTag = "BroomRingAreaEffect";

	protected override IEnumerator DoMainLogic()
	{
		int num = GetLogicTagFpValue(_actor, "Phase").AsInt();
		string actionKey = ((num >= 3) ? "Skill6_BroomRing_Fly" : "Skill6_BroomRing");
		BeginAttack(0, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		if (num >= 3)
		{
			PlayAreaEffect("AreaEffect_70061WuYu_Skill6_BroomAct_Plus", entityPosition, FP.Zero);
			PlayAreaEffect("AreaEffect_70061WuYu_Skill6_BroomAct_Max", entityPosition, FP.Zero);
		}
		else if (num >= 2)
		{
			PlayAreaEffect("AreaEffect_70061WuYu_Skill6_BroomAct_Plus", entityPosition, FP.Zero);
		}
		else
		{
			PlayAreaEffect("AreaEffect_70061WuYu_Skill6_BroomAct", entityPosition, FP.Zero);
		}
		if (num >= 3)
		{
			yield return WaitTime(RepositionDelay);
			TSVector2 newPos = GetEntityPosition(GetCurrentPlayer());
			yield return WaitTime(StartFxDelay - RepositionDelay);
			long startFxId = PlayEffect("fx_70061WuYu_base_Attack13_broom_start", 1f, default, newPos);
			yield return WaitTime(SpreadDelay);
			StopEffect(startFxId);
			PlayAreaEffect("AreaEffect_70061WuYu_Skill6_BroomSpread", newPos, FP.Zero);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
