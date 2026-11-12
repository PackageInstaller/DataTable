using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_JiGuangQiuPatrol : SkillSimpleBase
{
	private const string combo_Shoot = "Shoot3";

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginAttack(1, "Shoot3", flushInputedKeys: true);
		yield return WaitCustomEvent("StartAim");
		AimAtTarget(target, 80);
		yield return WaitTime(0.8);
		CancelAim();
		yield return WaitTime(0.7);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
