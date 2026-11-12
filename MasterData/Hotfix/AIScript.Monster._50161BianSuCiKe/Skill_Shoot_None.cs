using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Shoot_None : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Shoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.P };

	private static readonly FP searchDistanc = 11;

	private static readonly List<FP> searchAngles = new List<FP>
	{
		50, 30, 10, -10, -30, -50, 70, -70, 90, -90,
		0
	};

	private static readonly int bulletCount = 3;

	private static readonly FP WaitShootTime = 1.1;

	private static readonly FP ShootTime = 0.3;

	private static readonly int ShootAngle = 5;

	private TSVector2 ShootPosition;

	private static readonly TSVector2 ShootPositionOffset = new TSVector2(0.3, 2.8);

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetHideModelEnable();
		yield return WaitTime(0.5);
		GetAttackTarget(isUpToDate: true);
		TSVector2 pointsByActorAndScreenTopDirWithRotationAnglesAndDistance = ILRuntimeAPI.GetPointsByActorAndScreenTopDirWithRotationAnglesAndDistance(_actor, searchAngles, searchDistanc, searchDistanc);
		Teleport(pointsByActorAndScreenTopDirWithRotationAnglesAndDistance);
		BeginAttack(2, Shoot_Combo, flushInputedKeys: true);
		BeginLookAt_NotWait(GetAttackTarget(), 0.1, 1800);
		yield return WaitCustomEvent("JoinBattle");
		SetUnparalleledDisable();
		SetHideModelDisable();
		yield return WaitTime(WaitShootTime);
		ShootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), ShootPositionOffset);
		FanMultipleShoot("Bullet", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, bulletCount, ShootTime, ShootPosition, 1.7, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, ShootAngle, 0, 0);
		yield return WaitTime(ShootTime);
		yield return WaitTime(0.25);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5);
	}
}
