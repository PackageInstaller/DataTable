using System.Collections;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_Attack_02_Ex : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)828141665,
		(ComboInputBuffer.ActionKey)825242416,
		(ComboInputBuffer.ActionKey)1500408152
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1634222951,
		(ComboInputBuffer.ActionKey)1331654249,
		(ComboInputBuffer.ActionKey)1953775982
	};

	private readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1701668200,
		(ComboInputBuffer.ActionKey)1802659152,
		(ComboInputBuffer.ActionKey)1701336156
	};

	private readonly ComboInputBuffer.ActionKey[] Attack04 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)16777216,
		(ComboInputBuffer.ActionKey)788529152,
		(ComboInputBuffer.ActionKey)1936933212
	};

	private readonly string Combo01 = "C1";

	private readonly string Combo02 = "C2";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.5);
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			PlayAreaEffect("AreaEffect_Wind_Skill02", GetPosition());
		}
		yield return WaitCustomEvent(Combo01);
		CancelAttack();
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo02);
		Charge_NoTurn();
		yield return WaitDashFinish();
		Charge_Turn();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 4, 90);
		yield return WaitDashFinish();
		CancelAttack();
		StopWaitLookAt();
		ChooseChargeEndTurn();
		Charge_End();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.85, 120);
		yield return WaitDashFinish();
		yield return WaitFrame(35);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Charge_NoTurn()
	{
		BeginDashActorForward(1, 10, 4, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Charge_Turn()
	{
		BeginDashActorForward(2, 15, 30, 70, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Charge_End()
	{
		BeginDash(4, GetForward(), 4, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void ChooseChargeEndTurn()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0)
		{
			BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginAttack(4, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		}
	}
}
