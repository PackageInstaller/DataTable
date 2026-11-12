using System.Collections;
using AIScript.Monster.Trap;

namespace AIScript.Monster._99071CircleTrap;

public class Skill_Frozen : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
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
