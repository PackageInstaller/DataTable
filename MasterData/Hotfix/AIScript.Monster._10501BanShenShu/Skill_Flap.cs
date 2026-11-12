#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Flap : SkillSimpleBase
{
	private static readonly int StandbyIndex = 0;

	private static readonly string StandbyAction = "Standby";

	private static readonly int Flap_L_Index = 1;

	private static readonly string Flap_L_Action = "Flap_L";

	private static readonly int Flap_R_Index = 2;

	private static readonly string Flap_R_Action = "Flap_R";

	private static readonly int FlapEndIndex = 3;

	private static readonly string FlapEndAction = "FlapEnd";

	private static readonly string FeedbackEffect_L = "ShakeEffect_L";

	private static readonly string Flap_L_Warning = "fx_m10501_loop_Skill9_l_warning";

	private static readonly string Flap_R_Warning = "fx_m10501_loop_Skill9_r_warning";

	private readonly string FlapFx_L = "fx_10501_base_Skill9_l";

	private readonly string FlapFx_ATK_L = "fx_10501_base_Skill9_l_atk";

	private readonly string FlapFx_R = "fx_10501_base_Skill9_r";

	private readonly string FlapFx_ATK_R = "fx_10501_base_Skill9_r_atk";

	private static long FlapFxIndex;

	private readonly TSVector2 FlapPOS_L = new TSVector2(1.75, 14.25);

	private readonly TSVector2 FlapPOS_R = new TSVector2(-0.75, 14.25);

	private static readonly TSVector2 WarningPOS_L = new TSVector2(1.75, 14.25);

	private static readonly TSVector2 WarningPOS_R = new TSVector2(-0.75, 14.25);

	private List<long> FxWarningList_L = new List<long>();

	private List<long> FxWarningList_R = new List<long>();

	private static DeterministicShape Shape;

	private static HitFeatureData HitData;

	private static TSVector2 HitPOS;

	private static FP Width = 3.2;

	private static FP Length = 11;

	private static FP Rotation;

	private static FP Angle;

	private static FP SelfAngle;

	private static FP TargetAngle;

	private static FP RelativeAngle;

	private readonly string SpikeWeedFx = "FSpikeweed_Warning";

	private CoroutineNode TrapCor;

	private TSVector2 shapePOS;

	private bool attackSwitch_1;

	private bool attackSwitch_2;

	private bool attackSwitch_3;

	private int shape01Count = 2;

	private int shape02Count = 1;

	private int shape03Count = 1;

	private List<TSVector2> _shapeChoicePOS = new List<TSVector2>();

	protected override void OnSkillEnable()
	{
		attackSwitch_1 = false;
		attackSwitch_2 = false;
		attackSwitch_3 = false;
	}

	protected override void OnSkillDisable()
	{
		_shapeChoicePOS.Clear();
		StopCor(TrapCor);
		if (FlapFxIndex != 0L)
		{
			StopEffect(FlapFxIndex);
		}
		if (FxWarningList_L.Count > 0)
		{
			for (int i = 0; i < FxWarningList_L.Count; i++)
			{
				StopEffect(FxWarningList_L.get_Item(i));
			}
		}
		else if (FxWarningList_R.Count > 0)
		{
			for (int j = 0; j < FxWarningList_R.Count; j++)
			{
				StopEffect(FxWarningList_R.get_Item(j));
			}
		}
		FxWarningList_L.Clear();
		FxWarningList_R.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (!GetLogicTagToggleValue(_actor, "skillIsRunning"))
		{
			TrapCor = StartCor(TrapArea());
		}
		yield return StartCor(Flap_Logic_Unilateral());
	}

	protected IEnumerator Warning_L_Unilateral()
	{
		NovaLogger.Debug("进入预警");
		FxWarningList_L.Add(PlayEffect(Flap_L_Warning, 0.45f, default, WarningPOS_L, Angle));
		yield return WaitTime(0.6);
		FxWarningList_L.Add(PlayEffect(Flap_L_Warning, 0.5f, default, WarningPOS_L, Angle + 20));
		yield return WaitTime(0.8);
		FxWarningList_L.Add(PlayEffect(Flap_L_Warning, 0.5f, default, WarningPOS_L, Angle + 42));
		PlayEffect(FlapFx_ATK_L, 1f, default, WarningPOS_L, Angle);
		yield return WaitTime(0.32);
		PlayFeedbackEffect(FeedbackEffect_L);
		attackSwitch_1 = true;
		yield return WaitTime(0.03);
		StopEffect(FxWarningList_L.get_Item(0));
		HitPOS = new TSVector2(4.5, 8.4);
		Rotation = 0;
		Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, HitPOS, Width, Length, default, default, default, Rotation);
		AreaHit_Simple(_actor, Shape, HitData, 1050140, 1, HitBox.HurtAnimType.Small, "fx_common_hit_dark_center");
		yield return WaitTime(0.3);
		PlayEffect(FlapFx_ATK_L, 1f, default, WarningPOS_L, Angle + 20);
		yield return WaitTime(0.32);
		PlayFeedbackEffect(FeedbackEffect_L);
		attackSwitch_2 = true;
		yield return WaitTime(0.03);
		StopEffect(FxWarningList_L.get_Item(1));
		HitPOS = new TSVector2(6.2, 9.6);
		Rotation = 20;
		Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, HitPOS, Width, Length, default, default, default, Rotation);
		AreaHit_Simple(_actor, Shape, HitData, 1050140, 1, HitBox.HurtAnimType.Small, "fx_common_hit_dark_center");
		yield return WaitTime(0.25);
		PlayEffect(FlapFx_ATK_L, 1f, default, WarningPOS_L, Angle + 42);
		yield return WaitTime(0.32);
		PlayFeedbackEffect(FeedbackEffect_L);
		attackSwitch_3 = true;
		yield return WaitTime(0.03);
		StopEffect(FxWarningList_L.get_Item(2));
		HitPOS = new TSVector2(7.7, 11.7);
		Rotation = 42;
		Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, HitPOS, Width, Length, default, default, default, Rotation);
		AreaHit_Simple(_actor, Shape, HitData, 1050140, 1, HitBox.HurtAnimType.Small, "fx_common_hit_dark_center");
	}

	protected IEnumerator FlapAttack_L_Unilateral()
	{
		BeginAttack(StandbyIndex, StandbyAction);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		BeginAttack(Flap_L_Index, Flap_L_Action, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(3.2);
		CancelAttack();
		BeginAttack(FlapEndIndex, FlapEndAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		NovaLogger.Debug("动作结束");
	}

	protected IEnumerator Warning_R_Unilateral()
	{
		FxWarningList_R.Add(PlayEffect(Flap_R_Warning, 0.53f, default, WarningPOS_R, Angle));
		yield return WaitTime(0.6);
		FxWarningList_R.Add(PlayEffect(Flap_R_Warning, 0.5f, default, WarningPOS_R, Angle - 20));
		yield return WaitTime(0.8);
		FxWarningList_R.Add(PlayEffect(Flap_R_Warning, 0.5f, default, WarningPOS_R, Angle - 42));
		PlayEffect(FlapFx_ATK_R, 1f, default, WarningPOS_R, Angle);
		yield return WaitTime(0.32);
		PlayFeedbackEffect(FeedbackEffect_L);
		attackSwitch_1 = true;
		yield return WaitTime(0.03);
		StopEffect(FxWarningList_R.get_Item(0));
		HitPOS = new TSVector2(-4.1, 8.1);
		Rotation = 0;
		Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, HitPOS, Width, Length, default, default, default, Rotation);
		AreaHit_Simple(_actor, Shape, HitData, 1050140, 1, HitBox.HurtAnimType.Small, "fx_common_hit_dark_center");
		yield return WaitTime(0.3);
		PlayEffect(FlapFx_ATK_R, 1f, default, WarningPOS_R, Angle - 20);
		yield return WaitTime(0.32);
		PlayFeedbackEffect(FeedbackEffect_L);
		attackSwitch_2 = true;
		yield return WaitTime(0.03);
		StopEffect(FxWarningList_R.get_Item(1));
		HitPOS = new TSVector2(-6, 9.6);
		Rotation = -20;
		Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, HitPOS, Width, Length, default, default, default, Rotation);
		AreaHit_Simple(_actor, Shape, HitData, 1050140, 1, HitBox.HurtAnimType.Small, "fx_common_hit_dark_center");
		yield return WaitTime(0.25);
		PlayEffect(FlapFx_ATK_R, 1f, default, WarningPOS_R, Angle - 42);
		yield return WaitTime(0.32);
		PlayFeedbackEffect(FeedbackEffect_L);
		attackSwitch_3 = true;
		yield return WaitTime(0.03);
		StopEffect(FxWarningList_R.get_Item(2));
		HitPOS = new TSVector2(-7.4, 11.9);
		Rotation = -42;
		Shape = GetShapeData(DeterministicShape.ShapeType.Rectangle, HitPOS, Width, Length, default, default, default, Rotation);
		AreaHit_Simple(_actor, Shape, HitData, 1050140, 1, HitBox.HurtAnimType.Small, "fx_common_hit_dark_center");
	}

	protected IEnumerator FlapAttack_R_Unilateral()
	{
		BeginAttack(StandbyIndex, StandbyAction);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		BeginAttack(Flap_R_Index, Flap_R_Action, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(3.2);
		CancelAttack();
		BeginAttack(FlapEndIndex, FlapEndAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		NovaLogger.Debug("动作结束");
	}

	protected IEnumerator Flap_Logic_Unilateral()
	{
		Angle = GetEntityAngle(_actor);
		HitData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
		SelfAngle = GetEntityAngle(_actor);
		TargetAngle = GetEntityAngle(GetCurrentPlayer());
		RelativeAngle = AngleBetween2TSVector(new TSVector2(0, 1) - new TSVector2(0, 0), GetEntityPositionObsoleted(GetCurrentPlayer()), signed: true);
		FP fxAngle = GetRotation();
		if (RelativeAngle < 0)
		{
			StartCor(FlapAttack_L_Unilateral());
			yield return WaitTime(1);
			StartCor(Warning_L_Unilateral());
			yield return WaitTime(1.2);
			FlapFxIndex = PlayEffect(FlapFx_L, 0.95f, default, FlapPOS_L, fxAngle);
			yield return WaitTime(0.3);
			for (int i = 0; i < 2; i++)
			{
				yield return WaitTime(0.6);
				BeginRotateEffect(FlapFxIndex, 20, 100);
			}
			yield return WaitTime(0.6);
			if (FlapFxIndex != 0L)
			{
				StopEffect(FlapFxIndex);
			}
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			StartCor(FlapAttack_R_Unilateral());
			yield return WaitTime(1);
			StartCor(Warning_R_Unilateral());
			yield return WaitTime(1.2);
			FlapFxIndex = PlayEffect(FlapFx_R, 0.95f, default, FlapPOS_R, fxAngle);
			yield return WaitTime(0.3);
			for (int i = 0; i < 2; i++)
			{
				yield return WaitTime(0.6);
				BeginRotateEffect(FlapFxIndex, -20, 100);
			}
			yield return WaitTime(0.6);
			if (FlapFxIndex != 0L)
			{
				StopEffect(FlapFxIndex);
			}
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected IEnumerator TrapArea()
	{
		for (int i = 0; i < 100; i++)
		{
			if (attackSwitch_1)
			{
				for (int j = 0; j < shape01Count; j++)
				{
					shapePOS = GetEntityPositionObsoleted(GetCurrentPlayer());
					DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, shapePOS, default, default, 6, 3);
					_shapeChoicePOS.Add(GetShapeRandomPoint(shapeData, GetCurrentPlayer(), isReachable: true));
				}
				for (int k = 0; k < _shapeChoicePOS.Count; k++)
				{
					PlayAreaEffect(SpikeWeedFx, _shapeChoicePOS.get_Item(k));
				}
				attackSwitch_1 = false;
				_shapeChoicePOS.Clear();
			}
			else if (attackSwitch_2)
			{
				for (int l = 0; l < shape02Count; l++)
				{
					shapePOS = GetEntityPositionObsoleted(GetCurrentPlayer());
					DeterministicShape shapeData2 = GetShapeData(DeterministicShape.ShapeType.Circle, shapePOS, default, default, 4, 2);
					_shapeChoicePOS.Add(GetShapeRandomPoint(shapeData2, GetCurrentPlayer(), isReachable: true));
				}
				for (int m = 0; m < _shapeChoicePOS.Count; m++)
				{
					PlayAreaEffect(SpikeWeedFx, _shapeChoicePOS.get_Item(m));
				}
				attackSwitch_2 = false;
				_shapeChoicePOS.Clear();
			}
			else if (attackSwitch_3)
			{
				for (int n = 0; n < shape03Count; n++)
				{
					shapePOS = GetEntityPositionObsoleted(GetCurrentPlayer());
					DeterministicShape shapeData3 = GetShapeData(DeterministicShape.ShapeType.Circle, shapePOS, default, default, 1, 0);
					_shapeChoicePOS.Add(GetShapeRandomPoint(shapeData3, GetCurrentPlayer(), isReachable: true));
				}
				for (int num = 0; num < _shapeChoicePOS.Count; num++)
				{
					PlayAreaEffect(SpikeWeedFx, _shapeChoicePOS.get_Item(num));
				}
				attackSwitch_3 = false;
				_shapeChoicePOS.Clear();
			}
			yield return WaitTime(0.3);
		}
		yield return null;
	}
}
