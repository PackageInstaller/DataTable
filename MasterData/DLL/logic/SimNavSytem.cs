using System.Collections.Generic;
using Entitas;
using P08Common;
using Pathfinding;
using Pathfinding.RVO.Sampled;
using UnityEngine;

public class SimNavSytem : IInitializeSystem, ISystem, IExecuteSystem, ITearDownSystem
{
	private SimContext mSimContext;

	private AstarPath mMap;

	public SimNavSytem(SimContext sim, AstarPath map)
	{
		mSimContext = sim;
		mMap = map;
	}

	public void Initialize()
	{
		mSimContext.SimEventSystem.AddHandler<EntitySpawnedEvent>(OnEnitySpawnedEventHandler);
		mSimContext.SimEventSystem.AddHandler<EntityDespawnedEvent>(OnEnityDespawnedEventHandler);
	}

	private void OnEnityDespawnedEventHandler(EntityDespawnedEvent eventReceived)
	{
	}

	private void OnEnitySpawnedEventHandler(EntitySpawnedEvent eventReceived)
	{
	}

	private void OnMoveToEventHandler(EntityMoveToEvent eventReceived)
	{
		if (eventReceived == null)
		{
			return;
		}
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(eventReceived.mEnityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			entityWithEntityID[EntityVarName.ENTITY_AI_TARGETPOS] = eventReceived.mTargetPos;
			if (entityWithEntityID.hasEntityActionMove)
			{
				entityWithEntityID.entityActionMove.mStatus = EntityActionStatus.E_ACTIVE;
				entityWithEntityID.entityActionMove.mTargetPos = eventReceived.mTargetPos;
				entityWithEntityID.entityActionMove.mCurrentWaypointIndex = 0;
			}
			else
			{
				entityWithEntityID.AddEntityActionMove(EntityActionStatus.E_ACTIVE, eventReceived.mTargetPos, 0, newMHasCaculated: false, newMNeedAutoPath: true);
			}
		}
	}

	public void Execute()
	{
	}

	public void ProcessOwnerMovement()
	{
	}

	public void ProcessAIMovement()
	{
		HashSet<SimEntity>.Enumerator enumerator = mSimContext.GetGroup(SimMatcher.AIWithMovement).GetEnumerator();
		while (enumerator.MoveNext())
		{
			SimEntity current = enumerator.Current;
			if (current.entityActionMove.mStatus == EntityActionStatus.E_ACTIVE)
			{
				Int3 @int = current[EntityVarName.ENTITY_AI_TARGETPOS];
				if (@int != current.entityActionMove.mTargetPos || !current.entityActionMove.mHasCaculated)
				{
					current.entityActionMove.mTargetPos = @int;
					current.entityActionMove.mHasCaculated = true;
					mMap.AddSearchPath(current.entityActionMove.mPath);
					AstarPath.BlockUntilCalculated(current.entityActionMove.mPath);
					SimPathStartEndModifer.Apply(current.entityActionMove.mPath);
					SimPathFunnelModifier.Apply(current.entityActionMove.mPath, unwrap: false, splitAtEveryPortal: false);
					current.entityActionMove.mCurrentWaypointIndex = 0;
				}
			}
		}
		if (mMap != null)
		{
			mMap.Update();
		}
		UpdateAIMovement();
	}

	private void UpdateAIMovement()
	{
		//IL_025e: Unknown result type (might be due to invalid IL or missing references)
		HashSet<SimEntity>.Enumerator enumerator = mSimContext.GetGroup(SimMatcher.AIWithMovement).GetEnumerator();
		while (enumerator.MoveNext())
		{
			SimEntity current = enumerator.Current;
			Int3 mPosition = current.entityPositon.mPosition;
			List<Int3> int3Path = current.entityActionMove.mPath.int3Path;
			int mPickNextWaypointDist = current.entityBlackboard.var.mPickNextWaypointDist;
			if (int3Path.Count == 1)
			{
				int3Path.Insert(0, mPosition);
			}
			int num = current.entityActionMove.mCurrentWaypointIndex;
			if (num >= int3Path.Count)
			{
				num = int3Path.Count - 1;
			}
			if (num <= 1)
			{
				num = 1;
			}
			while (num < int3Path.Count - 1)
			{
				long num2 = XZSqrMagnitude(int3Path[num], mPosition);
				if (num2 >= mPickNextWaypointDist * mPickNextWaypointDist)
				{
					break;
				}
				num = ++current.entityActionMove.mCurrentWaypointIndex;
			}
			Int3 @int = int3Path[num] - int3Path[num - 1];
			Int3 int2 = CalculateTargetPoint(mPosition, int3Path[num - 1], int3Path[num], current.entityBlackboard.var.mForwardLook);
			@int = int2 - mPosition;
			@int.y = 0;
			Int intMagnitude = @int.IntMagnitude;
			for (int i = num; i < int3Path.Count - 1; i++)
			{
				intMagnitude += (int3Path[i + 1] - int3Path[i]).IntMagnitude;
			}
			VFactor vFactor = VFactor.Clamp01(new VFactor(intMagnitude.i, (current.entityBlackboard.var.mSlowdownDistance == 0) ? 1 : current.entityBlackboard.var.mSlowdownDistance.i));
			Int obj = (Int)(vFactor * current.entityBlackboard.var.mMaxSpeed);
			if ((int)current[EntityVarName.ENTITY_CALCULATED_SPEED] <= 200 && current.entityRVO.bugDirection != 0)
			{
				current.entityRVO.bugDirection = -current.entityRVO.bugDirection;
			}
			Vector2 desiredVelocity = new Int2(@int.x, @int.z);
			BugBehaviour(current, (Int)current.entityBlackboard.var.mMaxSpeed, ref desiredVelocity);
			@int = new Int3(new Vector3(desiredVelocity.x, 0f, desiredVelocity.y));
			@int.Normalize();
			current[EntityVarName.ENTITY_DESIRED_VELOCITY] = @int;
			current[EntityVarName.ENTITY_DESIRED_POSITION] = current.entityPositon.mPosition + IntMath.Divide(@int * obj.i, 1000);
			current[EntityVarName.ENTITY_DESIRED_SPEED] = obj.i;
		}
	}

	private void BugBehaviour(SimEntity entity, Int maxSpeed, ref Vector2 desiredVelocity)
	{
		//IL_05c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_05ce: Unknown result type (might be due to invalid IL or missing references)
		//IL_05d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0683: Unknown result type (might be due to invalid IL or missing references)
		//IL_0752: Unknown result type (might be due to invalid IL or missing references)
		//IL_0772: Unknown result type (might be due to invalid IL or missing references)
		//IL_06dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_06fd: Unknown result type (might be due to invalid IL or missing references)
		if (desiredVelocity == Vector2.Zero)
		{
			XLogger.Debug("desiredVelocity zero return");
			return;
		}
		float num = (float)entity.entityShape.mShape.AvgCollisionRadius / 1000f;
		if (num <= 0f)
		{
			XLogger.Debug("collisionRadius zero return");
			return;
		}
		Agent agent = entity.entityRVO.agent;
		Agent agent2 = entity.entityRVO.bugPrevAvoided;
		int num2 = entity.entityRVO.bugDirection;
		int bugTimer = entity.entityRVO.bugTimer;
		Path mPath = entity.entityActionMove.mPath;
		Vector2 vector = Int2.FromInt3XZ(entity.entityPositon.mPosition);
		float num3 = num;
		float scalar = maxSpeed.scalar;
		Vector2 vector2 = ((entity.hasEntityActionMove && mPath.int3Path.Count > 0) ? ((Vector2)new Int2(mPath.int3Path[mPath.int3Path.Count - 1].x, mPath.int3Path[mPath.int3Path.Count - 1].z)) : vector);
		Vector2 vector3 = vector2 - vector;
		float num4 = 1f;
		float magnitude = vector3.Magnitude;
		if (num4 > 0f && magnitude > num4)
		{
			vector3 = vector3 * (magnitude - num4) / magnitude;
		}
		if (agent2 != null && ((!agent2.locked && !(agent2.maxSpeed <= 0) && !(agent2.CalculatedSpeed <= agent2.maxSpeed * agent.rvoZeroSpeed)) || agent2.Radius <= 0))
		{
			agent2 = null;
		}
		int mCurrentWaypointIndex = entity.entityActionMove.mCurrentWaypointIndex;
		bool flag = mCurrentWaypointIndex == entity.entityActionMove.mPath.int3Path.Count - 2;
		Int3 @int = entity.entityActionMove.mPath.int3Path[mCurrentWaypointIndex];
		Vector2 vector4;
		if (num2 == 0 || agent2 == null)
		{
			vector4 = desiredVelocity;
		}
		else if (num2 < 0)
		{
			float num5 = agent2.Radius.scalar + num3;
			float num6 = num5 * num5;
			Vector2 vector5 = agent2.position;
			Vector2 vector6 = vector - vector5;
			float squareMagnitude = vector6.SquareMagnitude;
			if (squareMagnitude <= num6)
			{
				vector4 = vector6.Perpendicular * scalar / Math.Sqrt(squareMagnitude);
			}
			else
			{
				float num7 = num5 / squareMagnitude;
				float num8 = Math.Sqrt(squareMagnitude - num6);
				Vector2 vector7 = new Vector2(vector5.x + (num5 * vector6.x + num8 * vector6.y) * num7, vector5.y + (num5 * vector6.y - num8 * vector6.x) * num7);
				vector4 = (vector7 - vector) * scalar / num8;
			}
		}
		else
		{
			float num9 = agent2.Radius.scalar + num3;
			float num10 = num9 * num9;
			Vector2 vector8 = agent2.position;
			Vector2 vector9 = vector - vector8;
			float squareMagnitude2 = vector9.SquareMagnitude;
			if (squareMagnitude2 <= num10)
			{
				vector4 = -vector9.Perpendicular * scalar / Math.Sqrt(squareMagnitude2);
			}
			else
			{
				float num11 = num9 / squareMagnitude2;
				float num12 = Math.Sqrt(squareMagnitude2 - num10);
				Vector2 vector10 = new Vector2(vector8.x + (num9 * vector9.x - num12 * vector9.y) * num11, vector8.y + (num9 * vector9.y + num12 * vector9.x) * num11);
				vector4 = (vector10 - vector) * scalar / num12;
			}
		}
		int num13 = 0;
		for (int i = 0; i < agent.Neighbours.Count; i++)
		{
			Agent agent3 = agent.Neighbours[i];
			if (agent3 == agent || agent3 == agent2 || agent3.Radius <= 0 || (num13 & (1 << i)) != 0 || (!agent3.Locked && !(agent3.maxSpeed <= 0) && !(agent3.CalculatedSpeed <= agent3.maxSpeed * agent.rvoZeroSpeed)))
			{
				continue;
			}
			if (agent2 != null)
			{
				Vector2 vector11 = agent2.position;
				Vector2 vector12 = agent3.position;
				float num14 = Vector2.SquareDistance(vector11, vector12);
				if (num14 > Math.Square(agent3.Radius.scalar + 2f * num3 + agent2.Radius.scalar))
				{
					continue;
				}
				float num15 = Math.Sqrt(num14);
				Vector2 vector13 = (vector12 - vector11).Perpendicular * num2 / num15;
				Vector2 vector14 = vector2 + vector13 * num4;
				Vector2 a = vector14 - vector12;
				if (Vector2.Dot(a, vector13) > 0f && Vector2.Det(a, vector13) * (float)num2 > 0f)
				{
					float num16 = agent2.Radius.scalar + num3;
					num16 *= num16;
					float num17 = agent3.Radius.scalar + num3;
					num17 *= num17;
					float num18 = num16 - num17 + num14 / (2f * num15);
					float num19 = num16 - num18 * num18;
					Vector2 vector15 = vector14 + vector13 * (magnitude - num4);
					float num20 = (float)Geometry.Segment.SegmentSquareDistance(vector15, vector14, vector11, vector12);
					if (num20 >= num19)
					{
						continue;
					}
				}
			}
			float num21 = agent3.Radius.scalar + num3;
			float num22 = num21 * num21;
			Vector2 val = (Vector2)agent3.position;
			Vector2 b = vector - val;
			float squareMagnitude3 = b.SquareMagnitude;
			if (squareMagnitude3 <= num22)
			{
				if (squareMagnitude3 != 0f && !(Vector2.Dot(vector4, b) >= 0f))
				{
					if (num2 == 0)
					{
						num2 = ((!(Vector2.Det(vector4, b) > 0f)) ? 1 : (-1));
					}
					vector4 = ((num2 >= 0) ? (-b.Perpendicular * scalar / Math.Sqrt(squareMagnitude3)) : (b.Perpendicular * scalar / Math.Sqrt(squareMagnitude3)));
					agent2 = agent3;
					num13 |= 1 << i;
					i = -1;
				}
			}
			else if (Geometry.Point.SquareDistanceToSegment(val, vector, vector + vector4) < (double)num22)
			{
				if (num2 == 0)
				{
					num2 = ((!(Vector2.Det(vector4, b) > 0f)) ? 1 : (-1));
				}
				if (num2 < 0)
				{
					float num23 = num21 / squareMagnitude3;
					float num24 = Math.Sqrt(squareMagnitude3 - num22);
					Vector2 vector16 = new Vector2(val.x + (num21 * b.x + num24 * b.y) * num23, val.y + (num21 * b.y - num24 * b.x) * num23);
					vector4 = (vector16 - vector) * scalar / num24;
				}
				else
				{
					float num25 = num21 / squareMagnitude3;
					float num26 = Math.Sqrt(squareMagnitude3 - num22);
					Vector2 vector17 = new Vector2(val.x + (num21 * b.x - num26 * b.y) * num25, val.y + (num21 * b.y + num26 * b.x) * num25);
					vector4 = (vector17 - vector) * scalar / num26;
				}
				agent2 = agent3;
				num13 |= 1 << i;
				i = -1;
			}
		}
		if ((num13 == 0 && agent2 == null) || (Vector2.Dot(vector4, desiredVelocity) > 0f && (float)num2 * Vector2.Det(desiredVelocity, vector4) >= 0f))
		{
			agent2 = null;
			bugTimer -= 100;
			if (bugTimer <= 0)
			{
				bugTimer = 0;
				num2 = 0;
			}
		}
		else
		{
			bugTimer = ((Int)agent.rvoSurroundBehaviorDuration).i;
			desiredVelocity = vector4;
		}
		entity.entityRVO.bugPrevAvoided = agent2;
		entity.entityRVO.bugDirection = num2;
		entity.entityRVO.bugTimer = bugTimer;
	}

	protected static long XZSqrMagnitude(Int3 a, Int3 b)
	{
		int num = b.x - a.x;
		int num2 = b.z - a.z;
		return num * num + num2 * num2;
	}

	protected static Int3 CalculateTargetPoint(Int3 p, Int3 a, Int3 b, Int forwardLook)
	{
		a.y = p.y;
		b.y = p.y;
		Int intMagnitude = (a - b).IntMagnitude;
		if (intMagnitude == 0)
		{
			return a;
		}
		VFactor vFactor = VFactor.Clamp01(ClosestPointOnLineFactor(a, b, p));
		Int3 @int = (b - a) * vFactor + a;
		Int intMagnitude2 = (@int - p).IntMagnitude;
		VFactor vFactor2 = new VFactor(((Int)IntMath.Clamp(forwardLook.i - intMagnitude2.i, 0, forwardLook.i)).i, intMagnitude.i);
		vFactor2 = VFactor.Clamp01(vFactor2 + vFactor);
		return (b - a) * vFactor2 + a;
	}

	public static VFactor ClosestPointOnLineFactor(Int3 lineStart, Int3 lineEnd, Int3 point)
	{
		Int3 rhs = lineEnd - lineStart;
		long sqrMagnitudeLong = rhs.sqrMagnitudeLong;
		int num = Int3.Dot(point - lineStart, rhs);
		if (sqrMagnitudeLong != 0L)
		{
			return new VFactor(num, sqrMagnitudeLong);
		}
		return VFactor.zero;
	}

	public void TearDown()
	{
	}
}
