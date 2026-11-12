using System.Collections;

namespace AIScript.Monster._11031FaMuXie;

public class Skill_04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
