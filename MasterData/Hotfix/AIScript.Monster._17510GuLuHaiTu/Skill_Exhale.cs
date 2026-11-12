#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_Exhale : SkillSimpleBase
{
	private string exhaleChargeKey = "Exhale_Charge";

	private string exhaleAttackKey = "Exhale_Attack";

	private string exhaleStartKey = "Exhale_Start";

	private string hitEffect = "fx_common_hit_water_strike";

	private CoroutineNode DamegeCor;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔.吐息.开始");
	}

	protected override void OnSkillDisable()
	{
		StopCor(DamegeCor);
		NovaLogger.Debug("咕噜海兔.吐息.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, exhaleStartKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.7);
		BeginAttack(2, exhaleChargeKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 8.5));
		PlayEffect("fx_warning_square_3side_8x24", 0.5f, 1f, position, GetEntityAngle(_actor));
		yield return WaitTime(1);
		CancelAttack();
		BeginAttack(3, exhaleAttackKey, flushInputedKeys: true, forceInterruptAttack: true);
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
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TSVector2.zero, 6, 25);
			Skill_Exhale skill_Exhale = this;
			FP hitStrenth = 2;
			HitFeatureData hitFeatureData = skill_Exhale.GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
			AreaHit_Simple(_actor, shapeData, hitFeatureData, 17510011, 0.5, HitBox.HurtAnimType.Small, hitEffect);
			yield return WaitTime(0.5);
		}
		yield return null;
	}
}
