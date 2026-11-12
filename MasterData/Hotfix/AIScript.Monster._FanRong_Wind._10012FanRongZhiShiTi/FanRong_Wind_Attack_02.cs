using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_Attack_02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01;

	private readonly ComboInputBuffer.ActionKey[] Attack02;

	private readonly ComboInputBuffer.ActionKey[] Attack03;

	private readonly ComboInputBuffer.ActionKey[] Attack04;

	private readonly string Combo01;

	private readonly string Combo02;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
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

	public FanRong_Wind_Attack_02()
	{
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		//IL_000d: Field data (rva=0x740) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._326BDEC1E9B2516102A309A80336E11AD1C2BE8731440B66CC06D58A2273DAE4));
		Attack01 = array;
		Attack02 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1600352851,
			(ComboInputBuffer.ActionKey)1718906696,
			(ComboInputBuffer.ActionKey)1415346281
		};
		Attack03 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1600352851,
			(ComboInputBuffer.ActionKey)1718906696,
			(ComboInputBuffer.ActionKey)1415346281
		};
		Attack04 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1801675124,
			(ComboInputBuffer.ActionKey)863390815,
			ComboInputBuffer.ActionKey.A
		};
		Combo01 = "C1";
		Combo02 = "C2";
		base._002Ector();
	}
}
