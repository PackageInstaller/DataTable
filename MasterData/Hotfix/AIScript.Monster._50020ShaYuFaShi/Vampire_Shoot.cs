using System.Collections;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Vampire_Shoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1];

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.1);
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, 0.8, 160);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
