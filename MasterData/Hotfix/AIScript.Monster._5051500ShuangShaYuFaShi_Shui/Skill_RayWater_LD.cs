#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._5051500ShuangShaYuFaShi_Shui;

public class Skill_RayWater_LD : SkillSimpleBase
{
	private readonly string laserFx = "fx_50020_loop_LaserForward_Laser_W";

	private long laserFxIndex;

	private readonly int RayIndex;

	private readonly string RayKey = "RayWater";

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("水鲨鱼法师.技能开始");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("水鲨鱼法师.技能结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(RayIndex, RayKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.7, 185);
		yield return WaitTime(0.7);
		StopLookAt();
		PlayEffect("fx_common_base_Dash_YuJing_10_start", 1f, default, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		FP atkTime = 0.5;
		FP atkINTR = 0.08;
		TSVector2 targetPOS = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2));
		HitFeatureData hitFeature = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
		GetShapeData(DeterministicShape.ShapeType.Circle, targetPOS, default, default, 1, 0);
		for (int i = 0; i < atkTime / atkINTR; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, targetPOS, default, default, 1, 0);
			AreaHit_Simple(_actor, shapeData, hitFeature, 50020321, 0.5, HitBox.HurtAnimType.Small, "fx_50020_hit_atk_water");
			laserFxIndex = PlayLinkEffect(laserFx, useCustomSource: true, _actor, default, default, null, targetPOS);
			yield return WaitTime(atkINTR);
			targetPOS = TransLocalPosToWorldPos(targetPOS, GetForward(), new TSVector2(0, 1));
			StopEffect(laserFxIndex);
			TSVector2 tSVector = targetPOS;
			NovaLogger.Debug("鲨鱼法师.水射线.攻击坐标位置为" + tSVector.ToString());
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "warningFx")
		{
			PlayEffect("fx_common_base_charge_fire_actor", 1f, 1.2f, GetPosition(), default, 2f);
		}
	}
}
