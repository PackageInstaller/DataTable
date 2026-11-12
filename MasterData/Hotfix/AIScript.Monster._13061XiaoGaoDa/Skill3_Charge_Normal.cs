using System.Collections;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill3_Charge_Normal : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		BeginLookAt_NotWait(attackTarget, 1, 300);
		yield return WaitTime(1);
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(1.3);
		SetCloseBlockEnable();
		doDash_A();
		yield return WaitDashFinish();
		SetCloseBlockDisable();
		doDash_B();
		yield return WaitDashFinish();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doDash_A()
	{
		BeginDashActorForward(1, 45, 15, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 4);
	}

	private void doDash_B()
	{
		BeginDashActorForward(2, 6, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
