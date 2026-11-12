using System.Collections;

namespace AIScript.Monster._13001JinZhanHuiFeng;

public class Skill_EntranceShow : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(1.7);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
