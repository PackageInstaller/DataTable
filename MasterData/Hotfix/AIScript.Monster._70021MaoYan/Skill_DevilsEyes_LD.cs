using System.Collections;

namespace AIScript.Monster._70021MaoYan;

public class Skill_DevilsEyes_LD : SkillSimpleBase
{
	private LogicEntity target;

	private readonly string action = "DevilsEyes_Noarea";

	private readonly int actionIndex = 1;

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
		BeginAttack(actionIndex, action, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayAreaEffect("DevilsEyes", GetEntityPosition(target));
		yield return WaitTime(1);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
