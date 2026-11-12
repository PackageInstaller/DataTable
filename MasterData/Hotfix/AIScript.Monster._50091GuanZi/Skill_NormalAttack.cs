using System.Collections;

namespace AIScript.Monster._50091GuanZi;

public class Skill_NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] ActionKey = new ComboInputBuffer.ActionKey[1];

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, ActionKey);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
