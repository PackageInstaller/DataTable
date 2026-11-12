using System.Collections;

namespace AIScript.Monster._50101YinYing;

public class Skill_DarkWave_Ring : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack_Combo);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
