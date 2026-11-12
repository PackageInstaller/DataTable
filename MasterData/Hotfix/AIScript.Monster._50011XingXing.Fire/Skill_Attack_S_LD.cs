using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Fire;

public class Skill_Attack_S_LD : SkillSimpleBase
{
	private static readonly string WarningFx = "fx_common_base_charge_fire_actor";

	private static readonly int ATKSIndex = 0;

	private static readonly string ATKSKey = "NormalAttack_Short";

	private LogicEntity Target;

	private static readonly string hitFx = "fx_common_hit_fire_strike";

	private static readonly string WarningFx_ATKL = "fx_m50011_base_skill4_charge_Rhand_S_fire";

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
		if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
		{
			Target = GetAttackTarget(isUpToDate: true);
		}
		else
		{
			Target = GetCurrentPlayer();
		}
		BeginLookAtByPos_NotWait(GetEntityPositionObsoleted(Target), 0.2, 750);
		BeginAttack(ATKSIndex, ATKSKey, flushInputedKeys: true, forceInterruptAttack: true);
		_ATKLFx.Add(PlayEffect(WarningFx_ATKL, 1.4f, default, GetPosition(), default, 1f, actorScale: true));
		yield return WaitTime(0.4);
		_ATKLFx.Add(PlayEffect(WarningFx, 1f, 3.5, GetPosition(), default, 1.8f, actorScale: true));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == 0 && eventName == "HitFrame")
		{
			HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 3);
			TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-1, 3));
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, 3, 0, default, GetRotation());
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 50011011, 0, HitBox.HurtAnimType.Small, hitFx);
		}
	}
}
