using System.Collections;

namespace AIScript.Monster._50101YinYing;

public class Skill_SummonAct : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SummonAct");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
