using System.Collections.Generic;
using Config;
using Entitas;
using P08Common;
using Pathfinding;
using Pathfinding.Util;
using UnityEngine;

public class AIProcessor
{
	public enum AICommandStatus
	{
		None,
		Running,
		Success,
		Failed
	}

	public enum E_Direction
	{
		Forward,
		Backward,
		Left,
		Right,
		Up,
		Down
	}

	public static SimContext mSimContext;

	private static IAllOfMatcher<SimEntity> sAIMovementGroup;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
	}

	public static void UpdateAITarget(SimEntity entity, SimEntity target)
	{
		entity[EntityVarName.ENTITY_AI_TARGET] = target.creationIndex;
		UpdateAITargetStatus(entity);
	}

	public static E_Direction GetRandomLeftOrRight()
	{
		if (DRandom.Random(10u) % 2 == 0)
		{
			return E_Direction.Left;
		}
		return E_Direction.Right;
	}

	public static AICommandStatus DoAICommand(SimEntity entity, AICommand cmd, bool isInterrupt = false)
	{
		AICommandStatus aICommandStatus = AICommandStatus.Failed;
		if (!isInterrupt)
		{
			aICommandStatus = cmd.Run(mSimContext, entity);
		}
		if (aICommandStatus != AICommandStatus.Running)
		{
			cmd.Exit(mSimContext, entity);
		}
		return aICommandStatus;
	}

	public static Int3 GetTargetPos(SimEntity entity, E_Direction forward)
	{
		Int3 mPosition = entity.entityPositon.mPosition;
		int mAimTarget = entity.entityBlackboard.var.mAimTarget;
		if (!AICheckTargetValid(entity.creationIndex, mAimTarget))
		{
			return mPosition;
		}
		SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(mAimTarget);
		Int3 entityPostion = GetEntityPostion(simEntityByMultiColliders.creationIndex);
		Int3 @int = mPosition - entityPostion;
		return forward switch
		{
			E_Direction.Forward => mPosition - @int, 
			E_Direction.Backward => mPosition + @int, 
			E_Direction.Left => new Int3(-@int.z * -1, 0, @int.x * -1) + mPosition, 
			E_Direction.Right => new Int3(-@int.z, 0, @int.x) + mPosition, 
			_ => mPosition, 
		};
	}

	public static SimEntity GetAITarget(SimEntity entity)
	{
		SimEntity simEntity = GetAISkillTargetInView(entity);
		if (simEntity == null && (int)entity[EntityVarName.ENTITY_AI_TARGET] > 0)
		{
			simEntity = mSimContext.GetEntityWithEntityID(entity[EntityVarName.ENTITY_AI_TARGET]);
		}
		if (simEntity == null)
		{
			entity[EntityVarName.ENTITY_AI_TARGET] = 0;
		}
		return simEntity;
	}

	public static SimEntity GetAISkillTargetInView(SimEntity entity)
	{
		return null;
	}

	public static void UpdateAITargetStatus(SimEntity entity)
	{
		if ((int)entity[EntityVarName.ENTITY_AI_TARGET] > 0)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entity[EntityVarName.ENTITY_AI_TARGET]);
			if (entityWithEntityID == null)
			{
				entity[EntityVarName.ENTITY_AI_TRAGET_IS_DEATH] = true;
			}
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
			{
				entity[EntityVarName.ENTITY_AI_TRAGET_IS_DEATH] = entityWithEntityID.entityBlackboard.var.mHP <= 0;
			}
			if ((bool)entity[EntityVarName.ENTITY_AI_TRAGET_IS_DEATH])
			{
				XLogger.Debug("{0} IS DEATH : {1}", entity.creationIndex, entity[EntityVarName.ENTITY_AI_TRAGET_IS_DEATH]);
				entity[EntityVarName.ENTITY_AI_TARGET] = 0;
			}
		}
		else
		{
			entity[EntityVarName.ENTITY_AI_TRAGET_IS_DEATH] = true;
		}
	}

	public static SimEntity GetBestNearAttackTarget(SimContext sim, int entityID)
	{
		return null;
	}

	public static int IsAIThinking(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		if (entityWithEntityID.hasEntityAIThink && entityWithEntityID.entityAIThink.mThinkTimer > 0)
		{
			entityWithEntityID.entityAIThink.mThinkTimer -= 33;
			if (entityWithEntityID.hasEntityActionMoveDirection)
			{
				entityWithEntityID.RemoveEntityActionMoveDirection();
			}
			return entityWithEntityID.entityAIThink.mThinkTimer;
		}
		return 0;
	}

	public static bool IsAIBusying(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return true;
		}
		if (entityWithEntityID.hasEntityActionAbility)
		{
			return true;
		}
		return false;
	}

	public static bool IsAIHurting(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return false;
		}
		if (!entityWithEntityID.hasEntityActionModifyHP)
		{
			return entityWithEntityID.hasEntityHitRecover;
		}
		return true;
	}

	public static bool AIHasAttackTarget(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || entityWithEntityID.hasEntityActionDeath)
		{
			return false;
		}
		if (entityWithEntityID != null)
		{
			return entityWithEntityID.entityBlackboard.var.mAimTarget > 0;
		}
		return false;
	}

	public static int TryGetAttackTarget(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || entityWithEntityID.hasEntityActionDeath)
		{
			return 0;
		}
		entityWithEntityID.entityBlackboard.var.mAimTarget = AbilitiesProcessor.LookatNearestTarget(entityWithEntityID);
		return entityWithEntityID.entityBlackboard.var.mAimTarget;
	}

	public static bool AICheckTargetValid(int entityID, int targetID)
	{
		SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(targetID);
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID.entityBlackboard.var.mAimTarget > 0 && simEntityByMultiColliders != null && !simEntityByMultiColliders.hasEntityActionDeath && simEntityByMultiColliders.hasEntityBlackboard)
		{
			return simEntityByMultiColliders.entityBlackboard.var.mHP > 0;
		}
		return false;
	}

	public static bool CanLockOfEntity(SimEntity pSimEntity)
	{
		return AttributeProcessor.CanLockOfEntity(pSimEntity);
	}

	public static void AIStartAbility(int entityID, AIAbilityCommand cmd)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		RoleConfig roleConfig = entityWithEntityID.entityConfig.mConfig as RoleConfig;
		int abilityID = roleConfig.ID * 1000 + cmd.mID;
		if (!entityWithEntityID.hasEntityActionAbility)
		{
			AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, abilityID, cmd.mForceInterruptAbility);
			cmd.mAbilityStart = true;
			entityWithEntityID.entityBlackboard.var.mAttackCount++;
		}
		else if (cmd.mForceInterruptAbility)
		{
			AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, abilityID, cmd.mForceInterruptAbility);
			entityWithEntityID.entityBlackboard.var.mNewAbilityStartFrame = cmd.mBeginFrame;
			cmd.mAbilityStart = true;
		}
	}

	public static void AIReplaceAbility(int entityID, Int3 targetPostion, AIAbilityCommand cmd)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID.hasEntityActionAbility)
		{
			entityWithEntityID.entityPositon.mForward = Int3.ProjectionToY(targetPostion - entityWithEntityID.entityPositon.mPosition).NormalizeTo(1000);
			entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
			RoleConfig roleConfig = entityWithEntityID.entityConfig.mConfig as RoleConfig;
			int abilityID = roleConfig.ID * 1000 + cmd.mID;
			AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, abilityID, cmd.mForceInterruptAbility);
			entityWithEntityID.entityBlackboard.var.mNewAbilityStartFrame = cmd.mBeginFrame;
			entityWithEntityID.entityBlackboard.var.mAttackCount++;
		}
	}

	public static void AIStartAttack(int entityID, Int3 targetPostion, int abilityID, bool isForce = false)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		Int3 @int = Int3.ProjectionToY(targetPostion - entityWithEntityID.entityPositon.mPosition).NormalizeTo(1000);
		if (@int.sqrMagnitudeLong > 0)
		{
			entityWithEntityID.entityPositon.mForward = @int;
			entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(@int);
		}
		AbilitiesProcessor.SetNextFrameAbility(entityWithEntityID, abilityID, isForce);
		entityWithEntityID.entityBlackboard.var.mAttackCount++;
	}

	public static void SetAIThinking(int entityID, int time)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (!entityWithEntityID.hasEntityAIThink)
		{
			entityWithEntityID.AddEntityAIThink(time, new Dictionary<int, AICommand>(new IntComparer()), null, null, newMReevalute: false, newMForceMakeDecision: false, time);
		}
		else
		{
			entityWithEntityID.entityAIThink.mThinkTimer = time;
		}
	}

	public static Int3 GetEntityPostion(int entityID)
	{
		return mSimContext.GetEntityWithEntityID(entityID)?.entityPositon.mPosition ?? Int3.zero;
	}

	public static void MoveAIDirection(int entityID, Int3 targetPosition, VFactor factor)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		Int3 @int = Int3.ProjectionToY(targetPosition - entityWithEntityID.entityPositon.mPosition).NormalizeTo(1000);
		entityWithEntityID.entityBlackboard.var.mSpeedFactor = factor;
		if (entityWithEntityID.HasComponent(16))
		{
			entityWithEntityID.entityActionMoveDirection.mDirection = @int;
			entityWithEntityID.entityActionMoveDirection.mStatus = MovementProcessor.EnableMovement(entityWithEntityID, !entityWithEntityID.entityBlackboard.var.mActionBusy);
		}
		else if (entityWithEntityID.entityBlackboard.var.mActionBusy)
		{
			entityWithEntityID.AddEntityActionMoveDirection(MovementProcessor.EnableMovement(entityWithEntityID, !entityWithEntityID.entityBlackboard.var.mActionBusy), @int, Int3.zero, newMIsTurn: false, 0, Int3.zero, 0, 0, Int3.zero, EMoveDirectionMode.Lookat);
		}
		else
		{
			entityWithEntityID.AddEntityActionMoveDirection(EntityActionStatus.E_ACTIVE, @int, Int3.zero, newMIsTurn: false, 0, Int3.zero, 0, 0, Int3.zero, EMoveDirectionMode.Lookat);
		}
	}

	public static void StopAIMovement(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		MovementProcessor.Stop(entityWithEntityID);
		if (entityWithEntityID.hasEntityActionMoveDirection)
		{
			entityWithEntityID.RemoveEntityActionMoveDirection();
		}
	}

	public static bool IsAIDeath(int entityID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || entityWithEntityID.hasEntityActionDeath)
		{
			return true;
		}
		if (entityWithEntityID.hasEntityActionAbility && ConfigHelper.GetInstance().TryGetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID, out var config) && config.IsFinalAction)
		{
			return true;
		}
		return false;
	}

	public static bool IsAITargetInRange(int entityID, Int3 targetPosition, int range)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		return MovementProcessor.IsNear(entityWithEntityID, targetPosition, range);
	}

	internal static void Process_AI_GroupMovement()
	{
		if (sAIMovementGroup == null)
		{
			sAIMovementGroup = SimMatcher.AllOf(SimMatcher.EntityAIMovement, SimMatcher.EntityActionMoveDirection);
		}
		mSimContext.GetGroup(sAIMovementGroup).DoAction(delegate(SimEntity entity)
		{
			//IL_0057: Unknown result type (might be due to invalid IL or missing references)
			Int3 mDirection = entity.entityActionMoveDirection.mDirection;
			Vector2 desiredVelocity = new Int2(mDirection.x, mDirection.z);
			AIGroupMovementBehaviour(entity, (Int)entity.entityBlackboard.var.mMaxSpeed, ref desiredVelocity);
			entity.entityActionMoveDirection.mDirection = new Int3(new Vector3(desiredVelocity.x, 0f, desiredVelocity.y)).NormalizeTo(1000);
		});
	}

	private static void AIGroupMovementBehaviour(SimEntity entity, Int maxSpeed, ref Vector2 desiredVelocity)
	{
		if (desiredVelocity == Vector2.Zero)
		{
			return;
		}
		float scalar = entity.entityShape.GetRadius().scalar;
		if (scalar <= 0f)
		{
			XLogger.Debug("collisionRadius zero return");
			return;
		}
		SimEntity simEntity = mSimContext.GetEntityWithEntityID(entity.entityAIMovement.mPrevAvoidEntityID);
		int num = entity.entityAIMovement.mDirection;
		int mTimer = entity.entityAIMovement.mTimer;
		Vector2 vector = Int2.FromInt3XZ(entity.entityPositon.mPosition);
		float num2 = scalar;
		float scalar2 = maxSpeed.scalar;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entity.entityBlackboard.var.mAimTarget);
		Vector2 vector2 = ((entityWithEntityID != null) ? ((Vector2)Int2.FromInt3XZ(entityWithEntityID.entityShape.mShape.WorldPos)) : vector);
		Vector2 vector3 = vector2 - vector;
		float num3 = 1f;
		float magnitude = vector3.Magnitude;
		if (num3 > 0f && magnitude > num3)
		{
			vector3 = vector3 * (magnitude - num3) / magnitude;
		}
		if (simEntity != null && (!(simEntity.entityBlackboard.var.mCalculatedSpeed <= 10) || simEntity.entityShape.GetRadius() <= 0 || simEntity.hasEntityActionDeath))
		{
			simEntity = null;
		}
		Vector2 vector4;
		if (num == 0 || simEntity == null)
		{
			vector4 = desiredVelocity;
		}
		else if (num < 0)
		{
			float scalar3 = simEntity.entityShape.GetRadius().scalar;
			Vector2 vector5 = Int2.FromInt3XZ(simEntity.entityPositon.mPosition);
			float num4 = scalar3 + num2;
			float num5 = num4 * num4;
			Vector2 vector6 = vector5;
			Vector2 vector7 = vector - vector6;
			float squareMagnitude = vector7.SquareMagnitude;
			if (squareMagnitude <= num5)
			{
				vector4 = vector7.Perpendicular * scalar2 / Math.Sqrt(squareMagnitude);
			}
			else
			{
				float num6 = num4 / squareMagnitude;
				float num7 = Math.Sqrt(squareMagnitude - num5);
				Vector2 vector8 = new Vector2(vector6.x + (num4 * vector7.x + num7 * vector7.y) * num6, vector6.y + (num4 * vector7.y - num7 * vector7.x) * num6);
				vector4 = (vector8 - vector) * scalar2 / num7;
			}
		}
		else
		{
			float scalar4 = simEntity.entityShape.GetRadius().scalar;
			Vector2 vector9 = Int2.FromInt3XZ(simEntity.entityPositon.mPosition);
			float num8 = scalar4 + num2;
			float num9 = num8 * num8;
			Vector2 vector10 = vector9;
			Vector2 vector11 = vector - vector10;
			float squareMagnitude2 = vector11.SquareMagnitude;
			if (squareMagnitude2 <= num9)
			{
				vector4 = -vector11.Perpendicular * scalar2 / Math.Sqrt(squareMagnitude2);
			}
			else
			{
				float num10 = num8 / squareMagnitude2;
				float num11 = Math.Sqrt(squareMagnitude2 - num9);
				Vector2 vector12 = new Vector2(vector10.x + (num8 * vector11.x - num11 * vector11.y) * num10, vector10.y + (num8 * vector11.y + num11 * vector11.x) * num10);
				vector4 = (vector12 - vector) * scalar2 / num11;
			}
		}
		int num12 = 0;
		List<int> list = ListPool<int>.Claim();
		SimPhysics.Overlap(entity.entityPositon.mPosition, 5000, list, 2u);
		for (int i = 0; i < list.Count; i++)
		{
			SimEntity entityWithEntityID2 = mSimContext.GetEntityWithEntityID(list[i]);
			if (entityWithEntityID2 == entity || entityWithEntityID2 == simEntity || entityWithEntityID2.entityShape.GetRadius() <= 0 || (num12 & (1 << i)) != 0)
			{
				continue;
			}
			float num13 = (float)entityWithEntityID2.entityShape.mShape.AvgCollisionRadius / 1000f;
			Vector2 vector13 = Int2.FromInt3XZ(entityWithEntityID2.entityShape.mShape.WorldPos);
			if (simEntity != null)
			{
				float num14 = (float)simEntity.entityShape.mShape.AvgCollisionRadius / 1000f;
				Vector2 vector14 = Int2.FromInt3XZ(simEntity.entityPositon.mPosition);
				Vector2 vector15 = vector14;
				Vector2 vector16 = vector13;
				float num15 = Vector2.SquareDistance(vector15, vector16);
				if (num15 > Math.Square(num13 + 2f * num2 + num14))
				{
					continue;
				}
				float num16 = Math.Sqrt(num15);
				Vector2 vector17 = (vector16 - vector15).Perpendicular * num / num16;
				Vector2 vector18 = vector2 + vector17 * num3;
				Vector2 a = vector18 - vector16;
				if (Vector2.Dot(a, vector17) > 0f && Vector2.Det(a, vector17) * (float)num > 0f)
				{
					float num17 = num14 + num2;
					num17 *= num17;
					float num18 = num13 + num2;
					num18 *= num18;
					float num19 = num17 - num18 + num15 / (2f * num16);
					float num20 = num17 - num19 * num19;
					Vector2 vector19 = vector18 + vector17 * (magnitude - num3);
					float num21 = (float)Geometry.Segment.SegmentSquareDistance(vector19, vector18, vector15, vector16);
					if (num21 >= num20)
					{
						continue;
					}
				}
			}
			float num22 = num13 + num2;
			float num23 = num22 * num22;
			Vector2 b = vector - vector13;
			float squareMagnitude3 = b.SquareMagnitude;
			if (squareMagnitude3 <= num23)
			{
				if (squareMagnitude3 != 0f && !(Vector2.Dot(vector4, b) >= 0f))
				{
					if (num == 0)
					{
						num = ((!(Vector2.Det(vector4, b) > 0f)) ? 1 : (-1));
					}
					vector4 = ((num >= 0) ? (-b.Perpendicular * scalar2 / Math.Sqrt(squareMagnitude3)) : (b.Perpendicular * scalar2 / Math.Sqrt(squareMagnitude3)));
					simEntity = entityWithEntityID2;
					num12 |= 1 << i;
					i = -1;
				}
			}
			else if (Geometry.Point.SquareDistanceToSegment(vector13, vector, vector + vector4) < (double)num23)
			{
				if (num == 0)
				{
					num = ((!(Vector2.Det(vector4, b) > 0f)) ? 1 : (-1));
				}
				if (num < 0)
				{
					float num24 = num22 / squareMagnitude3;
					float num25 = Math.Sqrt(squareMagnitude3 - num23);
					Vector2 vector20 = new Vector2(vector13.x + (num22 * b.x + num25 * b.y) * num24, vector13.y + (num22 * b.y - num25 * b.x) * num24);
					vector4 = (vector20 - vector) * scalar2 / num25;
				}
				else
				{
					float num26 = num22 / squareMagnitude3;
					float num27 = Math.Sqrt(squareMagnitude3 - num23);
					Vector2 vector21 = new Vector2(vector13.x + (num22 * b.x - num27 * b.y) * num26, vector13.y + (num22 * b.y + num27 * b.x) * num26);
					vector4 = (vector21 - vector) * scalar2 / num27;
				}
				simEntity = entityWithEntityID2;
				num12 |= 1 << i;
				i = -1;
			}
		}
		if ((num12 == 0 && simEntity == null) || (Vector2.Dot(vector4, desiredVelocity) > 0f && (float)num * Vector2.Det(desiredVelocity, vector4) >= 0f))
		{
			simEntity = null;
			mTimer -= 100;
			if (mTimer <= 0)
			{
				mTimer = 0;
				num = 0;
			}
		}
		else
		{
			mTimer = 5000;
			entity.entityAIMovement.mTimer = 5000;
			desiredVelocity = vector4;
		}
		entity.entityAIMovement.mPrevAvoidEntityID = simEntity?.creationIndex ?? 0;
		entity.entityAIMovement.mDirection = num;
		entity.entityAIMovement.mTimer = mTimer;
		ListPool<int>.Release(list);
	}

	public static RoleType GetSimLayer(uint camp)
	{
		if (RoleCampProcessor.IsPlayer(camp))
		{
			return RoleType.Player;
		}
		if (RoleCampProcessor.IsEnemy(camp))
		{
			return RoleType.Enemy;
		}
		if (RoleCampProcessor.IsNeutral(camp))
		{
			return RoleType.Neutral;
		}
		return RoleType.None;
	}

	public SimEntity GetNearestAliveEntity(SimEntity agent, E_Direction direction, int maxRadius, uint layer)
	{
		Int3 mPosition = agent.entityPositon.mPosition;
		Int3 @int;
		switch (direction)
		{
		case E_Direction.Forward:
			@int = agent.entityPositon.mForward;
			break;
		case E_Direction.Backward:
			@int = -agent.entityPositon.mForward;
			break;
		case E_Direction.Right:
			@int = IntMath.GetXZRight(agent.entityPositon.mForward);
			break;
		case E_Direction.Left:
			@int = IntMath.GetXZLeft(agent.entityPositon.mForward);
			break;
		default:
			return null;
		}
		return GetNearestAliveEntity(mPosition + @int, mPosition + @int * 3, maxRadius, agent, layer);
	}

	public static SimEntity GetNearestAliveEntity(Int3 center, int radius, SimEntity ignoreAgent, uint layer)
	{
		float num = radius * radius;
		SimEntity result = null;
		List<int> list = ListPool<int>.Claim();
		SimPhysics.Overlap(center, radius, list, layer);
		for (int i = 0; i < list.Count; i++)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(list[i]);
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
			if (simEntityByMultiColliders != null && simEntityByMultiColliders != ignoreAgent && !simEntityByMultiColliders.hasEntityActionDeath)
			{
				float sqrMagnitude = (center - entityWithEntityID.entityShape.mShape.WorldPos).sqrMagnitude;
				if (sqrMagnitude < num)
				{
					num = sqrMagnitude;
					result = simEntityByMultiColliders;
				}
			}
		}
		ListPool<int>.Release(list);
		return result;
	}

	public static SimEntity GetNearestAliveEntity(Int3 start, Int3 end, int radius, SimEntity ignoreAgent, uint layer)
	{
		long num = radius * radius;
		SimEntity result = null;
		List<int> list = ListPool<int>.Claim();
		int i = (end - start).IntMagnitude.i;
		SimPhysics.Overlap((end - start) / 2f, i, list, layer);
		for (int j = 0; j < list.Count; j++)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(list[j]);
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
			if (simEntityByMultiColliders != null && simEntityByMultiColliders != ignoreAgent && !simEntityByMultiColliders.hasEntityActionDeath)
			{
				long num2 = SqrDistanceFromPointToVector(start, end, entityWithEntityID.entityShape.mShape.WorldPos);
				if (num2 < num)
				{
					num = num2;
					result = simEntityByMultiColliders;
				}
			}
		}
		ListPool<int>.Release(list);
		return result;
	}

	public static int DistanceFromPointToVector(Int3 lineStart, Int3 lineEnd, Int3 point)
	{
		Int3 @int = VectorMath.ClosestPointOnSegment(lineStart, lineEnd, point);
		return (point - @int).IntMagnitude.i;
	}

	public static long SqrDistanceFromPointToVector(Int3 lineStart, Int3 lineEnd, Int3 point)
	{
		Int3 @int = VectorMath.ClosestPointOnSegment(lineStart, lineEnd, point);
		return (point - @int).sqrMagnitudeLong;
	}

	public static bool RunMelee(SimEntity simEntity, bool mIsPressing, int buttonType)
	{
		if (simEntity == null)
		{
			return false;
		}
		if (mIsPressing)
		{
			if (simEntity.hasEntityActionManualInput)
			{
				simEntity.ReplaceEntityActionManualInput(EntityActionStatus.E_ACTIVE, buttonType, TimeHelper.Now(), newMCanDestroy: true, mIsPressing);
			}
			else
			{
				simEntity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, buttonType, TimeHelper.Now(), newMCanDestroy: true, mIsPressing);
			}
		}
		if (simEntity.hasEntityActionAbility)
		{
			simEntity.entityActionAbility.mIsPressing = mIsPressing;
		}
		return true;
	}

	public static bool AIInput(SimEntity simEntity, int buttonType, bool isPressing)
	{
		if (simEntity == null)
		{
			return false;
		}
		if (simEntity.hasEntityActionManualInput)
		{
			simEntity.entityActionManualInput.mStatus = EntityActionStatus.E_ACTIVE;
			simEntity.entityActionManualInput.mIsPressing = isPressing;
			simEntity.entityActionManualInput.mCanDestroy = true;
			simEntity.entityActionManualInput.mInputKey = buttonType;
			simEntity.entityActionManualInput.mInputStamp = TimeHelper.Now();
		}
		else
		{
			simEntity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, buttonType, TimeHelper.Now(), newMCanDestroy: true, isPressing);
		}
		if (simEntity.hasEntityActionAbility)
		{
			simEntity.entityActionAbility.mIsPressing = isPressing;
		}
		return true;
	}

	public static bool AIPressInput(SimEntity simEntity, bool isPressing, int buttonType)
	{
		if (simEntity == null)
		{
			return false;
		}
		if (isPressing)
		{
			if (simEntity.hasEntityActionManualInput)
			{
				simEntity.ReplaceEntityActionManualInput(EntityActionStatus.E_ACTIVE, buttonType, TimeHelper.Now(), newMCanDestroy: true, isPressing);
			}
			else
			{
				simEntity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, buttonType, TimeHelper.Now(), newMCanDestroy: true, isPressing);
			}
		}
		if (simEntity.hasEntityActionAbility)
		{
			simEntity.entityActionAbility.mIsPressing = isPressing;
		}
		return true;
	}

	public static Int3 GetEnemyCenterPos()
	{
		Int3 zero = Int3.zero;
		int num = 0;
		List<int> allEnemy = SpawnProcessor.GetAllEnemy();
		for (int i = 0; i < allEnemy.Count; i++)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(allEnemy[i]);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon && !entityWithEntityID.hasEntityActionDeath)
			{
				num++;
				zero += entityWithEntityID.entityPositon.mPosition;
			}
		}
		return zero / num;
	}

	public static int GetDistanceBetweenEntities(int entityID, int targetID)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entityID);
		SimEntity entityWithEntityID2 = mSimContext.GetEntityWithEntityID(targetID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityPositon || entityWithEntityID2 == null || !entityWithEntityID2.hasEntityPositon)
		{
			return int.MaxValue;
		}
		return (entityWithEntityID.entityPositon.mPosition - entityWithEntityID2.entityPositon.mPosition).magnitude2D;
	}

	public static void ChangeTarget(SimEntity entity, int targetID)
	{
		if (entity == null || !entity.hasEntityBlackboard)
		{
			return;
		}
		AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2213, out var baseValue, out var _, out var _);
		if (baseValue != 0L)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID((int)baseValue);
			if (CommonProcessor.IsAliveRole(entityWithEntityID))
			{
				targetID = (int)baseValue;
			}
		}
		AbilitiesProcessor.SetAimTargetAndNearestPart(entity, targetID);
		entity.entityBlackboard.var.mLastTarget = entity.entityBlackboard.var.mAimTarget;
		entity.entityBlackboard.var.hasManualLock = true;
		AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2209, 1L, 0L, 0L);
	}

	public static bool DoStopAbility(SimEntity simEntity)
	{
		return MovementProcessor.DoStopAbility(simEntity);
	}

	public static bool IsTargetInRange(SimEntity entity, int range)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entity.entityBlackboard.var.mAimTarget);
		entityWithEntityID = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
		if (entityWithEntityID == null)
		{
			return false;
		}
		ISimShape nearestCollisionData = GetNearestCollisionData(entity, entityWithEntityID, entityWithEntityID.entityCamp.mRoleTypeCamp, out var minDistance);
		if (minDistance < range)
		{
			return true;
		}
		return false;
	}

	public static Int3 GetTargetPosition(SimEntity entity)
	{
		Int3 result = Int3.zero;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(entity.entityBlackboard.var.mAimTarget);
		if (entityWithEntityID == null)
		{
			return result;
		}
		ISimShape mShape = entityWithEntityID.entityShape.mShape;
		if (mShape != null)
		{
			result = mShape.WorldPos;
		}
		return result;
	}

	public static ISimShape GetNearestCollisionData(SimEntity entity, SimEntity target, uint layerMask, out long minDistance)
	{
		target = CommonProcessor.GetSimEntityByMultiColliders(target);
		if (target == null || entity == null)
		{
			minDistance = long.MaxValue;
			return null;
		}
		return GetNearestCollisionData(entity.entityPositon.mPosition, target, layerMask, out minDistance);
	}

	public static ISimShape GetNearestCollisionData(Int3 position, SimEntity target, uint layerMask, out long minDistance)
	{
		minDistance = long.MaxValue;
		if (target == null)
		{
			return null;
		}
		List<ISimShape> list = FrameListPool<ISimShape>.Claim();
		SimShapeProcessor.GetAllShape(target, list);
		int num = -1;
		minDistance = long.MaxValue;
		for (int i = 0; i < list.Count; i++)
		{
			ISimShape simShape = list[i];
			if (simShape.IsEnable && RoleCampProcessor.Is(layerMask, (uint)simShape.Layer))
			{
				long a = MovementProcessor.SqrDistance(simShape.WorldPos, position);
				a = IntMath.Sqrt(a) - simShape.AvgCollisionRadius;
				if (minDistance > a)
				{
					num = i;
					minDistance = a;
				}
			}
		}
		ISimShape result = null;
		if (num >= 0)
		{
			result = list[num];
		}
		FrameListPool<ISimShape>.Release(list);
		return result;
	}

	public static E_Direction ChooseMoveDirection(SimEntity entity)
	{
		E_Direction e_Direction = ((DRandom.Random(10u) % 2 != 0) ? E_Direction.Right : E_Direction.Left);
		SimEntity nearestAliveEntity = GetNearestAliveEntity(entity.entityPositon.mPosition, 8000, entity, entity.entityCamp.mRoleTypeCamp);
		if (nearestAliveEntity != null)
		{
			Int3 mPosition = nearestAliveEntity.entityPositon.mPosition;
			Int3 rhs = mPosition - entity.entityPositon.mPosition;
			if (e_Direction == E_Direction.Left)
			{
				if (Int3.Det(entity.entityPositon.mForward, rhs) > 0)
				{
					e_Direction = E_Direction.Right;
				}
			}
			else if (Int3.Det(entity.entityPositon.mForward, rhs) < 0)
			{
				e_Direction = E_Direction.Left;
			}
		}
		return e_Direction;
	}
}
