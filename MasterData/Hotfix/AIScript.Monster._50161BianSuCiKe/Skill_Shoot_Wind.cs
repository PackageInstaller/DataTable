using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Shoot_Wind : SkillSimpleBase
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

	private static readonly FP WaitShootTime = 1.1;

	private static readonly FP ShootTime = 0.5;

	private static readonly int ShootAngle = 90;

	private static readonly FP BulletDistanceToShootPoint = 2.5;

	private TSVector2 ShootPosition;

	private static readonly TSVector2 ShootPositionOffset = new TSVector2(0.3, 2.8);

	private long BulletStartFX1;

	private long BulletStartFX2;

	private long BulletStartFX3;

	protected override void OnSkillDisable()
	{
		StopEffect(BulletStartFX1);
		StopEffect(BulletStartFX2);
		StopEffect(BulletStartFX3);
	}

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
		Skill_Shoot_Wind skill_Shoot_Wind = this;
		Skill_Shoot_Wind skill_Shoot_Wind2 = this;
		TSVector2 position = ShootPosition + RotateTo(GetForward().normalized * BulletDistanceToShootPoint, 45);
		FP tSVectToAngle = GetTSVectToAngle(GetForward(), 45);
		skill_Shoot_Wind.BulletStartFX1 = skill_Shoot_Wind2.PlayEffect("WindBulletStart", 0.75f, default, position, tSVectToAngle, 0.75f);
		yield return WaitTime(0.2);
		Skill_Shoot_Wind skill_Shoot_Wind3 = this;
		Skill_Shoot_Wind skill_Shoot_Wind4 = this;
		position = ShootPosition + RotateTo(GetForward().normalized * BulletDistanceToShootPoint, 0);
		tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		skill_Shoot_Wind3.BulletStartFX2 = skill_Shoot_Wind4.PlayEffect("WindBulletStart", 0.75f, default, position, tSVectToAngle, 0.75f);
		yield return WaitTime(0.2);
		Skill_Shoot_Wind skill_Shoot_Wind5 = this;
		Skill_Shoot_Wind skill_Shoot_Wind6 = this;
		position = ShootPosition + RotateTo(GetForward().normalized * BulletDistanceToShootPoint, -45);
		tSVectToAngle = GetTSVectToAngle(GetForward(), -45);
		skill_Shoot_Wind5.BulletStartFX3 = skill_Shoot_Wind6.PlayEffect("WindBulletStart", 0.75f, default, position, tSVectToAngle, 0.75f);
		yield return WaitTime(0.2);
		Skill_Shoot_Wind skill_Shoot_Wind7 = this;
		position = ShootPosition + RotateTo(GetForward().normalized * BulletDistanceToShootPoint, 45);
		tSVectToAngle = GetTSVectToAngle(GetForward(), 45);
		skill_Shoot_Wind7.PlayEffect("AimlineFX", 1f, default, position, tSVectToAngle);
		Skill_Shoot_Wind skill_Shoot_Wind8 = this;
		position = ShootPosition + RotateTo(GetForward().normalized * BulletDistanceToShootPoint, 0);
		tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		skill_Shoot_Wind8.PlayEffect("AimlineFX", 1f, default, position, tSVectToAngle);
		Skill_Shoot_Wind skill_Shoot_Wind9 = this;
		position = ShootPosition + RotateTo(GetForward().normalized * BulletDistanceToShootPoint, -45);
		tSVectToAngle = GetTSVectToAngle(GetForward(), -45);
		skill_Shoot_Wind9.PlayEffect("AimlineFX", 1f, default, position, tSVectToAngle);
		yield return WaitTime(0.4);
		FanMultipleShoot("Bullet", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, bulletCount, 0, ShootPosition, 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, ShootAngle, 0, BulletDistanceToShootPoint);
		StopEffect(BulletStartFX1);
		StopEffect(BulletStartFX2);
		StopEffect(BulletStartFX3);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5);
	}
}
