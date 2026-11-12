using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_EnergyRing_EnergyRingKuiLei : SkillSimpleBase
{
	private const string areaEffect_EnergyRing = "";

	private const string combo_Shoot = "Shoot";

	private const string combo_EnergyRing = "EnergyRing";

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginAttack(1, "Shoot", flushInputedKeys: true);
		yield return WaitCustomEvent("StartAim");
		AimAtTarget(target, 80);
		yield return WaitTime(0.8);
		CancelAim();
		yield return WaitTime(0.7);
		while (!GetLogicTagToggleValue(_actor, Common_73001.EnergyRingSync_Tag))
		{
			yield return null;
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
