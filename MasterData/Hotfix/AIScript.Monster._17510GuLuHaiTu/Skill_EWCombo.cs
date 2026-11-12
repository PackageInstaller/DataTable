#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_EWCombo : SkillSimpleBase
{
	private string exhaleChargeKey = "Exhale_Charge";

	private string exhaleAttackKey = "Exhale_Attack";

	private string exhaleStartKey = "Exhale_Start";

	private string hitEffect = "fx_common_hit_water_strike";

	private string actionStateTagName = "AcitonFinish";

	private bool sentEvent;

	private CoroutineNode DamegeCor;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔.吐息.开始");
		SetLogicTagToggleValue(_actor, actionStateTagName, value: false);
		sentEvent = false;
	}

	protected override void OnSkillDisable()
	{
		StopCor(DamegeCor);
		if (!sentEvent)
		{
			SetLogicTagToggleValue(_actor, actionStateTagName, value: true);
		}
		NovaLogger.Debug("咕噜海兔.吐息.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, exhaleStartKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.7);
		BeginAttack(1, exhaleChargeKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 8.5));
		PlayEffect("fx_warning_square_3side_8x24", 0.5f, 1f, position, GetEntityAngle(_actor));
		yield return WaitTime(0.75);
		DispatchCustomEvent("VerticalWave");
		sentEvent = true;
		yield return WaitTime(0.25);
		CancelAttack();
		BeginAttack(2, exhaleAttackKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.7);
		position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4));
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 1.5f, position, GetEntityAngle(_actor), 6f);
		yield return WaitTime(0.3);
		DamegeCor = StartCor(Damage());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(1);
		CancelAttack();
		yield return WaitTime(0.2);
		StopCor(DamegeCor);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Damage()
	{
		for (int i = 0; i < 99; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TSVector2.zero, 7.5, 25);
			Skill_EWCombo skill_EWCombo = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_EWCombo.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 17510011, 0.5, HitBox.HurtAnimType.Small, hitEffect);
			yield return WaitTime(0.5);
		}
		yield return null;
	}
}
