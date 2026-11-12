using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_SilkPierce_SiXianKuiLei : SkillSimpleBase
{
	private const string combo_SilkPierce2 = "SilkPierce";

	private FP turnTime = 0.5f;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (target == null)
		{
			target = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(target, turnTime, GetRotSpdInSkill());
		yield return WaitTime(turnTime);
		BeginAttack(1, "SilkPierce", flushInputedKeys: true);
		yield return WaitCustomEvent("StartAim");
		AimAtTarget(target, 80);
		yield return WaitTime(0.8);
		CancelAim();
		yield return WaitTime(0.7);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
