using System.Collections;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Danmu_Phase_1 : SkillSimpleBase
{
	private string key_Base1 = "Stage1_Skill04_1";

	private string key_Base2 = "Stage1_Skill04_2";

	private string bulletDanmu = "Bullet_70001_Skill04_1";

	private string evt_Danmu = "evt_Danmu";

	private TSVector2 center = new TSVector2(0, -7.5);

	private LogicEntity Targetenemy;

	protected override void OnInterrupt(int comboIndex)
	{
		_actor.tsTransform.Forward = new TSVector2(0, -1);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key_Base1);
		yield return WaitFrame(44);
		BeginAttack(2, key_Base2, flushInputedKeys: true, forceInterruptAttack: true);
		GetEnemy();
		if (Targetenemy.tsTransform.Position.x < center.x)
		{
			BeginRotateAngle_NotWait(-50, 180);
			yield return WaitFrame(15);
			BeginRotateAngle_NotWait(180, 52);
			ShootFromRight();
			yield return WaitFrame(160);
			CancelAttack();
			BeginLookAtByDir_NotWait(center, 0, 150);
		}
		else
		{
			BeginRotateAngle_NotWait(110, 275);
			yield return WaitFrame(15);
			ShootFromLeft();
			yield return WaitFrame(20);
			BeginRotateAngle_NotWait(-170, 52);
			yield return WaitFrame(140);
			CancelAttack();
			BeginLookAtByDir_NotWait(center, 0, 100);
		}
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

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_Danmu))
		{
			DispatchCustomEvent(evt_Danmu, isSelfEvent: false);
		}
	}

	private void ShootFromLeft()
	{
		FanMultipleShoot(bulletDanmu, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 12, 4, new TSVector2(0, 0), 1.5, new TSVector2(0, -7.5) - new TSVector2(0, 0), 0, AimType.Default, BulletDirectionType.ActorToBullet, 170, 0, 5);
	}

	private void ShootFromRight()
	{
		FanMultipleShoot(bulletDanmu, AdventureWeapon.MultipleShootStyle.FromRightToLeft, alignShoot: false, 0, 12, 4, new TSVector2(0, 0), 1.5, new TSVector2(0, -7.5) - new TSVector2(0, 0), 0, AimType.Default, BulletDirectionType.ActorToBullet, 170, 0, 5);
	}
}
