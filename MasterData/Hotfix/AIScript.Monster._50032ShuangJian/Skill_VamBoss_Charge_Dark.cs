using System.Collections;

namespace AIScript.Monster._50032ShuangJian;

public class Skill_VamBoss_Charge_Dark : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string ComboAttack = "ComboAttack";

	private static readonly string ChargeTo = "Charge";

	private static readonly string DashTo = "DashStart";

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(Targetenemy, 0.3, 720);
		yield return WaitTime(0.3);
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.77);
		Dash_Start();
		AddBuffToTarget(_actor, 990010030);
		yield return WaitDashFinish();
		RemoveBuffFromTarget(_actor, 990010030);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginLookAt_NotWait(Targetenemy, 0.3, 960);
		yield return WaitTime(0.2);
		BeginAttack(2, Attack01, flushInputedKeys: true);
		yield return WaitTime(0.77);
		Dash_Start2();
		AddBuffToTarget(_actor, 990010030);
		yield return WaitDashFinish();
		RemoveBuffFromTarget(_actor, 990010030);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginLookAt_NotWait(Targetenemy, 0.3, 960);
		yield return WaitTime(0.2);
		BeginAttack(3, Attack01, flushInputedKeys: true);
		yield return WaitTime(0.77);
		Dash_Start3();
		AddBuffToTarget(_actor, 990010030);
		yield return WaitDashFinish();
		RemoveBuffFromTarget(_actor, 990010030);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Dash_Start()
	{
		BeginDashActorForward(1, 45, 15, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Dash_Start2()
	{
		BeginDashActorForward(2, 45, 15, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Dash_Start3()
	{
		BeginDashActorForward(3, 45, 15, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
