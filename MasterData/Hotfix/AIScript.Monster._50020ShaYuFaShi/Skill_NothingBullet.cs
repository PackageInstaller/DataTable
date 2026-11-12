using System.Collections;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_NothingBullet : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Shoot", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		FanMultipleShoot("ShaYuFaShi_NothingBullet", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 2);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
