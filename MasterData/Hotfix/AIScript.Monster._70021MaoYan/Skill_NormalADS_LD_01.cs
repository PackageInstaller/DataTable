#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_NormalADS_LD_01 : SkillSimpleBase
{
	private readonly string Aim2Fire = "N_ADS";

	private readonly int AimIndex = 1;

	private readonly string _2Stand = "N_ADS_Stand";

	private readonly int StandIndex = 2;

	private readonly FP AttackWaitTime = 0.9;

	private readonly string FxAlias = "fx_70021_base_atk_LockOn_Laser_com02";

	private readonly float PlaybackSpd = 1f;

	private readonly FP FxPositionY = 1.7;

	private TSVector2 Position;

	private readonly string ShootFireFxAlias = "fx_70021_base_LockOn_Fire";

	private readonly FP ShootFireFxPositionY = 1.2;

	private readonly string WarningFxAlias = "fx_70021_loop_LockOn_Warning_EADS";

	private readonly FP WarningFxPositionY = 0;

	private readonly string DodgeFxAlias = "fx_common_base_charge_fire_actor";

	private readonly FP DodgeFxPositionY = 1.2;

	private readonly string BodyFxAlias = "fx_70021_loop_atk_LockOn_Laser_Burst_self";

	private readonly FP BodyFxPositionY = 0;

	private readonly string BulletAlias = "Bullet_Fire_LockOn_COM";

	private readonly string BulletAlias_Area = "Bullet_Fire_LockOn_COM_Area";

	private readonly bool AlignShoot;

	private readonly FP AlignShootDelay = 0;

	private readonly int BulletCount = 1;

	private readonly FP Duration = 0;

	private TSVector2 ShootPosition;

	private readonly FP ShootPositionY = 1.2;

	private TSVector2 MultiShootDirection;

	private readonly FP BulletDirectionOffset = 0;

	private readonly FP Angle = 100;

	private readonly FP Radius = 0;

	private readonly FP InnerRadius = 0;

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

	private FP DIST;

	private FP SelfAngle;

	private TSVector2 MoveTargetPoint;

	private TSVector2 selfPosition;

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
		Target = GetCurrentPlayer();
		yield return StartCor(Dodge());
		BeginLookAt(Target, 1.4, 500);
		yield return WaitTime(0.4);
		BeginAttack(AimIndex, Aim2Fire, flushInputedKeys: true, forceInterruptAttack: true);
		NovaLogger.Debug("释放技能，进入转向阶段");
		BeginLookAt_NotWait(Target, 5, 150);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		long FxID_01 = PlayEffect(WarningFxAlias, 0.6f, WarningFxPositionY);
		long FxID_3 = PlayEffect(BodyFxAlias, 1f, BodyFxPositionY, GetPosition());
		yield return WaitTime(AttackWaitTime);
		StopWaitLookAt();
		yield return WaitTime(0.3);
		PlayEffect(DodgeFxAlias, 1f, DodgeFxPositionY, GetPosition(), default, 3f);
		yield return WaitTime(0.3);
		CancelAttack();
		StopEffect(FxID_01);
		StopEffect(FxID_3);
		PlayEffect(ShootFireFxAlias, 1f, ShootFireFxPositionY);
		Position = GetPosition();
		MultiShootDirection = GetForward();
		ShootPosition = TransLocalPosToWorldPos(Position, MultiShootDirection, new TSVector2(0, 1.8));
		FanMultipleShoot(BulletAlias, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, BulletCount, Duration, ShootPosition, ShootPositionY, MultiShootDirection, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Angle, Radius, InnerRadius);
		FanMultipleShoot(BulletAlias_Area, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, BulletCount, Duration, ShootPosition, ShootPositionY, MultiShootDirection, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Angle, Radius, InnerRadius);
		yield return WaitTime(0.6);
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
		selfPosition = GetPosition();
		SelfAngle = GetTSVectToAngle(ZeroPosition - selfPosition, 0);
		PlayerPosition = GetEntityPosition(Target);
		DIST = Distance(selfPosition, PlayerPosition);
		FanPosition = selfPosition;
		NovaLogger.Debug("猫眼与场中心的距离为" + Distance(selfPosition, TSVector2.zero).ToString());
		if (Distance(selfPosition, TSVector2.zero) > 12)
		{
			TSVector2 csPos = GetPosition();
			BeginAttack(BIndex, BDodge, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.1);
			FP fP = Distance(selfPosition, TSVector2.zero);
			FP speed = fP / 0.66;
			BeginDash(6, TSVector2.zero - GetPosition(), speed, fP, 900, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			BeginLookAtByDir_NotWait(TransLocalPosToWorldPos(TSVector2.zero, csPos - TSVector2.zero, new TSVector2(0, 14)), 0.7, 258);
			yield return WaitDashFinish();
			StopLookAt();
		}
		else if (DIST < 4)
		{
			NovaLogger.Debug("近距离");
			FanRotation = GetTSVectToAngle(selfPosition - PlayerPosition, 0);
			Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_B, FanInnerRadius_B, FanAngle_B, FanRotation);
			MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
			DashDirection = MoveTargetPoint - selfPosition;
			DashDistance = Distance(selfPosition, MoveTargetPoint);
			DashSpeed = DashDistance / 0.66;
			BeginLookAt_NotWait(Target, 0, 720);
			BeginAttack(BIndex, BDodge, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.1);
			BeginDash(DashIndex, DashDirection, DashSpeed, DashDistance, DashAngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
		}
		else if (6 > DIST && DIST >= 4)
		{
			NovaLogger.Debug("中近距离");
			ChooseDirection = (int)(long)GetRandomValue(0, 1.5);
			if (ChooseDirection == 0)
			{
				NovaLogger.Debug("左边");
				FanRotation = GetTSVectToAngle(PlayerPosition - selfPosition, -140);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_LR, FanInnerRadius_LR, FanAngle_LR, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - selfPosition;
				DashDistance = Distance(selfPosition, MoveTargetPoint);
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
				FanRotation = GetTSVectToAngle(PlayerPosition - selfPosition, 140);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_LR, FanInnerRadius_LR, FanAngle_LR, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - selfPosition;
				DashDistance = Distance(selfPosition, MoveTargetPoint);
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
		else if (DIST >= 6 && 9 > DIST)
		{
			NovaLogger.Debug("选择中距离");
			ChooseDirection = (int)(long)GetRandomValue(0, 1.5);
			if (ChooseDirection == 0)
			{
				FanRotation = GetTSVectToAngle(PlayerPosition - selfPosition, -70);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_F, FanInnerRadius_F, FanAngle_F, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - selfPosition;
				DashDistance = Distance(selfPosition, MoveTargetPoint);
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
				FanRotation = GetTSVectToAngle(PlayerPosition - selfPosition, 70);
				Fan = GetShapeData(DeterministicShape.ShapeType.Fan, FanPosition, default, default, FanRadius_F, FanInnerRadius_F, FanAngle_F, FanRotation);
				MoveTargetPoint = GetShapeRandomPoint(Fan, _actor, isReachable: true);
				DashDirection = MoveTargetPoint - selfPosition;
				DashDistance = Distance(selfPosition, MoveTargetPoint);
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
				DashDirection = MoveTargetPoint - selfPosition;
				DashDistance = Distance(selfPosition, MoveTargetPoint);
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
				DashDirection = MoveTargetPoint - selfPosition;
				DashDistance = Distance(selfPosition, MoveTargetPoint);
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
