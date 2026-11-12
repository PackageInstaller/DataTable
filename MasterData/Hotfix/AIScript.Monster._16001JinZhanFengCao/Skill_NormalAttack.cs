using System.Collections;

namespace AIScript.Monster._16001JinZhanFengCao;

public class Skill_NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_Attack2 = new ComboInputBuffer.ActionKey[2];

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
		BeginAttack(1, Attack_Combo);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.4);
	}
}
