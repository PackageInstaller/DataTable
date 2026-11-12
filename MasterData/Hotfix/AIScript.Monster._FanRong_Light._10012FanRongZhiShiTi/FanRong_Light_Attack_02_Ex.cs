using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_Light._10012FanRongZhiShiTi;

public class FanRong_Light_Attack_02_Ex : SkillSimpleBase
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

	private readonly ComboInputBuffer.ActionKey[] Attack05 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)2053465458,
		(ComboInputBuffer.ActionKey)1701986661,
		(ComboInputBuffer.ActionKey)1935879777
	};

	private readonly ComboInputBuffer.ActionKey[] Attack06;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("C1");
		CancelAttack();
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("C2");
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
		BeginAttack(5, Attack05, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Turn");
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.25, 220);
		yield return WaitCustomEvent("Jump");
		Charge_Jump();
		yield return WaitCustomEvent("C3");
		BeginAttack(6, Attack06, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(20);
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
		BeginDash(3, GetForward(), 4, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Charge_Jump()
	{
		BeginDashActorForward(4, 12, 8, 90, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
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

	public FanRong_Light_Attack_02_Ex()
	{
		//IL_0080: Field data (rva=0x730) could not be found in any section!
		//IL_0080: Field data (rva=0x730) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._31B8A6421FC65C81153D12CDB79161199F4081BA1762BF0A3644020B96C636BD));
		Attack06 = array;
		base._002Ector();
	}
}
