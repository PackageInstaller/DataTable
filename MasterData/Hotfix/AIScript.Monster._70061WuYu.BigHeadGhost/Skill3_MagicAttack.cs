using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BigHeadGhost;

public class Skill3_MagicAttack : SkillSimpleBase
{
	private const string ComboKey = "Skill3_MagicAttack";

	private const string DamageAreaAlias = "AreaEffect_70061WuYu_BigHeadGhost_Skill3_MagicAttack";

	private static readonly FP AreaReleaseDelay = 0.5;

	private static readonly FP LoopHoldAfterArea = 0.5;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget != null)
		{
			BeginLookAt_NotWait(attackTarget, 0.1, 360);
		}
		BeginAttack(0, "Skill3_MagicAttack", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(AreaReleaseDelay);
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		PlayAreaEffect("AreaEffect_70061WuYu_BigHeadGhost_Skill3_MagicAttack", entityPosition, FP.Zero);
		yield return WaitTime(LoopHoldAfterArea);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
