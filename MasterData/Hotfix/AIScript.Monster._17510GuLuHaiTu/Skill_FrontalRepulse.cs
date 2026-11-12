#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_FrontalRepulse : SkillSimpleBase
{
	private string effect_warning = "fx_m17510_loop_Skill05_warning";

	private string effect_wave = "fx_m17510_bullet_Skill5_wave";

	private List<TSVector2> spawnPOS = new List<TSVector2>
	{
		new TSVector2(-8, 8),
		new TSVector2(0, 8),
		new TSVector2(8, 8)
	};

	private List<long> warningFxList = new List<long>();

	private List<TSVector2> fxPOSLis = new List<TSVector2>();

	private readonly int startIndex;

	private readonly string startKey = "FRepulse_Start";

	private readonly int attackIndex = 1;

	private readonly string attackKey = "FRepulse_Attack";

	private readonly int endIndex = 2;

	private readonly string endKey = "FRepulse_End";

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔.正面冲撞.开始");
	}

	protected override void OnSkillDisable()
	{
		for (int i = 0; i < warningFxList.Count; i++)
		{
			StopEffect(warningFxList.get_Item(i));
		}
		warningFxList.Clear();
		fxPOSLis.Clear();
		NovaLogger.Debug("咕噜海兔.正面冲撞.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startIndex, startKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(attackIndex, attackKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		BeginDash(10, TSVector2.up, Distance(GetPosition(), new TSVector2(0, 50.5)), Distance(GetPosition(), new TSVector2(0, 50.5)), 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 1);
		yield return WaitTime(0.35);
		fxPOSLis.AddRange(spawnPOS);
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				warningFxList.Add(PlayEffect(effect_warning, 1f, 0.7, fxPOSLis.get_Item(i), GetTSVectToAngle(GetForward(), 0)));
				fxPOSLis.set_Item(i, new TSVector2(fxPOSLis.get_Item(i).x, fxPOSLis.get_Item(i).y - 8));
			}
		}
		fxPOSLis.Clear();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(1);
		for (int k = 0; k < warningFxList.Count; k++)
		{
			StopEffect(warningFxList.get_Item(k));
		}
		CancelAttack();
		BeginDash(11, TSVector2.down, Distance(GetPosition(), new TSVector2(0, 18)) / 0.08, Distance(GetPosition(), new TSVector2(0, 18)), 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.08);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(endIndex, endKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnDashFinish(int index)
	{
		if (index != 11)
		{
			return;
		}
		PlayFeedbackEffect("CameraShake_BanShenShu_Flap");
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TSVector2.zero, 25, 25);
		FP knockBackForce = 50;
		FP knockBackDistance = 17;
		FP hitStrenth = 5;
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.KnockBack, knockBackForce, knockBackDistance, UseAtttackForward: true, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 17510021, 1, HitBox.HurtAnimType.Large);
		fxPOSLis.AddRange(spawnPOS);
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				warningFxList.Add(PlayEffect(effect_wave, 1f, 0.7, fxPOSLis.get_Item(i), GetTSVectToAngle(GetForward(), 0)));
				fxPOSLis.set_Item(i, new TSVector2(fxPOSLis.get_Item(i).x, fxPOSLis.get_Item(i).y - 8));
			}
		}
		fxPOSLis.Clear();
	}
}
