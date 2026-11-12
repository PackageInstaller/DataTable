using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Water;

public class Skill_Attack_S_LD : SkillBaseXingXing
{
	private LogicEntity target;

	private static readonly string WarningFx_ATKL = "fx_m50011_base_skill4_charge_Rhand_S";

	private List<long> _ATKLFx = new List<long>();

	protected override void OnSkillEnable()
	{
		_ATKLFx.Clear();
	}

	protected override void OnSkillDisable()
	{
		if (_ATKLFx.Count > 0)
		{
			for (int i = 0; i < _ATKLFx.Count; i++)
			{
				StopEffect(_ATKLFx.get_Item(i));
			}
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		yield return BeginLookAtByPos(GetEntityPositionObsoleted(target), 0.2, 900);
		BeginAttack(SkillBaseXingXing.ATKSIndex, SkillBaseXingXing.ATKSKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.4);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
		ElementalSkill();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == 0 && eventName == "HitFrame")
		{
			HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 3);
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-1, 3));
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, 3, 0, default, GetRotation());
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50011011, 0, HitBox.HurtAnimType.Small, "fx_m50011_base_skill4_hit_L");
		}
	}

	private void ElementalSkill()
	{
		int aiType = GetAiType();
		if (aiType != 0 && aiType == 1)
		{
			TriggerArea();
		}
	}
}
