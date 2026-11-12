using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Attack_OctopusBattery : SkillSimpleBase
{
	private static readonly string combo_Attack = "Attack";

	private LogicEntity targetEnemy;

	private int phase;

	private long WarningFX;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(WarningFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		while (true)
		{
			if (phase >= 2)
			{
				GetEnemy();
				if (targetEnemy != null)
				{
					BeginLookAt_NotWait(targetEnemy, 5, 720);
				}
				BeginAttack(1, combo_Attack, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(5);
				CancelAttack();
				WarningFX = PlayEffect("fx_common_base_charge_water_actor", 1f, 1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5)), 0);
				yield return WaitTime(0.2);
				StopEffect(WarningFX);
				TSVector2 shootPosition = GetPosition() + TSVector2.Rotate(new TSVector2(0, 1f), _actor.tsTransform.Rotation);
				FanMultipleShoot("Bullet_31302ZhangYuPaoTai_Skill01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 4, 0, shootPosition, 1.2, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 90, 0, 0);
				yield return WaitTime(0.8);
				GetEnemy();
				if (targetEnemy != null)
				{
					BeginLookAt_NotWait(targetEnemy, 1.5, 720);
				}
				BeginAttack(1, combo_Attack, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(1.5);
				CancelAttack();
				WarningFX = PlayEffect("fx_common_base_charge_water_actor", 1f, 1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5)), 0);
				yield return WaitTime(0.2);
				StopEffect(WarningFX);
				TSVector2 shootPosition2 = GetPosition() + TSVector2.Rotate(new TSVector2(0, 1f), _actor.tsTransform.Rotation);
				FanMultipleShoot("Bullet_31302ZhangYuPaoTai_Skill01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 4, 0, shootPosition2, 1.2, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 90, 0, 0);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
			else
			{
				GetEnemy();
				if (targetEnemy != null)
				{
					BeginLookAt_NotWait(targetEnemy, 5, 720);
				}
				BeginAttack(1, combo_Attack, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(5);
				CancelAttack();
				WarningFX = PlayEffect("fx_common_base_charge_water_actor", 1f, 1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5)), 0);
				yield return WaitTime(0.2);
				StopEffect(WarningFX);
				TSVector2 shootPosition3 = GetPosition() + TSVector2.Rotate(new TSVector2(0, 1f), _actor.tsTransform.Rotation);
				FanMultipleShoot("Bullet_31302ZhangYuPaoTai_Skill01", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 3, 0, shootPosition3, 1.2, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 90, 0, 0);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
	}

	private void GetEnemy()
	{
		targetEnemy = GetAttackTarget();
		if (targetEnemy == null)
		{
			targetEnemy = GetCurrentPlayer();
		}
	}
}
