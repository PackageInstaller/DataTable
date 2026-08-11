#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Text;
using Ase.ECS;
using Cinemachine;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public abstract class WorldBase
{
	private uint _id;

	private string _sceneLoadPath;

	private PhysicsScene _physicsScene;

	private readonly IMessenger worldMessenger;

	protected GameObject worldRoot;

	private GameObject paradoxRoot;

	private GameObject entityRoot;

	private GameObject virCameraRoot;

	private GameObject skillIndicatorRoot;

	private GameObject navMeshRoot;

	private GameObject mechanismRoot;

	private GameObject thredLog;

	private readonly float _initIntervalTimer;

	private float _intervalTimer;

	private bool _isStart;

	private bool _isPause;

	private bool _isForcePause;

	public int _updateSpeed;

	private bool _isTrackTick;

	private float _worldSpeed;

	protected uint tick;

	public int RealServerTick;

	private bool _worldForbidPlayEffect;

	private bool _settingForbidPlayEffect;

	protected int LocalActorId;

	protected LRandom LRandom;

	public int GameMs;

	private BaseSystem[] _worldSystems;

	private Dictionary<Type, BaseSystem> _cacheWorldSystems;

	protected bool IsBattleSettlement;

	public BattleVerificationSettleInfo GameBackResult;

	public WorldEntity WorldEntity;

	private ISubscription<AccounetNotifyMessager> accounetDisconnectSubscription;

	private int gameSpeedInfoIndex;

	private List<GameSpeedInfo> allGameSpeedInfos;

	private List<GameSpeedInfo> waitAddGameSpeedInfos;

	private List<int> waitRemoveGameSpeedInfos;

	private GameSpeedInfo currentGameSpeedInfo;

	private int? lastGameSpeedInfoIndex;

	private StringBuilder ignoreEntityStrBuilder;

	private bool playSnop;

	private BattleConfig _battleConfig;

	private GoldBodySettings _goldBodySettings;

	private CameraShakeNoiseData _noiseSettings;

	private NoiseSettings _monsterNoiseSettings;

	private CharacterClimbSetting characterClimbSetting;

	private CameraConfig _cameraData;

	private CharacterConfig _characterConfig;

	public abstract bool IsNeedExecuteViewSystem { get; }

	public Transform ParadoxRoot => paradoxRoot.transform;

	public Transform EntityRoot => entityRoot.transform;

	public Transform WorldRoot => worldRoot.transform;

	public Transform VirCameraRoot => virCameraRoot.transform;

	public Transform SkillIndicatorRoot => skillIndicatorRoot.transform;

	public Transform NavMeshRoot => navMeshRoot.transform;

	public Transform MechanismRoot => mechanismRoot.transform;

	public float IntervalTimer => _intervalTimer;

	public float WorldSpeed => _worldSpeed;

	public bool WorldForbidPlayEffect
	{
		get
		{
			if (!_worldForbidPlayEffect)
			{
				return _settingForbidPlayEffect;
			}
			return true;
		}
	}

	public abstract int ActorId { get; }

	public string SceneLoadPath => _sceneLoadPath;

	public uint Id => _id;

	public abstract BattleWorldMode BattleWorldMode { get; }

	public abstract bool TestingWorld { get; }

	public uint Tick => tick;

	public uint LocalTick => tick;

	public bool IsRunning
	{
		get
		{
			if (_isStart)
			{
				return !_isForcePause;
			}
			return false;
		}
	}

	public bool IsSoftPaused => _isPause;

	public virtual bool IsStoryWorld => false;

	public virtual bool IsGuideWorld => false;

	public bool BattleSettlement => IsBattleSettlement;

	public BattleConfig BattleConfig => _battleConfig;

	public GoldBodySettings GoldBodySettings => _goldBodySettings;

	public CameraShakeNoiseData NoiseSettings => _noiseSettings;

	public NoiseSettings MonsterNoiseSettings => _monsterNoiseSettings;

	public CharacterClimbSetting CharacterClimbSetting => characterClimbSetting;

	public CameraConfig CameraConfig => _cameraData;

	public CharacterConfig CharacterConfig => _characterConfig;

	public PhysicsScene GetPhysicsScene()
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return _physicsScene;
	}

	public IMessenger GetWorldMessenger()
	{
		return worldMessenger;
	}

	public WorldBase(string worldName, GameObject worldRoot, WorldData worldData)
	{
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		_updateSpeed = 1;
		GameMs = 10;
		_cacheWorldSystems = new Dictionary<Type, BaseSystem>();
		allGameSpeedInfos = new List<GameSpeedInfo>(5);
		waitAddGameSpeedInfos = new List<GameSpeedInfo>(5);
		waitRemoveGameSpeedInfos = new List<int>(5);
		ignoreEntityStrBuilder = new StringBuilder(10);
		base._002Ector();
		Input.multiTouchEnabled = true;
		IsBattleSettlement = false;
		_worldSpeed = 1f;
		_sceneLoadPath = worldData.SceneLoadPath;
		this.worldRoot = worldRoot;
		_physicsScene = PhysicsSceneExtensions.GetPhysicsScene(worldRoot.scene);
		worldMessenger = new BattleMessenger();
		_id = worldData.WorldId;
		paradoxRoot = new GameObject("ParadoxRoot");
		paradoxRoot.transform.SetParent(worldRoot.transform);
		entityRoot = new GameObject("EntityRoot");
		entityRoot.transform.SetParent(worldRoot.transform);
		virCameraRoot = new GameObject("VirtualCameraRoot");
		virCameraRoot.transform.SetParent(worldRoot.transform);
		skillIndicatorRoot = new GameObject("SkillIndicatorRoot");
		skillIndicatorRoot.transform.SetParent(worldRoot.transform);
		navMeshRoot = new GameObject("NavMeshRoot");
		navMeshRoot.transform.SetParent(worldRoot.transform);
		mechanismRoot = new GameObject("MechanismRoot");
		mechanismRoot.transform.SetParent(worldRoot.transform);
		_intervalTimer = 0.033f;
		_initIntervalTimer = _intervalTimer;
		_isStart = false;
		_isForcePause = false;
		_isPause = false;
		tick = 0u;
		InitPlayEffectPermissions();
		InitSystems();
		accounetDisconnectSubscription = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<AccounetNotifyMessager>(OnAccounetNotify);
	}

	private void InitSystems()
	{
		int sysIndex = 0;
		Type[] systemTypes = GetSystemTypes();
		_worldSystems = new BaseSystem[systemTypes.Length];
		Type[] array = systemTypes;
		foreach (Type type in array)
		{
			BaseSystem baseSystem = (BaseSystem)Activator.CreateInstance(type);
			bool systemIsNeedExecute = baseSystem.LogicSystem || IsNeedExecuteViewSystem;
			baseSystem.Init(systemIsNeedExecute, sysIndex, this);
			_worldSystems[sysIndex++] = baseSystem;
			_cacheWorldSystems.Add(type, baseSystem);
		}
	}

	public async UniTask<bool> OnEnter(object data = null)
	{
		bool result = true;
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if ((IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem) && !(await _worldSystems[i].OnEnter(data)))
			{
				result = false;
				break;
			}
		}
		return result;
	}

	public async UniTask<bool> OnGamePreparationEnd(object data = null)
	{
		bool result = true;
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if ((IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem) && !(await _worldSystems[i].OnGamePreparationEnd(data)))
			{
				result = false;
				break;
			}
		}
		return result;
	}

	public virtual async UniTask GameStartBefore()
	{
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if (IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem)
			{
				await _worldSystems[i].OnStartBefore();
			}
		}
	}

	public void WorldAwake()
	{
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if (IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem)
			{
				_worldSystems[i].OnAwake();
			}
		}
	}

	public abstract UniTask<bool> GamePreparation(WorldData worldData);

	public virtual void GameStart()
	{
		_isStart = true;
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if (IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem)
			{
				_worldSystems[i].OnStart();
			}
		}
	}

	public virtual void GamePause(bool transition = false)
	{
		if (!_isPause)
		{
			if (transition)
			{
				GamePauseBefore();
				OnGamePause();
			}
			else
			{
				_isForcePause = true;
				OnGamePause();
			}
		}
	}

	public void GameResume()
	{
		if (_isPause)
		{
			GameResumeBefore();
			OnGameResume();
			_isForcePause = false;
		}
	}

	public void GameOver()
	{
		if (_isStart)
		{
			_isStart = false;
		}
	}

	public virtual void Update(float deltaTime)
	{
		if (IsRunning)
		{
			Loop(deltaTime);
		}
	}

	public virtual void FixedUpdate(float deltaTime)
	{
		if (!IsRunning)
		{
			return;
		}
		try
		{
			FixedLoop(_intervalTimer);
		}
		catch (Exception arg)
		{
			Log.Error($"世界更新错误. e : {arg}");
			_isPause = true;
		}
	}

	public void LateUpdate(float deltaTime)
	{
		LateUpdateLoop(deltaTime);
	}

	private void Loop(float deltaTime)
	{
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if ((IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem) && _worldSystems[i].IsRunning)
			{
				_worldSystems[i].OnUpdate(deltaTime);
			}
		}
	}

	private void LateUpdateLoop(float deltaTime)
	{
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if ((IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem) && _worldSystems[i].IsRunning)
			{
				_worldSystems[i].OnLateUpdate(deltaTime);
			}
		}
	}

	protected virtual void FixedLoop(float deltaTime)
	{
	}

	protected void ExecuteOptionHeroCommand(MsgPlayerInput playerInput)
	{
		GetSystem<EntitySystem>().ExecuteLocal(LocalActorId, playerInput);
	}

	protected void ExecuteAISkillCommand()
	{
		GetSystem<CommandSystem>().ExecuteAiSkill();
	}

	protected MsgPlayerInput GetFramePlayerInput(float deltaTime)
	{
		CommandSystem system = GetSystem<CommandSystem>();
		if (system == null)
		{
			return null;
		}
		MsgPlayerInput playerInput = system.PlayerInput;
		return system.SetMsgPlayerAutoFight(playerInput, deltaTime);
	}

	protected void FixedLoop(WorldUpdateType updateType, float deltaTime)
	{
		DoSystemFixedUpdateBefore(updateType);
		DoSystemFixedUpdate(updateType, deltaTime);
		DoSystemFixedUpdateAfter(updateType);
	}

	private void DoSystemFixedUpdateBefore(WorldUpdateType updateType)
	{
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if ((IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem) && _worldSystems[i].IsRunning)
			{
				_worldSystems[i].OnFixedUpdateBefore(updateType);
			}
		}
	}

	private void DoSystemFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if ((IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem) && _worldSystems[i].IsRunning)
			{
				_worldSystems[i].OnFixedUpdate(updateType, deltaTime);
			}
		}
	}

	private void DoSystemFixedUpdateAfter(WorldUpdateType updateType)
	{
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if ((IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem) && _worldSystems[i].IsRunning)
			{
				_worldSystems[i].OnFixedUpdateAfter(updateType);
			}
		}
	}

	protected abstract Type[] GetSystemTypes();

	public T GetSystem<T>() where T : BaseSystem
	{
		Type typeFromHandle = typeof(T);
		if (!_cacheWorldSystems.TryGetValue(typeFromHandle, out var value) || value == null)
		{
			return null;
		}
		return (T)value;
	}

	public virtual void Shutdown()
	{
		if (WorldEntity != null)
		{
			WorldEntity.DoEntityRelease();
		}
		GameOver();
		if (accounetDisconnectSubscription != null)
		{
			accounetDisconnectSubscription.Dispose();
			accounetDisconnectSubscription = null;
		}
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			_worldSystems[i].OnDispose();
		}
		if (thredLog != null)
		{
			UnityEngine.Object.DestroyImmediate(thredLog);
			thredLog = null;
		}
		if (paradoxRoot != null)
		{
			UnityEngine.Object.DestroyImmediate(paradoxRoot);
			paradoxRoot = null;
		}
		if (entityRoot != null)
		{
			UnityEngine.Object.DestroyImmediate(entityRoot);
			entityRoot = null;
		}
		if (virCameraRoot != null)
		{
			UnityEngine.Object.DestroyImmediate(virCameraRoot);
			virCameraRoot = null;
		}
		if (worldRoot != null)
		{
			UnityEngine.Object.DestroyImmediate(worldRoot);
			worldRoot = null;
		}
		Input.multiTouchEnabled = false;
		_isForcePause = true;
		GetSystem<GameResourceSystem>().UnloadAsset(AssetUtility.GetBattleViewConfigAsset("GoldBodySetting.asset"));
		GetSystem<GameResourceSystem>().UnloadAsset(AssetUtility.GetBattleViewConfigAsset("CameraShakeNoiseData.asset"));
		GetSystem<GameResourceSystem>().UnloadAsset(AssetUtility.GetBattleViewConfigAsset("MonsterNoiseSetting.asset"));
		GetSystem<GameResourceSystem>().UnloadAsset(AssetUtility.GetBattleViewConfigAsset("CharacterClimbSetting.asset"));
		GetSystem<GameResourceSystem>().UnloadAsset(AssetUtility.GetBattleViewConfigAsset("CharacterConfig.asset"));
		GetSystem<GameResourceSystem>().UnloadAsset(AssetUtility.GetBattleViewConfigAsset("CameraConfig.asset"));
		_cameraData = null;
		_battleConfig = null;
		_goldBodySettings = null;
		_noiseSettings = null;
		_monsterNoiseSettings = null;
	}

	public virtual void GameSettlement(GameSettlementType gameSettlementType)
	{
		if (gameSettlementType == GameSettlementType.MonsterDead || gameSettlementType == GameSettlementType.GoldLevelOver)
		{
			GameAchievementSettlement(isSuccess: true);
		}
		else
		{
			GameAchievementSettlement(isSuccess: false);
		}
		SaveBattleProgressLog();
	}

	private void SaveBattleProgressLog()
	{
		BattleSystem system = GetSystem<BattleSystem>();
		if (system != null)
		{
			List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
			if (teamHero != null)
			{
				StringBuilder stringBuilder = new StringBuilder().AppendLine();
				stringBuilder.AppendLine("----------所有Hero实体的战斗统计数据----------");
				stringBuilder.AppendLine();
				foreach (HeroEntity item in teamHero)
				{
					EntityStatInfo entityStatInfo = system.GetEntityStatInfo(item.Id);
					if (entityStatInfo != null)
					{
						stringBuilder.AppendLine($"实体ID [{item.Id}]\t伤害 [{entityStatInfo.Damage}]\t削韧 [{entityStatInfo.Tenacity}]\t治疗 [{entityStatInfo.CurativeDose}]");
					}
				}
				stringBuilder.AppendLine();
				stringBuilder.AppendLine("---------------------------------------------");
				stringBuilder.AppendLine();
				stringBuilder.Clear();
			}
		}
		BattleProgressLog.SyncSave();
		BattleProgressPropertyMonitor.Clear();
	}

	protected virtual void GameAchievementSettlement(bool isSuccess)
	{
	}

	public void SetActorId(HeroEntity heroEntity)
	{
		LocalActorId = heroEntity.Id;
		GetSystem<CommandSystem>().BindTargetEntity(heroEntity);
		GetSystem<CameraSystem>().BindTargetEntity(heroEntity);
		GetSystem<InputSystem>().BindTargetEntity(heroEntity);
	}

	protected void ExecuteSpeedControl(uint sendTick)
	{
		if (tick == 1)
		{
			return;
		}
		int num = (int)(sendTick - RealServerTick);
		if (num >= 3)
		{
			_updateSpeed = 1;
			Singleton<AudioSystem>.Instance.StopGlobalSnapshot(8999900, (STOP_MODE)0);
			_worldForbidPlayEffect = false;
			int cacheVeritySuccessPacketNumber = GetSystem<ServerCommandSystem>().CacheVeritySuccessPacketNumber;
			if (cacheVeritySuccessPacketNumber < 2)
			{
				_updateSpeed = 1;
				Singleton<AudioSystem>.Instance.StopGlobalSnapshot(8999900, (STOP_MODE)0);
				_worldForbidPlayEffect = false;
			}
			else
			{
				_updateSpeed = cacheVeritySuccessPacketNumber;
				_worldForbidPlayEffect = false;
			}
		}
		else if (num < 3 && num >= -1)
		{
			_updateSpeed = 4;
			_worldForbidPlayEffect = false;
		}
		else if (num < -1 && num >= -4)
		{
			_updateSpeed = 4;
			_worldForbidPlayEffect = false;
		}
		else if (num < -4 && num >= -8)
		{
			_updateSpeed = 8;
			_worldForbidPlayEffect = false;
		}
		else if (num < -8 && num >= -16)
		{
			_updateSpeed = 16;
			_worldForbidPlayEffect = true;
		}
		else
		{
			_updateSpeed = 16;
			_worldForbidPlayEffect = true;
			Singleton<AudioSystem>.Instance.PlayGlobalSnapshot(8999900);
		}
	}

	private void InitPlayEffectPermissions()
	{
		int intRawValue = GameSettingExtension.GetIntRawValue("播放特效权限");
		switch (intRawValue)
		{
		case 0:
			_settingForbidPlayEffect = false;
			break;
		case 1:
			_settingForbidPlayEffect = true;
			break;
		default:
			_settingForbidPlayEffect = false;
			Log.Error($"初始化播放特效权限错误： 未知设置值：{intRawValue}");
			break;
		}
	}

	protected void NormalSpeedControl()
	{
		int cacheVeritySuccessPacketNumber = GetSystem<ServerCommandSystem>().CacheVeritySuccessPacketNumber;
		if (cacheVeritySuccessPacketNumber < 8)
		{
			if (cacheVeritySuccessPacketNumber > 1)
			{
				if (cacheVeritySuccessPacketNumber < 4)
				{
					_updateSpeed = cacheVeritySuccessPacketNumber;
					_worldForbidPlayEffect = false;
				}
				else
				{
					_updateSpeed = cacheVeritySuccessPacketNumber - 1;
					_worldForbidPlayEffect = false;
				}
			}
			else
			{
				_updateSpeed = 1;
				Singleton<AudioSystem>.Instance.StopGlobalSnapshot(8999900, (STOP_MODE)0);
				_worldForbidPlayEffect = false;
			}
		}
		else if (cacheVeritySuccessPacketNumber < 16)
		{
			_updateSpeed = cacheVeritySuccessPacketNumber - 1;
			_worldForbidPlayEffect = false;
		}
		else
		{
			_updateSpeed = 32;
			_worldForbidPlayEffect = true;
			Singleton<AudioSystem>.Instance.PlayGlobalSnapshot(8999900);
		}
	}

	private void GamePauseBefore()
	{
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if (IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem)
			{
				_worldSystems[i].OnPauseBefore();
			}
		}
	}

	private void GameResumeBefore()
	{
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if (IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem)
			{
				_worldSystems[i].OnResumeBefore();
			}
		}
	}

	private void OnGamePause()
	{
		_isPause = true;
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if (IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem)
			{
				_worldSystems[i].OnPause();
			}
		}
	}

	protected virtual void OnGameResume()
	{
		_isPause = false;
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			if (IsNeedExecuteViewSystem || _worldSystems[i].LogicSystem)
			{
				_worldSystems[i].OnResume();
			}
		}
	}

	public virtual void OnHeroCantRevived(int entityId)
	{
	}

	protected virtual void CheckCameraChange()
	{
	}

	public string GetSkinAssetPath(PeripheryHeroData heroModel, DRHero drHero)
	{
		if (heroModel.IsSkin)
		{
			DRHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRHeroSkin>(heroModel.SkinConfigId);
			if (dataRow == null)
			{
				Log.Error($"没有找到ID : {heroModel.SkinConfigId} 对应的皮肤配置..");
				return "";
			}
			return dataRow.AssetPath;
		}
		if (drHero == null)
		{
			return "";
		}
		return drHero.AssetPath;
	}

	public float RandomFloat(float minValue, float maxValue)
	{
		return LRandom.Range(minValue, maxValue);
	}

	public int RandomInt(int minValue, int maxValue)
	{
		return LRandom.Range(minValue, maxValue);
	}

	public virtual void RecodeCommand(int entityID, string paradoxParamKey, int paradoxParamValue)
	{
	}

	public virtual void RecodeMaxDamage(int entityID, float damage)
	{
	}

	public virtual void CreateWorldEntity()
	{
	}

	public virtual void LoadOtherWorld(LoadingToOtherLevelViewModel loadingToOtherLevelViewModel)
	{
	}

	public abstract CreateCopyData GetMapData();

	public virtual void MonsterAttrHandle(BaseEntity baseEntity, DRMonsterAttr drMonsterAttr, ref AttrAssignmentData data)
	{
		data.Hp = drMonsterAttr.Hp;
		data.Attack = drMonsterAttr.Attack;
		data.MaxTenacity = drMonsterAttr.MaxTenacity;
		data.BaseTough = drMonsterAttr.BaseTough;
		data.AtkLightLevel = drMonsterAttr.AtkLightLevel;
		data.HpLightLevel = drMonsterAttr.HpLightLevel;
	}

	private void OnAccounetNotify(AccounetNotifyMessager msg)
	{
		if (!msg.IsLogin)
		{
			OnAccountDisconnect(msg.DisconnectReason);
		}
	}

	protected abstract void OnAccountDisconnect(int disconnectReason);

	private void SetGameSpeed(float gameSpeed)
	{
		_intervalTimer = _initIntervalTimer * gameSpeed;
		float worldSpeed = _worldSpeed;
		_worldSpeed = gameSpeed;
		for (int i = 0; i < _worldSystems.Length; i++)
		{
			_worldSystems[i].OnGameSpeedChanged(worldSpeed, _worldSpeed);
		}
		if (InGameSpeed())
		{
			if (playSnop)
			{
				Singleton<AudioSystem>.Instance?.StopGlobalSnapshot(990005, (STOP_MODE)0);
				playSnop = false;
			}
			Singleton<AudioSystem>.Instance?.PlayGlobalSnapshot(990005);
			playSnop = true;
		}
		else if (playSnop)
		{
			Singleton<AudioSystem>.Instance?.StopGlobalSnapshot(990005, (STOP_MODE)0);
			playSnop = false;
		}
	}

	public int AddGameSpeedInfo(int priority, float gameSpeed, int Duration, bool isEffectWeakness, List<int> ignoreEntitys, BaseEntity entity)
	{
		GameSpeedInfo gameSpeedInfo = new GameSpeedInfo();
		gameSpeedInfo.GameSpeed = gameSpeed;
		gameSpeedInfo.Priority = priority;
		gameSpeedInfo.IgnoreEntitys = ignoreEntitys;
		gameSpeedInfo.TimeCount = (float)Duration * 0.033f;
		gameSpeedInfo.IsEffectWeakness = isEffectWeakness;
		gameSpeedInfo.Entity = entity;
		gameSpeedInfoIndex++;
		gameSpeedInfo.InfoIndex = gameSpeedInfoIndex;
		waitAddGameSpeedInfos.Add(gameSpeedInfo);
		if (ignoreEntitys != null)
		{
			ignoreEntityStrBuilder.Clear();
			ignoreEntityStrBuilder.Append(string.Join(",", ignoreEntitys));
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"添加游戏速度信息，游戏速度是：{gameSpeed}，序号是：{gameSpeedInfoIndex}，优先级是：{gameSpeedInfo.Priority}，忽略实体：{ignoreEntityStrBuilder.ToString()}", entity);
		}
		return gameSpeedInfoIndex;
	}

	public void RemoveGameSpeedInfo(int gameSpeedInfoIndex)
	{
		waitRemoveGameSpeedInfos.Add(gameSpeedInfoIndex);
	}

	private void RemoveGameSpeedInfo(ref bool find)
	{
		if (waitRemoveGameSpeedInfos.Count > 0)
		{
			for (int num = allGameSpeedInfos.Count - 1; num >= 0; num--)
			{
				if (waitRemoveGameSpeedInfos.Contains(allGameSpeedInfos[num].InfoIndex))
				{
					if (allGameSpeedInfos[num] == currentGameSpeedInfo)
					{
						if (LockstepData.Instance != null)
						{
							LockstepData.Instance.WriteAuthorityEntityId($"移除游戏速度，序号是：{currentGameSpeedInfo.InfoIndex}，当前改变游戏速度为空", currentGameSpeedInfo.Entity);
						}
						currentGameSpeedInfo = null;
						find = true;
					}
					allGameSpeedInfos.RemoveAt(num);
				}
			}
		}
		if (waitRemoveGameSpeedInfos.Count > 0)
		{
			for (int num2 = waitAddGameSpeedInfos.Count - 1; num2 >= 0; num2--)
			{
				if (waitRemoveGameSpeedInfos.Contains(waitAddGameSpeedInfos[num2].InfoIndex))
				{
					if (LockstepData.Instance != null)
					{
						LockstepData.Instance.WriteAuthorityEntityId($"等待添加被移除，序号是：{waitAddGameSpeedInfos[num2].InfoIndex}", waitAddGameSpeedInfos[num2].Entity);
					}
					waitAddGameSpeedInfos.RemoveAt(num2);
				}
			}
		}
		waitRemoveGameSpeedInfos.Clear();
	}

	private void AddGameSpeedInfo(ref bool find)
	{
		if (waitAddGameSpeedInfos.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < waitAddGameSpeedInfos.Count; i++)
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"添加游戏速度，序号是：{waitAddGameSpeedInfos[i].InfoIndex}", waitAddGameSpeedInfos[i].Entity);
			}
		}
		allGameSpeedInfos.AddRange(waitAddGameSpeedInfos);
		waitAddGameSpeedInfos.Clear();
		currentGameSpeedInfo = null;
		find = true;
	}

	protected void GetCurrentGameSpeedInfo()
	{
		bool find = false;
		lastGameSpeedInfoIndex = ((currentGameSpeedInfo == null) ? ((int?)null) : new int?(currentGameSpeedInfo.InfoIndex));
		RemoveGameSpeedInfo(ref find);
		AddGameSpeedInfo(ref find);
		if (find)
		{
			SetMaxPriorityGameSpeed();
		}
	}

	protected void UpdateGameSpeedInfo()
	{
		lastGameSpeedInfoIndex = ((currentGameSpeedInfo == null) ? ((int?)null) : new int?(currentGameSpeedInfo.InfoIndex));
		if (currentGameSpeedInfo == null || allGameSpeedInfos.Count <= 0)
		{
			return;
		}
		for (int num = allGameSpeedInfos.Count - 1; num >= 0; num--)
		{
			if (allGameSpeedInfos[num] == currentGameSpeedInfo)
			{
				allGameSpeedInfos[num].TimeCount -= _initIntervalTimer;
			}
			else
			{
				allGameSpeedInfos[num].TimeCount -= _intervalTimer;
			}
			if (allGameSpeedInfos[num].TimeCount < 0.033f * _worldSpeed)
			{
				if (allGameSpeedInfos[num] == currentGameSpeedInfo)
				{
					if (LockstepData.Instance != null)
					{
						LockstepData.Instance.WriteAuthorityEntityId($"改变游戏速度结束，序号是：{currentGameSpeedInfo.InfoIndex}", currentGameSpeedInfo.Entity);
					}
					currentGameSpeedInfo = null;
				}
				allGameSpeedInfos.Remove(allGameSpeedInfos[num]);
			}
		}
		SetMaxPriorityGameSpeed();
	}

	private void SetMaxPriorityGameSpeed()
	{
		if (currentGameSpeedInfo != null)
		{
			return;
		}
		if (allGameSpeedInfos.Count > 0)
		{
			currentGameSpeedInfo = allGameSpeedInfos[0];
			for (int i = 1; i < allGameSpeedInfos.Count; i++)
			{
				if (allGameSpeedInfos[i].Priority >= currentGameSpeedInfo.Priority)
				{
					currentGameSpeedInfo = allGameSpeedInfos[i];
				}
			}
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"设置游戏速度，序号是：{currentGameSpeedInfo.InfoIndex}，当前游戏速度为：{currentGameSpeedInfo.GameSpeed}", currentGameSpeedInfo.Entity);
			}
			if (!lastGameSpeedInfoIndex.HasValue || (lastGameSpeedInfoIndex.HasValue && lastGameSpeedInfoIndex.Value != currentGameSpeedInfo.InfoIndex))
			{
				SetGameSpeed(currentGameSpeedInfo.GameSpeed);
			}
		}
		else
		{
			SetGameSpeed(1f);
		}
	}

	public bool EntityIgnoreTimeScale(BaseEntity baseEntity)
	{
		if (currentGameSpeedInfo == null || currentGameSpeedInfo.IgnoreEntitys == null)
		{
			return false;
		}
		if (baseEntity.IgnoreTimeScale())
		{
			return true;
		}
		if (baseEntity is SummonedEntity)
		{
			return currentGameSpeedInfo.IgnoreEntitys.Contains(baseEntity.Id);
		}
		if (baseEntity.Parent != null && baseEntity.Parent.IgnoreTimeScale())
		{
			return true;
		}
		if (!currentGameSpeedInfo.IgnoreEntitys.Contains(baseEntity.Id))
		{
			if (baseEntity.Parent != null)
			{
				return currentGameSpeedInfo.IgnoreEntitys.Contains(baseEntity.Parent.Id);
			}
			return false;
		}
		return true;
	}

	public int GameSpeedIgnoreEntityCount()
	{
		if (currentGameSpeedInfo == null || currentGameSpeedInfo.IgnoreEntitys == null)
		{
			return 0;
		}
		return currentGameSpeedInfo.IgnoreEntitys.Count;
	}

	public float GetEntityDeltaTime(BaseEntity baseEntity)
	{
		if (!EntityIgnoreTimeScale(baseEntity))
		{
			return _intervalTimer;
		}
		return _initIntervalTimer;
	}

	public float GetEntityGameSpeed(BaseEntity baseEntity)
	{
		if (!EntityIgnoreTimeScale(baseEntity))
		{
			return _worldSpeed;
		}
		return 1f;
	}

	public bool InGameSpeed()
	{
		return currentGameSpeedInfo != null;
	}

	public bool TimeScaleEffectWeakness()
	{
		if (currentGameSpeedInfo != null)
		{
			return currentGameSpeedInfo.IsEffectWeakness;
		}
		return false;
	}

	public async UniTask<bool> LoadBattleConfig()
	{
		TextAsset textAsset = await GetSystem<GameResourceSystem>().LoadAssetAsync<TextAsset>(AssetUtility.GetConfigAsset("BattleConfig", LoadType.Text));
		if (textAsset == null)
		{
			Log.Error("初始化世界错误：缺少BattleConfig配置!");
			return false;
		}
		_battleConfig = JsonConvert.DeserializeObject<BattleConfig>(textAsset.text);
		GetSystem<GameResourceSystem>().UnloadAsset(AssetUtility.GetConfigAsset("BattleConfig", LoadType.Text));
		_goldBodySettings = await GetSystem<GameResourceSystem>().LoadAssetAsync<GoldBodySettings>(AssetUtility.GetBattleViewConfigAsset("GoldBodySetting.asset"));
		_noiseSettings = await GetSystem<GameResourceSystem>().LoadAssetAsync<CameraShakeNoiseData>(AssetUtility.GetBattleViewConfigAsset("CameraShakeNoiseData.asset"));
		_monsterNoiseSettings = await GetSystem<GameResourceSystem>().LoadAssetAsync<NoiseSettings>(AssetUtility.GetBattleViewConfigAsset("MonsterNoiseSetting.asset"));
		characterClimbSetting = await GetSystem<GameResourceSystem>().LoadAssetAsync<CharacterClimbSetting>(AssetUtility.GetBattleViewConfigAsset("CharacterClimbSetting.asset"));
		_cameraData = await GetSystem<GameResourceSystem>().LoadAssetAsync<CameraConfig>(AssetUtility.GetBattleViewConfigAsset("CameraConfig.asset"));
		_characterConfig = await GetSystem<GameResourceSystem>().LoadAssetAsync<CharacterConfig>(AssetUtility.GetBattleViewConfigAsset("CharacterConfig.asset"));
		if (_monsterNoiseSettings == null || _noiseSettings == null || _monsterNoiseSettings == null || (UnityEngine.Object)(object)characterClimbSetting == null || _cameraData == null || _characterConfig == null)
		{
			Log.Error("初始化世界错误：缺少BattleViewConfig配置!");
			return false;
		}
		return true;
	}
}
