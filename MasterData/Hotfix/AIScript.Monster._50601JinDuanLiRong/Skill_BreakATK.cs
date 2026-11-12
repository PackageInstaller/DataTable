#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_BreakATK : JinDuanLiRongSkillBase
{
	private LogicEntity target;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("禁断丽容.解体攻击.开始");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("禁断丽容.解体攻击.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
		{
			target = GetAttackTarget(isUpToDate: true);
		}
		else
		{
			target = GetCurrentPlayer();
		}
		BeginAttack(JinDuanLiRongSkillBase.breakATKIndex, JinDuanLiRongSkillBase.breakATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_common_base_Fire_YuJing_circular_8", 0.7f, default, GetPosition());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		PlayEffect(warningFx, 1f, 3, GetPosition(), default, 3f);
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitTime(0.1);
		int num = 1;
		int bulletCount = 36;
		FP angle = 360;
		for (int i = 0; i < num; i++)
		{
			TSVector2 multiShootDirection = RotateTo(GetForward(), 360 / num * i);
			FanMultipleShoot("50601JinDuanLiRong_DiffusionBubble", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, bulletCount, 0, GetPosition(), 0, multiShootDirection, 0, AimType.Default, BulletDirectionType.ActorToBullet, angle, 0, 8);
			PlayWwiseSound("mon_50601_JC2_greencircle");
		}
		BeginAttack(JinDuanLiRongSkillBase.breakEndIndex, JinDuanLiRongSkillBase.breakEndKey, flushInputedKeys: true, forceInterruptAttack: true);
		ModelNodeShow("comb", isShow: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
