using System.Collections;

namespace AIScript.Monster._50271FengMeiGuai;

public class Skill_SplitBullet : SkillSimpleBase
{
	private LogicEntity target;

	private readonly int SB_StartIndex;

	private readonly string SB_StartKey = "SplitBullet_Start";

	private readonly int SB_InhaleIndex = 1;

	private readonly string SB_InhaleKey = "SplitBullet_Inale";

	private readonly int SB_AttackIndex = 2;

	private readonly string SB_AttackKey = "SplitBullet_Attack";

	private string bullet = "FengMeiGuai_skill02_SplitBullet";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		StopLookAt();
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
		BeginAttack(SB_StartIndex, SB_StartKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.4);
		BeginAttack(SB_InhaleIndex, SB_InhaleKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.9);
		BeginAttack(SB_AttackIndex, SB_AttackKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 2, GetPosition(), default, 2.5f);
		yield return WaitTime(0.3);
		CancelAttack();
		StopLookAt();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == SB_AttackIndex && eventName == "beginShoot")
		{
			if (GetBuffNum(_actor, 502710000) >= 1)
			{
				FanMultipleShoot("FengMeiGuai_skill02_SplitBullet03", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 3);
			}
			else
			{
				FanMultipleShoot(bullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, GetPosition(), 0.5, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 5, 0, 3);
			}
		}
	}
}
