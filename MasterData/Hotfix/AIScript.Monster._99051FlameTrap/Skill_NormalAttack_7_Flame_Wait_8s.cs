using System.Collections;
using AIScript.Monster.Trap;

namespace AIScript.Monster._99051FlameTrap;

public class Skill_NormalAttack_7_Flame_Wait_8s : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(8);
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitTime(10);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
