using System.Collections;

namespace AIScript.Monster._13031XinYue;

public class Skill_RoundBomb : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
