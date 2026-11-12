using System.Collections;
using AIScript.Monster.Trap;

namespace AIScript.Monster._99041SoldierTrap;

public class Skill_NormalAttack : TrapSkillBase
{
	private int startKeyIndex1 = 1;

	private ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}
}
