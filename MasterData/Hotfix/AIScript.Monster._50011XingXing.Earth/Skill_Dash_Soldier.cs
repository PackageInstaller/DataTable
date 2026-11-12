using System.Collections;

namespace AIScript.Monster._50011XingXing.Earth;

public class Skill_Dash_Soldier : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Dash_Charge", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(60);
		SetCloseBlockEnable();
		BeginAttack(2, "Dash_Attack", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(43);
		BeginDash(1, GetForward(), 60, 20, default, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		SetCloseBlockDisable();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
