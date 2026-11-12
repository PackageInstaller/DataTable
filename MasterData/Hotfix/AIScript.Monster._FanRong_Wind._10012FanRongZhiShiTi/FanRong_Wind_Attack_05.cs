using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_Attack_05 : SkillSimpleBase
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

	private int StartListener;

	private TSVector2 FireStartPos;

	private List<LogicEntity> MonsterList;

	protected override void OnSkillEnable()
	{
		HomeDistance = Distance(GetPosition(), new TSVector2(0, 0));
		StartListener = 0;
		ClearShootBulletIdList();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		RemoveBuffFromTarget(_actor, 990020140);
		StartListener = 0;
		List<long> shootBulletIdList = GetShootBulletIdList();
		for (int i = 0; i < shootBulletIdList.Count; i++)
		{
			long bulletId = shootBulletIdList.get_Item(i);
			FinishBullet(bulletId);
		}
		MonsterList = GetTargetByTeammateIndex(1);
		ClearActors(MonsterList);
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
		FireStartPos = GetPosition();
		StartListener = 1;
		yield return WaitFrame(1);
		DoShoot();
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 10, HomeDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void DoShoot()
	{
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			CircleMultipleShoot("Weapon_Wind_Skill05_01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 2, 0, FireStartPos, 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			CircleMultipleShoot("Weapon_Wind_Skill05_02", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, FireStartPos, 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			CircleMultipleShoot("Weapon_Wind_Skill05_03", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 4, 0, FireStartPos, 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		}
		else
		{
			CircleMultipleShoot("Weapon_Wind_Skill05_01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, FireStartPos, 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			CircleMultipleShoot("Weapon_Wind_Skill05_02", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 2, 0, FireStartPos, 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
			CircleMultipleShoot("Weapon_Wind_Skill05_03", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, FireStartPos, 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		}
	}

	private void OnBulletFinish(IEvent e)
	{
		if (StartListener == 1 && e is AdventureBulletFinishEvent { tag: "FanRong_Skill05_A", bulletPosition: var bulletPosition })
		{
			TSVector2 spawnDirection = RotateTo(GetForward(), 0);
			SummonTeammate(1, bulletPosition, spawnDirection);
		}
	}
}
