using System.Collections;
using TrueSync;

namespace AIScript.Monster._10008ShaMoXie_Elite;

public class Skill02_PoisonBall : SkillSimpleBase
{
	private static readonly string Combo = "PoisonBullet";

	private static readonly string BombName = "Bullet_PoisonBall";

	private LogicEntity Targetenemy;

	private TSVector2 AttackPosition;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 2, 360);
		yield return WaitCustomEvent("Shoot");
		StopLookAt();
		PoisonBallShoot();
		yield return WaitCustomEvent("End");
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void PoisonBallShoot()
	{
		if (Targetenemy != null)
		{
			AttackPosition = GetEntityPosition(Targetenemy);
		}
		else
		{
			AttackPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5));
		}
		FanMultipleShoot(BombName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 3, bulletDirectionOffset: 0, multiShootDirection: GetForward(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
