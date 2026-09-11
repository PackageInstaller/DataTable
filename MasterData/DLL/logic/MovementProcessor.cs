using System.Collections.Generic;
using Config;
using Pathfinding;
using UnityEngine;

public class MovementProcessor
{
	public static SimContext mSimContext;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
	}

	public static bool IsArrive(SimEntity simEntity, Int3 targetPos)
	{
		if (simEntity.hasEntityPositon)
		{
			return simEntity.entityPositon.mPosition == targetPos;
		}
		return false;
	}

	public static bool IsNear(SimEntity simEntity, Int3 targetPos, int range)
	{
		if (simEntity.hasEntityPositon)
		{
			return (simEntity.entityPositon.mPosition - targetPos).sqrMagnitudeLong <= range * range;
		}
		return false;
	}

	public static long SqrDistance(SimEntity origin, SimEntity target)
	{
		return (origin.entityPositon.mPosition - target.entityPositon.mPosition).sqrMagnitudeLong;
	}

	public static long SqrDistance(Int3 originPos, SimEntity target)
	{
		return (originPos - target.entityPositon.mPosition).sqrMagnitudeLong;
	}

	public static long SqrDistance(Int3 originPos, Int3 targetPos)
	{
		return (originPos - targetPos).sqrMagnitudeLong;
	}

	public static void ModifyPosition(SimEntity simEntity, Int3 delta)
	{
		simEntity.entityPositon.mPosition += delta;
		if (!simEntity.hasEntityActionJump)
		{
			int groundY = 0;
			PathUtilities.GetGroundY(simEntity.entityPositon.mPosition, out groundY);
			simEntity.entityPositon.mPosition.y = groundY;
		}
		SimShapeProcessor.UpdateShapeWorldPosition(simEntity);
	}

	public static void SetPosition(SimEntity simEntity, Int3 position)
	{
		simEntity.entityPositon.mPosition = position;
		if (!simEntity.hasEntityActionJump)
		{
			int groundY = 0;
			PathUtilities.GetGroundY(simEntity.entityPositon.mPosition, out groundY);
			simEntity.entityPositon.mPosition.y = groundY;
		}
		SimShapeProcessor.UpdateShapeWorldPosition(simEntity);
	}

	public static Int3 FindValidMove(Int3 position, Int3 delta)
	{
		int groundY = 0;
		return PathUtilities.Move(position, delta, ref groundY);
	}

	public static Int3 PathfindingMove(SimEntity simEntity, Int3 delta, bool isUseTangentMove = true, bool preventPenetration = false, bool isAutoModify = true)
	{
		int groundY = 0;
		Int3 lhs = delta;
		if (delta.sqrMagnitudeLong <= 0)
		{
			return Int3.zero;
		}
		List<ISimShape> list = FrameListPool<ISimShape>.Claim();
		SimShapeProcessor.GetAllShape(simEntity, list);
		uint layer = 7367u;
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape simShape = list[i];
			if (simShape.IgnoreCollision)
			{
				continue;
			}
			SimEntity simEntity2 = mSimContext.GetEntityWithEntityID(simShape.OwnerID);
			if (simEntity2.mTag == SimEntity.Tag.MultiColliders)
			{
				simEntity2 = simEntity2.mParent;
			}
			List<ISimShape> list2 = FrameListPool<ISimShape>.Claim();
			if (simShape.IsEnable)
			{
				int avgCollisionRadius = simShape.AvgCollisionRadius;
				int z = (int)(long)delta.IntMagnitude;
				Int3 size = new Int3(avgCollisionRadius * 2, 1000, z);
				int z2 = size.z / 2 + avgCollisionRadius;
				SimPhysics.OverlapBox(centerOffset: new Int3(0, 0, z2), origin: simShape.WorldPos, forward: delta, size: size, collisions: list2, layer: layer);
				int num = -1;
				long num2 = long.MaxValue;
				for (int j = 0; j < list2.Count; j++)
				{
					SimEntity simEntity3 = mSimContext.GetEntityWithEntityID(list2[j].OwnerID);
					if (simEntity3.mTag == SimEntity.Tag.MultiColliders || simEntity3.mTag == SimEntity.Tag.Combination)
					{
						simEntity3 = simEntity3.mParent;
					}
					if (list2[j].IgnoreCollision || simEntity.creationIndex == simEntity3.creationIndex || !list2[j].IsEnable || (simEntity3.entityShape.GetWeight() < simEntity2.entityShape.GetWeight() && !preventPenetration))
					{
						continue;
					}
					Int3 @int = list2[j].WorldPos - simShape.WorldPos;
					int num3 = avgCollisionRadius + list2[j].AvgCollisionRadius;
					int magnitude2D = @int.magnitude2D;
					if (magnitude2D >= num3)
					{
						magnitude2D -= num3;
						if (magnitude2D < num2)
						{
							num2 = magnitude2D;
							num = j;
						}
					}
				}
				long num4 = num2;
				if (-1 != num)
				{
					Int3 int2 = list2[num].WorldPos - simShape.WorldPos;
					int num5 = avgCollisionRadius + list2[num].AvgCollisionRadius;
					if (int2.sqrMagnitudeLong < num5 * num5)
					{
						Debug.LogError((object)"找到了已经相交的");
					}
					int2.NormalizeTo(1000);
					Int3 int3 = int2 * IntMath.Divide(Int3.Dot(int2, delta), 1000) / 1000f;
					delta -= int3;
					if (delta.sqrMagnitudeLong2D > simShape.AvgCollisionRadius * simShape.AvgCollisionRadius)
					{
						delta.NormalizeTo(simShape.AvgCollisionRadius);
					}
					int num6 = (int)num4;
					Int3 int4 = int2 * num6 / 1000f;
					delta += int4;
					isUseTangentMove = false;
				}
			}
			list2.Clear();
			SimPhysics.Overlap(simShape as SimSphere, list2, layer);
			Int3 rhs = Int3.zero;
			bool flag = false;
			for (int k = 0; k < list2.Count; k++)
			{
				ISimShape simShape2 = list2[k];
				if (simShape2.IgnoreCollision)
				{
					continue;
				}
				SimEntity simEntity4 = mSimContext.GetEntityWithEntityID(simShape2.OwnerID);
				if (simEntity4.mTag == SimEntity.Tag.MultiColliders || simEntity4.mTag == SimEntity.Tag.Combination)
				{
					simEntity4 = simEntity4.mParent;
				}
				if (simEntity4.creationIndex == simEntity2.creationIndex || !simShape2.IsEnable || !simShape.Intersects(simShape2))
				{
					continue;
				}
				Int3 int5 = (simShape2.WorldPos - simShape.WorldPos).NormalizeTo(1000);
				if (0 >= Int3.Dot(int5, delta))
				{
					continue;
				}
				if (simEntity4.entityShape.GetWeight() >= simEntity2.entityShape.GetWeight())
				{
					isUseTangentMove = false;
					Int3 int6 = int5 * IntMath.Divide(Int3.Dot(int5, delta), 1000) / 1000f;
					Int3 int7 = int5;
					if (Int3.Det(lhs, rhs) * Int3.Det(lhs, int7) < 0)
					{
						flag = true;
						break;
					}
					rhs = int7;
					delta -= int6;
					if (delta.sqrMagnitudeLong2D > simShape.AvgCollisionRadius * simShape.AvgCollisionRadius)
					{
						delta.NormalizeTo(simShape.AvgCollisionRadius);
					}
					continue;
				}
				Int3 int8 = int5 * IntMath.Divide(Int3.Dot(int5, delta), 1000) / 1000f;
				if (0 >= PathfindingMove(simEntity4, int8).sqrMagnitudeLong)
				{
					isUseTangentMove = false;
					Int3 int9 = int5;
					if (Int3.Det(lhs, rhs) * Int3.Det(lhs, int9) < 0)
					{
						flag = true;
						break;
					}
					rhs = int9;
					delta -= int8;
					if (delta.sqrMagnitudeLong2D > simShape.AvgCollisionRadius * simShape.AvgCollisionRadius)
					{
						delta.NormalizeTo(simShape.AvgCollisionRadius);
					}
				}
				else
				{
					SimShapeProcessor.UpdateShapeWorldPosition(simEntity4);
				}
			}
			if (flag)
			{
				delta = Int3.zero;
			}
			FrameListPool<ISimShape>.Release(list2);
		}
		FrameListPool<ISimShape>.Release(list);
		delta = PathUtilities.Move(simEntity.entityPositon.mPosition, delta, ref groundY, isUseTangentMove);
		if (isAutoModify)
		{
			Int3 point = delta + simEntity.entityPositon.mPosition;
			if (!PathUtilities.IsOnGraph(point))
			{
				SetPosition(simEntity, simEntity.entityPositon.mPosition);
			}
			else
			{
				ModifyPosition(simEntity, delta);
			}
		}
		return delta;
	}

	public static Int3 UpdateForward(SimEntity simEntity, int deltaTime, out Int3 targetMovementDirection)
	{
		Int3 @int = simEntity.entityActionMoveDirection.mDirection;
		targetMovementDirection = simEntity.entityActionMoveDirection.mDirection;
		RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
		if ((simEntity.entityBlackboard.var.mHasAimTarget && simEntity.entityBlackboard.var.mIsLookatAimTarget) || simEntity.entityBlackboard.var.mIsMoveLock)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(simEntity.entityBlackboard.var.mAimTarget);
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
			if (simEntityByMultiColliders != null && !simEntityByMultiColliders.hasEntityActionDeath && simEntityByMultiColliders.entityBlackboard.var.mHP > 0)
			{
				Int3 aimDirection = (entityWithEntityID.entityShape.mShape.WorldPos - simEntity.entityPositon.mPosition).NormalizeTo(1000);
				LookAt(simEntity, aimDirection, simEntity.entityBlackboard.var.mDeltaRotationSpeed, deltaTime, out var lookat);
				@int = lookat;
			}
		}
		else
		{
			int num = Int3.Dot(@int, simEntity.entityPositon.mForward);
			VFactor vFactor = IntMath.acos(new VFactor(num, 1000000L)) * IntMath.Rad2Deg;
			if (!simEntity.entityActionMoveDirection.mIsTurn)
			{
				simEntity.entityActionMoveDirection.mIsTurn = vFactor > roleConfig.LimitTurnAngle;
			}
			bool flag = false;
			if (!simEntity.entityActionMoveDirection.mIsTurn)
			{
				flag = simEntity.entityBlackboard.var.mDeltaRotationSpeed != 0 && vFactor > IntMath.Divide((int)(long)simEntity.entityBlackboard.var.mDeltaRotationSpeed * deltaTime, 1000000);
			}
			if (vFactor == 0L)
			{
				simEntity.entityActionMoveDirection.mIsTurn = false;
			}
			if (simEntity.entityBlackboard.var.mDeltaRotationSpeed != 0 && (simEntity.entityActionMoveDirection.mIsTurn | flag))
			{
				LookAt(simEntity, @int, simEntity.entityBlackboard.var.mDeltaRotationSpeed, deltaTime, out var lookat2);
				simEntity.entityActionMoveDirection.mSpeedDirection = lookat2;
				@int = lookat2;
				targetMovementDirection = lookat2;
			}
			else
			{
				simEntity.entityPositon.mForwardAngle = IntMath.AngleOfVector(@int);
				if (@int.sqrMagnitudeLong > 0)
				{
					simEntity.entityPositon.mForward = @int;
				}
				simEntity.entityActionMoveDirection.mSpeedDirection = @int;
			}
		}
		return @int;
	}

	public static void SetForwardImmediately(SimEntity simEntity, Int3 moveDirection)
	{
		if (moveDirection.sqrMagnitudeLong > 0)
		{
			simEntity.entityPositon.mForwardAngle = IntMath.AngleOfVector(moveDirection);
			simEntity.entityPositon.mForward = moveDirection;
		}
		simEntity.entityActionMoveDirection.mSpeedDirection = moveDirection;
	}

	private static void MoveEntityBySpeed(SimEntity simEntity, Int3 moveDelta)
	{
		AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2016, out var baseValue, out var _, out var _);
		if (baseValue <= 0)
		{
			PathfindingMove(simEntity, moveDelta);
			simEntity[EntityVarName.ENTITY_CALCULATED_SPEED] = moveDelta.IntMagnitude * 30;
			simEntity[EntityVarName.ENTITY_CALCULATED_VELOCITY] = moveDelta * 30;
		}
	}

	public static Int3 GetTimelineDeltaMovement(Timeline timeline, int lastestLogicTime, int lastestStep)
	{
		Int3 zero = Int3.zero;
		if (!timeline.MoveActionTimelineNode.UseUniformMotion)
		{
			zero = CalcDeltaTimeline(timeline, lastestLogicTime - lastestStep, lastestLogicTime);
		}
		else
		{
			VectorInt3 averageSpeed = timeline.MoveActionTimelineNode.AverageSpeed;
			int x = IntMath.Divide(averageSpeed.X * lastestStep, CommonProcessor.GetConfigInterval());
			int z = IntMath.Divide(averageSpeed.Z * lastestStep, CommonProcessor.GetConfigInterval());
			int y = IntMath.Divide(averageSpeed.Y * lastestStep, CommonProcessor.GetConfigInterval());
			zero = new Int3(x, y, z);
		}
		return zero;
	}

	public static int GetTimelineDeltaAngle(Timeline timeline, int lastestLogicTime, int lastestStep)
	{
		if (timeline.MoveActionTimelineNode.AngleOffsetList.Count <= 0)
		{
			return 0;
		}
		int num = lastestLogicTime - lastestStep;
		int configInterval = CommonProcessor.GetConfigInterval();
		int num2 = num / configInterval;
		int num3 = num % configInterval;
		int dest = timeline.MoveActionTimelineNode.AngleOffsetList.get_Item(num2 % timeline.MoveActionTimelineNode.Duration);
		int num4 = 0;
		if (num3 != 0)
		{
			num4 = IntMath.Lerp(0, dest, num3, configInterval);
		}
		int num5 = lastestLogicTime / configInterval;
		int num6 = lastestLogicTime % configInterval;
		int dest2 = timeline.MoveActionTimelineNode.AngleOffsetList.get_Item(num5 % timeline.MoveActionTimelineNode.Duration);
		int num7 = 0;
		if (num6 != 0)
		{
			num7 = IntMath.Lerp(0, dest2, num6, configInterval);
		}
		int i = num2;
		int num8 = 0;
		for (; num5 > i; i++)
		{
			int num9 = timeline.MoveActionTimelineNode.AngleOffsetList.get_Item(i % timeline.MoveActionTimelineNode.Duration);
			int num10 = num9;
			num8 += num10;
		}
		num8 -= num4;
		return num8 + num7;
	}

	private static Int3 CalcDeltaTimeline(Timeline timeline, int startTime, int endTime)
	{
		int configInterval = CommonProcessor.GetConfigInterval();
		int num = startTime / configInterval;
		int num2 = startTime % configInterval;
		VectorInt3 vectorInt = timeline.MoveActionTimelineNode.AnimationMove.get_Item(num % timeline.MoveActionTimelineNode.Duration);
		int x = 0;
		int y = 0;
		int z = 0;
		if (num2 != 0)
		{
			x = IntMath.Lerp(0, vectorInt.X, num2, configInterval);
			y = IntMath.Lerp(0, vectorInt.Y, num2, configInterval);
			z = IntMath.Lerp(0, vectorInt.Z, num2, configInterval);
		}
		int num3 = endTime / configInterval;
		int num4 = endTime % configInterval;
		VectorInt3 vectorInt2 = timeline.MoveActionTimelineNode.AnimationMove.get_Item(num3 % timeline.MoveActionTimelineNode.Duration);
		int x2 = 0;
		int y2 = 0;
		int z2 = 0;
		if (num4 != 0)
		{
			x2 = IntMath.Lerp(0, vectorInt2.X, num4, configInterval);
			y2 = IntMath.Lerp(0, vectorInt2.Y, num4, configInterval);
			z2 = IntMath.Lerp(0, vectorInt2.Z, num4, configInterval);
		}
		int i = num;
		Int3 zero = Int3.zero;
		for (; num3 > i; i++)
		{
			VectorInt3 vectorInt3 = timeline.MoveActionTimelineNode.AnimationMove.get_Item(i % timeline.MoveActionTimelineNode.Duration);
			Int3 @int = new Int3(vectorInt3.X, vectorInt3.Y, vectorInt3.Z);
			zero += @int;
		}
		zero -= new Int3(x, y, z);
		return zero + new Int3(x2, y2, z2);
	}

	private static void UpdateTimelineMovement(SimEntity simEntity, int moveID, int step)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(moveID);
		if (config == null)
		{
			Debug.LogError((object)("Can't Find Timeline " + moveID));
		}
		Int3 @int = UpdateForward(simEntity, step, out var _);
		Int3 timelineDeltaMovement = GetTimelineDeltaMovement(config, simEntity.entityActionMoveDirection.mLogicTime, step);
		if (simEntity.entityActionMoveDirection.mMoveMode == EMoveDirectionMode.Lookat)
		{
			Int3 int2 = IntMath.Transform(timelineDeltaMovement, @int, simEntity.entityPositon.mPosition);
			Int3 moveDelta = int2 - simEntity.entityPositon.mPosition;
			MoveEntityBySpeed(simEntity, moveDelta);
		}
		else if (simEntity.entityActionMoveDirection.mMovementDirection != Int3.zero)
		{
			if (simEntity.entityActionMoveDirection.mMoveMode == EMoveDirectionMode.CustomMovementLocal)
			{
				@int = IntMath.TransformDirection(@int, simEntity.entityActionMoveDirection.mMovementDirection).NormalizeTo(1000);
			}
			else if (simEntity.entityActionMoveDirection.mMoveMode == EMoveDirectionMode.CustomMovementGlobal)
			{
				@int = simEntity.entityActionMoveDirection.mMovementDirection;
				@int = @int.NormalizeTo(1000);
			}
			else if (simEntity.entityActionMoveDirection.mMoveMode == EMoveDirectionMode.Pov)
			{
				@int = IntMath.TransformDirection(@int, simEntity.entityActionMoveDirection.mMovementDirection).NormalizeTo(1000);
			}
			Int3 int3 = IntMath.Transform(timelineDeltaMovement, @int, simEntity.entityPositon.mPosition);
			Int3 moveDelta2 = int3 - simEntity.entityPositon.mPosition;
			MoveEntityBySpeed(simEntity, moveDelta2);
		}
	}

	private static void UpdateShapeWhenMoving(SimEntity simEntity, int logicTime)
	{
		int mMoveID = simEntity.entityActionMoveDirection.mMoveID;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(mMoveID);
		for (int i = 0; i < config.ShapeInfoList.Count; i++)
		{
			ShapeInfo shapeInfo = config.ShapeInfoList.get_Item(i);
			int start = shapeInfo.Start;
			int num = start + shapeInfo.Duration;
			if (logicTime >= start && logicTime <= num)
			{
				SimShapeProcessor.UpdateShapeWorldPositionByConfig(mSimContext, simEntity, shapeInfo);
				break;
			}
		}
	}

	private static int GetMoveID(SimEntity simEntity)
	{
		int num = 0;
		if (simEntity.entityBlackboard.var.mDesiredMoveID != 0)
		{
			num = simEntity.entityBlackboard.var.mDesiredMoveID;
		}
		else
		{
			RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
			bool flag = simEntity.entityBlackboard.var.mSpeedFactor > new VFactor(roleConfig.RushSpeed, 100L);
			num = (flag ? simEntity.entityBlackboard.var.mRushIDSlot : simEntity.entityBlackboard.var.mRunSlot);
			if (simEntity.entityBlackboard.var.mIsLookatAimTarget && mSimContext.GetEntityWithEntityID(simEntity[EntityVarName.ENTITY_AI_TARGET]) != null)
			{
				Int3 mDirection = simEntity.entityActionMoveDirection.mDirection;
				Int3 rhs = simEntity.entityPositon.mForward.NormalizeTo(1000);
				if (IntMath.acos(new VFactor(Int3.Dot(mDirection, rhs), 1000000L)) * IntMath.Rad2Deg >= 45L)
				{
					num = ((Int3.Cross(mDirection, rhs).y < 0) ? simEntity.entityBlackboard.var.mRunRightIDSlot : simEntity.entityBlackboard.var.mRunLeftIDSlot);
				}
			}
			else
			{
				Int3 rhs2 = ((simEntity.entityActionMoveDirection.mLastDirection == Int3.zero) ? simEntity.entityPositon.mForward : simEntity.entityActionMoveDirection.mLastDirection);
				int num2 = Int3.Dot(simEntity.entityActionMoveDirection.mDirection, rhs2);
				VFactor vFactor = IntMath.acos(new VFactor(num2, 1000000L)) * IntMath.Rad2Deg;
				if (flag)
				{
					num = simEntity.entityBlackboard.var.mRushIDSlot;
				}
				else if (simEntity.entityActionMoveDirection.mMoveID == 0)
				{
					num = simEntity.entityBlackboard.var.mRunStartSlot;
				}
				else if (simEntity.entityBlackboard.var.mRunStartSlot == simEntity.entityActionMoveDirection.mMoveID)
				{
					Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity.entityBlackboard.var.mRunStartSlot);
					if (simEntity.entityActionMoveDirection.mLogicTime < config.Duration)
					{
						num = simEntity.entityBlackboard.var.mRunStartSlot;
					}
					if (vFactor > roleConfig.LimitTurnAngle && simEntity.entityActionMoveDirection.mLogicTime >= 7 * CommonProcessor.GetConfigInterval())
					{
						num2 = Int3.Dot(simEntity.entityActionMoveDirection.mDirection, simEntity.entityPositon.mForward);
						vFactor = IntMath.acos(new VFactor(num2, 1000000L)) * IntMath.Rad2Deg;
						if (vFactor > roleConfig.LimitTurnAngle)
						{
							simEntity.entityActionMoveDirection.mLogicTime = 0;
						}
					}
				}
				else if (vFactor > roleConfig.LimitTurnAngle)
				{
					num = simEntity.entityBlackboard.var.mRunStartSlot;
					simEntity.entityActionMoveDirection.mLogicTime = 0;
				}
			}
		}
		return num;
	}

	private static int TryMatchMoveID(SimEntity simEntity, int step = 0)
	{
		int moveID = GetMoveID(simEntity);
		if (moveID != simEntity.entityActionMoveDirection.mMoveID)
		{
			simEntity.entityActionMoveDirection.mLogicTime = 0;
		}
		simEntity.entityActionMoveDirection.mMoveID = moveID;
		return moveID;
	}

	private static int CalcMovementTimeStep(SimEntity simEntity)
	{
		if (simEntity.entityActionMoveDirection.mStatus == EntityActionStatus.E_UNUSED)
		{
			return 0;
		}
		int logicConstTick = CommonProcessor.GetLogicConstTick();
		SimWorldState worldState = CommonProcessor.GetWorldState();
		worldState.UpdateCommonWorldTimeScaleValue();
		long num = ((Int)simEntity.entityBlackboard.var.mSpeedFactor).i;
		long finalAttributeByAttributeID = AttributeProcessor.GetFinalAttributeByAttributeID(simEntity.entityBlackboard.var.mAttributeID, 2006, AttributeCalcType.AddMul);
		int num2 = (int)IntMath.Divide(logicConstTick * simEntity.entityBlackboard.var.mEntityTimeScale * num * finalAttributeByAttributeID, 100000000L);
		num2 = num2 * worldState.commonWorldTimeScaleValue / worldState.commonWorldTimeScaleBaseValue;
		simEntity.entityActionMoveDirection.mTimeStep = num2;
		return num2;
	}

	public static void MoveDirection(SimEntity simEntity)
	{
		if (simEntity.entityActionMoveDirection.mStatus == EntityActionStatus.E_UNUSED)
		{
			return;
		}
		int num = CalcMovementTimeStep(simEntity);
		int num2 = TryMatchMoveID(simEntity);
		if (simEntity.entityBlackboard.var.mUseRunMoveCurve)
		{
			while (num > 0)
			{
				num2 = TryMatchMoveID(simEntity);
				int num3 = num;
				if (num >= CommonProcessor.GetConfigInterval())
				{
					num3 = CommonProcessor.GetConfigInterval();
				}
				simEntity.entityActionMoveDirection.mLogicTime += num3;
				UpdateTimelineMovement(simEntity, num2, num3);
				num -= num3;
			}
		}
		else
		{
			num2 = TryMatchMoveID(simEntity);
			simEntity.entityActionMoveDirection.mLogicTime += num;
			Int3 @int = UpdateForward(simEntity, num, out var targetMovementDirection);
			if (simEntity.entityActionMoveDirection.mMoveMode == EMoveDirectionMode.Lookat)
			{
				Int3 moveDelta = targetMovementDirection * simEntity.entityBlackboard.var.mMaxSpeed * num / 1000f;
				MoveEntityBySpeed(simEntity, moveDelta);
			}
			else if (simEntity.entityActionMoveDirection.mMovementDirection != Int3.zero)
			{
				if (simEntity.entityActionMoveDirection.mMoveMode == EMoveDirectionMode.CustomMovementLocal)
				{
					@int = IntMath.Transform(simEntity.entityActionMoveDirection.mMovementDirection, @int, simEntity.entityPositon.mPosition).NormalizeTo(1000);
				}
				else if (simEntity.entityActionMoveDirection.mMoveMode == EMoveDirectionMode.CustomMovementGlobal)
				{
					@int = simEntity.entityActionMoveDirection.mMovementDirection;
					@int = @int.NormalizeTo(1000);
				}
				else if (simEntity.entityActionMoveDirection.mMoveMode == EMoveDirectionMode.Pov)
				{
					@int = IntMath.TransformDirection(@int, simEntity.entityActionMoveDirection.mMovementDirection).NormalizeTo(1000);
				}
				Int3 moveDelta2 = @int * simEntity.entityBlackboard.var.mMaxSpeed * num / 1000f;
				MoveEntityBySpeed(simEntity, moveDelta2);
			}
		}
		int mLogicTime = simEntity.entityActionMoveDirection.mLogicTime;
		UpdateShapeWhenMoving(simEntity, mLogicTime);
	}

	public static bool LookAt(SimEntity looker, Int3 aimDirection, Int speed, int deltaTime, out Int3 lookat)
	{
		lookat = looker.entityPositon.mForward;
		if (aimDirection.sqrMagnitudeLong2D <= 0 || lookat.sqrMagnitudeLong2D <= 0)
		{
			return false;
		}
		Int obj = IntMath.Divide(speed.i * deltaTime, 1000);
		long num = Int3.Det(lookat, aimDirection);
		if (num == 0L)
		{
			long num2 = Int3.DotXZLong(lookat, aimDirection);
			if (num2 > 0)
			{
				return true;
			}
		}
		speed = ((num < 0) ? obj : (0 - obj));
		if (speed == 0)
		{
			return true;
		}
		VFactor radians = new VFactor(speed.i, 1000L) * IntMath.Deg2Rad;
		lookat = lookat.RotateY(ref radians);
		if (num * Int3.Det(lookat, aimDirection) < 0)
		{
			lookat = aimDirection.NormalizeTo(1000);
			looker.entityPositon.mForward = lookat;
			looker.entityPositon.mForwardAngle = IntMath.AngleOfVector(lookat);
			return true;
		}
		Turn(looker, speed, out lookat);
		return false;
	}

	public static void Turn(SimEntity looker, Int angleSpeed, out Int3 lookat)
	{
		Int mForwardAngle = looker.entityPositon.mForwardAngle;
		lookat = IntMath.VectorOfAngle(mForwardAngle - angleSpeed);
		lookat = lookat.NormalizeTo(1000);
		looker.entityPositon.mForwardAngle = mForwardAngle - angleSpeed;
		if (looker.entityPositon.mForwardAngle > 360000)
		{
			looker.entityPositon.mForwardAngle -= (Int)360000;
		}
		else if (looker.entityPositon.mForwardAngle < 0)
		{
			looker.entityPositon.mForwardAngle += (Int)360000;
		}
		looker.entityPositon.mForward = lookat;
	}

	public static EntityActionStatus EnableMovement(SimEntity simEntity, bool isActive)
	{
		EntityActionStatus entityActionStatus = EntityActionStatus.E_UNUSED;
		if (simEntity.hasEntityActionMoveDirection)
		{
			entityActionStatus = (isActive ? EntityActionStatus.E_ACTIVE : EntityActionStatus.E_UNUSED);
			simEntity.entityActionMoveDirection.mStatus = entityActionStatus;
			if (!isActive)
			{
				simEntity.entityActionMoveDirection.mLogicTime = 0;
			}
		}
		else
		{
			Stop(simEntity);
		}
		return entityActionStatus;
	}

	public static bool DoStopAbility(SimEntity simEntity)
	{
		if (simEntity == null)
		{
			return false;
		}
		Stop(simEntity);
		if (simEntity.hasEntityActionMoveDirection)
		{
			int mMoveID = simEntity.entityActionMoveDirection.mMoveID;
			simEntity.RemoveEntityActionMoveDirection();
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2016, out var baseValue, out var plusValue, out var tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2021, out var baseValue2, out plusValue, out tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2022, out var baseValue3, out plusValue, out tempPlusValue);
			if (baseValue > 0 || baseValue2 > 0 || baseValue3 > 0)
			{
				return false;
			}
			int num = simEntity.entityBlackboard.var.mMovementStopSlot;
			if (mMoveID == simEntity.entityBlackboard.var.mRushIDSlot)
			{
				num = simEntity.entityBlackboard.var.mRushStopIDSlot;
			}
			else if (simEntity.entityBlackboard.var.mRunStartSlot == mMoveID)
			{
				num = simEntity.entityBlackboard.var.mNearStopSlot;
			}
			if (num == 0)
			{
				return true;
			}
			AbilitiesProcessor.SetNextFrameAbility(simEntity, num, forceBroken: false);
		}
		return true;
	}

	public static void Stop(SimEntity simEntity)
	{
		simEntity[EntityVarName.ENTITY_DESIRED_VELOCITY] = Int3.zero;
		simEntity[EntityVarName.ENTITY_DESIRED_POSITION] = simEntity.entityPositon.mPosition;
		simEntity[EntityVarName.ENTITY_DESIRED_SPEED] = 0;
		simEntity[EntityVarName.ENTITY_CALCULATED_VELOCITY] = Int3.zero;
		simEntity[EntityVarName.ENTITY_CALCULATED_POSITION] = simEntity.entityPositon.mPosition;
		simEntity[EntityVarName.ENTITY_CALCULATED_SPEED] = 0;
	}

	public static void Teleport(SimEntity simEntity, Int3 pos, Int3 forward)
	{
		simEntity.entityPositon.IsTeleport = true;
		simEntity.entityPositon.mPosition = pos;
		simEntity.entityPositon.mForward = forward;
		simEntity.entityPositon.mForwardAngle = IntMath.AngleOfVector(forward);
		simEntity.entityShape.mShape.UpdateWorldShape(simEntity.entityPositon.mPosition, simEntity.entityPositon.mForward);
	}

	public static void MoveClamp(SimEntity entity)
	{
		if (!entity.hasEntityMoveClamp || !entity.hasEntityPositon)
		{
			return;
		}
		Int3 mPosition = entity.entityPositon.mPosition;
		Int3 delta = Int3.zero;
		if (entity.entityMoveClamp.isCircle)
		{
			if (SqrDistance(entity.entityMoveClamp.mCenter, entity) > entity.entityMoveClamp.mRange)
			{
				Int3 @int = entity.entityMoveClamp.mCenter + (mPosition - entity.entityMoveClamp.mCenter).NormalizeTo(entity.entityMoveClamp.mRange);
				delta = @int - mPosition;
			}
		}
		else
		{
			if (mPosition.x >= entity.entityMoveClamp.mCenter.x - entity.entityMoveClamp.mXLength && mPosition.x <= entity.entityMoveClamp.mCenter.x + entity.entityMoveClamp.mXLength && mPosition.z >= entity.entityMoveClamp.mCenter.z - entity.entityMoveClamp.mZLength)
			{
				_ = mPosition.z;
				_ = entity.entityMoveClamp.mCenter.z + entity.entityMoveClamp.mZLength;
			}
			if (mPosition.x < entity.entityMoveClamp.mCenter.x - entity.entityMoveClamp.mXLength)
			{
				delta.x = entity.entityMoveClamp.mCenter.x - entity.entityMoveClamp.mXLength - mPosition.x;
			}
			else if (mPosition.x > entity.entityMoveClamp.mCenter.x + entity.entityMoveClamp.mXLength)
			{
				delta.x = entity.entityMoveClamp.mCenter.x + entity.entityMoveClamp.mXLength - mPosition.x;
			}
			if (mPosition.z < entity.entityMoveClamp.mCenter.z - entity.entityMoveClamp.mZLength)
			{
				delta.z = entity.entityMoveClamp.mCenter.z - entity.entityMoveClamp.mZLength - mPosition.z;
			}
			else if (mPosition.z > entity.entityMoveClamp.mCenter.z + entity.entityMoveClamp.mZLength)
			{
				delta.z = entity.entityMoveClamp.mCenter.z + entity.entityMoveClamp.mZLength - mPosition.z;
			}
		}
		PathfindingMove(entity, delta);
	}
}
