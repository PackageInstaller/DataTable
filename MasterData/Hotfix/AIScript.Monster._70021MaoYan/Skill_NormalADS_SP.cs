#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_NormalADS_SP : SkillSimpleBase
{
	private readonly string Aim2Fire = "N_ADS_SP_Aim2Fire";

	private readonly int AimIndex = 1;

	private readonly FP RotateTime_Attack = 0.8;

	private readonly FP RptateSpd_Attack = 40;

	private readonly FP AttackWaitTime = 0.3;

	private readonly FP RotateTime_Attack_2 = 0.5;

	private readonly string FxAlias_1 = "fx_70021_loop_atk_LockOn_Laser_com01";

	private readonly float PlaybackSpd_1 = 1f;

	private readonly FP FxPositionY_1 = 1.7;

	private TSVector2 Position_1;

	private readonly string FxAlias_2 = "fx_70021_loop_atk_LockOn_Laser_Burst";

	private readonly float PlaybackSpd_2 = 1f;

	private readonly FP FxPositionY_2 = 1.7;

	private TSVector2 Position_2;

	private DeterministicShape Rect_1;

	private TSVector2 ShapePOS;

	private FP ShapeW = 0.3;

	private readonly FP ShapeL = 50;

	private FP ShapeRot;

	private HitFeatureData RectHitData_1;

	private readonly int RectHitDamegeID_1 = 70021141;

	private readonly FP DamegeImmuneDuration_1 = 0.3;

	private readonly string HittedEffectAlias = "fx_70021_hit_atk_Strike_com";

	private readonly string LRDodge = "LR_Dodge";

	private readonly int LRIndex = 2;

	private readonly string RRDodge = "RR_Dodge";

	private readonly int RRIndex = 3;

	private readonly string LFRDodge = "LFR_Dodge";

	private readonly int LFRIndex = 4;

	private readonly string BDodge = "B_Dodge";

	private readonly int BIndex = 5;

	private readonly string FDodge = "F_Dodge";

	private readonly int FIndex = 6;

	private readonly FP MaxThreshold = 9;

	private readonly FP MidThreshold = 6;

	private readonly FP MinThreshold = 4;

	private readonly TSVector2 ZeroPosition = new TSVector2(0, 0);

	private DeterministicShape Fan;

	private TSVector2 FanPosition;

	private readonly FP FanRadius_B = 12;

	private readonly FP FanInnerRadius_B = 10.5;

	private readonly FP FanAngle_B = 10;

	private readonly FP FanRadius_F = 6;

	private readonly FP FanInnerRadius_F = 5;

	private readonly FP FanAngle_F = 10;

	private readonly FP FanRadius_LR = 7;

	private readonly FP FanInnerRadius_LR = 6;

	private readonly FP FanAngle_LR = 10;

	private readonly FP FanRadius_LFR = 7;

	private readonly FP FanInnerRadius_LFR = 6;

	private readonly FP FanAngle_LFR = 10;

	private FP FanRotation;

	private readonly int DashIndex = 6;

	private TSVector2 DashDirection;

	private FP DashSpeed;

	private FP DashDistance;

	private readonly FP DashAngleLimit = 720;

	private LogicEntity Target;

	private FP HitLoopTime;

	private FP DIST;

	private FP SelfAngle;

	private TSVector2 MoveTargetPoint;

	private TSVector2 SelfPosition;

	private TSVector2 PlayerPosition;

	private int ChooseDirection;

	protected override void OnSkillEnable()
	{
		ShapeW = 0.3;
	}

	protected override void OnSkillDisable()
	{
		HitLoopTime = 0;
		ShapeW = 0;
		DIST = 0;
		DashDistance = 0;
		ResetBlockPriority();
	}

	protected override IEnumerator DoMainLogic()
	{
		Target = GetCurrentPlayer();
		if (Target == null)
		{
			InterruptSkill();
		}
		yield return StartCoroutine(Dodge());
		BeginAttack(AimIndex, Aim2Fire, flushInputedKeys: true, forceInterruptAttack: true);
		NovaLogger.Debug("释放技能，进入转向阶段");
		WaitLookAt_NoWait(Target, 0.3, 720);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		NovaLogger.Debug("开始攻击");
		PlayEffect("fx_common_base_charge_fire_actor", 1f, 1.25, GetPosition(), default, 3f);
		yield return WaitTime(AttackWaitTime);
		Position_1 = GetPosition();
		long FxID_1 = PlayEffect(FxAlias_1, PlaybackSpd_1, FxPositionY_1, Position_1);
		RectHitData_1 = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 3);
		WaitLookAt_NoWait(Target, RotateTime_Attack, RptateSpd_Attack);
		while (HitLoopTime <= RotateTime_Attack)
		{
			FP shapeW = ShapeW;
			NovaLogger.Debug("进入循环攻击,攻击宽度为" + shapeW.ToString());
			ShapeRot = GetRotation();
			ShapePOS = TransLocalPosToWorldPos(Position_1, GetForward(), new TSVector2(0, ShapeL / 2));
			Rect_1 = GetShapeData(DeterministicShape.ShapeType.Rectangle, ShapePOS, ShapeW, ShapeL, default, default, default, ShapeRot);
			AreaHit_Simple(_actor, Rect_1, RectHitData_1, RectHitDamegeID_1, DamegeImmuneDuration_1, HitBox.HurtAnimType.Small, HittedEffectAlias);
			HitLoopTime += (FP)0.3;
			yield return WaitTime(0.3);
		}
		HitLoopTime = 0;
		StopEffect(FxID_1);
		StopWaitLookAt();
		Position_2 = GetPosition();
		long FxID_2 = PlayEffect(FxAlias_2, PlaybackSpd_2, FxPositionY_2, Position_2);
		while (HitLoopTime <= RotateTime_Attack_2)
		{
			ShapeW = 1;
			ShapeRot = GetRotation();
			ShapePOS = TransLocalPosToWorldPos(Position_1, GetForward(), new TSVector2(0, ShapeL / 2));
			Rect_1 = GetShapeData(DeterministicShape.ShapeType.Rectangle, ShapePOS, ShapeW, ShapeL, default, default, default, ShapeRot);
			AreaHit_Simple(_actor, Rect_1, RectHitData_1, RectHitDamegeID_1, DamegeImmuneDuration_1, HitBox.HurtAnimType.Small, HittedEffectAlias);
			HitLoopTime += (FP)0.2;
			yield return WaitTime(0.2);
		}
		StopEffect(FxID_2);
		yield return WaitTime(0.2);
		CancelAttack();
		RemoveBuffFromTarget(_actor, 70021130);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Dodge()
	{
		Target = GetCurrentPlayer();
		if (Target == null)
		{
			InterruptSkill();
		}
		SelfPosition = GetPosition();
		SelfAngle = GetTSVectToAngle(ZeroPosition - SelfPosition, 0);
		PlayerPosition = GetEntityPosition(Target);
		DIST = Distance(SelfPosition, PlayerPosition);
		FanPosition = SelfPosition;
		if (DIST < MinThreshold)
		{
			NovaLogger.Debug("近距离");
			FanRotation = GetTSVectToAngle(SelfPosition - PlayerPosition, 0);
			Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_B, FanInnerRadius_B, FanAngle_B, FanRotation);
			MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
			DashDirection = MoveTargetPoint - SelfPosition;
			DashDistance = Distance(SelfPosition, MoveTargetPoint);
			DashSpeed = DashDistance / 0.66;
			BeginLookAt_NotWait(Target, 0, 720);
			BeginAttack(BIndex, BDodge, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.1);
			BeginDash(DashIndex, DashDirection, DashSpeed, DashDistance, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
		}
		else if (MidThreshold > DIST && DIST >= MinThreshold)
		{
			NovaLogger.Debug("中近距离");
			ChooseDirection = (int)(long)GetRandomValue(0, 1.5);
			if (ChooseDirection == 0)
			{
				NovaLogger.Debug("左边");
				FanRotation = GetTSVectToAngle(PlayerPosition - SelfPosition, -140);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_LR, FanInnerRadius_LR, FanAngle_LR, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - SelfPosition;
				DashDistance = Distance(SelfPosition, MoveTargetPoint);
				DashSpeed = DashDistance / 0.66;
				BeginLookAtByPos_NotWait(MoveTargetPoint, 0, 720);
				BeginAttack(LRIndex, LRDodge, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.1);
				BeginDash(DashIndex, DashDirection, DashSpeed, DashDistance, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitTime(0.66);
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
			else
			{
				NovaLogger.Debug("右边");
				FanRotation = GetTSVectToAngle(PlayerPosition - SelfPosition, 140);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_LR, FanInnerRadius_LR, FanAngle_LR, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - SelfPosition;
				DashDistance = Distance(SelfPosition, MoveTargetPoint);
				DashSpeed = DashDistance / 0.66;
				BeginLookAtByPos_NotWait(MoveTargetPoint, 0, 720);
				BeginAttack(RRIndex, RRDodge, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitTime(0.1);
				BeginDash(DashIndex, DashDirection, DashSpeed, DashDistance, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitTime(0.66);
				CancelAttack();
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
		else if (DIST >= MidThreshold && MaxThreshold > DIST)
		{
			NovaLogger.Debug("选择中距离");
			ChooseDirection = (int)(long)GetRandomValue(0, 1.5);
			if (ChooseDirection == 0)
			{
				FanRotation = GetTSVectToAngle(PlayerPosition - SelfPosition, -70);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_F, FanInnerRadius_F, FanAngle_F, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - SelfPosition;
				DashDistance = Distance(SelfPosition, MoveTargetPoint);
				DashSpeed = DashDistance / 0.5;
				BeginLookAtByPos_NotWait(MoveTargetPoint, 0, 720);
				BeginAttack(FIndex, FDodge, flushInputedKeys: true, forceInterruptAttack: true);
				BeginDash(DashIndex, DashDirection, DashSpeed, DashDistance, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitTime(0.35);
				BeginLookAt_NotWait(Target, 0, 720);
				yield return WaitDashFinish();
			}
			else
			{
				FanRotation = GetTSVectToAngle(PlayerPosition - SelfPosition, 70);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_F, FanInnerRadius_F, FanAngle_F, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - SelfPosition;
				DashDistance = Distance(SelfPosition, MoveTargetPoint);
				DashSpeed = DashDistance / 0.5;
				BeginLookAtByPos_NotWait(MoveTargetPoint, 0, 720);
				BeginAttack(FIndex, FDodge, flushInputedKeys: true, forceInterruptAttack: true);
				BeginDash(DashIndex, DashDirection, DashSpeed, DashDistance, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitTime(0.35);
				BeginLookAt_NotWait(Target, 0, 720);
				yield return WaitDashFinish();
			}
		}
		else
		{
			NovaLogger.Debug("选择远距离");
			ChooseDirection = (int)(long)GetRandomValue(0, 1.5);
			if (ChooseDirection == 0)
			{
				NovaLogger.Debug("右边");
				FanRotation = GetTSVectToAngle(GetEntityPosition(Target) - FanPosition, -35);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_LFR, FanInnerRadius_LFR, FanAngle_LFR, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - SelfPosition;
				DashDistance = Distance(SelfPosition, MoveTargetPoint);
				DashSpeed = DashDistance / 0.4;
				BeginLookAtByPos_NotWait(MoveTargetPoint, 0, 720);
				BeginAttack(LFRIndex, LFRDodge, flushInputedKeys: true, forceInterruptAttack: true);
				BeginDash(DashIndex, DashDirection, DashSpeed, DashDistance, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitTime(0.35);
				CancelAttack();
				BeginLookAt_NotWait(Target, 0, 720);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
			else
			{
				NovaLogger.Debug("左边");
				FanRotation = GetTSVectToAngle(GetEntityPosition(Target) - FanPosition, 35);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_LFR, FanInnerRadius_LFR, FanAngle_LFR, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - SelfPosition;
				DashDistance = Distance(SelfPosition, MoveTargetPoint);
				DashSpeed = DashDistance / 0.4;
				BeginLookAtByPos_NotWait(MoveTargetPoint, 0, 720);
				BeginAttack(LFRIndex, LFRDodge, flushInputedKeys: true, forceInterruptAttack: true);
				BeginDash(DashIndex, DashDirection, DashSpeed, DashDistance, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
				yield return WaitTime(0.35);
				CancelAttack();
				BeginLookAt_NotWait(Target, 0, 720);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
	}
}
