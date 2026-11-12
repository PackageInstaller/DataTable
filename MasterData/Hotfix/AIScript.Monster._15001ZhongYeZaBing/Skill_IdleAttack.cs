using System.Collections;

namespace AIScript.Monster._15001ZhongYeZaBing;

public class Skill_IdleAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, 0.4, 160);
		yield return WaitTime(0.4);
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
