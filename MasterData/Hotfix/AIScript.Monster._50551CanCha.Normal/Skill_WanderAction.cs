using System.Collections;

namespace AIScript.Monster._50551CanCha.Normal;

public class Skill_WanderAction : SkillSimpleBase
{
	private readonly int actionIndex = 1;

	private readonly string actionKey = "WanderAction";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(actionIndex, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
