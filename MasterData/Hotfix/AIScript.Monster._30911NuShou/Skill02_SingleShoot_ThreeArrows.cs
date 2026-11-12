using System.Collections;
using TrueSync;

namespace AIScript.Monster._30911NuShou;

public class Skill02_SingleShoot_ThreeArrows : SkillSimpleBase
{
	private readonly string Shoot_Once = "Shoot_Once";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, Shoot_Once, flushInputedKeys: true, forceInterruptAttack: true);
		yield return BeginLookAt(Targetenemy, 1.5, 180);
		CancelAttack();
		Shoot3();
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

	private void Shoot3()
	{
		FanMultipleShoot("Bullet_Arrow_Triple", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 3, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1)), 1.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 30, 30, 0);
	}
}
