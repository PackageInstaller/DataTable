using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._FanRong_Dark._10012FanRongZhiShiTi;

public class FanRong_Dark_Attack_03_Ex_Lv2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1952805747,
		(ComboInputBuffer.ActionKey)1918065779,
		(ComboInputBuffer.ActionKey)1867013987
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02;

	private readonly ComboInputBuffer.ActionKey[] Attack03;

	private readonly ComboInputBuffer.ActionKey[] Attack04;

	private readonly ComboInputBuffer.ActionKey[] Attack05;

	private readonly ComboInputBuffer.ActionKey[] Attack06;

	private readonly ComboInputBuffer.ActionKey[] Attack07;

	private readonly string Combo01;

	private readonly string Combo02;

	private readonly string ChargeNext;

	private readonly string TurnToTarget;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo01);
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(TurnToTarget);
		yield return WaitCustomEvent(Combo02);
		Charge_NoTurn();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 2, 90);
		yield return WaitDashFinish();
		StopWaitLookAt();
		GetEnemy();
		ChooseChargeEndTurn();
		yield return WaitCustomEvent(ChargeNext);
		BeginAttack(5, Attack05, flushInputedKeys: true, forceInterruptAttack: true);
		Charge_NoTurn();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 2, 90);
		yield return WaitDashFinish();
		StopWaitLookAt();
		GetEnemy();
		ChooseChargeEndTurn();
		yield return WaitCustomEvent(ChargeNext);
		BeginAttack(6, Attack07, flushInputedKeys: true, forceInterruptAttack: true);
		Charge_End();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 2, 90);
		yield return WaitDashFinish();
		BeginAttack(7, Attack06, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(75);
		CancelAttack();
		yield return WaitFrame(30);
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
		BeginDashActorForward(1, 20, 50, 30, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 1.5);
	}

	private void Charge_End()
	{
		BeginDashActorForward(2, 20, 50, 30, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: true, triggerFriendStop: false, 0.25);
	}

	private void ChooseChargeEndTurn()
	{
		FP randomValue = GetRandomValue(150, 160, isInt: true);
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0)
		{
			BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
			if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 5)
			{
				BeginLookAt_NotWait(Targetenemy, 0.85, 210);
			}
			else
			{
				BeginRotateAngle_NotWait(randomValue, 210);
			}
		}
		else
		{
			BeginAttack(4, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
			if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 5)
			{
				BeginLookAt_NotWait(Targetenemy, 0.85, 210);
			}
			else
			{
				BeginRotateAngle_NotWait(randomValue, 210);
			}
		}
	}

	public FanRong_Dark_Attack_03_Ex_Lv2()
	{
		//IL_0024: Field data (rva=0x720) could not be found in any section!
		//IL_0024: Field data (rva=0x720) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._3183AD5CC447DEE86C6E6F85AD237EB12473784D2859CE96DAB80E4FFBEEEDD8));
		Attack02 = array;
		Attack03 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1951623022,
			(ComboInputBuffer.ActionKey)778399343,
			(ComboInputBuffer.ActionKey)29539
		};
		Attack04 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1953450079,
			(ComboInputBuffer.ActionKey)1551395174,
			(ComboInputBuffer.ActionKey)1835362388
		};
		Attack05 = new ComboInputBuffer.ActionKey[3]
		{
			ComboInputBuffer.ActionKey.B,
			(ComboInputBuffer.ActionKey)1933663275,
			(ComboInputBuffer.ActionKey)1937007987
		};
		Attack06 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1702064961,
			(ComboInputBuffer.ActionKey)1398567796,
			(ComboInputBuffer.ActionKey)1214210930
		};
		Attack07 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)778334817,
			(ComboInputBuffer.ActionKey)29539,
			(ComboInputBuffer.ActionKey)256
		};
		Combo01 = "ComboTo1";
		Combo02 = "Charge";
		ChargeNext = "ToCharge";
		TurnToTarget = "TurnTo";
		base._002Ector();
	}
}
