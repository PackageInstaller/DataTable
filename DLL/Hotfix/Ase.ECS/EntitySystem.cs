#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class EntitySystem : BaseSystem
{
	private List<BaseEntity> cacheRemoveEntities = new List<BaseEntity>();

	private List<BaseEntity> removeEntities = new List<BaseEntity>();

	private List<BaseEntity> cacheWaitEntities = new List<BaseEntity>();

	private Dictionary<int, BaseEntity> _entities = new Dictionary<int, BaseEntity>();

	private List<BaseEntity> _entityList = new List<BaseEntity>();

	private int serialId;

	private int serverId;

	private List<BaseEntity> _targetEntityList = new List<BaseEntity>();

	private List<BaseEntity> _interactiveEntityList = new List<BaseEntity>();

	private List<HeroEntity> _teamEntityList = new List<HeroEntity>();

	private List<HeroEntity> _woundedList = new List<HeroEntity>();

	private Dictionary<HeroEntity, List<HeroEntity>> _rescueDic = new Dictionary<HeroEntity, List<HeroEntity>>();

	protected override bool IsLogicSystem => true;

	public override bool NeedPauseSystem => false;

	public List<HeroEntity> PlayerTeamList => _teamEntityList;

	public bool IsNeedRescue => _woundedList.Count > 0;

	public List<HeroEntity> WoundedList => _woundedList;

	private void ExecuteCommand(int entityId, MsgPlayerInput playerInput, WorldUpdateType updateType)
	{
		BaseEntity entity = GetEntity(entityId, isGetCache: true);
		if (entity != null && entity.GetEntityType() == EntityType.HERO && playerInput != null)
		{
			entity.ExecuteCommand(playerInput, updateType);
		}
	}

	public void ExecuteLocal(int entityId, MsgPlayerInput playerInput)
	{
		ExecuteCommand(entityId, playerInput, WorldUpdateType.Local);
	}

	public void ExecuteServer(int entityId, MsgPlayerInput playerInput)
	{
		ExecuteCommand(entityId, playerInput, WorldUpdateType.Authority);
	}

	public void DoEntityDestroy(int entityId)
	{
		_entities.TryGetValue(entityId, out var value);
		value?.DoEntityDead();
	}

	public void DoEntityDestroy(BaseEntity entity)
	{
		lock (cacheRemoveEntities)
		{
			if (!cacheRemoveEntities.Contains(entity))
			{
				cacheRemoveEntities.Add(entity);
			}
		}
	}

	public override void OnDispose()
	{
		OnReset();
		serialId = 0;
	}

	public override void OnUpdate(float deltaTime)
	{
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnUpdate(deltaTime);
		}
	}

	public override void OnFixedUpdateBefore(WorldUpdateType updateType)
	{
		HandleWaitEntity();
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnFixedUpdateBefore(updateType);
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnFixedUpdate(updateType, _entityList[i].FinalDeltaTime);
		}
	}

	public override void OnFixedUpdateAfter(WorldUpdateType updateType)
	{
		ReleaseDeadEntity();
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnFixedUpdateAfter(updateType);
		}
	}

	private Dictionary<int, BaseEntity> GetCorrectEntity()
	{
		return _entities;
	}

	public List<BaseEntity> GetAllEntity()
	{
		return _entityList;
	}

	private void HandleWaitEntity()
	{
		lock (cacheWaitEntities)
		{
			for (int i = 0; i < cacheWaitEntities.Count; i++)
			{
				BaseEntity baseEntity = cacheWaitEntities[i];
				_entities.Add(baseEntity.Id, baseEntity);
				_entityList.Add(baseEntity);
				if (baseEntity.GetEntityType() == EntityType.HERO || baseEntity.GetEntityType() == EntityType.MONSTER)
				{
					_targetEntityList.Add(baseEntity);
				}
				if (baseEntity.GetEntityType() == EntityType.INTERACTIVE && baseEntity is InteractiveEntity interactiveEntity && interactiveEntity.GetHaveHitBox())
				{
					_interactiveEntityList.Add(interactiveEntity);
				}
				baseEntity.OnStart();
				ObserverEntityCreateParams observerEntityCreateParams = ReferencePool.Acquire<ObserverEntityCreateParams>();
				observerEntityCreateParams.Init(baseEntity);
				GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.EntityCreate, observerEntityCreateParams);
				ReferencePool.Release(observerEntityCreateParams);
			}
			cacheWaitEntities.Clear();
		}
	}

	private void ReleaseDeadEntity()
	{
		if (cacheRemoveEntities.Count <= 0)
		{
			return;
		}
		removeEntities.Clear();
		removeEntities.AddRange(cacheRemoveEntities);
		cacheRemoveEntities.Clear();
		for (int num = removeEntities.Count - 1; num >= 0; num--)
		{
			BaseEntity baseEntity = removeEntities[num];
			if (!baseEntity.CheckEntityState(EntityState.Dead))
			{
				cacheWaitEntities.Remove(baseEntity);
				_entities.Remove(baseEntity.Id);
				_entityList.Remove(baseEntity);
				_targetEntityList.Remove(baseEntity);
				_interactiveEntityList.Remove(baseEntity);
				baseEntity.OnEntityRelease();
				baseEntity.OnDispose();
			}
		}
		removeEntities.Clear();
	}

	public override void OnReset()
	{
		if (_teamEntityList != null)
		{
			_teamEntityList.Clear();
			_teamEntityList = null;
		}
		_woundedList.Clear();
		_woundedList = null;
		_rescueDic.Clear();
		_rescueDic = null;
		_entities.Clear();
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnDispose();
		}
		_entityList.Clear();
		_targetEntityList.Clear();
		_interactiveEntityList.Clear();
	}

	public void ClearAllEntity()
	{
		if (_teamEntityList != null)
		{
			_teamEntityList.Clear();
		}
		_woundedList.Clear();
		_rescueDic.Clear();
		_entities.Clear();
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].DoEntityDead(isRelease: true, isNormalDead: false);
		}
		_entityList.Clear();
		_targetEntityList.Clear();
		_interactiveEntityList.Clear();
	}

	public override void OnResumeBefore()
	{
		base.OnResumeBefore();
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnResumeBefore();
		}
	}

	public override void OnPauseBefore()
	{
		base.OnPauseBefore();
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnPauseBefore();
		}
	}

	public override void OnGameSpeedChanged(float beforeTheChangeSpeed, float gameSpeed)
	{
		for (int i = 0; i < _entityList.Count; i++)
		{
			if (!world.EntityIgnoreTimeScale(_entityList[i]))
			{
				_entityList[i].OnGameSpeedChanged(gameSpeed);
			}
			else
			{
				_entityList[i].OnGameSpeedChanged(1f);
			}
		}
	}

	public void OnLevelFail()
	{
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnLevelFail();
		}
	}

	public override void OnPause()
	{
		base.OnPause();
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnPause();
		}
	}

	public override void OnResume()
	{
		base.OnResume();
		for (int i = 0; i < _entityList.Count; i++)
		{
			_entityList[i].OnResume();
		}
	}

	public BaseEntity GetEntity(int eId, bool isGetCache = false)
	{
		if (eId == 0)
		{
			return null;
		}
		_entities.TryGetValue(eId, out var value);
		if (value != null)
		{
			return value;
		}
		if (isGetCache)
		{
			for (int i = 0; i < cacheWaitEntities.Count; i++)
			{
				if (cacheWaitEntities[i].Id == eId)
				{
					return cacheWaitEntities[i];
				}
			}
		}
		return null;
	}

	public BaseEntity GetEntityByConfigId(int configId, bool isGetCache = false)
	{
		if (configId == 0)
		{
			return null;
		}
		foreach (BaseEntity value in _entities.Values)
		{
			if (value.EntityId == configId)
			{
				return value;
			}
		}
		if (isGetCache)
		{
			for (int i = 0; i < cacheWaitEntities.Count; i++)
			{
				if (cacheWaitEntities[i].EntityId == configId)
				{
					return cacheWaitEntities[i];
				}
			}
		}
		return null;
	}

	public List<T> GetEntityList<T>(bool isGetCache = false) where T : BaseEntity
	{
		List<T> list = new List<T>();
		foreach (BaseEntity value in _entities.Values)
		{
			if (value is T item)
			{
				list.Add(item);
			}
		}
		if (isGetCache)
		{
			foreach (BaseEntity cacheWaitEntity in cacheWaitEntities)
			{
				if (cacheWaitEntity is T item2)
				{
					list.Add(item2);
				}
			}
		}
		return list;
	}

	public T CreateEntity<T>(int entityId, EntityData entityData, bool isSyncEntity = false, bool currentTickCreate = false) where T : BaseEntity, new()
	{
		if (isSyncEntity)
		{
			return CreateEntity<T>(--serialId * -1, entityId, entityData, currentTickCreate);
		}
		return CreateEntity<T>(--serialId, entityId, entityData, currentTickCreate);
	}

	public T CreateServerEntity<T>(int serverEntityId, int entityId, EntityData entityData) where T : BaseEntity, new()
	{
		return CreateEntity<T>(serverEntityId, entityId, entityData);
	}

	private T CreateEntity<T>(int id, int entityId, EntityData entityData, bool isCurrentTickCreate = false) where T : BaseEntity, new()
	{
		EntityCreateData entityCreateData = ReferencePool.Acquire<EntityCreateData>();
		entityCreateData.id = id;
		entityCreateData.entityId = entityId;
		entityCreateData.entityType = typeof(T);
		entityCreateData.parent = entityData.parent;
		entityCreateData.entityData = entityData;
		entityCreateData.world = world;
		if (!isCurrentTickCreate)
		{
			return (T)DoCreateEntity(entityCreateData);
		}
		return (T)DoCreateCurrentTickEntity(entityCreateData);
	}

	private BaseEntity DoCreateCurrentTickEntity(EntityCreateData createData)
	{
		try
		{
			BaseEntity baseEntity = (BaseEntity)Activator.CreateInstance(createData.entityType);
			baseEntity.OnInit(createData);
			baseEntity.OnAwake();
			baseEntity.OnStart();
			_entities.Add(baseEntity.Id, baseEntity);
			_entityList.Add(baseEntity);
			if (baseEntity.GetEntityType() == EntityType.HERO || baseEntity.GetEntityType() == EntityType.MONSTER)
			{
				_targetEntityList.Add(baseEntity);
			}
			if (baseEntity.GetEntityType() == EntityType.INTERACTIVE && baseEntity is InteractiveEntity interactiveEntity && interactiveEntity.GetHaveHitBox())
			{
				_interactiveEntityList.Add(interactiveEntity);
			}
			return baseEntity;
		}
		catch (Exception ex)
		{
			Log.Error("创建实体出错.. Error : " + ex.Message + " \n" + ex.StackTrace);
			return null;
		}
	}

	private BaseEntity DoCreateEntity(EntityCreateData createData)
	{
		try
		{
			BaseEntity baseEntity = (BaseEntity)Activator.CreateInstance(createData.entityType);
			baseEntity.OnInit(createData);
			baseEntity.OnAwake();
			cacheWaitEntities.Add(baseEntity);
			return baseEntity;
		}
		catch (Exception ex)
		{
			Log.Error("创建实体出错.. Error : " + ex.Message + " \n" + ex.StackTrace);
			return null;
		}
	}

	public BaseEntity FindNearestTarget(BaseEntity entity, float range)
	{
		BaseEntity result = null;
		float num = range;
		List<BaseEntity> roomEntity = world.GetSystem<RoomSystem>().GetRoomEntity(entity);
		for (int i = 0; i < roomEntity.Count; i++)
		{
			BaseEntity baseEntity = roomEntity[i];
			if (baseEntity.IsSurvival && baseEntity.IsSurvival && AIUtility.GetRelation(baseEntity.GetEntityCampType(), entity.GetEntityCampType()) == RelationTypeEnum.Hostile)
			{
				float num2 = Vector3.Distance(entity.transform.position, baseEntity.transform.position);
				if (num2 <= num)
				{
					num = num2;
					result = baseEntity;
				}
			}
		}
		return result;
	}

	public List<BaseEntity> FindAllTargetEntities()
	{
		return _targetEntityList;
	}

	public void FindAllSurvivalEntities(BaseEntity entity, in List<BaseEntity> hostileList, bool containSelf = false)
	{
		for (int i = 0; i < _entityList.Count; i++)
		{
			BaseEntity baseEntity = _entityList[i];
			if (baseEntity.IsSurvival && (containSelf || baseEntity.Id != entity.Id))
			{
				hostileList.Add(baseEntity);
			}
		}
	}

	public List<BaseEntity> FindAllSurvivalTargetEntities()
	{
		List<BaseEntity> list = CollectionPool<List<BaseEntity>, BaseEntity>.Get();
		for (int i = 0; i < _targetEntityList.Count; i++)
		{
			BaseEntity baseEntity = _targetEntityList[i];
			StateComponent component = baseEntity.GetComponent<StateComponent>();
			if ((component == null || !component.ImmuneLock()) && baseEntity.IsSurvival)
			{
				list.Add(baseEntity);
			}
		}
		return list;
	}

	public List<T> FindAllSurvivalTargetEntities<T>(IPredicate<T> predicate) where T : BaseEntity
	{
		if (predicate == null)
		{
			return null;
		}
		List<T> list = CollectionPool<List<T>, T>.Get();
		for (int i = 0; i < _targetEntityList.Count; i++)
		{
			BaseEntity baseEntity = _targetEntityList[i];
			StateComponent component = baseEntity.GetComponent<StateComponent>();
			if ((component == null || !component.ImmuneLock()) && baseEntity.IsSurvival && baseEntity is T item && predicate.Predicate(item))
			{
				list.Add(item);
			}
		}
		return list;
	}

	public T FindEntity<T>(IPredicate<T> predicate) where T : BaseEntity
	{
		if (predicate == null)
		{
			return null;
		}
		foreach (BaseEntity targetEntity in _targetEntityList)
		{
			if (targetEntity is T val && predicate.Predicate(val))
			{
				return val;
			}
		}
		return null;
	}

	public List<BaseEntity> FindTargetEntities(BaseEntity entity, RelationTypeEnum relationType = RelationTypeEnum.Hostile)
	{
		List<BaseEntity> list = CollectionPool<List<BaseEntity>, BaseEntity>.Get();
		for (int i = 0; i < _targetEntityList.Count; i++)
		{
			BaseEntity baseEntity = _targetEntityList[i];
			StateComponent component = baseEntity.GetComponent<StateComponent>();
			if ((component == null || !component.ImmuneLock()) && baseEntity.IsSurvival && AIUtility.GetRelation(baseEntity.GetEntityCampType(), entity.GetEntityCampType()) == relationType)
			{
				list.Add(baseEntity);
			}
		}
		return list;
	}

	public List<BaseEntity> FindInteractiveEntity()
	{
		List<BaseEntity> list = CollectionPool<List<BaseEntity>, BaseEntity>.Get();
		list.AddRange(_interactiveEntityList);
		return list;
	}

	public List<BaseEntity> FindAllMonsterEntities()
	{
		List<BaseEntity> list = CollectionPool<List<BaseEntity>, BaseEntity>.Get();
		for (int i = 0; i < _targetEntityList.Count; i++)
		{
			BaseEntity baseEntity = _targetEntityList[i];
			if (baseEntity.GetEntityType() == EntityType.MONSTER && baseEntity.IsSurvival)
			{
				StateComponent component = baseEntity.GetComponent<StateComponent>();
				if (component == null || !component.ImmuneLock())
				{
					list.Add(baseEntity);
				}
			}
		}
		return list;
	}

	public List<BaseEntity> FindAllRelationEntities(BaseEntity entity, RelationTypeEnum relationType = RelationTypeEnum.Hostile)
	{
		List<BaseEntity> list = CollectionPool<List<BaseEntity>, BaseEntity>.Get();
		for (int i = 0; i < _targetEntityList.Count; i++)
		{
			BaseEntity baseEntity = _targetEntityList[i];
			StateComponent component = baseEntity.GetComponent<StateComponent>();
			if ((component == null || !component.ImmuneLock()) && (relationType != RelationTypeEnum.Friendly || (baseEntity.Id != entity.Id && baseEntity.Id != entity.Id * -1)) && baseEntity.IsSurvival && AIUtility.GetRelation(baseEntity.GetEntityCampType(), entity.GetEntityCampType()) == relationType)
			{
				list.Add(baseEntity);
			}
		}
		return list;
	}

	public List<EffectEntity> GetFrozenEffectEntities(BaseEntity parent, bool isAttackEffect = true)
	{
		List<EffectEntity> list = new List<EffectEntity>();
		if (isAttackEffect)
		{
			int count = _entityList.Count;
			for (int i = 0; i < count; i++)
			{
				BaseEntity baseEntity = _entityList[i];
				if (baseEntity is IEffectHelper effectHelper && effectHelper.GetEffectOwner().Id == parent.Id && effectHelper.IsFrozenEffect)
				{
					list.Add((EffectEntity)baseEntity);
				}
			}
		}
		else
		{
			foreach (BaseEntity cacheWaitEntity in cacheWaitEntities)
			{
				if (cacheWaitEntity is IEffectHelper effectHelper2 && effectHelper2.GetEffectOwner().Id == parent.Id && effectHelper2.IsFrozenEffect)
				{
					list.Add((EffectEntity)cacheWaitEntity);
				}
			}
		}
		return list;
	}

	public void HeroRegisterTeam(HeroEntity heroEntity)
	{
		_teamEntityList.Add(heroEntity);
	}

	public List<int> GetTeamEntityId(int entityId, bool isIncludeEntity, EntityLogicType entityLogicType = EntityLogicType.None)
	{
		List<int> list = CollectionPool<List<int>, int>.Get();
		foreach (HeroEntity teamEntity in _teamEntityList)
		{
			if ((teamEntity.LogicType == EntityLogicType.None || teamEntity.LogicType == entityLogicType) && (isIncludeEntity || teamEntity.Id != entityId))
			{
				list.Add(teamEntity.Id);
			}
		}
		return list;
	}

	public int GetTeamAttributeCountByEntity(HeroAttributeEnum attribute)
	{
		int num = 0;
		foreach (HeroEntity teamEntity in _teamEntityList)
		{
			if (teamEntity.IsSurvival && (teamEntity.BattleHeroData.Attribute == attribute || attribute == HeroAttributeEnum.Every))
			{
				num++;
			}
		}
		return num;
	}

	public List<HeroEntity> GetTeamHero()
	{
		return _teamEntityList;
	}

	public void ClearTeam()
	{
		_teamEntityList.Clear();
	}

	public int GetTeamHeroNumber(bool isIncludeAi)
	{
		int num = 0;
		foreach (HeroEntity teamEntity in _teamEntityList)
		{
			if (teamEntity.LogicType != EntityLogicType.Logic && teamEntity.LogicType != EntityLogicType.None)
			{
				continue;
			}
			if (!isIncludeAi)
			{
				if (!teamEntity.IsAi)
				{
					num++;
				}
			}
			else
			{
				num++;
			}
		}
		return num;
	}

	public List<HeroEntity> GetAIHeroList()
	{
		return _teamEntityList.FindAll((HeroEntity heroEntity) => heroEntity.IsAi);
	}

	public bool GetEntityIsTeam(BaseEntity entity)
	{
		if (entity == null)
		{
			return false;
		}
		if (_teamEntityList == null)
		{
			return false;
		}
		if (entity.IsActorEntity)
		{
			return false;
		}
		if (entity is HeroEntity item && _teamEntityList.Contains(item))
		{
			return true;
		}
		if (entity is SummonedEntity { Parent: not null, Parent: HeroEntity parent })
		{
			if (parent.IsActorEntity)
			{
				return false;
			}
			if (_teamEntityList.Contains(parent))
			{
				return true;
			}
		}
		return false;
	}

	public void RegisterWounded(HeroEntity heroEntity)
	{
		heroEntity.GetComponent<NearDeathRescueComponent>().EnterNearDeathState();
		_woundedList.Add(heroEntity);
	}

	public void SuccessFulRescue(HeroEntity wounded)
	{
		_woundedList.Remove(wounded);
		wounded.GetComponent<NearDeathRescueComponent>().PullThrough();
		_rescueDic.TryGetValue(wounded, out var value);
		if (value != null)
		{
			for (int i = 0; i < value.Count; i++)
			{
				value[i].GetComponent<NearDeathRescueComponent>().SuccessFulRescue();
			}
		}
		_rescueDic.Remove(wounded);
	}

	public void GiveUpRescue(HeroEntity wounded, HeroEntity rescue)
	{
		_rescueDic.TryGetValue(wounded, out var value);
		wounded.GetComponent<NearDeathRescueComponent>().OnWoundedGiveUp(rescue);
		if (value != null && value.Contains(rescue))
		{
			value.Remove(rescue);
		}
	}

	public void RegisterRescue(HeroEntity wounded, HeroEntity rescue)
	{
		wounded.GetComponent<NearDeathRescueComponent>().WoundedStartCure(rescue);
		_rescueDic.TryGetValue(wounded, out var value);
		if (value == null)
		{
			value = new List<HeroEntity> { rescue };
			_rescueDic.Add(wounded, value);
		}
		else if (!value.Contains(rescue))
		{
			value.Add(rescue);
		}
	}

	public void WoundedDie(HeroEntity wounded)
	{
		_woundedList.Remove(wounded);
		_rescueDic.TryGetValue(wounded, out var value);
		wounded.GetComponent<NearDeathRescueComponent>().OnWoundedGiveUp(wounded);
		if (value != null)
		{
			for (int i = 0; i < value.Count; i++)
			{
				value[i].GetComponent<NearDeathRescueComponent>().GiveUpRescue();
			}
			_rescueDic.Remove(wounded);
		}
	}
}
