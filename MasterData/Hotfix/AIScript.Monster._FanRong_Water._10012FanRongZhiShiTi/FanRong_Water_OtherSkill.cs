using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Water._10012FanRongZhiShiTi;

public class FanRong_Water_OtherSkill : SkillSimpleBase
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
		FanMultipleShoot("Weapon_FanRong_Water_Skill01_1", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, GetPosition(), 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 80, 0, 6);
		yield return WaitTime(10);
	}

	private void OnBulletFinish(IEvent e)
	{
		if (e is AdventureBulletFinishEvent { tag: "FanRong_Skill01_A", bulletPosition: var bulletPosition })
		{
			TSVector2 multiShootDirection = GetPosition() - bulletPosition;
			RotateTo(GetForward(), 180);
			if (Distance(bulletPosition, new TSVector2(0, 0)) <= 15 && Distance(bulletPosition, new TSVector2(0, 0)) >= 14)
			{
				CircleMultipleShoot("Weapon_FanRong_Water_Skill01_2", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, bulletPosition, 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 1);
			}
		}
	}
}
