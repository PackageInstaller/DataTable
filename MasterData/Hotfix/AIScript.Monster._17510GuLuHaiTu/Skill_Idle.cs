using System.Collections;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_Idle : SkillSimpleBase
{
	private string key = "Idle";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
