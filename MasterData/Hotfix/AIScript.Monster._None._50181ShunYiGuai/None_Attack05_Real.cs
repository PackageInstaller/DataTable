using System.Collections;
using TrueSync;

namespace AIScript.Monster._None._50181ShunYiGuai;

public class None_Attack05_Real : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack05 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly ComboInputBuffer.ActionKey[] Teleport01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly ComboInputBuffer.ActionKey[] Teleport02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._2
	};

	protected override void OnInterrupt(int comboIndex)
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), new TSVector2(0, 0)) > 5)
		{
			BeginAttack(1, Teleport01, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Disappear");
			SetHideModelEnable();
			SetUnparalleledEnable();
			Teleport(new TSVector2(0, 0));
			BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.1, 360);
			yield return WaitTime(0.15);
			BeginAttack(1, Teleport02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Appear");
			SetUnparalleledDisable();
			SetHideModelDisable();
		}
		BeginAttack(3, Attack05, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Turn");
		BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.5, 360);
		yield return WaitCustomEvent("Fire");
		if (GetBuffNum(_actor, 501810002) >= 1)
		{
			SpawnDoor03();
			yield return WaitTime(0.25);
			SpawnDoor04();
			yield return WaitTime(0.25);
			SpawnDoor05();
			yield return WaitTime(3.5);
			CancelAttack();
		}
		else
		{
			SpawnDoor01();
			yield return WaitTime(0.5);
			SpawnDoor02();
			yield return WaitTime(3.5);
			CancelAttack();
		}
		BeginLookAt_NotWait(GetCurrentPlayer(), 1, 180);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void SpawnDoor01()
	{
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_S", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 3, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 220), 0, AimType.Position, BulletDirectionType.BulletToTarget, 72, 0, 12);
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_Shadow", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 3, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 220), 0, AimType.Position, BulletDirectionType.BulletToTarget, 72, 0, 12);
	}

	protected void SpawnDoor02()
	{
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_S", AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 2, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 120), 0, AimType.Position, BulletDirectionType.BulletToTarget, 36, 0, 12);
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_Shadow", AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 2, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 120), 0, AimType.Position, BulletDirectionType.BulletToTarget, 36, 0, 12);
	}

	protected void SpawnDoor03()
	{
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_S", AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 3, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 240), 0, AimType.Position, BulletDirectionType.BulletToTarget, 80, 0, 12);
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_Shadow", AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 3, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 240), 0, AimType.Position, BulletDirectionType.BulletToTarget, 80, 0, 12);
	}

	protected void SpawnDoor04()
	{
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_S", AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 3, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 120), 0, AimType.Position, BulletDirectionType.BulletToTarget, 80, 0, 12);
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_Shadow", AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 3, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 120), 0, AimType.Position, BulletDirectionType.BulletToTarget, 80, 0, 12);
	}

	protected void SpawnDoor05()
	{
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_S", AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 3, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 0), 0, AimType.Position, BulletDirectionType.BulletToTarget, 80, 0, 12);
		FanMultipleShoot("Bullet_50181_ShunYiGuai_Earth_Skill05_Door_Shadow", AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 3, 3, new TSVector2(0, 0), 0, RotateTo(GetForward(), 0), 0, AimType.Position, BulletDirectionType.BulletToTarget, 80, 0, 12);
	}
}
