using System.Collections;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Sleep_OctopusBattery : SkillSimpleBase
{
	private static readonly string combo_Sleep = "Sleep";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_Sleep, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		ReplaceAnimationGroup(1);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
