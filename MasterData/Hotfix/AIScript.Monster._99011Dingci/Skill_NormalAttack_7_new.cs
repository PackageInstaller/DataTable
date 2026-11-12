using System.Collections;
using AIScript.Monster.Trap;

namespace AIScript.Monster._99011Dingci;

public class Skill_NormalAttack_7_new : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitTime(1.65);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
