using System.Collections;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Danmu2_Phase_1 : SkillSimpleBase
{
	private string key_Base1 = "Stage2_Skill10_1";

	private string key_Base2 = "Stage2_Skill10_2";

	private string evt_CastSkill = "evt_Danmu";

	private string bulletDanmu_down = "Bullet_70001_Skill10_Sweep";

	private string bulletDanmu_up_Door = "Bullet_70001_Skill10_Door_Start";

	private string bulletDanmu_up_Laser = "Bullet_70001_Skill10_Door_Loop";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base1);
		yield return WaitFrame(50);
		StartCor(Shoot02());
		Shoot01();
		yield return WaitFrame(40);
		BeginAttack(2, key_Base2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Shoot01()
	{
		FanMultipleShoot(bulletDanmu_down, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 8, 1, new TSVector2(1, -2), 2, new TSVector2(2, -6) - new TSVector2(1, -2), 0, AimType.Default, BulletDirectionType.ActorToBullet, 160, 0, 3);
		FanMultipleShoot(bulletDanmu_down, AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 8, 1, new TSVector2(-1, -2), 2, new TSVector2(-2, -6) - new TSVector2(-1, -2), 0, AimType.Default, BulletDirectionType.ActorToBullet, 160, 0, 3);
	}

	protected IEnumerator Shoot02()
	{
		FanMultipleShoot(bulletDanmu_up_Door, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 9, 1, new TSVector2(0, 0), 1, new TSVector2(0, -6) - new TSVector2(0, 0), 0, AimType.Default, BulletDirectionType.ActorToBullet, 160, 0, 4);
		yield return WaitFrame(15);
		FanMultipleShoot(bulletDanmu_up_Laser, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 9, 1, new TSVector2(0, 0), 1, new TSVector2(0, -6) - new TSVector2(0, 0), 0, AimType.Default, BulletDirectionType.ActorToBullet, 160, 0, 4);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_CastSkill))
		{
			DispatchCustomEvent(evt_CastSkill, isSelfEvent: false);
		}
	}
}
