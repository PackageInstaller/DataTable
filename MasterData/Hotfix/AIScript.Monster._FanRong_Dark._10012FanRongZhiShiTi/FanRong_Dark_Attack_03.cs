using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_Dark._10012FanRongZhiShiTi;

public class FanRong_Dark_Attack_03 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01;

	private readonly ComboInputBuffer.ActionKey[] FireAttack02;

	private readonly ComboInputBuffer.ActionKey[] FireAttack03;

	private readonly ComboInputBuffer.ActionKey[] FireAttack04;

	private readonly string Combo01;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo01);
		BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		Charge_NoTurn();
		yield return WaitDashFinish();
		Charge_Turn();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 2, 90);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitFrame(1);
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
		BeginDashActorForward(1, 15, 4, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Charge_Turn()
	{
		BeginDashActorForward(2, 15, 30, 50, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void Charge_End()
	{
		BeginDash(4, GetForward(), 4, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void ChooseChargeEndTurn()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0)
		{
			BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginAttack(4, FireAttack04, flushInputedKeys: true, forceInterruptAttack: true);
		}
	}

	public FanRong_Dark_Attack_03()
	{
		//IL_003b: Field data (rva=0x750) could not be found in any section!
		//IL_003b: Field data (rva=0x750) could not be found in any section!
		//IL_0024: Field data (rva=0x780) could not be found in any section!
		//IL_0024: Field data (rva=0x780) could not be found in any section!
		//IL_000d: Field data (rva=0x678) could not be found in any section!
		//IL_000d: Field data (rva=0x678) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._291F8E50FBD783B2E79C62EBCF558FEB3C6AA873DC0ED0A6D156675648515C9B));
		FireAttack01 = array;
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._3C48E4EA0267931F2C9FD5BF0F97BAB297CCB783D4F77D6AB5D7D6407BFDA6D3));
		FireAttack02 = array2;
		ComboInputBuffer.ActionKey[] array3 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array3, __ldtoken(_003CPrivateImplementationDetails_003E._34BC078DF17EBFD40D018884BDB464B78EDBFEEF053BEA5C6EF966A4DCE4C9F5));
		FireAttack03 = array3;
		FireAttack04 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1937007987,
			(ComboInputBuffer.ActionKey)1668436828,
			(ComboInputBuffer.ActionKey)1953450079
		};
		Combo01 = "ComboTo1";
		base._002Ector();
	}
}
