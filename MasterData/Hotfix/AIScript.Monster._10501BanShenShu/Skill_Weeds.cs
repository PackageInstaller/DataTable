using System.Collections;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Weeds : SkillSimpleBase
{
	private static readonly int ActionIndex = 0;

	private static readonly string AttackAction = "GeneralAttack";

	private int AttackTimes;

	protected override void OnSkillEnable()
	{
		AttackTimes = 0;
	}

	protected override void OnSkillDisable()
	{
		AttackTimes = 0;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(ActionIndex, AttackAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		UseMonsterCloneActorCastSkill(1050142);
		yield return WaitTime(1);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == 0)
		{
			AttackTimes++;
			if (AttackTimes == 2)
			{
				CancelAttack();
			}
		}
	}
}
