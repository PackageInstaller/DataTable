#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_OnceSkill : Skill_Base
{
	private static LogicEntity Target;

	private static long IndexFxDogde;

	private static TSVector2 MovePOS;

	private static readonly int IndexMove = 10;

	private static FP XOffsetRatio = 1.2;

	private static FP YOffsetRatio = 0.8;

	private static FP SpeedRatioAmend = 9;

	private static int MoveStep = 4;

	private static int DashIndex = 10;

	private static TSVector2 Direction;

	private static FP Speed = 30;

	private static FP DIST = 1.5;

	private static FP AngleLimit = 999;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("花原.开场技能.开始");
	}

	protected override void OnSkillDisable()
	{
		CancelBezierPathMove();
		NovaLogger.Debug("花原.开场技能.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		GetTarget();
		BeginLookAt_NotWait(Target, 0.2, 2000);
		NovaLogger.Debug("面向调整结束");
		BeginAttack(IndexDodge, DodgeKey, flushInputedKeys: true, forceInterruptAttack: true);
		IndexFxDogde = PlayEffect(Fx_Dogde);
		MovePOS = TransLocalPosToWorldPos(GetEntityPosition(Target), GetEntityPosition(Target) - GetPosition(), new TSVector2(0, 2));
		BeginBezierPathMove(IndexMove, MovePOS, XOffsetRatio, YOffsetRatio, comboWithAttack: true, SpeedRatioAmend, AdventureActor.MovementMode.None, MoveStep);
		yield return WaitBezierPathMoveFinish();
		CancelAttack();
		StopEffect(IndexFxDogde);
		BeginLookAt_NotWait(Target, 0.3, 2000);
		yield return StartCor(Attack());
	}

	protected IEnumerator Attack()
	{
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.1, 9999);
		BeginAttack(StartLIndex, StartLKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.95);
		WarningFlashFx();
		yield return WaitTime(0.29);
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
		WarningFlashFx();
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
}
