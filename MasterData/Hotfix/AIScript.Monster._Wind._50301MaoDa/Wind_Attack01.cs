using System.Collections;
using TrueSync;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Attack01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] Attack03 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._2
	};

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.3, 300);
		if (GetBuffNum(_actor, 503010004) >= 1)
		{
			yield return WaitCustomEvent("LightShoot01");
			DoShoot01();
			yield return WaitCustomEvent("LightShoot02");
			DoShoot01();
		}
		yield return WaitCustomEvent("LightShootEnd");
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.3, 600);
		yield return WaitCustomEvent("Storage");
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.5, 60);
		yield return WaitFrame(20);
		CancelAttack();
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

	protected void DoShoot01()
	{
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2));
		FanMultipleShoot("Bullet_50301_MaoDa_Skill01_Small_01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 2, 0, shootPosition, 1.85, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 30, 0, 0);
	}

	protected void DoShoot02()
	{
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2));
		FanMultipleShoot("Bullet_50301_MaoDa_Skill01_Small_01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 2, 0, shootPosition, 1.85, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 30, 0, 0);
	}

	protected void Shoot01()
	{
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2));
		LogicEntity currentPlayer = GetCurrentPlayer();
		Shoot("Bullet_50301_MaoDa_Skill01_Small_03_1", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, GetEntityPositionObsoleted(currentPlayer));
		Shoot("Bullet_50301_MaoDa_Skill01_Small_03_2", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, GetEntityPositionObsoleted(currentPlayer));
		Shoot("Bullet_50301_MaoDa_Skill01_Small_03_3", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, GetEntityPositionObsoleted(currentPlayer));
		Shoot("Bullet_50301_MaoDa_Skill01_Small_03_4", position, 1.1, 0, GetForward(), AimType.Position, BulletDirectionType.BulletToTarget, GetEntityPositionObsoleted(currentPlayer));
	}
}
