using System.Collections;

namespace AIScript.Monster._13011YuanChengHuiFeng;

public class Skill_Spawn : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.2);
	}
}
