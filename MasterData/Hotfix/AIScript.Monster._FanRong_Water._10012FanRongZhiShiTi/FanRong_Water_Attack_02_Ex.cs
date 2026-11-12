using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._FanRong_Water._10012FanRongZhiShiTi;

public class FanRong_Water_Attack_02_Ex : SkillSimpleBase
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

	private readonly ComboInputBuffer.ActionKey[] Attack07;

	private readonly string Combo01;

	private readonly string Combo02;

	private readonly string ChargeNext;

	private readonly string TurnToTarget;

	private FP Times;

	private long Effect01;

	private LogicEntity Targetenemy;

	protected override void OnSkillEnable()
	{
		Times = 0;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo01);
		CancelAttack();
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			BeginAttack(6, Attack06, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent(Combo02);
			Charge_Turn();
			StartCor(AttackCombo01());
			yield return WaitDashFinish();
			Times = 1;
			CancelAttack();
			StopWaitLookAt();
			ChooseChargeEndCombo();
			yield return WaitCustomEvent(ChargeNext);
			BeginAttack(7, Attack07, flushInputedKeys: true, forceInterruptAttack: true);
			Charge_Turn();
			StartCor(AttackCombo02());
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 2, 90);
			yield return WaitDashFinish();
			Times = 2;
			CancelAttack();
			StopWaitLookAt();
		}
		else
		{
			BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent(Combo02);
			Charge_Turn();
			yield return WaitDashFinish();
			StopEffect(Effect01);
			CancelAttack();
			StopWaitLookAt();
			ChooseChargeEndCombo();
			yield return WaitCustomEvent(ChargeNext);
			BeginAttack(5, Attack05, flushInputedKeys: true, forceInterruptAttack: true);
			Charge_Turn();
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 2, 90);
			yield return WaitDashFinish();
			StopEffect(Effect01);
			CancelAttack();
			StopWaitLookAt();
		}
		ChooseChargeEndTurn();
		Charge_End();
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.75, 180);
		yield return WaitDashFinish();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Charge_Turn()
	{
		BeginDashActorForward(1, 15, 50, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 1);
	}

	private void Charge_End()
	{
		BeginDash(4, GetForward(), 4, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void ChooseChargeEndCombo()
	{
		FP randomValue = GetRandomValue(150, 160, isInt: true);
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0)
		{
			BeginAttack(3, Attack03, flushInputedKeys: true, forceInterruptAttack: true);
			if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 5)
			{
				Targetenemy = GetAttackTarget();
				if (Targetenemy == null)
				{
					Targetenemy = GetCurrentPlayer();
				}
				BeginLookAt_NotWait(Targetenemy, 0.85, 210);
			}
			else
			{
				BeginRotateAngle_NotWait(randomValue, 210);
			}
			return;
		}
		BeginAttack(4, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 5)
		{
			Targetenemy = GetAttackTarget();
			if (Targetenemy == null)
			{
				Targetenemy = GetCurrentPlayer();
			}
			BeginLookAt_NotWait(Targetenemy, 0.85, 210);
		}
		else
		{
			BeginRotateAngle_NotWait(randomValue, 210);
		}
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

	private IEnumerator AttackCombo01()
	{
		yield return WaitFrame(6);
		while (Times == 0)
		{
			PlayAreaEffect("AreaEffect_FanRong_Water_Skill02", GetPosition(), GetRotation());
			yield return WaitFrame(3);
		}
	}

	private IEnumerator AttackCombo02()
	{
		yield return WaitFrame(6);
		while (Times == 1)
		{
			PlayAreaEffect("AreaEffect_FanRong_Water_Skill02", GetPosition(), GetRotation());
			yield return WaitFrame(5);
		}
	}

	public FanRong_Water_Attack_02_Ex()
	{
		//IL_0080: Field data (rva=0x730) could not be found in any section!
		//IL_0080: Field data (rva=0x730) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._31B8A6421FC65C81153D12CDB79161199F4081BA1762BF0A3644020B96C636BD));
		Attack06 = array;
		Attack07 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)855638016,
			(ComboInputBuffer.ActionKey)1936933212,
			(ComboInputBuffer.ActionKey)1551070309
		};
		Combo01 = "C1";
		Combo02 = "C2";
		ChargeNext = "ToCharge";
		TurnToTarget = "TurnTo";
		base._002Ector();
	}
}
