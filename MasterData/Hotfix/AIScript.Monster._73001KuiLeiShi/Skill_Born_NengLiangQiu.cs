using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Born_NengLiangQiu : SkillSimpleBase
{
	private const string combo_Born = "EnergyBall";

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable();
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "EnergyBall", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
