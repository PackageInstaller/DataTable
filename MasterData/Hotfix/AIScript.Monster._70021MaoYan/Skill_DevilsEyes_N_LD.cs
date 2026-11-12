using System.Collections;

namespace AIScript.Monster._70021MaoYan;

public class Skill_DevilsEyes_N_LD : SkillSimpleBase
{
	private LogicEntity target;

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(1, "DevilsEyes_Noarea", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayAreaEffect("DevilsEyes_comm", GetEntityPosition(target));
		yield return WaitTime(1);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
