using System.Collections;
using TrueSync;

namespace AIScript.Monster._Water._HardLevel._50020ShaYuFaShi;

public class HardLevel_Water_SpawnSkill : SkillSimpleBase
{
	private readonly string AreaName = "Area_50020ShaYuFaShi_HardLevel_Water_Skill02_Wave01";

	private readonly string WeaponName = "Weapon_50020ShaYuFaShi_HardLevel_Water_Skill02";

	protected override void OnSkillEnable()
	{
		SetHideModelEnable();
		SetUnparalleledDisable();
		SetSearchedImmunityEnable();
		SetCloseBlockEnable();
		SetHideOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 position = GetPosition();
		PlayAreaEffect(AreaName, position, -90);
		PlayAreaEffect(AreaName, position, 30);
		PlayAreaEffect(AreaName, position, 150);
		yield return WaitTime(2);
		CircleMultipleShoot(WeaponName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0);
		yield return WaitTime(5);
	}
}
