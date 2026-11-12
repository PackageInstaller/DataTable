using System.Collections;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_Cyclone : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Cyclone", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		FanMultipleShoot("ShaYuFaShi_Cyclone", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 3);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
