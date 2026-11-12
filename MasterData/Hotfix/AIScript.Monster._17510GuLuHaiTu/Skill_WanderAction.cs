using System.Collections;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_WanderAction : SkillScript_Base
{
	private string wanderActionKey = "WanderAction";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, wanderActionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
