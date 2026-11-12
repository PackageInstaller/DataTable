using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Earth._10012FanRongZhiShiTi;

public class FanRong_Earth_Attack_05 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] FireAttack03 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.E,
		ComboInputBuffer.ActionKey._3
	};

	private FP HomeDistance;

	private TSVector2 FireStartPos;

	private TSVector2 FireStartRot;

	private FP FireTimes;

	private FP AddRotNum;

	private FP AddRot01;

	private FP AddRot02;

	private FP AddRot03;

	private int StartListener;

	protected override void OnSkillEnable()
	{
		HomeDistance = Distance(GetPosition(), new TSVector2(0, 0));
		FireTimes = 0;
		AddRotNum = 0;
		AddRot01 = 0;
		AddRot02 = 0;
		AddRot03 = 0;
		StartListener = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		RemoveBuffFromTarget(_actor, 990020140);
		if (!ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FanRonShiTi_003))
		{
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FanRonShiTi_003);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 990020140);
		if (HomeDistance >= 4)
		{
			SetCloseBlockEnable();
			BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			BeginLookAtByPos(new TSVector2(0, 0), 0.5, 360, 0);
			yield return WaitFrame(15);
			DoDash();
			yield return WaitDashFinish();
			CancelAttack();
			SetCloseBlockDisable();
			yield return WaitFrame(10);
			BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.5, 360);
			yield return WaitFrame(30);
			StartCor(AttackCombo());
			yield return WaitFrame(325);
			CancelAttack();
			BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(70);
			RemoveBuffFromTarget(_actor, 990020140);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(2, FireAttack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(10);
			BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.5, 360);
			yield return WaitFrame(30);
			StartCor(AttackCombo());
			yield return WaitFrame(325);
			CancelAttack();
			BeginAttack(3, FireAttack03, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitFrame(70);
			RemoveBuffFromTarget(_actor, 990020140);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private IEnumerator AttackCombo()
	{
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			StartListener = 1;
			DoArea02();
			yield return WaitFrame(50);
			DoArea02();
			yield return WaitFrame(50);
			DoArea02();
			yield return WaitFrame(50);
			DoArea02();
			yield return WaitFrame(50);
			DoArea02();
			yield return WaitFrame(50);
			DoArea02();
			yield return WaitFrame(50);
			DoArea02();
		}
		else
		{
			FireStartPos = GetEntityPositionObsoleted(GetCurrentPlayer());
			DoArea01();
			yield return WaitFrame(50);
			DoArea01();
			yield return WaitFrame(50);
			DoArea01();
			yield return WaitFrame(50);
			DoArea01();
			yield return WaitFrame(50);
			DoArea01();
			yield return WaitFrame(50);
			DoArea01();
			yield return WaitFrame(50);
			DoArea01();
		}
	}

	private void DoArea01()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		if (Distance(FireStartPos, entityPositionObsoleted) < 1 && FireTimes != 0)
		{
			FP addRotNum = AddRotNum;
			AddRotNum = addRotNum + 20;
			FireStartRot = RotateTo(GetForward(), AddRotNum);
			PlayAreaEffect("AreaEffect_FanRong_Earth_Skill05_1", FireStartPos);
			PlayAreaEffect("AreaEffect_FanRong_Earth_Skill05_2", FireStartPos);
			CircleMultipleShoot("Weapon_FanRong_Earth_Skill05_1_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, FireStartPos, 0, FireStartRot, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 3);
		}
		else
		{
			FireStartPos = entityPositionObsoleted;
			FireTimes = 1;
			FP addRotNum2 = AddRotNum;
			AddRotNum = addRotNum2 + 20;
			FireStartRot = RotateTo(GetForward(), AddRotNum);
			PlayAreaEffect("AreaEffect_FanRong_Earth_Skill05_1", entityPositionObsoleted);
			PlayAreaEffect("AreaEffect_FanRong_Earth_Skill05_2", entityPositionObsoleted);
			CircleMultipleShoot("Weapon_FanRong_Earth_Skill05_1_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, entityPositionObsoleted, 0, FireStartRot, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 3);
		}
	}

	private void DoArea02()
	{
		FireStartPos = GetEntityPositionObsoleted(GetCurrentPlayer());
		CircleMultipleShoot("Weapon_FanRong_Earth_Skill05_2_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, FireStartPos, 0, RotateTo(GetForward(), 0), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 2.5);
		CircleMultipleShoot("Weapon_FanRong_Earth_Skill05_2_2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, FireStartPos, 0, RotateTo(GetForward(), 120), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 2.5);
		CircleMultipleShoot("Weapon_FanRong_Earth_Skill05_2_3", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, FireStartPos, 0, RotateTo(GetForward(), 240), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 2.5);
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 10, HomeDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void OnBulletFinish(IEvent e)
	{
		if (StartListener == 1 && e is AdventureBulletFinishEvent adventureBulletFinishEvent)
		{
			if (adventureBulletFinishEvent.tag == "FanRong_Skill05_A")
			{
				TSVector2 bulletPosition = adventureBulletFinishEvent.bulletPosition;
				TSVector2 multiShootDirection = RotateTo(GetForward(), AddRot01);
				FP addRot = AddRot01;
				AddRot01 = addRot + 20;
				CircleMultipleShoot("Weapon_FanRong_Earth_Skill05_1_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, bulletPosition, 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 3);
			}
			if (adventureBulletFinishEvent.tag == "FanRong_Skill05_B")
			{
				TSVector2 bulletPosition2 = adventureBulletFinishEvent.bulletPosition;
				TSVector2 multiShootDirection2 = RotateTo(GetForward(), AddRot02);
				FP addRot2 = AddRot02;
				AddRot02 = addRot2 + 20;
				CircleMultipleShoot("Weapon_FanRong_Earth_Skill05_1_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, bulletPosition2, 0, multiShootDirection2, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 3);
			}
			if (adventureBulletFinishEvent.tag == "FanRong_Skill05_C")
			{
				TSVector2 bulletPosition3 = adventureBulletFinishEvent.bulletPosition;
				TSVector2 multiShootDirection3 = RotateTo(GetForward(), AddRot03);
				FP addRot3 = AddRot03;
				AddRot03 = addRot3 + 20;
				CircleMultipleShoot("Weapon_FanRong_Earth_Skill05_1_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, bulletPosition3, 0, multiShootDirection3, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 3);
			}
		}
	}
}
