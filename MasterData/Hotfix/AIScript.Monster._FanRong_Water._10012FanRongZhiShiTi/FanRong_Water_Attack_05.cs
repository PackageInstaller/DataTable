using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Water._10012FanRongZhiShiTi;

public class FanRong_Water_Attack_05 : SkillSimpleBase
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

	protected override void OnSkillEnable()
	{
		HomeDistance = Distance(GetPosition(), new TSVector2(0, 0));
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
		else
		{
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
		CircleMultipleShoot("Weapon_FanRong_Water_Skill05_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 7, 0, GetPosition(), 0, GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 2);
		CircleMultipleShoot("Weapon_FanRong_Water_Skill05_Wave", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 7, 0, GetPosition(), 0, GetEntityPositionObsoleted(GetCurrentPlayer()) - GetPosition(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 2);
	}

	private void DoDash()
	{
		BeginDashActorForward(1, 10, HomeDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void OnBulletFinish(IEvent e)
	{
		if (StartListener == 1 && e is AdventureBulletFinishEvent { tag: "FanRong_Skill05_A", bulletPosition: var bulletPosition })
		{
			RotateTo(GetForward(), 180);
			CircleMultipleShoot("Weapon_FanRong_Water_Skill05_2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, bulletPosition, 0, GetPosition() - bulletPosition, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 1);
		}
	}
}
