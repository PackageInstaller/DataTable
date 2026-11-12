using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Shoot_Daily_3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Shoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.P };

	private static readonly ComboInputBuffer.ActionKey[] Null_Combo = new ComboInputBuffer.ActionKey[0];

	private static readonly FP searchDistanc = 11;

	private static readonly List<FP> searchAngles = new List<FP>
	{
		50, 30, 10, -10, -30, -50, 70, -70, 90, -90,
		0
	};

	private static readonly int bulletCount = 3;

	private static readonly FP WaitShootTime = 1.25;

	private static readonly FP ShootTime = 0.73;

	private static readonly int ShootAngle = 0;

	private TSVector2 ShootPosition;

	private TSVector2 blinkPoint = new TSVector2(7.5, -2.5);

	private static readonly TSVector2 ShootPositionOffset = new TSVector2(0.3, 2.8);

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetHideModelEnable();
		yield return WaitTime(0.5);
		GetAttackTarget(isUpToDate: true);
		Teleport(blinkPoint);
		BeginAttack(2, Shoot_Combo, flushInputedKeys: true);
		BeginLookAtCameraDir_NotWait(DirectionType.Left, 0, 1800);
		yield return WaitCustomEvent("JoinBattle");
		SetUnparalleledDisable();
		SetHideModelDisable();
		yield return WaitTime(WaitShootTime);
		ShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), ShootPositionOffset);
		FanMultipleShoot("Bullet", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, bulletCount, ShootTime, ShootPosition, 1.7, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, ShootAngle, 0, 0);
		yield return WaitTime(ShootTime);
		yield return WaitTime(0.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(3);
	}
}
