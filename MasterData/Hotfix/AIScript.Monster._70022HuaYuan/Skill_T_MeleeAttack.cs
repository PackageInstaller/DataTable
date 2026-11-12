using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_MeleeAttack : Skill_Base
{
	private int DashIndex = 10;

	private TSVector2 Direction;

	private FP Speed = 30;

	private FP DIST = 1.5;

	private FP AngleLimit = 999;

	private LogicEntity Target;

	private TSVector2 TargetPOS;

	private readonly int ThrowBStartIndex = 8;

	private readonly string ThrowBStartKey = "Throw_Back";

	private readonly int ThrowSTraceIndex = 9;

	private readonly string ThrowSTraceKey = "Throw_M_Trace";

	private readonly string BulletFx = "fx_70022_base_JThrow_Down";

	private readonly string BulletGroundFx = "SLJ_atk";

	private List<long> _BulletFx = new List<long>();

	private List<long> _BulletGroundFx = new List<long>();

	private FP BulletAngle;

	private FP AngleOffset = 20;

	private string LineFx = "fx_70022_laser_JTrow";

	private List<long> LineFxList = new List<long>();

	private int DashIndex_JumpB = 10;

	private List<TSVector2> BulletPOSList = new List<TSVector2>();

	private bool AlignShoot;

	private readonly FP AlignShootDelay = 0;

	private int BulletCount = 1;

	private readonly FP Duration = 0;

	private TSVector2 ShootPOS;

	private readonly FP ShootPOSY = 1;

	private TSVector2 MultishootDirection;

	private readonly FP BulletDirectionOffset = 0;

	private FP Angle;

	private readonly FP Radius = 0;

	private readonly FP InnerRadius = 0;

	private long IndexFxDogde;

	private TSVector2 MovePOS;

	private readonly int IndexMove = 11;

	private FP XOffsetRatio = 1.2;

	private FP YOffsetRatio = 0.8;

	private FP SpeedRatioAmend = 9;

	private int MoveStep = 4;

	protected override void OnSkillEnable()
	{
		_BulletFx.Clear();
		_BulletGroundFx.Clear();
		LineFxList.Clear();
	}

	protected override void OnSkillDisable()
	{
		CancelBezierPathMove();
		_BulletFx.Clear();
		BulletPOSList.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		Target = GetCurrentPlayer();
		TargetPOS = GetEntityPosition(Target);
		if (Distance(TargetPOS, GetPosition()) <= 5)
		{
			yield return StartCor(BackShoot());
		}
		yield return StartCor(DodgeMove());
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.1, 9999);
		BeginAttack(StartLIndex, StartLKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.2);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.8, 180);
		yield return WaitTime(0.25);
		PlayEffect(WarningFx_Actor, 1f, 3.1, GetPosition(), default, 1.4f);
		yield return WaitTime(0.8);
		CancelAttack();
		BeginAttack(ACTRIndex, ACTRKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(AttackFx_R, 0.8f, default, default, GetRotation() - 15, 0.85f, actorScale: true);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 1)
		{
			Direction = GetForward();
			BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitTime(0.25);
		CancelAttack();
		BeginAttack(ACTLIndex, ACTLKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(AttackFx_L, 0.8f, default, default, GetRotation() + 15, 0.85f, actorScale: true);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 1)
		{
			Direction = GetForward();
			BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.2, 9999);
		PlayEffect(WarningFx_Actor, 1f, 2, GetPosition(), default, 1.4f);
		BeginAttack(StartSIndex, StartSKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.2);
		BeginAttack(ACTRIndex, ACTRKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(AttackFx_R, 0.8f, default, default, GetRotation() - 15, 0.85f, actorScale: true);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 1)
		{
			Direction = GetForward();
			BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitTime(0.25);
		CancelAttack();
		BeginAttack(ACTLIndex, ACTLKey, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect(AttackFx_L, 0.8f, default, default, GetRotation() + 15, 0.85f, actorScale: true);
		yield return WaitTime(0.1);
		if (Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) > 1)
		{
			Direction = GetForward();
			BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator BackShoot()
	{
		SetSearchedImmunityEnable();
		LogicEntity target = GetCurrentPlayer();
		yield return BeginLookAt(GetCurrentPlayer(), 0.2, 900);
		BeginAttack(ThrowBStartIndex, ThrowBStartKey, flushInputedKeys: true, forceInterruptAttack: true);
		TSVector2 Direction_JumpB = GetPosition() - GetEntityPosition(target);
		yield return WaitTime(0.1);
		FP speed = 16;
		FP distance = 20;
		BeginDash(DashIndex_JumpB, Direction_JumpB, speed, distance, 9999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitTime(0.3);
		speed = 5;
		distance = 10;
		BeginDash(DashIndex_JumpB, Direction_JumpB, speed, distance, 9999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitTime(0.15);
		CancelAttack();
		yield return WaitTime(0.1);
		FP rotation = GetRotation();
		if (GetLogicTagToggleValue(_actor, "SkillTag_SLJTrace"))
		{
			for (int i = 0; i < 3; i++)
			{
				if (i == 0)
				{
					PlayEffect(BulletFx, 0.8f, default, GetPosition(), rotation, 1.05f);
					BulletPOSList.Add(TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5)));
					continue;
				}
				PlayEffect(BulletFx, 0.8f, default, GetPosition(), rotation + AngleOffset * i, 1.05f);
				PlayEffect(BulletFx, 0.8f, default, GetPosition(), rotation - AngleOffset * i, 1.05f);
				BulletPOSList.Add(TransLocalPosToWorldPos(GetPosition(), RotateTo(GetForward(), AngleOffset * i), new TSVector2(0, 5)));
				BulletPOSList.Add(TransLocalPosToWorldPos(GetPosition(), RotateTo(GetForward(), -AngleOffset * i), new TSVector2(0, 5)));
			}
		}
		else
		{
			for (int j = 0; j < 3; j++)
			{
				if (j == 0)
				{
					PlayEffect(BulletFx, 0.8f, default, GetPosition(), rotation, 1.05f);
					BulletPOSList.Add(TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5)));
					continue;
				}
				PlayEffect(BulletFx, 0.8f, default, GetPosition(), rotation + AngleOffset * j, 1.05f);
				PlayEffect(BulletFx, 0.8f, default, GetPosition(), rotation - AngleOffset * j, 1.05f);
				BulletPOSList.Add(TransLocalPosToWorldPos(GetPosition(), RotateTo(GetForward(), AngleOffset * j), new TSVector2(0, 5)));
				BulletPOSList.Add(TransLocalPosToWorldPos(GetPosition(), RotateTo(GetForward(), -AngleOffset * j), new TSVector2(0, 5)));
			}
		}
		if (BulletPOSList != null && BulletPOSList.Count > 0)
		{
			for (int k = 0; k < BulletPOSList.Count; k++)
			{
				_BulletGroundFx.Add(PlayAreaEffect(BulletGroundFx, BulletPOSList.get_Item(k), rotation));
				if (GetLogicTagToggleValue(_actor, "SkillTag_SLJTrace"))
				{
					LineFxList.Add(PlayLinkEffect(LineFx, useCustomSource: true, _actor, default, default, null, BulletPOSList.get_Item(k), default, breakWhenLostSourceOrTarget: false));
				}
			}
		}
		yield return WaitTime(0.3);
		StopDash();
		yield return WaitTime(0.4);
		SetSearchedImmunityDisable();
	}

	protected IEnumerator DodgeMove()
	{
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		for (int i = 0; i < 3; i++)
		{
			Target = GetAttackTarget(isUpToDate: true);
			if (CheckTargetIsValid(Target))
			{
				break;
			}
			if (i == 2)
			{
				Target = GetCurrentPlayer();
			}
			yield return WaitTime(0.15);
		}
		SetSearchedImmunityEnable();
		SetCloseBlockEnable();
		SetUnparalleledEnable();
		BeginLookAt_NotWait(Target, 0.2, 2000);
		BeginAttack(IndexDodge, DodgeKey, flushInputedKeys: true, forceInterruptAttack: true);
		IndexFxDogde = PlayEffect(Fx_Dogde);
		MovePOS = TransLocalPosToWorldPos(GetEntityPosition(Target), GetEntityPosition(Target) - GetPosition(), new TSVector2(0, 2));
		BeginBezierPathMove(IndexMove, MovePOS, XOffsetRatio, YOffsetRatio, comboWithAttack: true, SpeedRatioAmend, AdventureActor.MovementMode.None, MoveStep);
		yield return WaitBezierPathMoveFinish();
		SetSearchedImmunityDisable();
		SetCloseBlockDisable();
		SetUnparalleledDisable();
		StopEffect(IndexFxDogde);
		if (GetLogicTagToggleValue(_actor, "SkillTag_SLJTrace"))
		{
			BeginAttack(ThrowSTraceIndex, ThrowSTraceKey, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(0.25);
			for (int j = 0; j < _BulletGroundFx.Count; j++)
			{
				ShootPOS = BulletPOSList.get_Item(j);
				MultishootDirection = GetPosition() - ShootPOS;
				StopAreaEffect(_BulletGroundFx.get_Item(j));
				if (LineFxList.Count > j)
				{
					StopEffect(LineFxList.get_Item(j));
				}
				FanMultipleShoot(BulletAlias_S, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, BulletCount, Duration, ShootPOS, ShootPOSY, MultishootDirection, BulletDirectionOffset, AimType.Target, BulletDirectionType.BulletToTarget, Angle, Radius, InnerRadius, default, _actor);
			}
		}
		else
		{
			CancelAttack();
		}
		BeginLookAt_NotWait(Target, 0.2, 2000);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
