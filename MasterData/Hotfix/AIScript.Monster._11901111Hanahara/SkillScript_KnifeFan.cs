using System.Collections;

namespace AIScript.Monster._11901111Hanahara;

public class SkillScript_KnifeFan : SkillSimpleBase
{
	private string key = "119FenShen_Skill_T27";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
