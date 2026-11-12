using System.Collections;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Alert_Long : SkillSimpleBase
{
	private readonly int actionIndex = 1;

	private readonly string actionKey = "WanderAction";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(actionIndex, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
