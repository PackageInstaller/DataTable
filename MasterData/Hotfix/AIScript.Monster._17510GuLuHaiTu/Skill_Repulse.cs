#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_Repulse : SkillSimpleBase
{
	private bool interrupt;

	private string effect_Warn = "fx_m17510_loop_Skill05_warning";

	private string effect_Wave = "fx_m17510_bullet_Skill5_wave";

	private List<TSVector2> spawnPOS = new List<TSVector2>
	{
		new TSVector2(-8, 8),
		new TSVector2(0, 8),
		new TSVector2(8, 8)
	};

	private List<long> warningFxList = new List<long>();

	private List<TSVector2> fxPOSLis = new List<TSVector2>();

	private int RepulseTimes;

	private readonly int startIndex;

	private readonly string startKey = "FRepulse_Start";

	private readonly int attackIndex = 1;

	private readonly string attackKey = "FRepulse_Attack";

	private readonly int endIndex = 2;

	private readonly string endKey = "FRepulse_End";

	private readonly int FBIndex = 4;

	private readonly string FBKey = "FloorBreak";

	private readonly int RepulseIndex = 3;

	private readonly string RepulseKey = "Repulse_Attack_02";

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔.连续击退.开始");
		interrupt = true;
		RepulseTimes = 0;
	}

	protected override void OnSkillDisable()
	{
		if (interrupt)
		{
			SetUnparalleledDisable();
			SetSearchedImmunityDisable();
		}
		if ((warningFxList != null) & (warningFxList.Count > 0))
		{
			for (int i = 0; i < warningFxList.Count; i++)
			{
				StopEffect(warningFxList.get_Item(i));
			}
			warningFxList.Clear();
		}
		if (fxPOSLis != null && fxPOSLis.Count > 0)
		{
			fxPOSLis.Clear();
		}
		NovaLogger.Debug("咕噜海兔.连续击退.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(FrontalRepulse());
		yield return StartCor(SideRepulse());
		yield return StartCor(SideRepulse());
	}

	protected IEnumerator FrontalRepulse()
	{
		BeginAttack(startIndex, startKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		BeginAttack(attackIndex, attackKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		EnterSneakWithDynamicTransparentByDistance(15, 20, 0.5, 0.3);
		BeginDash(10, TSVector2.up, Distance(GetPosition(), new TSVector2(0, 50.5)), Distance(GetPosition(), new TSVector2(0, 50.5)), 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 1);
		yield return WaitTime(0.35);
		TriggerOpLisener("DeActiveObstruct");
		fxPOSLis.AddRange(spawnPOS);
		PlayWwiseSound("mon_17510_warning_3period");
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				warningFxList.Add(PlayEffect(effect_Warn, 1f, 0.7, fxPOSLis.get_Item(i), GetTSVectToAngle(GetForward(), 0)));
				fxPOSLis.set_Item(i, new TSVector2(fxPOSLis.get_Item(i).x, fxPOSLis.get_Item(i).y - 8));
			}
		}
		fxPOSLis.Clear();
		yield return WaitTime(0.5);
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.9);
		for (int k = 0; k < warningFxList.Count; k++)
		{
			StopEffect(warningFxList.get_Item(k));
		}
		warningFxList.Clear();
		CancelAttack();
		SetHideModelDisable();
		BeginDash(11, TSVector2.down, Distance(GetPosition(), new TSVector2(0, 18)) / 0.08, Distance(GetPosition(), new TSVector2(0, 18)), 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.08);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetSneakDisable();
	}

	protected IEnumerator SideRepulse()
	{
		StartCor(SideWarningFx());
		BeginAttack(FBIndex, FBKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(2);
		SetBattleOutEnable();
		SetHideModelEnable();
		if (RepulseTimes != 0)
		{
			Teleport(new TSVector2(0, 20.5));
			BeginLookAtByPos_NotWait(TSVector2.zero, 0.1, 9999);
		}
		else
		{
			Teleport(new TSVector2(-20.5, 0));
			BeginLookAtByPos_NotWait(TSVector2.zero, 0.1, 9999);
		}
		CancelAttack();
		SetBattleOutDisable();
		SetHideModelDisable();
		yield return WaitTime(0.55);
		BeginAttack(RepulseIndex, RepulseKey, flushInputedKeys: true, forceInterruptAttack: true);
		StartCor(SideAttack());
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (RepulseTimes != 0)
		{
			interrupt = false;
			SetUnparalleledDisable();
			SetSearchedImmunityDisable();
			yield return WaitTime(0.5);
			TriggerOpLisener("ActiveObstruct");
			BeginAttack(endIndex, endKey, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		RepulseTimes++;
	}

	protected override void OnDashFinish(int index)
	{
		if (index != 11)
		{
			return;
		}
		PlayFeedbackEffect("CameraShake_BanShenShu_Flap");
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TSVector2.zero, 25, 25);
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.KnockBack, 50, 11, UseAtttackForward: true, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 5);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 17510021, 1, HitBox.HurtAnimType.Large);
		fxPOSLis.AddRange(spawnPOS);
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				warningFxList.Add(PlayEffect(effect_Wave, 1f, 0.7, fxPOSLis.get_Item(i), GetTSVectToAngle(GetForward(), 0)));
				fxPOSLis.set_Item(i, new TSVector2(fxPOSLis.get_Item(i).x, fxPOSLis.get_Item(i).y - 8));
			}
		}
		fxPOSLis.Clear();
	}

	protected IEnumerator SideWarningFx()
	{
		PlayWwiseSound("mon_17510_warning_3period");
		TSVector2 value = ((RepulseTimes == 0) ? TSVector2.right : TSVector2.down);
		fxPOSLis.AddRange(spawnPOS);
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < 3; j++)
			{
				warningFxList.Add(PlayEffect(effect_Warn, 1f, 0.7, fxPOSLis.get_Item(i), GetTSVectToAngle(value, 0)));
				fxPOSLis.set_Item(i, new TSVector2(fxPOSLis.get_Item(i).x, fxPOSLis.get_Item(i).y - 8));
			}
		}
		fxPOSLis.Clear();
		yield break;
	}

	protected IEnumerator SideAttack()
	{
		for (int i = 0; i < warningFxList.Count; i++)
		{
			StopEffect(warningFxList.get_Item(i));
		}
		PlayFeedbackEffect("CameraShake_BanShenShu_Flap");
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, TSVector2.zero, 25, 25);
		HitFeatureData hitFeatureData = GetHitFeatureData(HitBox.FeatureFlag.KnockBack, 50, 11, UseAtttackForward: true, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 5);
		AreaHit_Simple(_actor, shapeData, hitFeatureData, 17510021, 1, HitBox.HurtAnimType.Large);
		fxPOSLis.AddRange(spawnPOS);
		for (int j = 0; j < 3; j++)
		{
			for (int k = 0; k < 3; k++)
			{
				warningFxList.Add(PlayEffect(effect_Wave, 1f, 0.7, fxPOSLis.get_Item(j), GetTSVectToAngle(GetForward(), 0)));
				fxPOSLis.set_Item(j, new TSVector2(fxPOSLis.get_Item(j).x, fxPOSLis.get_Item(j).y - 8));
			}
		}
		fxPOSLis.Clear();
		yield break;
	}
}
