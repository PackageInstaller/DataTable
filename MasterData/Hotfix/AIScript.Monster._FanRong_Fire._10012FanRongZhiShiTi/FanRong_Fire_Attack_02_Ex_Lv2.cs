using System.Collections;

namespace AIScript.Monster._FanRong_Fire._10012FanRongZhiShiTi;

public class FanRong_Fire_Attack_02_Ex_Lv2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)828141665,
		(ComboInputBuffer.ActionKey)825242416,
		(ComboInputBuffer.ActionKey)1500408152
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack02 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1634222951,
		(ComboInputBuffer.ActionKey)1331654249,
		(ComboInputBuffer.ActionKey)1953775982
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack03 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack04 = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._0,
		ComboInputBuffer.ActionKey._3
	};

	private readonly string Combo01 = "ComboTo1";

	private readonly string Combo02 = "Charge";

	private readonly string TurnToTarget = "TurnTo";

	private long Emoji;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo01);
		BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(TurnToTarget);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.25, 90);
		yield return WaitCustomEvent(Combo02);
		Charge_NoTurn();
		yield return WaitDashFinish();
		Charge_Turn();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 2, 90);
		yield return WaitFrame(50);
		StopEffect(Emoji);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitFrame(1);
		Charge_End();
		yield return WaitFrame(60);
	}

	private void Charge_NoTurn()
	{
		BeginDashActorForward(1, 15, 4, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Charge_Turn()
	{
		BeginDashActorForward(2, 15, 30, 60, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Charge_End()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 50)
		{
			StartCor(AttackCombo());
			BeginDashActorForward(1, 10, 4, 180, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
	}

	private IEnumerator AttackCombo()
	{
		BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.5, 180);
		yield return WaitFrame(30);
		BeginAttack(4, FireAttack04, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(17);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
