using System.Collections;

namespace AIScript.Monster.Soldier._2501073;

public class DeathSkill : SkillSimpleBase
{
	private const string comboTag = "Die";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Die", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Hide");
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
