#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.Serializing;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public abstract class BaseEntity : BaseLifeCycle, IEntity, ILifeCycle, IInit, IAwake, IStart, IUpdate, IFixedUpdate, IPause, IDispose, IEntityRoom
{
	protected IComponentData componentData;

	protected BaseEntityView BaseEntityView;

	private BaseComponent[] _cacheComps;

	protected bool cacheTickUpdate = true;

	protected EntityCallbacks callbacks;

	protected CampType CampType;

	protected CollisionSetting.CollisionLayer collisionLayer;

	protected int collisionMass;

	protected Dictionary<Type, BaseComponent> entityComps = new Dictionary<Type, BaseComponent>();

	protected EntityData entityData;

	protected GameObject entityObject;

	protected EntityState entityState;

	protected bool isFrozen;

	protected EntityLogicType logicType;

	protected ILTransform lInitTransform;

	protected ILTransform lTransform;

	protected int mEntityId;

	protected int mId;

	protected BaseEntity parent;

	protected int roomId;

	protected uint tick;

	protected EntityUpdateType updateType;

	protected bool ViewIsNeedLerp = true;

	protected float StableMovementSharpness = 0.2f;

	protected float StableRotationSharpness = 1f / 30f;

	protected object userData;

	protected object userDataPam;

	protected WorldBase world;

	protected float entityDeltaTime;

	protected float entityGameSpeed = 1f;

	protected float frozenSpeed = 1f;

	private int frozenType;

	private bool _existCacheComps;

	private bool isPause;

	private EntityCreateData createData;

	private bool isDeadReleaseEffect = true;

	protected EntityViewModel property;

	private DRSkinAssociation drSkinAssociation;

	private Dictionary<int, int> skinEffect;

	private Dictionary<int, int> skinSound;

	private Dictionary<int, int> skinMaterial;

	protected DRHeroSkin drHeroSkin;

	private Dictionary<uint, PooledWriter> cacheSnapShots = new Dictionary<uint, PooledWriter>();

	public IComponentData ComponentData => componentData;

	public EntityData EntityData => entityData;

	public bool ViewNeedLerp => ViewIsNeedLerp;

	public float ViewMovementSharpness => StableMovementSharpness;

	public float ViewRotationSharpness => StableRotationSharpness;

	public float EntityDeltaTime => entityDeltaTime;

	public float FinalDeltaTime => entityDeltaTime;

	public float EntityGameSpeed => entityGameSpeed;

	public float FrozenSpeed => frozenSpeed;

	public int FrozenType => frozenType;

	public float FinalSpeed => frozenSpeed * entityGameSpeed;

	public bool IsFrozen => isFrozen;

	public virtual bool ViewInitIsActive => true;

	public virtual string AssetPath => string.Empty;

	public virtual bool SyncPosition => true;

	public virtual bool IsSyncEntity => false;

	public virtual bool IsSyncPhysicsEntity => false;

	public virtual EntityUpdateType UpdateType => updateType;

	public EntityLogicType LogicType => logicType;

	public bool CacheTickUpdate => cacheTickUpdate;

	public uint Tick => tick;

	public bool IsCanExecuteDisPlay
	{
		get
		{
			if (Id == GetWorld().ActorId)
			{
				return logicType == EntityLogicType.None;
			}
			return true;
		}
	}

	public bool IsCanExecuteLogic
	{
		get
		{
			if (logicType != EntityLogicType.Logic)
			{
				return logicType == EntityLogicType.None;
			}
			return true;
		}
	}

	public bool InPause => isPause;

	public int Id => mId;

	public int EntityId => mEntityId;

	public BaseEntity Parent => parent;

	public bool IsSurvival => entityState == EntityState.Survival;

	public bool IsStandby => entityState == EntityState.Standby;

	public bool IsActorEntity => mId == world.ActorId;

	public bool IsNeedUpdateCom
	{
		get
		{
			if (entityState != EntityState.Survival && entityState != EntityState.Reborn)
			{
				return entityState == EntityState.MarkDead;
			}
			return true;
		}
	}

	public ILTransform initTransform => lInitTransform;

	public ILTransform transform => lTransform;

	int IEntityRoom.ID => mId;

	int IEntityRoom.RoomId
	{
		get
		{
			return roomId;
		}
		set
		{
			roomId = value;
		}
	}

	public EntityViewModel EntityViewModel => property;

	public virtual ObservableDictionary<string, PropertyData> Property => property?.Property;

	public DRSkinAssociation HeroSkin => drSkinAssociation;

	public bool IsInteractiveEntity => GetEntityType() == EntityType.INTERACTIVE;

	private void InitEntityComponentData(EntityCreateData entityCreateData)
	{
		componentData = ReferencePool.Acquire<ComponentData>();
	}

	public void SetData<T>(string key, T value)
	{
		componentData.Put(key, value);
	}

	public T GetData<T>(string key)
	{
		return componentData.Get<T>(key);
	}

	public T GetData<T>(string key, T defaultValue)
	{
		return componentData.Get(key, defaultValue);
	}

	public Vector3 GetCenterPosition()
	{
		return GetComponent<EntityBoneComponent>()?.GetBonePosition("center") ?? Vector3.zero;
	}

	public BaseEntityView GetBaseEntityView()
	{
		return BaseEntityView;
	}

	public bool CheckEntityState(EntityState state)
	{
		return state == entityState;
	}

	public bool IsDeadReleaseEffect()
	{
		return isDeadReleaseEffect;
	}

	public void SetDeadReleaseEffect(bool releaseEffect)
	{
		isDeadReleaseEffect = releaseEffect;
	}

	public override void OnInit(object data = null)
	{
		createData = (EntityCreateData)data;
		if (createData != null)
		{
			mId = createData.id;
			mEntityId = createData.entityId;
			parent = createData.parent;
			world = createData.world;
			entityObject = createData.entityData.entityObject;
			callbacks = createData.entityData.callbacks;
			entityData = createData.entityData;
			collisionLayer = createData.entityData.collisionLayer;
			collisionMass = createData.entityData.collisionMass;
			logicType = createData.entityData.logicType;
			userData = createData.entityData.userData;
			userDataPam = createData.entityData.userDataPam;
			updateType = createData.entityData.updateType;
			CampType = createData.entityData.campType;
			isDeadReleaseEffect = createData.entityData.isDeadReleaseEffect;
			lInitTransform = LTransform.Create(createData.entityData.pointData);
			lTransform = LTransform.Create(createData.entityData.pointData);
			tick = world.Tick;
			ViewIsNeedLerp = world.CharacterConfig.viewLerp;
			StableMovementSharpness = world.CharacterConfig.stableMovementSharpness;
			StableRotationSharpness = world.CharacterConfig.stableRotationSharpness;
			InitEntityComponentData(createData);
			InitEntityComponent();
			InitEntitySkinConfig();
		}
	}

	public override void OnAwake(object data = null)
	{
		entityDeltaTime = GetWorld().GetEntityDeltaTime(this);
		entityGameSpeed = GetWorld().GetEntityGameSpeed(this);
		int num = ((_cacheComps != null) ? _cacheComps.Length : 0);
		for (int i = 0; i < num; i++)
		{
			_cacheComps[i].OnAwake(data);
		}
		callbacks?.OnAwake(this);
		ChangeEntityState(EntityState.Survival);
	}

	public override void OnStart(object data = null)
	{
		int num = ((_cacheComps != null) ? _cacheComps.Length : 0);
		for (int i = 0; i < num; i++)
		{
			_cacheComps[i].OnStart(data);
		}
		callbacks?.OnStart(this);
	}

	public override void OnUpdate(float deltaTime)
	{
		if (IsNeedUpdateCom && _existCacheComps)
		{
			int num = _cacheComps.Length;
			for (int i = 0; i < num; i++)
			{
				_cacheComps[i].OnUpdate(deltaTime);
			}
		}
	}

	public override void OnFixedUpdateBefore(WorldUpdateType type)
	{
		tick++;
		if (IsNeedUpdateCom && _existCacheComps)
		{
			int num = _cacheComps.Length;
			for (int i = 0; i < num; i++)
			{
				_cacheComps[i].OnFixedUpdateBefore(type);
			}
		}
	}

	public override void OnFixedUpdate(WorldUpdateType type, float deltaTime)
	{
		if (cacheTickUpdate && IsNeedUpdateCom && _existCacheComps)
		{
			int num = _cacheComps.Length;
			for (int i = 0; i < num; i++)
			{
				_cacheComps[i].OnFixedUpdate(type, deltaTime);
			}
		}
	}

	public override void OnFixedUpdateAfter(WorldUpdateType type)
	{
		if (cacheTickUpdate && IsNeedUpdateCom && _existCacheComps)
		{
			int num = _cacheComps.Length;
			for (int i = 0; i < num; i++)
			{
				_cacheComps[i].OnFixedUpdateAfter(type);
			}
		}
	}

	public override void OnPause()
	{
		if (IsSurvival)
		{
			int num = ((_cacheComps != null) ? _cacheComps.Length : 0);
			for (int i = 0; i < num; i++)
			{
				_cacheComps[i].OnPause();
			}
			isPause = true;
		}
		BaseEntityView?.OnPause();
	}

	public override void OnResume()
	{
		if (IsSurvival)
		{
			int num = ((_cacheComps != null) ? _cacheComps.Length : 0);
			for (int i = 0; i < num; i++)
			{
				_cacheComps[i].OnResume();
			}
			isPause = false;
		}
		BaseEntityView?.OnResume();
	}

	public override void OnGameSpeedChanged(float gameSpeed)
	{
		if (world != null)
		{
			entityDeltaTime = Utility.Math.Round(world.GetEntityDeltaTime(this), 10000f);
			entityDeltaTime = Math.Max(entityDeltaTime, 1E-05f);
			entityGameSpeed = world.GetEntityGameSpeed(this);
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId("设置实体游戏速度：" + $"{gameSpeed},entityDeltaTime：" + $"{entityDeltaTime}，entityGameSpeed：" + $"{entityGameSpeed} ", this);
		}
		if (_cacheComps != null)
		{
			for (int i = 0; i < _cacheComps.Length; i++)
			{
				if (_cacheComps[i] != null)
				{
					_cacheComps[i].OnGameSpeedChanged(gameSpeed);
				}
			}
		}
		BaseEntityView?.OnGameSpeedChanged(gameSpeed);
	}

	public override void OnDispose()
	{
		ClearEntityComponent();
		mId = 0;
		mEntityId = 0;
		tick = 0u;
		if (property != null)
		{
			property.Dispose();
			property = null;
		}
		parent = null;
		callbacks = null;
		entityData = null;
		entityObject = null;
		if (createData != null)
		{
			ReferencePool.Release(createData);
		}
	}

	public void RegisterEntityViewComponent(BaseEntityView entityView)
	{
		BaseEntityView = entityView;
	}

	private void InitEntityComponent()
	{
		Type[] array = GetEntityComps();
		_cacheComps = new BaseComponent[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			Type type = array[i];
			BaseComponent baseComponent = (BaseComponent)Activator.CreateInstance(type);
			baseComponent.Init(i, this);
			entityComps.Add(type, baseComponent);
			_cacheComps[i] = baseComponent;
		}
		_existCacheComps = true;
	}

	protected abstract Type[] GetEntityComps();

	public abstract Type GetEntityView();

	public virtual int RandomInt(int minValue, int maxValue)
	{
		return 0;
	}

	public virtual float RandomFloat(float minValue, float maxValue)
	{
		return 0f;
	}

	public bool InFreedomBattleMode()
	{
		return GetComponent<AutoFightCompment>()?.IsFreedomBattleMode ?? false;
	}

	public virtual GameObject GetEntityObject()
	{
		return entityObject;
	}

	public virtual CampType GetEntityCampType()
	{
		return CampType;
	}

	public virtual EntityType GetEntityType()
	{
		return EntityType.Unknown;
	}

	public void SwitchEntityViewLerp(bool viewIsNeedLerp, float stableMovementSharpness, float stableRotationSharpness)
	{
		ViewIsNeedLerp = viewIsNeedLerp;
		StableMovementSharpness = stableMovementSharpness;
		StableRotationSharpness = stableRotationSharpness;
	}

	public void SwitchEntityViewLerp(bool viewIsNeedLerp)
	{
		ViewIsNeedLerp = viewIsNeedLerp;
	}

	private void CheckFixedUpdate(WorldUpdateType type)
	{
		cacheTickUpdate = false;
		if (type == WorldUpdateType.All)
		{
			cacheTickUpdate = true;
		}
		else if ((!IsSyncEntity && type != WorldUpdateType.RollBack) || UpdateType == EntityUpdateType.Ignore)
		{
			cacheTickUpdate = true;
		}
		else if (IsSyncEntity && type == WorldUpdateType.RollBack && logicType == EntityLogicType.Display)
		{
			cacheTickUpdate = true;
		}
		else if (type != WorldUpdateType.Authority || Tick < world.Tick)
		{
			cacheTickUpdate = (uint)type == (uint)updateType;
		}
	}

	public void ExecuteCommand(MsgPlayerInput playerInput, WorldUpdateType type)
	{
		GetComponent<MoveComponent>()?.ExecuteCommand(playerInput.inputUV);
		GetComponent<SkillComponent>()?.ExecuteCommand(playerInput);
		GetComponent<AbnormalStateComponent>()?.ExecuteCommand(playerInput);
		GetComponent<NearDeathRescueComponent>()?.ExecuteCommand(playerInput);
		GetComponent<AutoFightCompment>()?.ExecuteCommand(playerInput, type);
	}

	public virtual string Name()
	{
		return string.Empty;
	}

	private void ClearEntityComponent()
	{
		int num = ((_cacheComps != null) ? _cacheComps.Length : 0);
		for (int i = 0; i < num; i++)
		{
			_cacheComps[i]?.OnDispose();
			_cacheComps[i] = null;
		}
		_cacheComps = null;
		_existCacheComps = false;
		entityComps.Clear();
	}

	public void DoEntityDead(bool isRelease = true, bool isNormalDead = true)
	{
		if (!IsSurvival)
		{
			if (isRelease)
			{
				world.GetSystem<EntitySystem>()?.DoEntityDestroy(this);
			}
			return;
		}
		ChangeEntityState(EntityState.MarkDead);
		int num = ((_cacheComps != null) ? _cacheComps.Length : 0);
		for (int i = 0; i < num; i++)
		{
			_cacheComps[i].OnEntityDead();
		}
		if (callbacks != null && callbacks.EntityDeadCallback != null)
		{
			callbacks.EntityDeadCallback(this, isNormalDead);
		}
		if (isRelease)
		{
			world.GetSystem<EntitySystem>()?.DoEntityDestroy(this);
		}
	}

	public void DoEntityRelease()
	{
		world.GetSystem<EntitySystem>()?.DoEntityDestroy(this);
	}

	public virtual void OnEntityRelease()
	{
		OnDeadRemoveBindEntity();
		ChangeEntityState(EntityState.Dead);
		SendEntityReleaseEvent();
		int num = ((_cacheComps != null) ? _cacheComps.Length : 0);
		for (int i = 0; i < num; i++)
		{
			_cacheComps[i]?.OnEntityRelease();
		}
		if (callbacks != null && callbacks.EntityDeadReleaseCallback != null)
		{
			callbacks.EntityDeadReleaseCallback(this, isNormal: true);
		}
	}

	protected virtual void OnDeadRemoveBindEntity()
	{
		List<EffectEntity> list = world.GetSystem<EffectSystem>()?.GetEffectBindList(Id);
		if (list.IsNullOrEmpty())
		{
			return;
		}
		foreach (EffectEntity item in list)
		{
			item.GetComponent<FollowParentEntityTransformComponent>()?.StopFollow();
		}
		list.Clear();
	}

	protected virtual void SendEntityReleaseEvent()
	{
		ObserverEntityReleaseParams observerEntityReleaseParams = ReferencePool.Acquire<ObserverEntityReleaseParams>();
		observerEntityReleaseParams.Init(this);
		this.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.EntityRelease, observerEntityReleaseParams);
		ReferencePool.Release(observerEntityReleaseParams);
	}

	public virtual void OnEntityReborn()
	{
		ChangeEntityState(EntityState.Reborn);
		int num = ((_cacheComps != null) ? _cacheComps.Length : 0);
		for (int i = 0; i < num; i++)
		{
			_cacheComps[i].OnEntityReborn();
		}
		ObserverEntityRebornParams observerEntityRebornParams = ReferencePool.Acquire<ObserverEntityRebornParams>();
		observerEntityRebornParams.Init(this);
		world.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.EntityReborn, observerEntityRebornParams);
		ReferencePool.Release(observerEntityRebornParams);
	}

	public void ChangeEntitySurvivalState()
	{
		ChangeEntityState(EntityState.Survival);
	}

	public void ChangeEntityState(EntityState state)
	{
		entityState = state;
	}

	public virtual void ChangeUpdateType(EntityUpdateType type)
	{
		updateType = type;
	}

	public T GetComponent<T>() where T : BaseComponent
	{
		Type typeFromHandle = typeof(T);
		if (entityComps.ContainsKey(typeFromHandle))
		{
			return (T)entityComps[typeFromHandle];
		}
		return null;
	}

	public T GetTypeOfComponent<T>() where T : BaseComponent
	{
		foreach (Type key in entityComps.Keys)
		{
			if (typeof(T).IsAssignableFrom(key))
			{
				return (T)entityComps[key];
			}
		}
		return null;
	}

	public WorldBase GetWorld()
	{
		return world;
	}

	public bool InLocalActorRoom()
	{
		IEntityRoom entityRoom = world.GetSystem<RoomSystem>()?.GetLocalActor();
		if (entityRoom != null)
		{
			return entityRoom.RoomId == roomId;
		}
		return true;
	}

	public void DoFrozen(float speed, int frozenType, bool isFrozenLogic = true)
	{
		if (!IsFrozen)
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"实体冻帧，冻帧速度是：{speed}", this);
			}
			isFrozen = true;
			frozenSpeed = speed;
			this.frozenType = frozenType;
			OnEntityFrozen(speed, isFrozen, isFrozenLogic);
		}
	}

	protected virtual void OnEntityFrozen(float speed, bool frozen, bool isFrozenLogic = true)
	{
		if (_cacheComps != null)
		{
			for (int i = 0; i < _cacheComps.Length; i++)
			{
				_cacheComps[i]?.OnEntityFrozen(frozen, isFrozenLogic);
			}
		}
		BaseEntityView?.OnEntityFrozen(frozen);
	}

	public void DoUnFrozen(float speed, bool isFrozenLogic = true)
	{
		if (IsFrozen)
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"实体解除冻帧，速度是：{speed}", this);
			}
			isFrozen = false;
			frozenSpeed = speed;
			frozenType = -1;
			OnEntityFrozen(speed, isFrozen, isFrozenLogic);
		}
	}

	public virtual void OnLevelFail()
	{
		int num = ((_cacheComps != null) ? _cacheComps.Length : 0);
		for (int i = 0; i < num; i++)
		{
			_cacheComps[i]?.OnLevelFail();
		}
	}

	public virtual bool IgnoreTimeScale()
	{
		return false;
	}

	public virtual bool HasProperty(string propertyKey)
	{
		if (property == null)
		{
			return false;
		}
		return property.HasProperty(propertyKey);
	}

	public virtual float GetProperty(string propertyKey, float defaults = 0f)
	{
		if (property == null)
		{
			return defaults;
		}
		return property.GetPropertyData(propertyKey)?.CurValue ?? defaults;
	}

	public virtual PropertyData GetPropertyData(string propertyKey)
	{
		if (property == null)
		{
			return null;
		}
		return property.GetPropertyData(propertyKey);
	}

	public virtual PropertyData GetPropertyDataOrCreate(string propertyKey)
	{
		if (property == null)
		{
			return null;
		}
		return property.GetPropertyDataOrCreate(propertyKey);
	}

	public virtual float GetPropertyCur(string propertyKey, float defaults = 0f)
	{
		if (property == null)
		{
			return defaults;
		}
		return property.GetPropertyData(propertyKey)?.ReadCurValue ?? defaults;
	}

	public virtual float GetPropertyBuff(string propertyKey, bool isClearEffect = true, float defaults = 0f)
	{
		if (property == null)
		{
			return defaults;
		}
		if (isClearEffect)
		{
			return property.GetPropertyData(propertyKey)?.BuffValue ?? defaults;
		}
		return property.GetPropertyData(propertyKey)?.ReadCurValue ?? defaults;
	}

	public virtual float GetPropertyMax(string propertyKey)
	{
		if (property == null)
		{
			return 0f;
		}
		return property.GetPropertyData(propertyKey)?.MaxValue ?? 0f;
	}

	public virtual float GetPropertyMin(string propertyKey)
	{
		if (property == null)
		{
			return 0f;
		}
		return property.GetPropertyData(propertyKey)?.MinValue ?? 0f;
	}

	public virtual float GetPropertyInit(string propertyKey)
	{
		if (property == null)
		{
			return 0f;
		}
		return property.GetPropertyData(propertyKey)?.InitValue ?? 0f;
	}

	public virtual float GetPropertyPercentage(string propertyKey, float defaultValue = 0f)
	{
		if (property == null)
		{
			return defaultValue;
		}
		PropertyData propertyData = property.GetPropertyData(propertyKey);
		if (propertyData == null)
		{
			return defaultValue;
		}
		return propertyData.CurValue / propertyData.MaxValue;
	}

	public virtual float ChangeProperty(string propertyKey, float value, bool isExecuteValueChanged = true, bool isIgnoreMin = false)
	{
		if (property == null)
		{
			return 0f;
		}
		return property.AdditionProperty(propertyKey, value, isIgnoreMax: false, isExecuteValueChanged, isIgnoreMin);
	}

	public virtual float ChangePropertyBuff(string propertyKey, float value, bool isExecuteValueChanged = true)
	{
		if (property == null)
		{
			return 0f;
		}
		return property.AdditionPropertyBuff(propertyKey, value, isIgnoreMax: false, isExecuteValueChanged);
	}

	public virtual void SetProperty(string propertyKey, float value, bool isIgnoreMax = false, bool isExecuteValueChanged = true)
	{
		if (property != null)
		{
			property.Set(propertyKey, value, isIgnoreMax, isExecuteValueChanged);
		}
	}

	public virtual void SetPropertyBuff(string propertyKey, float value, bool isIgnoreMax = false, bool isClearEffect = true, bool isExcuteValueChanged = true)
	{
		if (property != null)
		{
			if (isClearEffect)
			{
				property.SetBuff(propertyKey, value, isIgnoreMax, isExcuteValueChanged);
			}
			else
			{
				property.Set(propertyKey, value, isIgnoreMax, isExcuteValueChanged);
			}
			ObserverActorAddEnergy(propertyKey, value);
		}
	}

	private void ObserverActorAddEnergy(string propertyKey, float value)
	{
		if (propertyKey == "Energy" && value > 0f && IsActorEntity)
		{
			ObserverActorAddEenergyParams observerActorAddEenergyParams = ReferencePool.Acquire<ObserverActorAddEenergyParams>();
			observerActorAddEenergyParams.Init(this);
			this.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.ActorAddEnergy, observerActorAddEenergyParams);
			ReferencePool.Release(observerActorAddEenergyParams);
		}
	}

	public virtual void SetPropertyMax(string propertyKey, float value, bool isExecuteValueChanged = true)
	{
		if (property != null)
		{
			property.ResetMax(propertyKey, value, isExecuteValueChanged);
		}
	}

	public virtual void ResetMax2Original(string propertyKey)
	{
		if (property != null)
		{
			property.ResetMax2Original(propertyKey);
		}
	}

	public virtual void SetPropertyInit(string propertyKey, float value)
	{
		if (property != null)
		{
			property.SetInit(propertyKey, value);
		}
	}

	public virtual void SetProperty(PropertyAdditionData addition)
	{
		if (addition != null && !string.IsNullOrEmpty(addition.propertyKey) && property != null)
		{
			property.Set(addition);
		}
	}

	public virtual void ResetProperty(string propertyKey, bool toMax = false, bool isExecuteValueChanged = true)
	{
		property?.ResetProperty(propertyKey, toMax, isExecuteValueChanged);
	}

	public virtual void RebornResetAllProperty()
	{
		if (property != null)
		{
			property.RebornResetAll();
		}
	}

	public void SetPropertyRefreshState(string propertyKey, bool isRefresh)
	{
		Property.TryGetValue(propertyKey, out var value);
		value?.SetPropertyRefreshState(isRefresh);
	}

	public virtual void RebornResetProperty()
	{
		if (property != null)
		{
			property.GetPropertyData("Hp").ResetValue(toMax: true);
			property.GetPropertyData("Energy").ResetValue(toMax: true);
			property.GetPropertyData("NearDeathSchedule").ResetValue(toMax: true);
		}
	}

	public virtual WeaponMechanismBase GetWeaponMechanism()
	{
		return null;
	}

	protected virtual void InitEntitySkinConfig()
	{
	}

	protected void InitSkinAssociation(int skinConfigId)
	{
		drSkinAssociation = GameEntry.DataTable.GetDataRow<DRSkinAssociation>(skinConfigId);
		if (drSkinAssociation == null)
		{
			return;
		}
		if (drSkinAssociation.EffectConfigId.Count == drSkinAssociation.SkinAssociationEffectConfigId.Count)
		{
			skinEffect = new Dictionary<int, int>();
			for (int i = 0; i < drSkinAssociation.EffectConfigId.Count; i++)
			{
				skinEffect.Add(drSkinAssociation.EffectConfigId[i], drSkinAssociation.SkinAssociationEffectConfigId[i]);
			}
		}
		else
		{
			Log.Error("特效配置错误 ：原始和替换 数量不一致...");
		}
		if (drSkinAssociation.SoundConfigId.Count == drSkinAssociation.SkinAssociationSoundConfigId.Count)
		{
			skinSound = new Dictionary<int, int>();
			for (int j = 0; j < drSkinAssociation.SoundConfigId.Count; j++)
			{
				skinSound.Add(drSkinAssociation.SoundConfigId[j], drSkinAssociation.SkinAssociationSoundConfigId[j]);
			}
		}
		else
		{
			Log.Error("音效配置错误 ：原始和替换 数量不一致...");
		}
		if (drSkinAssociation.MaterialPath.Count == drSkinAssociation.SkinAssociationMaterialPath.Count)
		{
			skinMaterial = new Dictionary<int, int>();
			for (int k = 0; k < drSkinAssociation.MaterialPath.Count; k++)
			{
				skinMaterial.Add(drSkinAssociation.MaterialPath[k], drSkinAssociation.SkinAssociationMaterialPath[k]);
			}
		}
		else
		{
			Log.Error("材质配置错误 ：原始和替换 数量不一致...");
		}
	}

	public virtual DREffect GetEffectSkinIdByParentSkinConfig(int originalEffectConfigId)
	{
		if (skinEffect != null && skinEffect.TryGetValue(originalEffectConfigId, out var value))
		{
			return GameEntry.DataTable.GetDataRow<DREffect>(value);
		}
		return GameEntry.DataTable.GetDataRow<DREffect>(originalEffectConfigId);
	}

	public virtual int GetEffectIdByParentSkinConfig(int originalEffectConfigId)
	{
		if (skinEffect != null && skinEffect.TryGetValue(originalEffectConfigId, out var value))
		{
			return value;
		}
		return originalEffectConfigId;
	}

	public virtual DRAudio GetSoundIdByParentSkinConfig(int soundId)
	{
		if (skinSound != null && skinSound.TryGetValue(soundId, out var value))
		{
			return GameEntry.DataTable.GetDataRow<DRAudio>(value);
		}
		return GameEntry.DataTable.GetDataRow<DRAudio>(soundId);
	}

	public virtual string GetMaterialByParentSkinConfig(DRMaterial material)
	{
		string arg = ((skinMaterial == null || !skinMaterial.TryGetValue(material.Id, out var value)) ? material.MaterialPath : GameEntry.DataTable.GetDataRow<DRMaterial>(value).MaterialPath);
		return Utility.Text.Format("Assets/Art/Battle/{0}.mat", arg);
	}

	public virtual int GetSummonedSkinConfigByParentSkin(int summonedConfigId)
	{
		if (drHeroSkin == null)
		{
			return 0;
		}
		if (drHeroSkin.SummonedConfigID.Count != drHeroSkin.SummonedSkinID.Count)
		{
			Log.Error("角色皮肤配置错误：原始和替换 数量不一致");
			return 0;
		}
		for (int i = 0; i < drHeroSkin.SummonedConfigID.Count; i++)
		{
			if (drHeroSkin.SummonedConfigID[i] == summonedConfigId)
			{
				return drHeroSkin.SummonedSkinID[i];
			}
		}
		return 0;
	}

	public string GetSummonedSkinPathByParentSkinConfig(int id)
	{
		if (drHeroSkin == null)
		{
			return "";
		}
		if (drHeroSkin.SummonedConfigID.Count != drHeroSkin.SummonedSkinID.Count)
		{
			Log.Error("角色皮肤配置错误：原始和替换 数量不一致");
			return "";
		}
		for (int i = 0; i < drHeroSkin.SummonedConfigID.Count; i++)
		{
			if (drHeroSkin.SummonedConfigID[i] == id)
			{
				return drHeroSkin.SummonedSkinPath[i];
			}
		}
		return "";
	}

	public virtual string GetCastingPath(string casting, bool isStreamer = false)
	{
		if (drSkinAssociation != null)
		{
			if (isStreamer && drSkinAssociation.CastingPath.Count == drSkinAssociation.SkinStreamerCastingPath.Count)
			{
				for (int i = 0; i < drSkinAssociation.CastingPath.Count; i++)
				{
					if (drSkinAssociation.CastingPath[i] == casting)
					{
						return drSkinAssociation.SkinStreamerCastingPath[i];
					}
				}
			}
			if (drSkinAssociation.CastingPath.Count == drSkinAssociation.SkinAssociationCastingPath.Count)
			{
				for (int j = 0; j < drSkinAssociation.CastingPath.Count; j++)
				{
					if (drSkinAssociation.CastingPath[j] == casting)
					{
						return drSkinAssociation.SkinAssociationCastingPath[j];
					}
				}
			}
		}
		return casting;
	}

	private void TakeSnapShot()
	{
		if (this is MonsterEntity)
		{
			return;
		}
		PooledWriter writer = WriterPool.GetWriter();
		writer.WriteUInt32(tick);
		if (IsSurvival)
		{
			for (int i = 0; i < _cacheComps?.Length; i++)
			{
				_cacheComps[i].TakeSnapShot(writer);
			}
		}
		cacheSnapShots.Add(tick, writer);
	}

	public PooledWriter GetSnapShot(uint snapShotTick)
	{
		cacheSnapShots.TryGetValue(snapShotTick, out var value);
		return value;
	}

	public void RemoveSnapShot(uint uTick)
	{
		if (cacheSnapShots.ContainsKey(uTick))
		{
			cacheSnapShots[uTick].Dispose();
			cacheSnapShots.Remove(uTick);
		}
	}

	public void ClearSnapShotCache()
	{
		List<uint> list = CollectionPool<List<uint>, uint>.Get();
		foreach (uint key in cacheSnapShots.Keys)
		{
			list.Add(key);
		}
		for (int i = 0; i < list.Count; i++)
		{
			RemoveSnapShot(list[i]);
		}
		CollectionPool<List<uint>, uint>.Release(list);
	}

	public void RollBackTo(ref RollBackData rollBackData, PooledReader localReader, PooledReader reader)
	{
		rollBackData.AddRollBackInfo(string.Empty);
		rollBackData.AddRollBackInfo($"实体 - [{Id} , {EntityId}] 回滚检查.");
		localReader.ReadUInt32();
		uint num = reader.ReadUInt32();
		for (uint num2 = num; num2 <= tick; num2++)
		{
			RemoveSnapShot(num2);
		}
		tick = num;
		if (IsSurvival)
		{
			int num3 = ((_cacheComps != null) ? _cacheComps.Length : 0);
			for (int i = 0; i < num3; i++)
			{
				_cacheComps[i].RollBackTo(ref rollBackData, localReader, reader);
			}
		}
	}

	public void ChangeEntityStandby()
	{
		if (IsSurvival)
		{
			ChangeEntityState(EntityState.Standby);
			OnEntityStandby();
		}
	}

	public void ReactivateEntity()
	{
		if (entityState == EntityState.Standby)
		{
			ChangeEntityState(EntityState.Survival);
			OnReactivateEntity();
		}
	}

	public virtual void OnNearDeadStateUnderAttack(BaseEntity attackEntity)
	{
	}

	protected virtual void OnEntityStandby()
	{
	}

	protected virtual void OnReactivateEntity()
	{
	}
}
