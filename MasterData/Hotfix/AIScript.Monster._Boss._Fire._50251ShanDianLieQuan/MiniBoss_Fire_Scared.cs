using System.Collections;

namespace AIScript.Monster._Boss._Fire._50251ShanDianLieQuan;

public class MiniBoss_Fire_Scared : SkillSimpleBase
{
	private readonly string Scared = "Scared";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Scared, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
