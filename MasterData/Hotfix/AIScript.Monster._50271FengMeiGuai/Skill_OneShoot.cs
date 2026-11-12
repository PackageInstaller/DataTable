using System.Collections;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_OneShoot : SkillSimpleBase
{
	private LogicEntity target;

	private readonly int OneShootIndex;

	private readonly string OneShootKey = "OneShoot";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			target = GetAttackTarget();
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(target, 3, 80);
		BeginAttack(OneShootIndex, OneShootKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(1);
		CancelAttack();
		PlayEffect("fx_50271_base_skill01_bullet_yujing");
		FanMultipleShoot("FengMeiGuai_skill01_bullet", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 3);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
