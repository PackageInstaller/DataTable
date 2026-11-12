#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_BreakATK_Ring : JinDuanLiRongSkillBase
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
		PlayEffect("fx_common_base_red_fan_360c_5r_14r", 0.5f, default, GetPosition());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.7);
		CancelAttack();
		BeginAttack(JinDuanLiRongSkillBase.breakEndIndex, JinDuanLiRongSkillBase.breakEndKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_50601JinDuanLiRong_base_RingATK_1", 1f, default, GetPosition());
		Damage();
		ModelNodeShow("comb", isShow: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Damage()
	{
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetPosition(), default, default, 14, 5);
		FP hitStrenth = 2;
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 50601311, 0.5, HitBox.HurtAnimType.Small, "fx_50601JinDuanLiRong_hit_Skill01");
	}
}
