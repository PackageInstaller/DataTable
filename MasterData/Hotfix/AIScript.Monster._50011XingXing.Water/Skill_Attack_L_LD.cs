using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Water;

public class Skill_Attack_L_LD : SkillBaseXingXing
{
	private LogicEntity target;

	private static readonly string WarningFx_ATKL = "fx_m50011_base_skill4_hint_L";

	private static readonly string Charge_ATKL = "fx_m50011_loop_skill4_charge_Rhand_L";

	private static readonly string hitFx = "fx_common_hit_water_strike";

	private List<long> _ATKLFx = new List<long>();

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		if (_ATKLFx.Count > 0)
		{
			for (int i = 0; i < _ATKLFx.Count; i++)
			{
				StopEffect(_ATKLFx.get_Item(0));
			}
		}
		_ATKLFx.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		double ChargeRHandBegin = 0.3;
		double WarningBegin = 0.77 - ChargeRHandBegin;
		ElementalSkill();
		yield return BeginLookAtByPos(GetEntityPositionObsoleted(target), 0.2, 300);
		BeginAttack(SkillBaseXingXing.ATKLIndex, SkillBaseXingXing.ATKLKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(ChargeRHandBegin);
		_ATKLFx.Add(PlayEffect(Charge_ATKL, 1f, default, default, default, 1f, actorScale: true));
		yield return WaitTime(WarningBegin);
		if (_ATKLFx.Count > 0)
		{
			for (int i = 0; i < _ATKLFx.Count; i++)
			{
				StopEffect(_ATKLFx.get_Item(i));
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == 0 && eventName == "HitFrame")
		{
			HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 3);
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, GetPosition(), default, default, 4, 0, 160, GetRotation());
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50011011, 0, HitBox.HurtAnimType.Small, hitFx);
		}
	}

	protected IEnumerator turnLATKFlow()
	{
		FP atkRotation = GetTSVectToAngle(GetForward(), 60);
		BeginAttack(SkillBaseXingXing.TurnATKLIndex, SkillBaseXingXing.TurnATKLKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		StartCor(Damage(atkRotation));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator turnRATKFlow()
	{
		FP atkRotation = GetTSVectToAngle(GetForward(), -60);
		BeginAttack(SkillBaseXingXing.TurnATKRIndex, SkillBaseXingXing.TurnATKRKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		StartCor(Damage(atkRotation));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Damage(FP rotation)
	{
		for (int i = 0; i < 1; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, GetPosition(), default, default, 4.5, default, 240, rotation);
			HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50011013, 0.5, HitBox.HurtAnimType.Small, "fx_50601JinDuanLiRong_hit_Skill01");
			yield return WaitTime(0.05);
		}
		yield return null;
	}

	private void ElementalSkill()
	{
		int aiType = GetAiType();
		if (aiType != 0 && aiType == 1 && GetRandomValue(0, 1) >= 0.5)
		{
			StartCor(WaterArea());
		}
	}
}
