using System.Collections;

namespace AIScript.Monster.Common;

public class Skill_TestAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		FanMultipleShoot("TestBullet", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, GetPosition(), 1, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0, 0);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0);
	}
}
