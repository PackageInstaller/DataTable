using System;
using System.Collections.Generic;
using Config;
using Entitas;
using Pathfinding;

public static class SimulatorExtensions
{
	public static void SubcriteID(this SimContext context)
	{
		for (int i = 0; i < context.contextInfo.componentTypes.Length; i++)
		{
			if (context.contextInfo.componentTypes[i] == typeof(EntityID))
			{
				context.OnEntityCreated += context.OnEntityCreatedHandler;
				context.OnEntityDestroyed += context.OnEntityDestroyHandler;
			}
		}
	}

	private static void OnEntityCreatedHandler(this SimContext simContext, IContext context, IEntity entity)
	{
		if (entity.HasComponent(41))
		{
			(entity.GetComponent(41) as EntityID).mID = entity.creationIndex;
		}
		else
		{
			EntityID entityID = entity.CreateComponent<EntityID>(41);
			entityID.mID = entity.creationIndex;
			entity.AddComponent(41, entityID);
		}
		SimEntity simEntity = entity as SimEntity;
		simEntity.BindEntityVar(simContext);
		simEntity.OnDestroyEntity += simContext.OnDestroyEntity;
		simEntity.OnComponentRemoved += simContext.OnComponentRemoved;
		simEntity.OnComponentAdded += simContext.OnComponentAdded;
		simEntity.OnEntityReleased += simContext.OnEntityReleased;
		simEntity.OnComponentReplaced += simContext.OnComponentReplaced;
	}

	private static void OnEntityDestroyHandler(this SimContext simContext, IContext context, IEntity entity)
	{
		entity.OnDestroyEntity -= simContext.OnDestroyEntity;
		entity.OnComponentRemoved -= simContext.OnComponentRemoved;
		entity.OnComponentAdded -= simContext.OnComponentAdded;
		entity.OnEntityReleased -= simContext.OnEntityReleased;
		if (entity is SimEntity simEntity)
		{
			simEntity.DestroyChildren();
		}
	}

	public static void OnComponentAdded(this SimContext context, IEntity entity, int index, IComponent component)
	{
		if (component is IEntityShape)
		{
			if (SimPhysics.sAABBTree == null)
			{
				SimPhysics.sAABBTree = context.sEntityAABBTree.mDynamicTree;
			}
			SimEntity entityWithEntityID = context.GetEntityWithEntityID(entity.creationIndex);
			if (!entityWithEntityID.hasEntityShape)
			{
				return;
			}
			(component as IEntityShape).GetShape().IsEnable = true;
			context.sEntityAABBTree.mDynamicTree.AddProxy((component as IEntityShape).GetShape());
		}
		if (component is EntityActionMove)
		{
			EntityActionMove entityActionMove = component as EntityActionMove;
			if (entityActionMove.mNeedAutoPath)
			{
				SimEntity simEntity = entity as SimEntity;
				Int3 mTargetPos = simEntity[EntityVarName.ENTITY_AI_TARGETPOS];
				simEntity.entityActionMove.mTargetPos = mTargetPos;
				simEntity.entityActionMove.mPath = ABPath.Construct(simEntity.entityPositon.mPosition, entityActionMove.mTargetPos);
				simEntity.entityActionMove.mPath.Claim(simEntity);
				simEntity.entityActionMove.mCurrentWaypointIndex = 0;
			}
		}
		if (component is EntityActionAbility)
		{
			EntityActionAbility entityActionAbility = component as EntityActionAbility;
			SimEntity simEntity2 = entity as SimEntity;
			UpdateCDAndPowerOnAbilityChange(context, simEntity2, null, entityActionAbility);
			OnAddOrReplaceActionAbility(entityActionAbility, simEntity2, context);
			if (context.GetSimInterface().mAbilityAddedLogicEvent != null && !entity.HasComponent(42))
			{
				context.GetSimInterface().mAbilityAddedLogicEvent(entity.creationIndex, 0, entityActionAbility.mAbilityID);
			}
		}
		if (component is EntityHitRecover)
		{
			EntityHitRecover entityHitRecover = component as EntityHitRecover;
			SimEntity simEntity3 = entity as SimEntity;
			if (simEntity3.hasEntityRemotePlayer)
			{
				context.PostEvent(EntityHitRecoverStatusEvent.Claim(simEntity3.creationIndex, entityHitRecover.mHitRecoverActionID, entityHitRecover.mHitRecoverStatus, entityHitRecover.mHitAbilityID, E_HitRecover.OnEnter, entityHitRecover.mCasterID, entityHitRecover.mHitCount));
			}
		}
		if (!(component is EntityActionAvoidShadow))
		{
			return;
		}
		SimEntity simEntity4 = entity as SimEntity;
		if (!simEntity4.FindChildrenTag(SimEntity.Tag.AvoidShadow, out var children) || children == null)
		{
			return;
		}
		for (int i = 0; i < children.Count; i++)
		{
			if (children[i].hasEntityShape)
			{
				children[i].entityShape.SetEnable(isEnable: true);
			}
		}
	}

	private static void OnAddOrReplaceActionAbility(EntityActionAbility ability, SimEntity simEntity, SimContext context)
	{
		if (simEntity.hasEntityHitRecover)
		{
			simEntity.RemoveEntityHitRecover();
			if (simEntity.hasEntityActionMoveDirection)
			{
				MovementProcessor.UpdateForward(simEntity, CommonProcessor.GetLogicConstTick(), out var _);
			}
		}
		if (context.hasSimStatus && simEntity.hasEntityBlackboard)
		{
			AttributeProcessor.SetAttributeWithIntName(simEntity.entityBlackboard.var.mAttributeID, 2207, (int)context.simStatus.mSimTime, 0L, 0L);
		}
		if (simEntity.hasEntityPuppetHost && context.GetSimInterface().mPuppetHostDoAbilityEvent != null)
		{
			for (int i = 0; i < simEntity.entityPuppetHost.mPuppets.Count; i++)
			{
				context.GetSimInterface().mPuppetHostDoAbilityEvent(simEntity.creationIndex, simEntity.entityPuppetHost.mPuppets[i], ability.mAbilityID);
			}
		}
		if (simEntity.hasEntityActionMoveDirection)
		{
			simEntity.entityActionMoveDirection.mMoveID = 0;
			simEntity.entityActionMoveDirection.mLogicTime = 0;
		}
	}

	private static void OnRemoveOrReplaceActionAbility(EntityActionAbility newAbility, EntityActionAbility oldAbility, SimEntity simEntity, SimContext context)
	{
		if (simEntity.hasEntityPuppetHost && context.GetSimInterface().mPuppetHostDoAbilityEvent != null)
		{
			for (int i = 0; i < simEntity.entityPuppetHost.mPuppets.Count; i++)
			{
				context.GetSimInterface().mPuppetHostAbilityOverEvent(simEntity.creationIndex, simEntity.entityPuppetHost.mPuppets[i], newAbility?.mAbilityID ?? 0, oldAbility.mAbilityID);
			}
		}
		if (simEntity.hasEntityBlackboard)
		{
			simEntity.entityBlackboard.var.mIsMoveLock = false;
		}
	}

	public static void OnComponentReplaced(this SimContext context, IEntity entity, int index, IComponent previousComponent, IComponent newComponent)
	{
		if (previousComponent is EntityActionMove)
		{
			EntityActionMove entityActionMove = previousComponent as EntityActionMove;
			SimEntity entity2 = entity as SimEntity;
			entityActionMove.Reset(entity2);
			(entity as SimEntity)[EntityVarName.ENTITY_DESIRED_VELOCITY] = Int3.zero;
			(entity as SimEntity)[EntityVarName.ENTITY_DESIRED_POSITION] = (entity as SimEntity).entityPositon.mPosition;
			(entity as SimEntity)[EntityVarName.ENTITY_DESIRED_SPEED] = 0;
		}
		if (previousComponent is EntityActionMoveDirection)
		{
			EntityActionMoveDirection entityActionMoveDirection = previousComponent as EntityActionMoveDirection;
		}
		if (newComponent is EntityActionMove)
		{
			EntityActionMove entityActionMove2 = newComponent as EntityActionMove;
			if (entityActionMove2.mNeedAutoPath)
			{
				SimEntity simEntity = entity as SimEntity;
				Int3 mTargetPos = simEntity[EntityVarName.ENTITY_AI_TARGETPOS];
				simEntity.entityActionMove.mTargetPos = mTargetPos;
				simEntity.entityActionMove.mPath = ABPath.Construct(simEntity.entityPositon.mPosition, entityActionMove2.mTargetPos);
				simEntity.entityActionMove.mPath.Claim(simEntity);
				simEntity.entityActionMove.mCurrentWaypointIndex = 0;
			}
		}
		if (newComponent is EntityActionAbility)
		{
			SimEntity simEntity2 = entity as SimEntity;
			EntityActionAbility entityActionAbility = newComponent as EntityActionAbility;
			EntityActionAbility oldAbility = previousComponent as EntityActionAbility;
			UpdateCDAndPowerOnAbilityChange(context, simEntity2, oldAbility, entityActionAbility);
			OnAddOrReplaceActionAbility(entityActionAbility, simEntity2, context);
			OnRemoveOrReplaceActionAbility(entityActionAbility, oldAbility, simEntity2, context);
			context.sEntityWorldState.status.RemoveHitHistory(simEntity2.creationIndex);
			EntityActionAbility entityActionAbility2 = previousComponent as EntityActionAbility;
			if (context.GetSimInterface().mAbilityFinishLogicEvent != null && !entity.HasComponent(42))
			{
				context.GetSimInterface().mAbilityFinishLogicEvent(entity.creationIndex, entityActionAbility2.mAbilityID, entityActionAbility.mAbilityID);
			}
			if (context.GetSimInterface().mAbilityAddedLogicEvent != null && !entity.HasComponent(42))
			{
				context.GetSimInterface().mAbilityAddedLogicEvent(entity.creationIndex, entityActionAbility2.mAbilityID, entityActionAbility.mAbilityID);
			}
		}
		if (previousComponent is EntityHitRecover)
		{
			EntityHitRecover entityHitRecover = previousComponent as EntityHitRecover;
			SimEntity simEntity3 = entity as SimEntity;
			if (simEntity3.hasEntityRemotePlayer)
			{
				context.PostEvent(EntityHitRecoverStatusEvent.Claim(simEntity3.creationIndex, entityHitRecover.mHitRecoverActionID, entityHitRecover.mHitRecoverStatus, entityHitRecover.mHitAbilityID, E_HitRecover.OnLeave, entityHitRecover.mCasterID, entityHitRecover.mHitCount));
			}
		}
		if (newComponent is EntityHitRecover)
		{
			EntityHitRecover entityHitRecover2 = newComponent as EntityHitRecover;
			if (entity is SimEntity { hasEntityRemotePlayer: not false } simEntity4)
			{
				context.PostEvent(EntityHitRecoverStatusEvent.Claim(simEntity4.creationIndex, entityHitRecover2.mHitRecoverActionID, entityHitRecover2.mHitRecoverStatus, entityHitRecover2.mHitAbilityID, E_HitRecover.OnEnter, entityHitRecover2.mCasterID, entityHitRecover2.mHitCount));
			}
		}
		if (previousComponent is EntityShape)
		{
			(previousComponent as EntityShape).mShape.IsEnable = false;
		}
		if (newComponent is EntityShape)
		{
			(newComponent as EntityShape).mShape.IsEnable = true;
		}
	}

	public static void OnComponentRemoved(this SimContext context, IEntity entity, int index, IComponent component)
	{
		if (component is EntityActionMove)
		{
			EntityActionMove entityActionMove = component as EntityActionMove;
			SimEntity entity2 = entity as SimEntity;
			entityActionMove.Reset(entity2);
			(entity as SimEntity)[EntityVarName.ENTITY_DESIRED_VELOCITY] = Int3.zero;
			(entity as SimEntity)[EntityVarName.ENTITY_DESIRED_POSITION] = (entity as SimEntity).entityPositon.mPosition;
			(entity as SimEntity)[EntityVarName.ENTITY_DESIRED_SPEED] = 0;
		}
		if (component is EntityRVO)
		{
			(component as EntityRVO).Reset(entity);
		}
		if (component is EntityHide)
		{
			CommonProcessor.HideEntity(entity as SimEntity, isShow: true);
		}
		if (component is IEntityShape)
		{
			if (SimPhysics.sAABBTree == null)
			{
				SimPhysics.sAABBTree = context.sEntityAABBTree.mDynamicTree;
			}
			(component as IEntityShape).SetEnable(isEnable: false);
			context.sEntityAABBTree.mDynamicTree.RemoveProxy((component as IEntityShape).GetShape());
		}
		if (component is EntityActionAttack)
		{
			EntityActionAttack entityActionAttack = component as EntityActionAttack;
			entityActionAttack.Reset(entity as SimEntity);
		}
		if (component is EntityActionJump)
		{
			EntityActionJump entityActionJump = component as EntityActionJump;
			entityActionJump.Reset(entity as SimEntity);
		}
		if (component is EntityActionAbility)
		{
			SimEntity simEntity = entity as SimEntity;
			EntityActionAbility entityActionAbility = component as EntityActionAbility;
			UpdateCDAndPowerOnAbilityChange(context, simEntity, entityActionAbility, null);
			OnRemoveOrReplaceActionAbility(null, entityActionAbility, simEntity, context);
			entityActionAbility.Reset(simEntity);
			if ((entity as SimEntity).hasEntityBlackboard)
			{
				(entity as SimEntity).entityBlackboard.var.mActionBusy = false;
				(entity as SimEntity).entityBlackboard.var.meleeIndex = 0;
			}
			context.sEntityWorldState.status.RemoveHitHistory(entity.creationIndex);
			if (context.GetSimInterface().mAbilityFinishLogicEvent != null && !entity.HasComponent(42))
			{
				context.GetSimInterface().mAbilityFinishLogicEvent(entity.creationIndex, entityActionAbility.mAbilityID, 0);
			}
		}
		if (component is EntityHitRecover)
		{
			EntityHitRecover entityHitRecover = component as EntityHitRecover;
			if (entity is SimEntity && (entity as SimEntity).hasEntityRemotePlayer)
			{
				context.PostEvent(EntityHitRecoverStatusEvent.Claim(entity.creationIndex, entityHitRecover.mHitRecoverActionID, E_HitRecoverStatus.HitReocver, entityHitRecover.mHitAbilityID, E_HitRecover.OnLeave, entityHitRecover.mCasterID, entityHitRecover.mHitCount));
			}
		}
		if (component is EntityActionMoveDirection)
		{
			MovementProcessor.Stop(entity as SimEntity);
		}
		if (component is IComponentReset)
		{
			(component as IComponentReset).Reset(entity as Entity);
		}
		if (!(component is EntityActionAvoidShadow))
		{
			return;
		}
		SimEntity simEntity2 = entity as SimEntity;
		if (!simEntity2.FindChildrenTag(SimEntity.Tag.AvoidShadow, out var children) || children == null)
		{
			return;
		}
		for (int i = 0; i < children.Count; i++)
		{
			if (children[i].hasEntityShape)
			{
				children[i].entityShape.SetEnable(isEnable: false);
			}
		}
	}

	public static void OnEntityReleased(this SimContext contenxt, IEntity entity)
	{
	}

	public static void OnDestroyEntity(this SimContext contenxt, IEntity entity)
	{
		SimEntity simEntity = entity as SimEntity;
	}

	public static void Initialize()
	{
	}

	public static void Shutdown()
	{
	}

	public static T GetEntityValue<T>(this SimEntity entity, EntityVarName key)
	{
		return (T)entity.GetEntityValue(key);
	}

	public static void SetEntityValue<T>(this SimEntity entity, EntityVarName key, T value)
	{
	}

	public static object GetEntityValue(this SimEntity entity, EntityVarName key)
	{
		return null;
	}

	public static uint ToMask(this InterestConfig config)
	{
		uint num = 0u;
		for (int i = 0; i < config.Group.Count; i++)
		{
			num |= (uint)config.Group.get_Item(i);
		}
		return num;
	}

	public static void ToMask(this InterestConfig config, ref uint mask)
	{
		for (int i = 0; i < config.Group.Count; i++)
		{
			mask |= (uint)config.Group.get_Item(i);
		}
	}

	public static void DoAction<TEntity>(this IGroup<TEntity> group, Action<TEntity> process) where TEntity : class, IEntity
	{
		if (process == null)
		{
			return;
		}
		foreach (TEntity item in group)
		{
			process(item);
		}
	}

	public static void DoAction<TContext, TEntity>(this IGroup<TEntity> group, TContext context, Action<TContext, TEntity> process) where TEntity : class, IEntity
	{
		if (process == null)
		{
			return;
		}
		foreach (TEntity item in group)
		{
			process(context, item);
		}
	}

	public static void DoAction<TEntity>(this List<TEntity> group, Action<TEntity> process) where TEntity : class, IEntity
	{
		if (process == null)
		{
			return;
		}
		foreach (TEntity item in group)
		{
			process(item);
		}
	}

	public static void DoAction<TContext, TEntity>(this List<TEntity> group, TContext context, Action<TContext, TEntity> process) where TEntity : class, IEntity
	{
		if (process == null)
		{
			return;
		}
		foreach (TEntity item in group)
		{
			process(context, item);
		}
	}

	public static void DoAction<TEntity>(this IGroup<TEntity> group, Action<TEntity> process, Action<TEntity> process1) where TEntity : class, IEntity
	{
		if (process != null)
		{
			HashSet<TEntity>.Enumerator enumerator = group.GetEnumerator();
			while (enumerator.MoveNext())
			{
				process(enumerator.Current);
				process1(enumerator.Current);
			}
		}
	}

	private static void UpdateCDAndPowerOnAbilityChange(SimContext contenxt, SimEntity simEntity, EntityActionAbility oldAbility, EntityActionAbility newAbility)
	{
		if (!simEntity.hasEntityCD || !simEntity.hasEntityRemotePlayer || oldAbility == null)
		{
			return;
		}
		int num = CDProcessor.CheckAbilityIsAvoid(oldAbility.mAbilityID);
		AbilityConfig config = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(num);
		if (config == null || !simEntity.hasEntityCD)
		{
			return;
		}
		num = ((config.OriginAbility == 0 || num == config.OriginAbility) ? num : config.OriginAbility);
		if (AbilitiesProcessor.GetCDReturn(oldAbility, out var percent))
		{
			CDProcessor.ProcessCDReturn(simEntity, num, percent);
			for (int i = 0; i < config.SyncCDSkillID.Count; i++)
			{
				int mAbilityID = config.SyncCDSkillID.get_Item(i);
				CDProcessor.ProcessCDReturn(simEntity, mAbilityID, percent);
			}
			contenxt.GetSimInterface().mOnAbilityInterruptBySelf?.Invoke(simEntity.creationIndex, num);
		}
	}
}
