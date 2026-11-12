#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster.Common;

public class Skill_AlertMoveBase : SkillSimpleBase
{
	private enum MovementType
	{
		close,
		awayFrom,
		orbital
	}

	protected FP nearValue_Melee;

	protected FP farValuee_Melee;

	protected FP movementMaXRuningTime;

	protected FP nearValue_Range;

	protected FP farValuee_Range;

	protected FP moveForwardDistance;

	protected FP moveForwardDirection;

	protected FP moveBackwardDistance;

	protected FP moveBackwardRangeOffset;

	protected FP moveBackwardDirection;

	protected FP moveOrbitalDistance;

	protected FP moveOrbitalDirection;

	private FP moveAcc;

	private LogicEntity target;

	private MovementType movementType;

	private bool hasFinish;

	private int playerATKType;

	private FP nearValue;

	private FP farValue;

	private int orbitalDirection;

	protected void Enable()
	{
		target = GetTarget();
		hasFinish = false;
		playerATKType = GetPlayerJobType((AdventureActor)GetCurrentPlayer());
		moveAcc = _actor.actorInfo.moveAcceleration;
		switch (playerATKType)
		{
		case 1:
			nearValue = ((nearValue_Melee == 0) ? (nearValue = 0.1) : (nearValue = nearValue_Melee));
			farValue = ((farValuee_Melee == 0) ? (farValue = 0.1) : (farValue = farValuee_Melee));
			break;
		case 2:
			nearValue = ((nearValue_Range == 0) ? (nearValue = 0.1) : (nearValue = nearValue_Range));
			farValue = ((farValuee_Range == 0) ? (farValue = 0.1) : (farValue = farValuee_Range));
			break;
		}
	}

	protected void Disable()
	{
		_actor.actorInfo.moveAcceleration = moveAcc;
	}

	protected CoroutineNode MovementCor()
	{
		movementType = GetMoveMentType();
		NovaLogger.Debug($"通用.移动.类型为.{movementType}");
		switch (movementType)
		{
		case MovementType.close:
			return StartCor(MoveForward());
		case MovementType.awayFrom:
			return StartCor(MoveBackward());
		case MovementType.orbital:
			return StartCor(MoveOrbital());
		default:
			NovaLogger.Debug("通用战中警戒移动.移动类型为空");
			return null;
		}
	}

	protected virtual IEnumerator MoveForward()
	{
		yield return BeginLookAt(target, 0.1, 1800);
		yield return StartCor(MovementUpdate());
	}

	protected virtual IEnumerator MoveBackward()
	{
		yield return BeginLookAt(target, 0.1, 1800);
		yield return StartCor(MovementUpdate());
	}

	protected virtual IEnumerator MoveOrbital()
	{
		yield return BeginLookAt(target, 0.1, 1800);
		yield return StartCor(MovementUpdate());
	}

	protected virtual IEnumerator MovementUpdate()
	{
		bool loopCondition = !hasFinish;
		_actor.actorInfo.moveAcceleration = 40;
		FP updateInterval = 0.05;
		switch (movementType)
		{
		case MovementType.close:
		{
			CoroutineNode DRITConsitionCor = StartCor(DirectionCondition());
			CoroutineNode DISTConsitionCor = StartCor(DistanceCondition());
			CoroutineNode RuningTimeConsitionCor = StartCor(RuningTimeCondition());
			while (loopCondition)
			{
				TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(target);
				MoveToPosition(entityPositionObsoleted, 0.1, AdventureActor.MovementMode.Walk, 2f);
				loopCondition = !hasFinish;
				yield return WaitTime(updateInterval);
			}
			StopMove();
			StopCor(DRITConsitionCor);
			StopCor(DISTConsitionCor);
			StopCor(RuningTimeConsitionCor);
			break;
		}
		case MovementType.awayFrom:
		{
			TransLocalPosToWorldPos(GetPosition(), GetPosition() - GetEntityPositionObsoleted(target), new TSVector2(0, 10));
			CoroutineNode DISTConsitionCor = StartCor(DistanceCondition());
			CoroutineNode DRITConsitionCor = StartCor(DirectionCondition());
			CoroutineNode RuningTimeConsitionCor = StartCor(RuningTimeCondition());
			while (loopCondition)
			{
				AimAtPosition(GetEntityPositionObsoleted(target), 100);
				TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetPosition() - GetEntityPositionObsoleted(target), new TSVector2(0, 10));
				MoveToPosition(position, 0.1, AdventureActor.MovementMode.Walk, 2f);
				loopCondition = !hasFinish;
				yield return WaitTime(updateInterval);
			}
			CancelAim();
			StopMove();
			StopCor(DISTConsitionCor);
			StopCor(DRITConsitionCor);
			StopCor(RuningTimeConsitionCor);
			break;
		}
		case MovementType.orbital:
		{
			orbitalDirection = ((GetRandomValue(0, 1) > 0.5) ? 1 : (-1));
			CoroutineNode DISTConsitionCor = StartCor(DistanceCondition());
			CoroutineNode RuningTimeConsitionCor = StartCor(RuningTimeCondition());
			while (loopCondition)
			{
				AimAtPosition(GetEntityPositionObsoleted(target), 0);
				TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetEntityPositionObsoleted(target) - GetPosition(), new TSVector2(10 * orbitalDirection, 0));
				MoveToPosition(position, 0.1, AdventureActor.MovementMode.Walk, 2f);
				loopCondition = !hasFinish;
				yield return WaitTime(updateInterval);
			}
			CancelAim();
			StopMove();
			StopCor(DISTConsitionCor);
			StopCor(RuningTimeConsitionCor);
			break;
		}
		}
	}

	protected virtual IEnumerator DistanceCondition()
	{
		_ = _actor.actorInfo.walkSpeed;
		bool result = true;
		FP interval = 0.05;
		switch (movementType)
		{
		case MovementType.close:
		{
			FP movementDistance = moveForwardDistance;
			while (result)
			{
				yield return WaitTime(interval);
				movementDistance -= _actor.actorInfo.walkSpeed * interval;
				TSVector2 position2 = GetPosition();
				TSVector2 entityPositionObsoleted2 = GetEntityPositionObsoleted(target);
				if (Distance(position2, entityPositionObsoleted2) <= nearValue)
				{
					NovaLogger.Debug("通用.移动.距离结束条件.满足相对距离条件");
					result = false;
				}
				else if (0 >= movementDistance)
				{
					result = false;
					NovaLogger.Debug("通用.移动.距离结束条件.满足移动路程条件");
				}
			}
			break;
		}
		case MovementType.awayFrom:
		{
			FP fP2;
			if (GetPlayerJobType((AdventureActor)GetCurrentPlayer()) != 1)
			{
				FP fP = moveBackwardDistance + moveBackwardRangeOffset;
				fP2 = fP;
			}
			else
			{
				FP fP = moveBackwardDistance;
				fP2 = fP;
			}
			FP movementDistance = fP2;
			NovaLogger.Debug($"通用.移动.距离结束条件.移动距离为{movementDistance}");
			while (result)
			{
				yield return WaitTime(interval);
				movementDistance -= _actor.actorInfo.walkSpeed * interval;
				TSVector2 position3 = GetPosition();
				TSVector2 entityPositionObsoleted3 = GetEntityPositionObsoleted(target);
				if (Distance(position3, entityPositionObsoleted3) >= nearValue)
				{
					result = false;
				}
			}
			break;
		}
		case MovementType.orbital:
		{
			FP movementDistance = moveOrbitalDistance;
			while (result)
			{
				yield return WaitTime(interval);
				movementDistance -= _actor.actorInfo.walkSpeed * interval;
				TSVector2 position = GetPosition();
				TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(target);
				if (0 >= movementDistance)
				{
					result = false;
				}
				else if (Distance(position, entityPositionObsoleted) <= nearValue * 0.8)
				{
					result = false;
				}
			}
			break;
		}
		}
		hasFinish = true;
		NovaLogger.Debug("通用.移动.距离结束条件.达成");
	}

	protected virtual IEnumerator DirectionCondition()
	{
		bool result = true;
		FP interval = 0.05;
		switch (movementType)
		{
		case MovementType.close:
			while (result)
			{
				yield return WaitTime(interval);
				TSVector2 to = GetEntityPositionObsoleted(target) - GetPosition();
				TSVector2 forward = GetForward();
				if (AngleBetween2TSVector(forward, to, signed: false) > moveForwardDirection)
				{
					result = false;
				}
			}
			break;
		case MovementType.awayFrom:
			while (result)
			{
				yield return WaitTime(interval);
				TSVector2 to = GetEntityPositionObsoleted(target) - GetPosition();
				TSVector2 forward = GetForward();
				if (AngleBetween2TSVector(forward, to, signed: false) > moveBackwardDirection)
				{
					result = false;
				}
			}
			break;
		case MovementType.orbital:
			while (result)
			{
				yield return WaitTime(interval);
				TSVector2 to = GetEntityPositionObsoleted(target) - GetPosition();
				TSVector2 forward = GetForward();
				if (AngleBetween2TSVector(forward, to, signed: false) > moveOrbitalDirection)
				{
					result = false;
				}
			}
			break;
		}
		hasFinish = true;
		NovaLogger.Debug("通用.移动.朝向结束条件.达成");
	}

	protected virtual IEnumerator RuningTimeCondition()
	{
		bool result = true;
		FP interval = 0.05;
		FP time = 0;
		while (result)
		{
			yield return WaitTime(interval);
			time += interval;
			if (time > movementMaXRuningTime)
			{
				result = false;
			}
		}
		hasFinish = true;
		NovaLogger.Debug("通用.移动.运行时长条件.达成");
	}

	private MovementType GetMoveMentType()
	{
		TSVector2 position = GetPosition();
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(target);
		FP fP = Distance(position, entityPositionObsoleted);
		if (fP > farValue)
		{
			return MovementType.close;
		}
		if (farValue > fP && fP > nearValue)
		{
			return MovementType.orbital;
		}
		return MovementType.awayFrom;
	}

	private LogicEntity GetTarget()
	{
		LogicEntity logicEntity = null;
		if (CheckTargetIsValid(GetAttackTarget(isUpToDate: true)))
		{
			return GetAttackTarget(isUpToDate: true);
		}
		return GetCurrentPlayer();
	}
}
