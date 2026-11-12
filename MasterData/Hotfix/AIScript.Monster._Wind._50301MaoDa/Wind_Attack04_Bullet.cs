using System.Collections;
using TrueSync;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Attack04_Bullet : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetBuffNum(GetMonsterCloner(), 503010004) >= 1)
		{
			if (GetBuffNum(GetMonsterCloner(), 503010003) >= 1)
			{
				DoShoot02();
			}
			else
			{
				DoShoot01();
			}
		}
		else
		{
			DoShoot01();
		}
		yield return WaitTime(4);
	}

	protected void DoShoot01()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		CircleMultipleShoot("Bullet_50301_MaoDa_Skill04_Small", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 1.5, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 1);
	}

	protected void DoShoot02()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		CircleMultipleShoot("Bullet_50301_MaoDa_Skill04_Big", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, position, 1.5, forward, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 1);
	}

	private void OnBulletFinish(IEvent e)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = e as AdventureBulletFinishEvent;
		if (!(adventureBulletFinishEvent.owner != _actor))
		{
			if (adventureBulletFinishEvent.tag == "MaoDa_Skill04_A")
			{
				TSVector2 bulletPosition = adventureBulletFinishEvent.bulletPosition;
				AdventureActor monsterCloner = GetMonsterCloner();
				Shoot("Bullet_50301_MaoDa_Skill04_Small_Back", bulletPosition, 1.1, 0, GetForward(), AimType.Target, BulletDirectionType.BulletToTarget, default, monsterCloner);
			}
			if (adventureBulletFinishEvent.tag == "MaoDa_Skill04_B")
			{
				TSVector2 bulletPosition2 = adventureBulletFinishEvent.bulletPosition;
				AdventureActor monsterCloner2 = GetMonsterCloner();
				Shoot("Bullet_50301_MaoDa_Skill04_Big_Back", bulletPosition2, 1.1, 0, GetForward(), AimType.Target, BulletDirectionType.BulletToTarget, default, monsterCloner2);
			}
		}
	}
}
