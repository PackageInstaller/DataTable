#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_NormalADS_LD_02 : SkillSimpleBase
{
	private readonly string Aim2Fire = "N_ADS";

	private readonly int AimIndex = 1;

	private readonly string _2Stand = "N_ADS_Stand";

	private readonly int StandIndex = 2;

	private readonly FP AttackWaitTime = 1.2;

	private readonly FP RotateTime_Attack_2 = 0.5;

	private readonly string DodgeFxAlias = "fx_common_base_charge_fire_actor";

	private readonly FP DodgeFxPositionY = 1.2;

	private readonly string LineFxAlias = "fx_70021_loop_LockOn_Warning_Laser";

	private readonly bool UseCustomSource;

	private LogicEntity LineOrigin;

	private readonly FP SourcePositionY = 1.1;

	private LogicEntity LineTarget;

	private readonly bool BreakWhenLostSourceOrTarget = true;

	private readonly string FxAlias = "fx_70021_base_atk_LockOn_Laser_com02";

	private readonly float PlaybackSpd = 1f;

	private readonly FP FxPositionY = 1.7;

	private TSVector2 Position;

	private readonly string FxAlias02 = "fx_70021_loop_LockOn_Warning";

	private readonly float PlaybackSpd02 = 1f;

	private readonly FP FxPositionY02 = 1.7;

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

	private readonly int LRIndex = 3;

	private readonly string RRDodge = "RR_Dodge";

	private readonly int RRIndex = 4;

	private readonly string LFRDodge = "LFR_Dodge";

	private readonly int LFRIndex = 5;

	private readonly string BDodge = "B_Dodge";

	private readonly int BIndex = 6;

	private readonly string FDodge = "F_Dodge";

	private readonly int FIndex = 7;

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
		SetBlockPriorityToStatic();
	}

	protected override void OnSkillDisable()
	{
		DIST = 0;
		DashDistance = 0;
		ResetBlockPriority();
	}

	protected override IEnumerator DoMainLogic()
	{
		Target = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(Target))
		{
			InterruptSkill();
		}
		yield return StartCor(Dodge());
		LineOrigin = _actor;
		LineTarget = Target;
		BeginAttack(AimIndex, Aim2Fire, flushInputedKeys: true, forceInterruptAttack: true);
		NovaLogger.Debug("释放技能，进入转向阶段");
		BeginLookAt_NotWait(Target, 5, 720);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		long FxID_1 = PlayEffect(FxAlias02, PlaybackSpd02, FxPositionY02);
		long ID01 = PlayLinkEffect(LineFxAlias, UseCustomSource, LineOrigin, default, SourcePositionY, LineTarget, default, default, BreakWhenLostSourceOrTarget, 1f, actorScale: true);
		yield return WaitTime(AttackWaitTime);
		yield return WaitTime(0.2);
		PlayEffect(DodgeFxAlias, 1f, DodgeFxPositionY, GetPosition(), default, 3f);
		yield return WaitTime(0.2);
		StopEffect(ID01);
		StopWaitLookAt();
		yield return WaitTime(0.1);
		CancelAttack();
		HitLoopTime = 0;
		Position = GetPosition();
		long FxID_2 = PlayEffect(FxAlias, PlaybackSpd, FxPositionY, Position);
		StopEffect(FxID_1);
		while (HitLoopTime <= RotateTime_Attack_2)
		{
			ShapeW = 1;
			ShapeRot = GetRotation();
			ShapePOS = TransLocalPosToWorldPos(Position, GetForward(), new TSVector2(0, ShapeL / 2));
			Rect_1 = GetShapeData(DeterministicShape.ShapeType.Rectangle, ShapePOS, ShapeW, ShapeL, default, default, default, ShapeRot);
			RectHitData_1 = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 2);
			AreaHit_Simple(_actor, Rect_1, RectHitData_1, RectHitDamegeID_1, DamegeImmuneDuration_1, HitBox.HurtAnimType.Small, HittedEffectAlias);
			HitLoopTime += (FP)0.2;
			yield return WaitTime(0.2);
		}
		StopEffect(FxID_2);
		BeginAttack(StandIndex, _2Stand, flushInputedKeys: true, forceInterruptAttack: true);
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
