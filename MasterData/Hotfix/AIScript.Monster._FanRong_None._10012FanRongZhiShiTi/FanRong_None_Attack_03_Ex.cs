using System.Collections;
using System.Runtime.CompilerServices;

namespace AIScript.Monster._FanRong_None._10012FanRongZhiShiTi;

public class FanRong_None_Attack_03_Ex : SkillSimpleBase
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
		BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
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
			BeginAttack(3, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginAttack(4, Attack05, flushInputedKeys: true, forceInterruptAttack: true);
		}
	}

	public FanRong_None_Attack_03_Ex()
	{
		//IL_0052: Field data (rva=0x750) could not be found in any section!
		//IL_0052: Field data (rva=0x750) could not be found in any section!
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
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._34BC078DF17EBFD40D018884BDB464B78EDBFEEF053BEA5C6EF966A4DCE4C9F5));
		Attack04 = array2;
		Attack05 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1937007987,
			(ComboInputBuffer.ActionKey)1668436828,
			(ComboInputBuffer.ActionKey)1953450079
		};
		Combo01 = "C1";
		Combo02 = "C2";
		base._002Ector();
	}
}
