using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Earth._10012FanRongZhiShiTi;

public class FanRong_Earth_Attack_02_Ex : SkillSimpleBase
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

	private TSVector2 StartPos;

	private FP Times;

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo01);
		CancelAttack();
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(Combo02);
		Charge_NoTurn();
		StartCor(AttackCombo());
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

	private IEnumerator AttackCombo()
	{
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			StartPos = GetPosition();
			DoArea02();
			yield return WaitFrame(10);
			DoArea02();
			yield return WaitFrame(10);
			DoArea02();
			yield return WaitFrame(10);
			DoArea02();
			yield return WaitFrame(10);
			DoArea02();
			yield return WaitFrame(10);
			DoArea02();
			yield return WaitFrame(10);
			DoArea02();
			yield return WaitFrame(10);
			DoArea02();
		}
		else
		{
			StartPos = GetPosition();
			DoArea01();
			yield return WaitFrame(10);
			DoArea01();
			yield return WaitFrame(10);
			DoArea01();
			yield return WaitFrame(10);
			DoArea01();
			yield return WaitFrame(10);
			DoArea01();
			yield return WaitFrame(10);
			DoArea01();
			yield return WaitFrame(10);
			DoArea01();
			yield return WaitFrame(10);
			DoArea01();
		}
	}

	private void DoArea01()
	{
		TSVector2 position = GetPosition();
		if (Distance(StartPos, position) > 2 && Times != 0)
		{
			StartPos = position;
			CircleMultipleShoot("Weapon_FanRong_Earth_Skill02_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		}
		else if (Times == 0)
		{
			Times = 1;
			CircleMultipleShoot("Weapon_FanRong_Earth_Skill02_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		}
	}

	private void DoArea02()
	{
		TSVector2 position = GetPosition();
		if (Distance(StartPos, position) > 2 && Times != 0)
		{
			StartPos = position;
			CircleMultipleShoot("Weapon_FanRong_Earth_Skill02_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 2, 0, GetPosition(), 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 2);
		}
		else if (Times == 0)
		{
			Times = 1;
			CircleMultipleShoot("Weapon_FanRong_Earth_Skill02_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 2, 0, GetPosition(), 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 2);
		}
	}
}
