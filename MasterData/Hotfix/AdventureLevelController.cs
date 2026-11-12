using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AdventureBehaviour;
using LitJson;
using Nova.Client;
using Nova.Hotfix;
using Pathfinding;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;
using UnityEngine.UI.Extensions;

public class AdventureLevelController : MonoBehaviour
{
	public class RoomRuleInfo
	{
		public int id;

		public int[] camps;

		public HotfixEnum.monsterEpicType[] epics;

		public List<AddEffectInfo> effectInfos;

		public List<int> buffIDs;

		public AdventureActor fromActor;

		public bool IsCampSatis(int camp)
		{
			if (camps == null || camps.Length == 0)
			{
				return false;
			}
			bool result = false;
			for (int i = 0; i < camps.Length; i++)
			{
				if (camp == camps[i])
				{
					result = true;
					break;
				}
			}
			return result;
		}

		public bool IsEpicSatis(HotfixEnum.monsterEpicType epic)
		{
			if (epics == null || epics.Length == 0)
			{
				return false;
			}
			bool result = false;
			for (int i = 0; i < epics.Length; i++)
			{
				if (epics[i] == HotfixEnum.monsterEpicType.ALL)
				{
					result = true;
					break;
				}
				if (epic == epics[i])
				{
					result = true;
					break;
				}
			}
			return result;
		}
	}

	public string scenePath;

	public string musicName;

	public string leaveMusicEvent;

	public string levelScript;

	private AIAdapter _aiAdapter;

	protected Action flowCallback;

	private LogManager.Logger logger;

	public Dictionary<string, int> dicLevelCounter = new Dictionary<string, int>();

	public int boxID;

	protected GameObject configPrefab;

	private bool _isLoadingLevel;

	public bool isUnloadingLevel;

	private Transform timelineNode;

	protected string timelineName;

	protected ExtraLevelInfo extraLevelInfo;

	protected EventDispatcher eventDispatcher;

	protected int currentLvDropCount;

	protected List<InteractiveNpc> interactiveNpc = new List<InteractiveNpc>();

	protected Dictionary<int, int> dicIndexTreasureBox = new Dictionary<int, int>();

	protected Dictionary<int, int> dicIndexChestBoss = new Dictionary<int, int>();

	protected Dictionary<int, int> dicIndexChestMiniBoss = new Dictionary<int, int>();

	protected Dictionary<int, int> dicIndexChestSpecCom = new Dictionary<int, int>();

	protected TSVector2 bigChestPos = TSVector2.zero;

	internal AdventureObjectOrderByLocationComparer _objectOrderByLocationComparer = new AdventureObjectOrderByLocationComparer();

	private const int frame2Check = 30;

	private const long INTERNAL_UID = 10000L;

	private long _uidCounter = 10000L;

	internal const long INVALID_UID = -1L;

	private bool _lockEntitiesListUpdate;

	private static readonly Type actorType = typeof(AdventureActor);

	private static readonly Type playerType = typeof(PlayerAdventureActor);

	private static readonly Type monsterType = typeof(MonsterAdventureActor);

	private static readonly Type obstacleType = typeof(AdventureObstacle);

	private static readonly Type destructibleType = typeof(DestructibleObject);

	private static readonly Type weaponType = typeof(AdventureWeapon);

	private static readonly Type specialEntityType = typeof(ISpecialEntity);

	private static readonly Type skillType = typeof(AdventureSkill);

	private static readonly Type treasureType = typeof(TreasureBoxSpawnPoint);

	private static readonly Type trapType = typeof(TrapAdventureActor);

	private static readonly Type areaEffectType = typeof(AreaEffectEntity);

	private static readonly Type dropEntityType = typeof(DropEntity);

	private static readonly Type placeHolderEntityType = typeof(AdventurePlaceHolder);

	private static readonly Type npcEntityType = typeof(NPCAdventureActor);

	private static readonly Type dynamicActorType = typeof(DynamicActor);

	protected readonly List<LogicEntity> removeEntities = new List<LogicEntity>();

	private int currentMonsterWeaponCount;

	protected readonly Dictionary<long, LogicEntity> _entityIDCache = new Dictionary<long, LogicEntity>(250);

	private bool isHaveBigBox;

	private List<int[]> tmpPrizeList = new List<int[]>();

	private NavmeshCut[] navMeshCuts;

	private List<RoomRuleInfo> roomRuleInfos;

	protected List<TreasureBoxSpawnPoint> specifiedTreasureBoxSpawnPoints = new List<TreasureBoxSpawnPoint>(10);

	protected List<TreasureBoxSpawnPoint> treasureBoxSpawnPoints = new List<TreasureBoxSpawnPoint>(10);

	protected List<PlayerSpawnPointGizmo> playerSpawnPoints = new List<PlayerSpawnPointGizmo>();

	protected PlayerSpawnPointGizmo playerSpawnPointGizmo;

	public List<AdventureLevelTeleporter> teleporters = new List<AdventureLevelTeleporter>();

	protected List<NPCSpawnPointGizmo> npcSpawnPoints = new List<NPCSpawnPointGizmo>(5);

	internal AdventureObjectOrderByLocationComparer objectOrderByLocationComparer = new AdventureObjectOrderByLocationComparer();

	private AdventurePlayerCameraTriggerGizmo curCameraTriggerGizmo;

	protected AdventureLevelState _levelStatus;

	protected Action<AdventureLevelState> levelStatusChanged;

	protected AdventureLevelTeleporter.NextLevelData nextLevelData;

	protected bool hasBattleStartMsgTrigger;

	protected bool hasBattleFinishMsgTrigger;

	private bool hasSendMonsterClearEvt;

	private Animator[] _allAnimatorsInScene;

	private ParticleSystem[] _allParticlesInScene;

	private PlayableDirector[] _allTimelinesInScene;

	public AdventureModuleLevelLoadParams levelLoadParams { get; protected set; }

	public LogManager.Logger _logger
	{
		get
		{
			if (logger == null)
			{
				logger = Singleton<LogManager>.Instance.get_Item("Adventure");
			}
			return logger;
		}
	}

	public bool isReconnected { get; protected set; }

	public bool isBattleFinish { get; protected set; }

	public bool isLastLevelFloor { get; protected set; }

	public bool isPrologueBattleCanSwitchActor { get; protected set; }

	protected bool isLevelLogicComplete
	{
		get
		{
			if (isReconnected)
			{
				return isBattleFinish;
			}
			return false;
		}
	}

	public bool isLoadingLevel
	{
		get
		{
			return _isLoadingLevel;
		}
		set
		{
			_isLoadingLevel = value;
			AdventureStateProxy.IsLoadingLevel = value;
		}
	}

	public bool isViewSceneMode => levelLoadParams?.viewSceneMode ?? false;

	public bool sendBattleEndMsg => levelLoadParams?.sendBattleEndMsg ?? true;

	public List<LogicEntity> entities { get; protected set; } = new List<LogicEntity>(250);

	public List<LogicEntity> playerActors { get; protected set; } = new List<LogicEntity>(10);

	public List<LogicEntity> monsterActors { get; protected set; } = new List<LogicEntity>(50);

	public List<LogicEntity> weapons { get; protected set; } = new List<LogicEntity>(100);

	public List<LogicEntity> destructibleObjects { get; protected set; } = new List<LogicEntity>(50);

	public List<Searchable> searchables { get; protected set; } = new List<Searchable>(100);

	public List<LogicEntity> obstacles { get; protected set; } = new List<LogicEntity>(100);

	public List<LogicEntity> trapActors { get; protected set; } = new List<LogicEntity>(50);

	public List<LogicEntity> areaEffects { get; protected set; } = new List<LogicEntity>(20);

	public List<LogicEntity> dropEntitys { get; protected set; } = new List<LogicEntity>(20);

	public List<LogicEntity> forzenTimeChildren { get; protected set; } = new List<LogicEntity>(10);

	public Dictionary<Transform, GameObject> minimapObjects { get; protected set; } = new Dictionary<Transform, GameObject>(20);

	public List<LogicEntity> dynamicActors { get; protected set; } = new List<LogicEntity>(50);

	public List<LogicEntity> placeHolders { get; protected set; } = new List<LogicEntity>(20);

	public List<LogicEntity> specialEntities { get; protected set; } = new List<LogicEntity>(20);

	public int totalAlivePlayerActorCount { get; protected set; }

	public bool isMonsterCleared { get; protected set; }

	protected Transform actorRootNode => extraLevelInfo.actorRootNode;

	protected Transform weaponRootNode => extraLevelInfo.weaponRootNode;

	protected Transform skillRootNode => extraLevelInfo.skillRootNode;

	protected Transform minimapRootNode => extraLevelInfo.minimapRootNode;

	public List<MonsterSpawnWaveGizmo> monsterSpawnWaves { get; protected set; } = new List<MonsterSpawnWaveGizmo>(5);

	public List<TrapSpawnGroupGizmo> trapGroups { get; protected set; } = new List<TrapSpawnGroupGizmo>(5);

	public List<VirtualMonsterSpawnWaveGizmo> virtualMonsterSpawnWaves { get; set; } = new List<VirtualMonsterSpawnWaveGizmo>(5);

	public List<AdventureTriggerGizmo> triggerGizmos { get; protected set; } = new List<AdventureTriggerGizmo>(25);

	public AdventureInteractableEventTriggerGizmo activedInteractableEventTriggerGizmo { get; protected set; }

	public AdventurePlayerCameraTriggerGizmo CurCameraTriggerGizmo => curCameraTriggerGizmo;

	public AdventureLevelState levelStatus
	{
		get
		{
			return _levelStatus;
		}
		protected set
		{
			_levelStatus = value;
			levelStatusChanged?.Invoke(_levelStatus);
		}
	}

	public HotfixEnum.levelState gameState { get; protected set; }

	protected int levelSuccessDelayKey => extraLevelInfo.levelSuccessDelayKey;

	protected int levelDefeatDelayKey => extraLevelInfo.levelDefeatDelayKey;

	protected int levelTeleporterDelayKey => extraLevelInfo.levelTeleporterDelayKey;

	protected virtual void Awake()
	{
		logger = Singleton<LogManager>.Instance.get_Item("Adventure");
	}

	public virtual void Initialize(ExtraLevelInfo extraLevelInfo, EventDispatcher eventDispatcher, Action<AdventureLevelState> levelStatusChanged)
	{
		this.extraLevelInfo = extraLevelInfo;
		this.eventDispatcher = eventDispatcher;
		this.levelStatusChanged = levelStatusChanged;
		_levelStatus = AdventureLevelState.Init;
		AddEventListener("ADVENTURE_CHANGE_LEVEL_STATE", OnChangeLevelState);
		AddEventListener("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", OnLevelTeleporterTriggered);
		AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
	}

	public virtual void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		levelLoadParams = param;
		flowCallback = callback;
		isLoadingLevel = true;
		hasBattleStartMsgTrigger = false;
		hasBattleFinishMsgTrigger = false;
		InitRoomEffects();
		PreloadPlayer();
	}

	protected void LevelLoadProcessUpdate(string sceneName, int process)
	{
		MonoSingleton<ClientManager>.Instance.UpdateLoadingView((float)process / 100f);
		if (process == 200)
		{
			LevelLoadComplete(sceneName);
		}
	}

	protected virtual void LevelLoadComplete(string sceneName)
	{
		logger.LogInfo("关卡加载完毕");
		GameObject[] rootGameObjects = SceneManager.GetSceneByName(sceneName).GetRootGameObjects();
		foreach (GameObject gameObject in rootGameObjects)
		{
			if (!gameObject.name.Equals("==== Environment ===="))
			{
				continue;
			}
			int childCount = gameObject.transform.childCount;
			for (int j = 0; j < childCount; j++)
			{
				Transform child = gameObject.transform.GetChild(j);
				if (child.name.ToLowerInvariant().Equals("timeline"))
				{
					timelineNode = child;
					break;
				}
			}
			break;
		}
		if (null != configPrefab)
		{
			TriggerTask[] componentsInChildren = configPrefab.transform.GetComponentsInChildren<TriggerTask>();
			for (int k = 0; k < componentsInChildren.Length; k++)
			{
				TaskCellBase[] array = componentsInChildren[k]?.taskCells;
				for (int l = 0; l < array.Length; l++)
				{
					if (array[l] is Task_MsgBattleStart)
					{
						hasBattleStartMsgTrigger = true;
					}
					else if (array[l] is Task_MsgBattleFinish)
					{
						hasBattleFinishMsgTrigger = true;
					}
					if (hasBattleStartMsgTrigger && hasBattleFinishMsgTrigger)
					{
						break;
					}
				}
			}
		}
		StartCoroutine(FinishAndUnloadUnusedResources(() =>
		{
			SetupVisualControllerOnLevelLoaded();
			_logger.LogInfo("关卡加载完毕！");
			if (flowCallback != null)
			{
				flowCallback();
			}
			isLoadingLevel = false;
		}));
	}

	protected virtual void LevelTeleporterTriggered(AdventureLevelTeleporter.NextLevelData nextData)
	{
	}

	public virtual void LevelStart(Action callback = null)
	{
		levelStatus = AdventureLevelState.LevelStart;
		for (int i = 0; i < trapGroups.Count; i++)
		{
			trapGroups.get_Item(i).ExecuteSpawnLogic();
		}
		for (int j = 0; j < entities.Count; j++)
		{
			LogicEntity logicEntity = entities.get_Item(j);
			if (actorType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as AdventureActor).LevelStart();
			}
		}
		playerSpawnPointGizmo?.LevelStart();
		if (!string.IsNullOrEmpty(levelScript))
		{
			_aiAdapter = new AIAdapter();
			if (_aiAdapter.Initialize(levelScript, ModuleController<AdventureModuleController>.Instance.gameObject))
			{
				_aiAdapter.Start();
			}
			else
			{
				_aiAdapter = null;
			}
		}
	}

	public virtual void LevelEnd()
	{
		hasSendMonsterClearEvt = false;
		levelStatus = AdventureLevelState.LevelEnd;
		isReconnected = false;
		playerSpawnPointGizmo?.LevelEnd();
		playerSpawnPointGizmo = null;
		timelineName = null;
		timelineNode = null;
		for (int i = 0; i < entities.Count; i++)
		{
			LogicEntity logicEntity = entities.get_Item(i);
			if (actorType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as AdventureActor).LevelEnd();
			}
		}
		SceneSingleton<AdventurePlayerFeedbackEffectController>.Instance.StopAllFX();
		SceneSingleton<AdventureFXManager>.Instance.StopAllFXPlayers(dontPlaySubFX: true);
		ReleaseWeapons();
		ReleaseMonsters();
		ReleasePlayerActors();
		ReleaseTeleporters();
		ReleaseTraps();
		ReleaseAreaEffect();
		ReleaseSpecialEntity();
		for (int num = entities.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity2 = entities.get_Item(num);
			if (!FilterObject(logicEntity2))
			{
				logicEntity2.ActiveSelf = false;
			}
		}
		RemoveNoActiveEntitied();
		ReleaseTriggerGizmos();
		ClearSpawnPoints();
		if (_aiAdapter != null)
		{
			_aiAdapter.Stop();
			_aiAdapter.Disable();
			_aiAdapter = null;
		}
		static bool FilterObject(LogicEntity entity)
		{
			if (entity is AdventurePlayerCameraTriggerGizmo adventurePlayerCameraTriggerGizmo)
			{
				return adventurePlayerCameraTriggerGizmo.dontDestory;
			}
			return false;
		}
	}

	public virtual void LevelFinish()
	{
		levelStatus = AdventureLevelState.Finish;
		isLastLevelFloor = false;
		isBattleFinish = false;
		isReconnected = false;
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.LevelFinish();
		StopAllCoroutines();
		dicLevelCounter.Clear();
		hasSendMonsterClearEvt = false;
	}

	public virtual void Unload(Action callback = null)
	{
		isUnloadingLevel = true;
		MonoSingleton<SceneLoaderController>.Instance.UnloadAdditiveSceneAsync(scenePath, UnloadSceneOptions.None, (string sceneN, int process) =>
		{
			if (process == 300)
			{
				UnloadLevelComplete(callback);
			}
			return true;
		});
	}

	protected virtual void UnloadLevelComplete(Action unloadCallback = null)
	{
		_logger.LogInfo("关卡场景卸载完毕");
		ClearRoomEffects();
		AdventureFXManager.ClearFXInstancePool();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.UnloadAssets();
		GameResourceLoader.Unload("Level");
		unloadCallback?.Invoke();
		isUnloadingLevel = false;
	}

	public virtual void UpdateLogic(FP logicDeltaTime)
	{
		UpdateLogicEntities();
		UpdateSpawnLogic();
		CheckLevelStatus();
		UpdateMonsterActiveScheme();
		if (_aiAdapter != null)
		{
			_aiAdapter.Update();
		}
	}

	protected IEnumerator FinishAndUnloadUnusedResources(Action callback = null)
	{
		GC.Collect();
		yield return MonoSingleton<ResourceManager>.Instance.UnloadUnusedAssets(null);
		yield return null;
		callback?.Invoke();
	}

	protected void PreloadPlayer()
	{
		GameTeamConfig teamConfig = AdventureGameContext.TeamConfig;
		if (teamConfig != null)
		{
			int[] actorIDs = teamConfig.ActorIDs;
			if (actorIDs != null && actorIDs.Length != 0)
			{
				MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.PreloadPlayers(actorIDs);
			}
		}
	}

	public virtual void PreloadAssets()
	{
		List<int> list = new List<int>();
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			if (monsterSpawnWaves.get_Item(i).waveType != MonsterSpawnWaveGizmo.WaveType.Default)
			{
				continue;
			}
			MonsterSpawnPointGizmo[] componentsInChildren = monsterSpawnWaves.get_Item(i).transform.GetComponentsInChildren<MonsterSpawnPointGizmo>();
			for (int j = 0; j < componentsInChildren.Length; j++)
			{
				int monsterID = componentsInChildren[j].monsterID;
				if (!list.Contains(monsterID))
				{
					list.Add(monsterID);
				}
			}
		}
		AdventureModulePreloadAssetsMrg instance = MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance;
		if (list.Count > 0)
		{
			instance.PreloadMonsters_IDList(list, isRoguelikeMonster: false);
		}
	}

	public virtual void Clear()
	{
		levelLoadParams = null;
		flowCallback = null;
		levelStatusChanged = null;
		RemoveEventListener("ADVENTURE_CHANGE_LEVEL_STATE", OnChangeLevelState);
		RemoveEventListener("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", OnLevelTeleporterTriggered);
		RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDeath);
		eventDispatcher = null;
		currentLvDropCount = 0;
	}

	public virtual bool IsLevelComplete()
	{
		return isMonsterCleared;
	}

	protected bool AddEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return AddEventListener(aEventName_string, aEventDelegate, EventDispatchMode.Default);
	}

	private bool AddEventListener(string aEventName_string, EventDelegate aEventDelegate, EventDispatchMode aEventDispatchMode)
	{
		return eventDispatcher.AddEventListener(aEventName_string, aEventDelegate, aEventDispatchMode);
	}

	protected bool HasEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return eventDispatcher.HasEventListener(aEventName_string, aEventDelegate);
	}

	protected bool RemoveEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return eventDispatcher.RemoveEventListener(aEventName_string, aEventDelegate);
	}

	protected bool RemoveAllEventListeners()
	{
		return eventDispatcher.RemoveAllEventListeners();
	}

	protected void MonsterDeath(IEvent evt)
	{
		if (levelLoadParams.dropMaxNum <= 0 || currentLvDropCount >= levelLoadParams.dropMaxNum || !(MonoSingleton<GameController>.Instance.Random_Roguelike(FP.Zero, FP.One) <= levelLoadParams.dropEntityRate))
		{
			return;
		}
		AdventureMonsterDiedEvent adventureMonsterDiedEvent = evt as AdventureMonsterDiedEvent;
		List<DropObjectGroup> list = Singleton<HotfixDataController>.Instance.DropObjectGroupData.FindAll((DropObjectGroup x) => object.Equals(x.DropObjectGroupId, levelLoadParams.dropEntityGroupId));
		int num = 0;
		Dictionary<DropObjectGroup, int> dictionary = new Dictionary<DropObjectGroup, int>();
		for (int num2 = 0; num2 < list.Count; num2++)
		{
			num += list.get_Item(num2).Weight;
			dictionary.set_Item(list.get_Item(num2), num);
		}
		int num3 = 0;
		if (num > 0)
		{
			float num4 = Random(0, num);
			foreach (KeyValuePair<DropObjectGroup, int> item in dictionary)
			{
				if (num4 < (float)item.Value)
				{
					num3 = item.Key.DropObjectId;
					break;
				}
			}
		}
		if (num3 != 0)
		{
			currentLvDropCount++;
			SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(adventureMonsterDiedEvent.sender as AdventureActor, num3);
		}
	}

	private float Random(float min, float max)
	{
		float result = min;
		if (null != MonoSingleton<GameController>.Instance)
		{
			result = (float)MonoSingleton<GameController>.Instance.Random_Roguelike(min, max);
		}
		else
		{
			_logger.LogInfo("缺少[GameController.cs]");
		}
		return result;
	}

	private float Random(int min, int max)
	{
		int num = min;
		if (null != MonoSingleton<GameController>.Instance)
		{
			num = MonoSingleton<GameController>.Instance.Random_Roguelike(min, max);
		}
		else
		{
			_logger.LogInfo("缺少[GameController.cs]");
		}
		return num;
	}

	public void VisualUpdateEntities()
	{
		int count = entities.Count;
		for (int i = 0; i < count; i++)
		{
			LogicEntity logicEntity = entities.get_Item(i);
			if (logicEntity != null && logicEntity.ActiveSelf)
			{
				entities.get_Item(i).VisualUpdate();
			}
		}
	}

	protected void UpdateMonsterActiveScheme()
	{
		if (LockStepManager.frameCount % 30 != 0)
		{
			return;
		}
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (!(activedPlayerActor != null))
		{
			return;
		}
		for (int i = 0; i < monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(i) as MonsterAdventureActor;
			if (monsterAdventureActor != null && monsterAdventureActor.logicUpdateEnabled)
			{
				monsterAdventureActor.monsterActiveScheme.UpdateLogic(activedPlayerActor);
			}
		}
	}

	public void UpdateLogicEntities()
	{
		for (int i = 0; i < entities.Count; i++)
		{
			LogicEntity logicEntity = entities.get_Item(i);
			if (logicEntity != null && logicEntity.ActiveSelf && logicEntity.logicUpdateEnabled && !logicEntity.logicUpdatePaused)
			{
				if (!logicEntity._callLogicStartOnce)
				{
					logicEntity.LogicStart();
					logicEntity._callLogicStartOnce = true;
				}
				logicEntity.LogicUpdate();
			}
		}
	}

	public void RemoveNoActiveEntitied()
	{
		if (removeEntities.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < removeEntities.Count; i++)
		{
			LogicEntity logicEntity = removeEntities.get_Item(i);
			if (monsterType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as MonsterAdventureActor)?.Recycle();
			}
			else if (playerType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as PlayerAdventureActor)?.Recycle();
			}
			else if (skillType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as AdventureSkill)?.Recycle();
			}
			else if (treasureType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as TreasureBoxSpawnPoint)?.Recycle();
			}
			else if (weaponType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as AdventureWeapon)?.Recycle();
			}
			else if (trapType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as TrapAdventureActor)?.Recycle();
			}
			else if (areaEffectType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as AreaEffectEntity)?.Recycle();
			}
			else if (dropEntityType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as DropEntity)?.Recycle();
			}
			else if (npcEntityType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as NPCAdventureActor)?.Recycle();
			}
			else if (dynamicActorType.IsInstanceOfType(logicEntity))
			{
				(logicEntity as DynamicActor)?.Recycle();
			}
		}
		removeEntities.Clear();
		entities.RemoveAll((LogicEntity x) => null == x || x.isInvalid || !x.ActiveSelf);
	}

	internal long GenerateUniqueID()
	{
		_uidCounter++;
		return _uidCounter;
	}

	public void RegisterSearchable(Searchable search)
	{
		if (!searchables.Contains(search))
		{
			searchables.Add(search);
		}
	}

	public void UnRegisterSearchable(Searchable search)
	{
		searchables.Remove(search);
	}

	public void RegisterEntity(LogicEntity entity)
	{
		if (!entities.Contains(entity))
		{
			entity.Id = GenerateUniqueID();
			entities.Add(entity);
			_entityIDCache.Add(entity.Id, entity);
			if (obstacleType.IsInstanceOfType(entity))
			{
				obstacles.Add(entity);
			}
			else if (monsterType.IsInstanceOfType(entity))
			{
				monsterActors.Add(entity);
			}
			else if (playerType.IsInstanceOfType(entity))
			{
				playerActors.Add(entity);
			}
			else if (weaponType.IsInstanceOfType(entity))
			{
				weapons.Add(entity);
			}
			else if (destructibleType.IsInstanceOfType(entity))
			{
				destructibleObjects.Add(entity);
			}
			else if (trapType.IsInstanceOfType(entity))
			{
				trapActors.Add(entity);
			}
			else if (areaEffectType.IsInstanceOfType(entity))
			{
				areaEffects.Add(entity);
			}
			else if (dropEntityType.IsInstanceOfType(entity))
			{
				dropEntitys.Add(entity);
			}
			else if (placeHolderEntityType.IsInstanceOfType(entity))
			{
				placeHolders.Add(entity);
			}
			else if (dynamicActorType.IsInstanceOfType(entity))
			{
				dynamicActors.Add(entity);
			}
			else if (specialEntityType.IsInstanceOfType(entity))
			{
				specialEntities.Add(entity);
			}
		}
		else
		{
			_logger.LogWarning("重复注册实体:" + entity.gameObject.name);
		}
	}

	public void UnRegisterEntity(LogicEntity entity, bool delayDrop = false)
	{
		Transform key = entity.transform;
		if (minimapObjects.ContainsKey(key))
		{
			GameObject obj = minimapObjects.get_Item(key);
			minimapObjects.Remove(key);
			UnityEngine.Object.Destroy(obj);
		}
		if (forzenTimeChildren.Contains(entity))
		{
			forzenTimeChildren.Remove(entity);
		}
		if (_entityIDCache.Remove(entity.Id))
		{
			entity.Id = -1L;
			removeEntities.Add(entity);
			if (obstacleType.IsInstanceOfType(entity))
			{
				obstacles.Remove(entity);
			}
			else if (monsterType.IsInstanceOfType(entity))
			{
				monsterActors.Remove(entity);
			}
			else if (playerType.IsInstanceOfType(entity))
			{
				playerActors.Remove(entity);
			}
			else if (weaponType.IsInstanceOfType(entity))
			{
				weapons.Remove(entity);
			}
			else if (destructibleType.IsInstanceOfType(entity))
			{
				destructibleObjects.Remove(entity);
			}
			else if (trapType.IsInstanceOfType(entity))
			{
				trapActors.Remove(entity);
			}
			else if (areaEffectType.IsInstanceOfType(entity))
			{
				areaEffects.Remove(entity);
			}
			else if (dropEntityType.IsInstanceOfType(entity))
			{
				dropEntitys.Remove(entity);
			}
			else if (placeHolderEntityType.IsInstanceOfType(entity))
			{
				placeHolders.Remove(entity);
			}
			else if (dynamicActorType.IsInstanceOfType(entity))
			{
				dynamicActors.Remove(entity);
			}
			else if (specialEntityType.IsInstanceOfType(entity))
			{
				specialEntities.Remove(entity);
			}
		}
	}

	public void GetObstacleGroup(string obstacleName, List<AdventureObstacle> obstacles)
	{
		if (obstacles == null)
		{
			return;
		}
		obstacles.Clear();
		for (int i = 0; i < obstacles.Count; i++)
		{
			if (this.obstacles.get_Item(i).name == obstacleName)
			{
				obstacles.Add(obstacles.get_Item(i));
			}
		}
	}

	[Obsolete]
	public void SetObstacleSate(string targetName, bool active)
	{
		for (int i = 0; i < obstacles.Count; i++)
		{
			if (obstacles.get_Item(i).name == targetName)
			{
				obstacles.get_Item(i).ActiveSelf = active;
			}
		}
	}

	protected void ReleaseWeapons()
	{
		for (int num = weapons.Count - 1; num >= 0; num--)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(num) as AdventureWeapon;
			if (adventureWeapon != null && !adventureWeapon.isValid)
			{
				adventureWeapon.Finish(cancel: true);
			}
		}
		currentMonsterWeaponCount = 0;
	}

	protected void ReleaseTraps()
	{
		for (int num = trapActors.Count - 1; num >= 0; num--)
		{
			AdventureTrap adventureTrap = trapActors.get_Item(num) as AdventureTrap;
			if (adventureTrap != null)
			{
				adventureTrap.ActiveSelf = false;
			}
		}
	}

	protected void ReleaseAreaEffect()
	{
		for (int num = areaEffects.Count - 1; num >= 0; num--)
		{
			AreaEffectEntity areaEffectEntity = areaEffects.get_Item(num) as AreaEffectEntity;
			if (areaEffectEntity != null)
			{
				areaEffectEntity.Finish();
			}
		}
	}

	protected void ReleaseSpecialEntity()
	{
		for (int num = specialEntities.Count - 1; num >= 0; num--)
		{
			if (specialEntities.get_Item(num) is ISpecialEntity specialEntity)
			{
				specialEntity.Finish();
			}
		}
	}

	public void ReduceMonsterWeaponCount()
	{
		currentMonsterWeaponCount--;
	}

	public void KillAllMonsters(bool clearOrDestroy = false, bool ignoreAll = false, bool ignoreSpawnState = true, bool ignoreDiedState = false, int appointID = 0)
	{
		for (int num = monsterActors.Count - 1; num >= 0; num--)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(num) as MonsterAdventureActor;
			if (!(null == monsterAdventureActor) && (appointID <= 0 || monsterAdventureActor.Id == appointID) && (ignoreAll || ((ignoreSpawnState || monsterAdventureActor.state > ActorState.Spawn) && (ignoreDiedState || (!monsterAdventureActor.isDead && (monsterAdventureActor.actorHealthInfo.isAlive || monsterAdventureActor.isDead))) && monsterAdventureActor.monsterInfo.subType == HotfixEnum.monsterSubType.Monster && (monsterAdventureActor.monsterSummonInfo == null || !(null != monsterAdventureActor.monsterSummonInfo.SummonActor) || !(monsterAdventureActor.monsterSummonInfo.SummonActor is PlayerAdventureActor)))))
			{
				if (clearOrDestroy)
				{
					monsterAdventureActor.ClearSelf();
				}
				else
				{
					monsterAdventureActor.DestroySelf();
				}
			}
		}
	}

	protected void ReleaseMonsters()
	{
		KillAllMonsters(clearOrDestroy: true, ignoreAll: false, ignoreSpawnState: true, ignoreDiedState: true);
	}

	public void ReleasePlayerActors()
	{
		for (int num = playerActors.Count - 1; num >= 0; num--)
		{
			PlayerAdventureActor playerAdventureActor = playerActors.get_Item(num) as PlayerAdventureActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.Despawn();
			}
		}
	}

	public void ReleaseTeleporters()
	{
		if (teleporters != null)
		{
			teleporters.Clear();
		}
	}

	public void SpawnTreasureBox(ActorSpawnInfo spawnInfo, out Chest boxData, Action<AdventureLevelObjPoolMgr.PoolObj> callback)
	{
		int boxID = spawnInfo.id;
		boxData = Singleton<HotfixDataController>.Instance.GetChest(boxID);
		if (boxData == null)
		{
			_logger.LogError($"宝箱数据为空:{boxID}");
			return;
		}
		string modelPath = boxData.ModelPath;
		if (string.IsNullOrEmpty(modelPath))
		{
			_logger.LogError("ID = " + modelPath + " 的宝箱模型资源 配置项为空");
		}
		else
		{
			if (string.IsNullOrEmpty(modelPath))
			{
				return;
			}
			string loadPath = "Assets/AssetBundles/" + modelPath + ".prefab";
			SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_SceneObject(loadPath, (AdventureLevelObjPoolMgr.PoolBase poolBase) =>
			{
				if (poolBase != null)
				{
					AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
					poolObj.Enabled(enable: true);
					GameObject gameObject = poolObj.gameObject;
					if (gameObject == null)
					{
						_logger.LogError($"ID={boxID}的角色资源不存在");
					}
					else
					{
						if (null != gameObject && !actorRootNode.Equals(gameObject.transform.parent))
						{
							gameObject.transform.SetParent(actorRootNode);
						}
						InteractiveBox interactiveBox = gameObject.GetComponent<InteractiveBox>();
						if (null == interactiveBox)
						{
							interactiveBox = gameObject.AddComponent<InteractiveBox>();
						}
						interactiveBox.tsTransform.PositionY = spawnInfo.positionY;
						interactiveBox.tsTransform.Position = spawnInfo.position;
						interactiveBox.tsTransform.Rotation = spawnInfo.rotation;
						interactiveBox.enabled = true;
						SpawnMinimapTreasureBox(gameObject.transform);
						if (callback != null)
						{
							callback(poolObj);
						}
					}
				}
			});
		}
	}

	public void SpawnMinimapTreasureBox(Transform target)
	{
		if (SceneSingleton<AdventureMiniMapController>.Instance.isActived && !minimapObjects.ContainsKey(target))
		{
			string assetName = "Assets/AssetBundles/Environment/Minimap/baoxiang.prefab";
			GameObject gameObject = UnityEngine.Object.Instantiate(GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject, minimapRootNode);
			gameObject.transform.localEulerAngles = new Vector3(0f, -90f, 0f);
			gameObject.GetComponent<MinmapObject>().SetTarget(target);
			minimapObjects.Add(target, gameObject);
		}
	}

	public void SpawnMinimapObject(HotfixEnum.monsterEpicType type, Transform target)
	{
		if (SceneSingleton<AdventureMiniMapController>.Instance.isActived && type != HotfixEnum.monsterEpicType.NORMAL && type != HotfixEnum.monsterEpicType.ELITE && !minimapObjects.ContainsKey(target))
		{
			string assetName = "Assets/AssetBundles/Environment/Minimap/jingying.prefab";
			if (type == HotfixEnum.monsterEpicType.LORD)
			{
				assetName = "Assets/AssetBundles/Environment/Minimap/boss.prefab";
			}
			GameObject gameObject = UnityEngine.Object.Instantiate(GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject, minimapRootNode);
			gameObject.GetComponent<MinmapObject>().SetTarget(target);
			minimapObjects.Add(target, gameObject);
		}
	}

	protected int GetMonsterThemeSkillID(int monsterID)
	{
		if (!(this is StarTowerLevelController))
		{
			return 0;
		}
		if (levelLoadParams.starTowerFloorSet == null)
		{
			return 0;
		}
		int themeSkillLv = levelLoadParams.starTowerFloorSet.ThemeSkillLv;
		if (themeSkillLv <= 0)
		{
			return 0;
		}
		StarTowerMonsterSpAttr starTowerMonsterSpAttr = Singleton<HotfixDataController>.Instance.GetStarTowerMonsterSpAttr(monsterID);
		if (starTowerMonsterSpAttr == null)
		{
			return 0;
		}
		string themeSkills = starTowerMonsterSpAttr.ThemeSkills;
		if (string.IsNullOrEmpty(themeSkills))
		{
			return 0;
		}
		try
		{
			foreach (JsonData item in (IEnumerable)JsonMapper.ToObject(themeSkills))
			{
				if ((int)item.get_Item("Level") == themeSkillLv)
				{
					return (int)item.get_Item("SkillId");
				}
			}
		}
		catch (Exception)
		{
			_logger.LogError("JSON解析出错:ThemeSkills:" + themeSkills);
			return 0;
		}
		return 0;
	}

	public void SpawnMonster(ActorSpawnInfo spawnInfo, Action<AdventureLevelObjPoolMgr.PoolObj, bool> callback, SummonCfg cfg = null)
	{
		int actorID = spawnInfo.id;
		Monster actorData = Singleton<HotfixDataController>.Instance.GetMonster(actorID);
		if (actorData == null)
		{
			_logger.LogError($"ID = {actorID} 的怪物数据不存在");
			return;
		}
		MonsterSkin skin = Singleton<HotfixDataController>.Instance.GetMonsterSkin(actorData.FAId);
		if (skin == null)
		{
			_logger.LogError($"ID = {actorID} 的怪物skin配置项为空");
			return;
		}
		string model = skin.Model;
		if (string.IsNullOrEmpty(model))
		{
			_logger.LogError("ID = " + model + "  的怪物模型资源 配置项为空");
			return;
		}
		string loadPath = string.Format("{0}{1}.prefab${2}", "Assets/AssetBundles/", model, actorID);
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Monster(loadPath, (AdventureLevelObjPoolMgr.PoolBase poolBase) =>
		{
			if (poolBase != null)
			{
				if (spawnInfo.maxCout > 0 && QueryMonsterEntitiesByDataID(spawnInfo.id).Count >= spawnInfo.maxCout)
				{
					SceneSingleton<AdventureLevelObjPoolMgr>.Instance.En_Monster(poolBase);
				}
				else
				{
					AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
					poolObj.Enabled(enable: true);
					GameObject gameObject = poolObj.gameObject;
					if (gameObject == null)
					{
						_logger.LogError($"ID={actorID}的角色资源不存在");
					}
					else
					{
						if (null != gameObject && !actorRootNode.Equals(gameObject.transform.parent))
						{
							gameObject.transform.SetParent(actorRootNode);
						}
						MonsterAdventureActor orAddComponent = gameObject.GetOrAddComponent<MonsterAdventureActor>();
						orAddComponent.SyncMovementLocation(spawnInfo.position, spawnInfo.positionY, spawnInfo.rotation);
						MonsterSpawnerInfo spawnerInfo = orAddComponent.spawnerInfo;
						AdventureEntityGroup adventureEntityGroup = null;
						if (orAddComponent.monsterAIInfo != null)
						{
							orAddComponent.monsterAIInfo.themeSkillId = GetMonsterThemeSkillID(actorID);
						}
						MonsterAdventureActor monsterAdventureActor = orAddComponent;
						monsterAdventureActor.columnOfScene = spawnInfo.posOfRogueX;
						monsterAdventureActor.rowOfScene = spawnInfo.posOfRogueY;
						monsterAdventureActor.GroupId = null;
						BaseSpawnPointGizmo spawnGizmo = spawnInfo.spawnGizmo;
						if (spawnerInfo != null)
						{
							spawnerInfo.enterActionStateWhenSpawn = spawnInfo.enterActionWhenSpawn;
							spawnerInfo.level = spawnInfo.monsterLevel;
							spawnerInfo.jumpOverSpawnPerformance = spawnInfo.jumpOverBornPerformance;
							spawnerInfo.callSpawnSrc = spawnInfo.callSpawnSrc;
							spawnerInfo.strollPoints = spawnInfo.strollPoints;
							spawnerInfo.strollInCircle = spawnInfo.strollInCircle;
							spawnerInfo.quitSettlement = spawnInfo.quitSettlement;
							spawnerInfo.indexOfSpawnWave = spawnInfo.indexOfSpawnWave;
							if (spawnGizmo != null)
							{
								BaseSpawnPointGizmo parentGizmo = spawnGizmo.parentGizmo;
								if (null != parentGizmo)
								{
									if (!(parentGizmo is MonsterSpawnGroupGizmo))
									{
										if (!(parentGizmo is RandomMonsterSpawnWaveGizmo))
										{
											if (parentGizmo is RegionBossSummonMonsterGroupGizmo)
											{
												monsterAdventureActor.isSyncActived = true;
												monsterAdventureActor.GroupId = parentGizmo.name;
												adventureEntityGroup = SceneSingleton<ActorGroupManager>.Instance.AddOrGetEntityGroup(orAddComponent.GroupId);
											}
										}
										else
										{
											monsterAdventureActor.isSyncActived = true;
											monsterAdventureActor.GroupId = parentGizmo.name;
											adventureEntityGroup = SceneSingleton<ActorGroupManager>.Instance.AddOrGetEntityGroup(orAddComponent.GroupId);
										}
									}
									else
									{
										MonsterSpawnGroupGizmo monsterSpawnGroupGizmo = spawnGizmo.parentGizmo as MonsterSpawnGroupGizmo;
										monsterAdventureActor.isSyncActived = monsterSpawnGroupGizmo.isSyncActive;
										monsterAdventureActor.GroupId = spawnGizmo.parentGizmo.id;
										adventureEntityGroup = SceneSingleton<ActorGroupManager>.Instance.AddOrGetEntityGroup(orAddComponent.GroupId);
									}
								}
							}
						}
						AdventureActor summoner = spawnInfo.summoner;
						if (summoner != null)
						{
							if (!string.IsNullOrEmpty(summoner.GroupId))
							{
								if (!string.IsNullOrEmpty(spawnInfo.summonGroupSuffix))
								{
									string groupID = (monsterAdventureActor.GroupId = summoner.GroupId + "_" + spawnInfo.summonGroupSuffix);
									adventureEntityGroup = SceneSingleton<ActorGroupManager>.Instance.AddOrGetEntityGroup(groupID);
								}
								else
								{
									adventureEntityGroup = SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(summoner.GroupId);
									if (adventureEntityGroup != null)
									{
										monsterAdventureActor.GroupId = summoner.GroupId;
									}
								}
							}
							monsterAdventureActor.isSyncActived = summoner.isSyncActived;
						}
						adventureEntityGroup?.AddMember(orAddComponent);
						orAddComponent.enabled = true;
						orAddComponent.LoadData(actorData, skin, spawnInfo, summoner != null, cfg);
						orAddComponent.spawnPoolObj = poolObj;
						SpawnMinimapObject(orAddComponent.monsterInfo.epicType, orAddComponent.transform);
						if (orAddComponent.monsterAIInfo.spawnSkillId != 0)
						{
							orAddComponent.Hide();
						}
						orAddComponent.LevelStart();
						if ((!(summoner != null) || !(summoner is PlayerAdventureActor)) && levelStatus != AdventureLevelState.LevelStart)
						{
							orAddComponent.DestroySelf();
						}
						_logger.LogInfo(string.Format("出生点{0}怪物{1}出生", (null != spawnGizmo) ? spawnGizmo.name : "empty", actorID));
						AdventurActorSpawned adventurActorSpawned = AdventurActorSpawned.Generate();
						adventurActorSpawned.sender = orAddComponent;
						ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorSpawned);
						callback?.Invoke(poolObj, spawnInfo.isRoguelikeMonster);
						ModuleController<AdventureModuleController>.Instance.RecordMonsterSpawn(orAddComponent);
					}
				}
			}
		});
	}

	public AdventureLevelObjPoolMgr.PoolBase SpawnPlayer(ActorSpawnInfo spawnConfig)
	{
		int id = spawnConfig.id;
		Character character = Singleton<HotfixDataController>.Instance.GetCharacter(id);
		if (character == null)
		{
			_logger.LogError($"ID={id}的角色数据不存在");
			return null;
		}
		string text = null;
		int key = character.DefaultSkinId;
		if (ModuleController<AdventureModuleController>.Instance.GetActorAttribute(character.Id, out var attribute))
		{
			key = attribute.skinId;
		}
		CharacterSkin characterSkin = Singleton<HotfixDataController>.Instance.GetCharacterSkin(key);
		if (characterSkin != null)
		{
			text = characterSkin.Model;
		}
		if (!string.IsNullOrEmpty(text))
		{
			string loadPath = "Assets/AssetBundles/" + text + ".prefab";
			AdventureLevelObjPoolMgr.PoolBase poolBase = SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Player(loadPath);
			if (poolBase == null)
			{
				_logger.LogError($"ID={id}的角色资源不存在");
				return null;
			}
			poolBase.Enabled(enable: true);
			AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
			GameObject gameObject = poolObj.gameObject;
			if (gameObject == null)
			{
				_logger.LogError($"ID={id}的角色资源不存在");
				return null;
			}
			gameObject.transform.SetParent(actorRootNode);
			if (null == gameObject.GetComponent<PlayerAdventureActor>())
			{
				gameObject.GetOrAddComponent<PlayerAdventureActor>().LoadData(character, characterSkin);
			}
			PlayerAdventureActor component = gameObject.GetComponent<PlayerAdventureActor>();
			component.SyncMovementLocation(spawnConfig.position, spawnConfig.positionY, spawnConfig.rotation);
			AdventureEntityGroup adventureEntityGroup = null;
			component.GroupId = null;
			if (spawnConfig.spawnGizmo != null)
			{
				component.GroupId = "STANDALONE_PLAYER_ACTOR_GROUP";
				adventureEntityGroup = SceneSingleton<ActorGroupManager>.Instance.AddOrGetEntityGroup(component.GroupId);
			}
			adventureEntityGroup?.AddMember(component);
			component.spawnPoolObj = poolObj;
			component.Born();
			if (levelStatus == AdventureLevelState.LevelStart)
			{
				component.LevelStart();
			}
			AdventurActorSpawned adventurActorSpawned = AdventurActorSpawned.Generate();
			adventurActorSpawned.sender = component;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorSpawned);
			return poolBase;
		}
		return null;
	}

	public void SpawnPlayer(int actorID, TSVector2 pos, FP posY, FP rot, Action<PlayerAdventureActor> callback)
	{
		Character character = Singleton<HotfixDataController>.Instance.GetCharacter(actorID);
		if (character == null)
		{
			_logger.LogError($"ID={actorID}的角色数据不存在");
			return;
		}
		string text = null;
		int key = character.DefaultSkinId;
		if (ModuleController<AdventureModuleController>.Instance.GetActorAttribute(character.Id, out var attribute))
		{
			key = attribute.skinId;
		}
		CharacterSkin characterSkin = Singleton<HotfixDataController>.Instance.GetCharacterSkin(key);
		if (characterSkin != null)
		{
			text = characterSkin.Model;
		}
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		string loadPath = "Assets/AssetBundles/" + text + ".prefab";
		AdventureLevelObjPoolMgr.PoolBase poolBase = SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Player(loadPath);
		if (poolBase == null)
		{
			_logger.LogError($"ID={actorID}的角色资源不存在");
			return;
		}
		poolBase.Enabled(enable: true);
		AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
		GameObject gameObject = poolObj.gameObject;
		if (gameObject == null)
		{
			_logger.LogError($"ID={actorID}的角色资源不存在");
			return;
		}
		gameObject.transform.SetParent(actorRootNode);
		PlayerAdventureActor component = gameObject.GetComponent<PlayerAdventureActor>();
		component.SyncMovementLocation(pos, posY, rot);
		component.GroupId = "STANDALONE_PLAYER_ACTOR_GROUP";
		SceneSingleton<ActorGroupManager>.Instance.AddOrGetEntityGroup(component.GroupId)?.AddMember(component);
		component.spawnPoolObj = poolObj;
		component.Born();
		component.Hide();
		callback(component);
		if (levelStatus == AdventureLevelState.LevelStart)
		{
			component.EnableLogicUpdate();
			component.Idle(isActorLevelStart: true);
		}
		AdventurActorSpawned adventurActorSpawned = AdventurActorSpawned.Generate();
		adventurActorSpawned.sender = component;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorSpawned);
	}

	public void SpawnTrap(TrapSpawnInfo spawnInfo, Action<AdventureLevelObjPoolMgr.PoolObj> callback)
	{
		int id = spawnInfo.id;
		Trap actorData = Singleton<HotfixDataController>.Instance.GetTrap(id);
		if (actorData == null || string.IsNullOrEmpty(actorData.Model))
		{
			_logger.LogError($"ID = {id} 的陷阱数据Error");
			return;
		}
		string loadPath = string.Format("{0}{1}.prefab${2}", "Assets/AssetBundles/", actorData.Model, id);
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Monster(loadPath, (AdventureLevelObjPoolMgr.PoolBase poolBase) =>
		{
			AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
			poolObj.Enabled(enable: true);
			GameObject gameObject = poolObj.gameObject;
			if (gameObject != null)
			{
				if (!actorRootNode.Equals(gameObject.transform.parent))
				{
					gameObject.transform.SetParent(actorRootNode);
				}
				TrapAdventureActor orAddComponent = gameObject.GetOrAddComponent<TrapAdventureActor>();
				orAddComponent.TrapGroupId = spawnInfo.groupId;
				orAddComponent.SyncMovementLocation(spawnInfo.position, spawnInfo.positionY, spawnInfo.rotation);
				callback?.Invoke(poolObj);
				orAddComponent.enabled = true;
				orAddComponent.LoadData(actorData, spawnInfo.isRoguelike, spawnInfo.Level);
				orAddComponent.spawnPoolObj = poolObj;
				if (levelStatus == AdventureLevelState.LevelStart)
				{
					orAddComponent.LevelStart();
				}
				else
				{
					orAddComponent.LevelStart();
					orAddComponent.DestroySelf();
				}
				AdventurActorSpawned adventurActorSpawned = AdventurActorSpawned.Generate();
				adventurActorSpawned.sender = orAddComponent;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorSpawned);
			}
		});
	}

	public void SpawnNPC(int npcID, int npcSkinID, TSVector2 pos, FP posY, FP rot, Action<NPCAdventureActor> callback)
	{
		NPCConfig nPCConfig = Singleton<HotfixDataController>.Instance.GetNPCConfig(npcID);
		if (nPCConfig == null)
		{
			_logger.LogError($"ID={npcID}的NPC数据不存在");
			return;
		}
		string text = string.Empty;
		NPCSkin nPCSkin = Singleton<HotfixDataController>.Instance.GetNPCSkin(npcSkinID);
		if (nPCSkin != null)
		{
			text = nPCSkin.Model;
		}
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		string loadPath = "Assets/AssetBundles/" + text + ".prefab";
		AdventureLevelObjPoolMgr.PoolBase poolBase = SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Player(loadPath);
		if (poolBase == null)
		{
			_logger.LogError($"ID={npcID}的NPC资源不存在");
			return;
		}
		poolBase.Enabled(enable: true);
		AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
		GameObject gameObject = poolObj.gameObject;
		if (gameObject == null)
		{
			_logger.LogError($"ID={npcID}的NPC资源不存在");
			return;
		}
		gameObject.transform.SetParent(actorRootNode);
		NPCAdventureActor orAddComponent = gameObject.GetOrAddComponent<NPCAdventureActor>();
		orAddComponent.SyncMovementLocation(pos, posY, rot);
		orAddComponent.SyncNPCInfo(nPCConfig, nPCSkin);
		orAddComponent.spawnPoolObj = poolObj;
		orAddComponent.enabled = true;
		callback(orAddComponent);
		if (levelStatus >= AdventureLevelState.LevelStart && levelStatus < AdventureLevelState.Finish)
		{
			orAddComponent.EnableLogicUpdate();
			orAddComponent.Idle(isActorLevelStart: true);
		}
	}

	public void DespawnActor<T>(T instance) where T : AdventureActor
	{
		if (instance.GroupId != null)
		{
			SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(instance.GroupId)?.RemoveMember(instance);
		}
		ObjectPoolUtils.DespawnToPool(instance.transform, "Actor");
	}

	public void PreSpawnWeapon<T>(GameObject prefab, Transform parent) where T : AdventureWeapon
	{
		SpawnWeapon<T>(prefab, parent).gameObject.SetActive(value: false);
	}

	public T SpawnWeapon<T>(GameObject prefab, Transform parent, AdventureActor owner = null) where T : AdventureWeapon
	{
		if (prefab.GetComponent<T>() == null)
		{
			_logger.LogError("创建武器/飞行物实体时，预制体上没有正确的组件");
			return null;
		}
		if (owner != null && monsterType.IsInstanceOfType(owner))
		{
			currentMonsterWeaponCount++;
		}
		GameObject gameObject = ObjectPoolUtils.SpawnGameObjectFromPool(prefab, "Weapon", autoDespawn: false);
		gameObject.transform.SetParent(parent);
		T component = gameObject.GetComponent<T>();
		component.prefab = prefab;
		return component;
	}

	public void DespawnWeapon<T>(T instance) where T : AdventureWeapon
	{
		ObjectPoolUtils.DespawnToPool(instance.transform, "Weapon");
	}

	public AdventureSkill SpawnSkill(int skillId)
	{
		string arg = "Assets/AssetBundles/" + ModuleController<AdventureModuleController>.Instance.sharedConfigureData.SkillTemplatePath + ".prefab";
		string loadPath = $"{arg}${skillId}";
		AdventureLevelObjPoolMgr.PoolBase poolBase = SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_SkillTemplate(loadPath);
		if (poolBase == null)
		{
			return null;
		}
		AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
		poolObj.Enabled(enable: true);
		GameObject gameObject = poolObj.gameObject;
		if (null == gameObject)
		{
			return null;
		}
		AdventureSkill component = gameObject.GetComponent<AdventureSkill>();
		if (null != component)
		{
			component.InitPoolOwner(poolObj);
		}
		return component;
	}

	public void DespawnSkill(AdventureSkill instance)
	{
		ObjectPoolUtils.DespawnToPool(instance.transform, "Skill");
	}

	public List<AdventureLevelTeleporter> GetTeleporters(string teleporterName, int x, int y)
	{
		List<AdventureLevelTeleporter> list = new List<AdventureLevelTeleporter>();
		int count = teleporters.Count;
		for (int i = 0; i < count; i++)
		{
			AdventureLevelTeleporter adventureLevelTeleporter = teleporters.get_Item(i);
			if (adventureLevelTeleporter.name.Equals(teleporterName) && adventureLevelTeleporter.x == x && adventureLevelTeleporter.y == y)
			{
				list.Add(adventureLevelTeleporter);
			}
		}
		return list;
	}

	public LogicEntity QueryEntityByID(long id)
	{
		if (!_entityIDCache.TryGetValue(id, out var value))
		{
			return null;
		}
		return value;
	}

	public LogicEntity QueryPlayerEntityByDataID(int dataID)
	{
		for (int i = 0; i < playerActors.Count; i++)
		{
			AdventureActor adventureActor = playerActors.get_Item(i) as AdventureActor;
			if (null != adventureActor && adventureActor.dataID == dataID)
			{
				return adventureActor;
			}
		}
		return null;
	}

	public LogicEntity QueryPlayerEntityByID(long id)
	{
		for (int i = 0; i < playerActors.Count; i++)
		{
			LogicEntity logicEntity = playerActors.get_Item(i);
			if (null != logicEntity && logicEntity.Id == id)
			{
				return logicEntity;
			}
		}
		return null;
	}

	public LogicEntity QueryMonsterEntityByID(long id)
	{
		for (int i = 0; i < monsterActors.Count; i++)
		{
			LogicEntity logicEntity = monsterActors.get_Item(i);
			if (null != logicEntity && logicEntity.Id == id)
			{
				return logicEntity;
			}
		}
		return null;
	}

	public List<LogicEntity> QueryMonsterEntitiesByDataID(int dataID)
	{
		List<LogicEntity> searchData = ILRuntimeAPI.GetSearchData();
		for (int i = 0; i < monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(i) as MonsterAdventureActor;
			if (null != monsterAdventureActor && monsterAdventureActor.dataID == dataID)
			{
				searchData.Add(monsterAdventureActor);
			}
		}
		return searchData;
	}

	public int QueryMonsterActorAliveCount(bool excludePlayerSummoned = false)
	{
		int num = 0;
		for (int i = 0; i < monsterActors.Count; i++)
		{
			if (monsterActors.get_Item(i) is MonsterAdventureActor monsterAdventureActor && (!monsterAdventureActor.IsSummoned(out var _, out var summonType) || summonType == SummonType.Minion) && (!excludePlayerSummoned || !monsterAdventureActor.IsPlayerMinion(out var _)))
			{
				ActorHealthInfo actorHealthInfo = monsterAdventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive)
				{
					num++;
				}
			}
		}
		return num;
	}

	public void HandleNavigation(GameObject root, string sceneName)
	{
		if (null == root || string.IsNullOrEmpty(sceneName))
		{
			return;
		}
		AdventureModuleConfigureData config = AdventureModuleController.Config;
		Transform transform = root.transform.Find("---- Walkable ----");
		if (null != transform)
		{
			transform.gameObject.SetActive(value: true);
			if (!sceneName.Contains("test") && !sceneName.Contains("Test") && !sceneName.Contains("prototype") && !sceneName.Contains("Prototype"))
			{
				MeshFilter[] componentsInChildren = transform.GetComponentsInChildren<MeshFilter>(includeInactive: true);
				for (int i = 0; i < componentsInChildren.Length; i++)
				{
					GameObject gameObject = componentsInChildren[i].gameObject;
					gameObject.SetActive(value: true);
					MeshCollider meshCollider = gameObject.GetComponent<MeshCollider>();
					if (meshCollider == null)
					{
						meshCollider = gameObject.AddComponent<MeshCollider>();
					}
					meshCollider.enabled = true;
					meshCollider.cookingOptions = MeshColliderCookingOptions.CookForFasterSimulation | MeshColliderCookingOptions.EnableMeshCleaning | MeshColliderCookingOptions.WeldColocatedVertices;
					MeshRenderer meshRenderer = gameObject.GetComponent<MeshRenderer>();
					if (meshRenderer == null)
					{
						meshRenderer = gameObject.AddComponent<MeshRenderer>();
					}
					meshRenderer.sharedMaterial = config.Env_NavIndicatorMaskMaterial;
					meshRenderer.enabled = true;
				}
			}
		}
		transform = root.transform.Find("---- NotWalkable ----");
		if (!(null != transform))
		{
			return;
		}
		transform.gameObject.SetActive(value: true);
		if (sceneName.Contains("test") || sceneName.Contains("Test") || sceneName.Contains("prototype") || sceneName.Contains("Prototype"))
		{
			return;
		}
		MeshFilter[] componentsInChildren2 = transform.GetComponentsInChildren<MeshFilter>(includeInactive: true);
		for (int j = 0; j < componentsInChildren2.Length; j++)
		{
			GameObject gameObject2 = componentsInChildren2[j].gameObject;
			gameObject2.SetActive(value: true);
			MeshCollider meshCollider2 = gameObject2.GetComponent<MeshCollider>();
			if (meshCollider2 == null)
			{
				meshCollider2 = gameObject2.AddComponent<MeshCollider>();
			}
			meshCollider2.enabled = true;
			meshCollider2.cookingOptions = MeshColliderCookingOptions.CookForFasterSimulation | MeshColliderCookingOptions.EnableMeshCleaning | MeshColliderCookingOptions.WeldColocatedVertices;
			MeshRenderer component = gameObject2.GetComponent<MeshRenderer>();
			if (component != null)
			{
				component.enabled = false;
			}
		}
	}

	public virtual void UpdateSpawnLogic()
	{
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			monsterSpawnWaves.get_Item(i).UpdateSpawnLogic();
		}
		for (int j = 0; j < virtualMonsterSpawnWaves.Count; j++)
		{
			virtualMonsterSpawnWaves.get_Item(j).UpdateSpawnLogic();
		}
		for (int k = 0; k < treasureBoxSpawnPoints.Count; k++)
		{
			treasureBoxSpawnPoints.get_Item(k).UpdateSpawnLogic();
		}
		for (int l = 0; l < trapGroups.Count; l++)
		{
			trapGroups.get_Item(l).UpdateSpawnLogic();
		}
	}

	public void OpenTreasureAndNpc(List<int[]> prizeList, bool showNpc)
	{
		if (dicIndexChestBoss.Count == 0)
		{
			string[] array = Singleton<GameDataController>.Instance.GetConfig("RoguelikeChestBoss").Value.Split(',');
			for (int i = 0; i < array.Length; i++)
			{
				dicIndexChestBoss.Add(i + 1, CommonHelper.ParseStringParamToInt(array[i]));
			}
			string[] array2 = Singleton<GameDataController>.Instance.GetConfig("RoguelikeChestMiniBoss").Value.Split(',');
			for (int j = 0; j < array2.Length; j++)
			{
				dicIndexChestMiniBoss.Add(j + 1, CommonHelper.ParseStringParamToInt(array2[j]));
			}
			string[] array3 = Singleton<GameDataController>.Instance.GetConfig("RoguelikeChestSpecCom").Value.Split(',');
			for (int k = 0; k < array3.Length; k++)
			{
				dicIndexChestSpecCom.Add(k + 1, CommonHelper.ParseStringParamToInt(array3[k]));
			}
		}
		if (showNpc)
		{
			if (interactiveNpc.Count > 0)
			{
				for (int l = 0; l < interactiveNpc.Count; l++)
				{
					interactiveNpc.get_Item(l).ForceActive();
				}
			}
			else
			{
				_logger.LogError("NPC刷新点不存在!!!!");
			}
		}
		tmpPrizeList = prizeList;
		isHaveBigBox = false;
		for (int m = 0; m < prizeList.Count; m++)
		{
			if (prizeList.get_Item(m)[0] != 0)
			{
				continue;
			}
			isHaveBigBox = true;
			int num = 0;
			bool flag = false;
			flag = true;
			num = dicIndexChestSpecCom.get_Item(1);
			for (int n = 0; n < treasureBoxSpawnPoints.Count; n++)
			{
				if (treasureBoxSpawnPoints.get_Item(n).boxIndex == 1)
				{
					if (flag)
					{
						ModuleController<AdventureModuleController>.Instance?.AddEventListener("TREASURE_BOX_SPAWN", OnCommonBoxSpawn);
					}
					int id = num;
					treasureBoxSpawnPoints.get_Item(n).InitTreasureInfo(id, -1);
					treasureBoxSpawnPoints.get_Item(n).boxPrizeType = 0;
					treasureBoxSpawnPoints.get_Item(n).boxThemeId = 0;
					if (flag)
					{
						treasureBoxSpawnPoints.get_Item(n).isRandomPosition = true;
						treasureBoxSpawnPoints.get_Item(n).randomCenterPos = TSVector2.zero;
						treasureBoxSpawnPoints.get_Item(n).RandomAngle = 270;
						treasureBoxSpawnPoints.get_Item(n).RandomRotation = 0;
					}
					treasureBoxSpawnPoints.get_Item(n).EnableSpawnLogic();
					if (!flag)
					{
						bigChestPos = new TSVector2(treasureBoxSpawnPoints.get_Item(n).transform.position.x, treasureBoxSpawnPoints.get_Item(n).transform.position.z);
					}
					break;
				}
			}
			if (flag)
			{
				return;
			}
		}
		OpenTreasureOther(tmpPrizeList);
	}

	private void OpenTreasureOther(List<int[]> prizeList)
	{
		bigChestPos = TSVector2.zero;
		tmpPrizeList.Clear();
	}

	private void OnCommonBoxSpawn(IEvent ievent)
	{
		AdventureTreasureBoxSpawnPosEvent adventureTreasureBoxSpawnPosEvent = (AdventureTreasureBoxSpawnPosEvent)ievent;
		bigChestPos = adventureTreasureBoxSpawnPosEvent.boxPos;
		int boxId = adventureTreasureBoxSpawnPosEvent.boxId;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TREASURE_BOX_SPAWN", OnCommonBoxSpawn);
		if (boxId == dicIndexChestSpecCom.get_Item(1))
		{
			OpenTreasureOther(tmpPrizeList);
		}
	}

	public virtual bool HasTimelinePerformance()
	{
		return false;
	}

	public virtual void PlayTimelinePerformance(Action callback = null, bool needLimitPlayTimes = true)
	{
		if (isBattleFinish)
		{
			_logger.LogError("战斗已结束，不播放timeline");
			callback?.Invoke();
			return;
		}
		PlayableDirector playableDirector = null;
		if (null != timelineNode)
		{
			Transform transform = timelineNode.Find(timelineName);
			if (null != transform)
			{
				playableDirector = transform.GetComponent<PlayableDirector>();
			}
		}
		if (null == playableDirector)
		{
			_logger.LogError("timeline为空");
			callback?.Invoke();
			return;
		}
		string text = null;
		string text2 = null;
		int day = DateTime.Now.Day;
		string text3 = $"{levelLoadParams.levelType}_{playableDirector.gameObject.name}";
		if (needLimitPlayTimes && !string.IsNullOrEmpty(text3))
		{
			text = $"{AdventureModuleHelper.playerUid}_{text3}_Day";
			text2 = $"{AdventureModuleHelper.playerUid}_{text3}_Time";
			if (((PlayerPrefs.GetInt(text, 0) == day && PlayerPrefs.GetInt(text2, 0) != 0) ? 1 : 0) > (false ? 1 : 0))
			{
				_logger.LogInfo("褰撴棩宸叉挱鏀捐繃璇\ue65aimeline,TimelineKey:" + text3 + ",Timeline:" + playableDirector.name);
				callback?.Invoke();
				return;
			}
		}
		SceneSingleton<PerformManager>.Instance.PlayTimelinePerform(playableDirector.gameObject, (bool success) =>
		{
			callback?.Invoke();
		});
		if (!string.IsNullOrEmpty(text) && !string.IsNullOrEmpty(text2))
		{
			PlayerPrefs.SetInt(text, day);
			PlayerPrefs.SetInt(text2, 1);
		}
	}

	public void InitRoomEffects()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		if (roomRuleInfos == null)
		{
			roomRuleInfos = new List<RoomRuleInfo>();
		}
		else
		{
			roomRuleInfos.Clear();
		}
	}

	public void RefreshRoomRules(List<int> roomRules)
	{
		if (roomRules != null && roomRules.Count != 0)
		{
			for (int i = 0; i < roomRules.Count; i++)
			{
				AddRoomRule(roomRules.get_Item(i));
			}
		}
	}

	public void AddRoomRule(int roomRule, AdventureActor fromActor = null)
	{
		FloorBuff floorBuff = Singleton<HotfixDataController>.Instance.GetFloorBuff(roomRule);
		if (floorBuff == null)
		{
			Debug.LogError($"房间buff报错为空：{roomRule}");
			return;
		}
		RoomRuleInfo roomRuleInfo = new RoomRuleInfo();
		roomRuleInfo.id = floorBuff.Id;
		roomRuleInfo.camps = floorBuff.AddCamp.ToArray();
		roomRuleInfo.fromActor = fromActor;
		List<HotfixEnum.monsterEpicType> list = new List<HotfixEnum.monsterEpicType>();
		foreach (int item in floorBuff.AddClass)
		{
			list.Add((HotfixEnum.monsterEpicType)item);
		}
		roomRuleInfo.epics = list.ToArray();
		List<AddEffectInfo> list2 = new List<AddEffectInfo>();
		foreach (int item2 in floorBuff.EffectId)
		{
			list2.Add(new AddEffectInfo(item2, -1, 0L));
		}
		roomRuleInfo.effectInfos = list2;
		roomRuleInfo.buffIDs = floorBuff.BuffId.ToList();
		roomRuleInfos.Add(roomRuleInfo);
		RefreshEntitiesRoomRule(roomRuleInfo, isAddOrRemove: true);
	}

	public void RemoveRoomRule(int roomRule)
	{
		if (roomRuleInfos == null || roomRuleInfos.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < roomRuleInfos.Count; i++)
		{
			RoomRuleInfo roomRuleInfo = roomRuleInfos.get_Item(i);
			if (roomRuleInfo.id == roomRule)
			{
				RefreshEntitiesRoomRule(roomRuleInfo, isAddOrRemove: false);
				roomRuleInfos.RemoveAt(i);
				break;
			}
		}
	}

	public void RefreshEntitiesRoomRule(RoomRuleInfo rule, bool isAddOrRemove)
	{
		int[] camps = rule.camps;
		if (camps == null || camps.Length == 0)
		{
			_logger.LogError($"要移除的房间规则指定阵营为空!{rule.id}");
			return;
		}
		List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.playerActors;
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				AdventureActor adventureActor = list.get_Item(i) as AdventureActor;
				if (!adventureActor.isDead)
				{
					OnEntityAddOrRemove(rule, adventureActor, isAddOrRemove);
				}
			}
		}
		list = ModuleController<AdventureModuleController>.Instance.monsterActors;
		if (list != null)
		{
			for (int j = 0; j < list.Count; j++)
			{
				MonsterAdventureActor monsterAdventureActor = list.get_Item(j) as MonsterAdventureActor;
				if (!monsterAdventureActor.isDead && (monsterAdventureActor.monsterSummonInfo == null || !(null != monsterAdventureActor.monsterSummonInfo.SummonActor) || !(monsterAdventureActor.monsterSummonInfo.SummonActor is PlayerAdventureActor)))
				{
					ActorInfo actorInfo = monsterAdventureActor.actorInfo;
					HotfixEnum.monsterEpicType epic = ((actorInfo != null) ? monsterAdventureActor.monsterInfo.epicType : ((HotfixEnum.monsterEpicType)0));
					if (rule.IsEpicSatis(epic))
					{
						OnEntityAddOrRemove(rule, monsterAdventureActor, addOrRemove: true);
					}
				}
			}
		}
		list = ModuleController<AdventureModuleController>.Instance.traps;
		if (list == null)
		{
			return;
		}
		for (int k = 0; k < list.Count; k++)
		{
			AdventureActor adventureActor2 = list.get_Item(k) as AdventureActor;
			if (!adventureActor2.isDead)
			{
				OnEntityAddOrRemove(rule, adventureActor2, isAddOrRemove);
			}
		}
	}

	private void OnActorSpawned(IEvent ievent)
	{
		if (roomRuleInfos == null || roomRuleInfos.Count == 0)
		{
			return;
		}
		AdventurActorSpawned adventurActorSpawned = (AdventurActorSpawned)ievent;
		if (adventurActorSpawned == null)
		{
			return;
		}
		AdventureActor adventureActor = adventurActorSpawned.sender as AdventureActor;
		if (adventureActor is MonsterAdventureActor)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActor as MonsterAdventureActor;
			for (int i = 0; i < roomRuleInfos.Count; i++)
			{
				RoomRuleInfo roomRuleInfo = roomRuleInfos.get_Item(i);
				if (monsterAdventureActor.monsterSummonInfo == null || !(null != monsterAdventureActor.monsterSummonInfo.SummonActor) || !(monsterAdventureActor.monsterSummonInfo.SummonActor is PlayerAdventureActor))
				{
					ActorInfo actorInfo = adventureActor.actorInfo;
					HotfixEnum.monsterEpicType epic = ((actorInfo != null) ? monsterAdventureActor.monsterInfo.epicType : ((HotfixEnum.monsterEpicType)0));
					if (roomRuleInfo.IsEpicSatis(epic))
					{
						OnEntityAddOrRemove(roomRuleInfo, adventureActor, addOrRemove: true);
					}
				}
			}
		}
		else if (adventureActor is PlayerAdventureActor)
		{
			for (int j = 0; j < roomRuleInfos.Count; j++)
			{
				OnEntityAddOrRemove(roomRuleInfos.get_Item(j), adventureActor, addOrRemove: true);
			}
		}
		else if (adventureActor is TrapAdventureActor)
		{
			for (int k = 0; k < roomRuleInfos.Count; k++)
			{
				OnEntityAddOrRemove(roomRuleInfos.get_Item(k), adventureActor, addOrRemove: true);
			}
		}
	}

	private void OnEntityAddOrRemove(RoomRuleInfo ruleInfo, AdventureActor actor, bool addOrRemove)
	{
		if (ruleInfo.IsCampSatis(actor.actorInfo.factionID))
		{
			if (addOrRemove)
			{
				EntityAddEffect(actor, ruleInfo.effectInfos, ruleInfo.buffIDs, ruleInfo.fromActor);
			}
			else
			{
				EntityRemoveEffect(actor, ruleInfo.effectInfos, ruleInfo.buffIDs);
			}
		}
	}

	private void EntityAddEffect(AdventureActor actor, List<AddEffectInfo> addEffectInfos, List<int> addBuffs, AdventureActor from = null)
	{
		actor.effectManage?.AddEffectByTalent(addEffectInfos);
		actor.buffComponent?.AddBuffs(addBuffs, (from != null) ? from : actor);
	}

	private void EntityRemoveEffect(AdventureActor actor, List<AddEffectInfo> removeEffectInfos, List<int> removeBuffs)
	{
		actor.effectManage?.RemoveEffectByTalent(removeEffectInfos.Select((AddEffectInfo t) => t.effectId).ToList());
		actor.buffComponent?.RemoveBuffs(removeBuffs);
	}

	public void ClearRoomEffects()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
	}

	public virtual void InitSpawnPoints()
	{
		entities.Sort(_objectOrderByLocationComparer);
	}

	public virtual void HandleSpawnGizmos()
	{
		MonsterSpawnWaveGizmo[] array = UnityEngine.Object.FindObjectsOfType<MonsterSpawnWaveGizmo>();
		foreach (MonsterSpawnWaveGizmo monsterSpawnWaveGizmo in array)
		{
			if (monsterSpawnWaveGizmo.isActiveAndEnabled)
			{
				monsterSpawnWaves.Add(monsterSpawnWaveGizmo);
			}
		}
		VirtualMonsterSpawnWaveGizmo[] array2 = UnityEngine.Object.FindObjectsOfType<VirtualMonsterSpawnWaveGizmo>();
		foreach (VirtualMonsterSpawnWaveGizmo virtualMonsterSpawnWaveGizmo in array2)
		{
			if (virtualMonsterSpawnWaveGizmo.isActiveAndEnabled)
			{
				virtualMonsterSpawnWaves.Add(virtualMonsterSpawnWaveGizmo);
			}
		}
		TrapSpawnGroupGizmo[] array3 = UnityEngine.Object.FindObjectsOfType<TrapSpawnGroupGizmo>();
		foreach (TrapSpawnGroupGizmo trapSpawnGroupGizmo in array3)
		{
			if (trapSpawnGroupGizmo.isActiveAndEnabled)
			{
				trapGroups.Add(trapSpawnGroupGizmo);
			}
		}
		NPCSpawnPointGizmo[] array4 = UnityEngine.Object.FindObjectsOfType<NPCSpawnPointGizmo>();
		foreach (NPCSpawnPointGizmo nPCSpawnPointGizmo in array4)
		{
			if (nPCSpawnPointGizmo.isActiveAndEnabled)
			{
				npcSpawnPoints.Add(nPCSpawnPointGizmo);
			}
		}
		monsterSpawnWaves.Sort();
		virtualMonsterSpawnWaves.Sort();
		trapGroups.Sort();
		npcSpawnPoints.Sort();
		for (int m = 0; m < npcSpawnPoints.Count; m++)
		{
			NPCSpawnPointGizmo nPCSpawnPointGizmo2 = npcSpawnPoints.get_Item(m);
			if (nPCSpawnPointGizmo2.npcType == NPCSpawnPointGizmo.SpawnNPCType.IDNpc)
			{
				nPCSpawnPointGizmo2.EnableSpawnLogic();
				nPCSpawnPointGizmo2.ExecuteSpawnLogic();
			}
		}
	}

	public void DeActiveVirtualMonsterSpawnWaves()
	{
		if (monsterSpawnWaves != null)
		{
			for (int i = 0; i < monsterSpawnWaves.Count; i++)
			{
				monsterSpawnWaves.get_Item(i).gameObject.SetActive(value: false);
			}
			monsterSpawnWaves.Clear();
		}
	}

	public void ActiveVirtualMonsterSpawnWave(string virtualSpawnWaveID, AdventureActor summoner = null)
	{
		for (int i = 0; i < virtualMonsterSpawnWaves.Count; i++)
		{
			VirtualMonsterSpawnWaveGizmo virtualMonsterSpawnWaveGizmo = virtualMonsterSpawnWaves.get_Item(i);
			if (virtualMonsterSpawnWaveGizmo.id == virtualSpawnWaveID)
			{
				if (virtualMonsterSpawnWaveGizmo.isSpawnActived)
				{
					Debug.LogWarning("虚拟怪物生成批次[" + virtualSpawnWaveID + "]重复激活");
				}
				virtualMonsterSpawnWaveGizmo.EnableSpawnLogic();
				virtualMonsterSpawnWaveGizmo.ExecuteSpawnLogic(summoner);
				return;
			}
		}
		Debug.LogError("虚拟怪物生成批次[" + virtualSpawnWaveID + "]不存在");
	}

	protected virtual void HandleTreasureBoxSpawnPoints()
	{
	}

	public virtual void ClearSpawnPoints()
	{
		isMonsterCleared = false;
		if (monsterSpawnWaves != null)
		{
			for (int i = 0; i < monsterSpawnWaves.Count; i++)
			{
				monsterSpawnWaves.get_Item(i).gameObject.SetActive(value: false);
			}
			monsterSpawnWaves.Clear();
		}
		if (virtualMonsterSpawnWaves != null)
		{
			for (int j = 0; j < virtualMonsterSpawnWaves.Count; j++)
			{
				virtualMonsterSpawnWaves.get_Item(j).gameObject.SetActive(value: false);
			}
			virtualMonsterSpawnWaves.Clear();
		}
		if (treasureBoxSpawnPoints != null)
		{
			for (int k = 0; k < treasureBoxSpawnPoints.Count; k++)
			{
				treasureBoxSpawnPoints.get_Item(k).gameObject.SetActive(value: false);
			}
			treasureBoxSpawnPoints.Clear();
		}
		if (trapGroups != null)
		{
			for (int l = 0; l < trapGroups.Count; l++)
			{
				trapGroups.get_Item(l).gameObject.SetActive(value: false);
			}
			trapGroups.Clear();
		}
		if (npcSpawnPoints != null)
		{
			for (int m = 0; m < npcSpawnPoints.Count; m++)
			{
				npcSpawnPoints.get_Item(m).gameObject.SetActive(value: false);
			}
			npcSpawnPoints.Clear();
		}
	}

	public bool IsSpawnWaveCleared(string waveName)
	{
		if (monsterSpawnWaves == null || monsterSpawnWaves.Count == 0)
		{
			return true;
		}
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			if (monsterSpawnWaves.get_Item(i).name.Equals(waveName))
			{
				return monsterSpawnWaves.get_Item(i).IsAllActivedAndDied();
			}
		}
		return false;
	}

	public virtual List<NPCSpawnPointGizmo> GetNPCs(HotfixEnum.npcNewType npcType)
	{
		if (npcSpawnPoints == null)
		{
			return null;
		}
		if (npcType == HotfixEnum.npcNewType.Narrate)
		{
			return npcSpawnPoints.Where((NPCSpawnPointGizmo a) => !a.isSpawnActived && a.npcType == NPCSpawnPointGizmo.SpawnNPCType.TalkNpc).ToList();
		}
		return npcSpawnPoints.Where((NPCSpawnPointGizmo a) => !a.isSpawnActived && a.npcType == NPCSpawnPointGizmo.SpawnNPCType.RandomNpc).ToList();
	}

	public virtual List<BaseSpawnPointGizmo> GetWaves(string waveName, int x = -1, int y = -1)
	{
		if (monsterSpawnWaves == null)
		{
			return null;
		}
		List<BaseSpawnPointGizmo> list = new List<BaseSpawnPointGizmo>();
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = monsterSpawnWaves.get_Item(i);
			if (monsterSpawnWaveGizmo.name.Equals(waveName))
			{
				list.Add(monsterSpawnWaveGizmo);
			}
		}
		return list;
	}

	public virtual List<BaseSpawnPointGizmo> GetPlans(string planName, int x = -1, int y = -1)
	{
		if (monsterSpawnWaves == null)
		{
			return null;
		}
		List<BaseSpawnPointGizmo> list = new List<BaseSpawnPointGizmo>();
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			List<BaseSpawnPointGizmo> childrenGizmos = monsterSpawnWaves.get_Item(i).childrenGizmos;
			if (childrenGizmos == null)
			{
				continue;
			}
			for (int j = 0; j < childrenGizmos.Count; j++)
			{
				BaseSpawnPointGizmo baseSpawnPointGizmo = childrenGizmos.get_Item(j);
				if (baseSpawnPointGizmo.name.Equals(planName))
				{
					list.Add(baseSpawnPointGizmo);
				}
			}
		}
		return list;
	}

	public virtual List<BaseSpawnPointGizmo> GetGroups(string groupName, int x = -1, int y = -1)
	{
		if (monsterSpawnWaves == null)
		{
			return null;
		}
		List<BaseSpawnPointGizmo> result = new List<BaseSpawnPointGizmo>();
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			List<BaseSpawnPointGizmo> childrenGizmos = monsterSpawnWaves.get_Item(i).childrenGizmos;
			if (childrenGizmos == null)
			{
				continue;
			}
			for (int j = 0; j < childrenGizmos.Count; j++)
			{
				List<BaseSpawnPointGizmo> childrenGizmos2 = childrenGizmos.get_Item(j).childrenGizmos;
				if (childrenGizmos2 == null)
				{
					continue;
				}
				for (int k = 0; k < childrenGizmos2.Count; k++)
				{
					BaseSpawnPointGizmo baseSpawnPointGizmo = childrenGizmos2.get_Item(k);
					if (baseSpawnPointGizmo.name.Equals(groupName))
					{
						childrenGizmos2.Add(baseSpawnPointGizmo);
					}
				}
			}
		}
		return result;
	}

	public List<BaseSpawnPointGizmo> GetTreasureBoxs(string boxName, int x = -1, int y = -1)
	{
		List<BaseSpawnPointGizmo> list = new List<BaseSpawnPointGizmo>();
		int count = treasureBoxSpawnPoints.Count;
		for (int i = 0; i < count; i++)
		{
			TreasureBoxSpawnPoint treasureBoxSpawnPoint = treasureBoxSpawnPoints.get_Item(i);
			if (treasureBoxSpawnPoint.name.Equals(boxName) && treasureBoxSpawnPoint.x == x && treasureBoxSpawnPoint.y == y)
			{
				list.Add(treasureBoxSpawnPoint);
			}
		}
		return list;
	}

	public List<AdventureLevelTeleporter> GetTeleporters()
	{
		return teleporters;
	}

	public virtual void BossSummonMonster()
	{
	}

	public virtual List<Vector3> BossSummonMonsterPoint(long bossEntityId, float innerRadius, float outsideRadius, int summonMonsterID, int summonCount)
	{
		return null;
	}

	public void InitTriggerGizmos()
	{
		AdventureTriggerGizmo[] array = UnityEngine.Object.FindObjectsOfType<AdventureTriggerGizmo>();
		foreach (AdventureTriggerGizmo adventureTriggerGizmo in array)
		{
			if (adventureTriggerGizmo.isActiveAndEnabled)
			{
				triggerGizmos.Add(adventureTriggerGizmo);
			}
		}
		triggerGizmos.Sort(objectOrderByLocationComparer);
		for (int j = 0; j < triggerGizmos.Count; j++)
		{
			triggerGizmos.get_Item(j).Initialize();
		}
	}

	public void ReleaseTriggerGizmos()
	{
		for (int i = 0; i < triggerGizmos.Count; i++)
		{
			triggerGizmos.get_Item(i).Release();
		}
		triggerGizmos.Clear();
	}

	public bool ActiveInteractableEventTrigger(string triggerName, Action onComplete)
	{
		if (null != activedInteractableEventTriggerGizmo)
		{
			_logger.LogInfo("可交互事件触发器\"" + activedInteractableEventTriggerGizmo.gameObject.name + "\"正在执行中，不能开始执行新的触发器\"" + triggerName + "\"");
			return false;
		}
		for (int i = 0; i < triggerGizmos.Count; i++)
		{
			AdventureTriggerGizmo adventureTriggerGizmo = triggerGizmos.get_Item(i);
			if (null != adventureTriggerGizmo && adventureTriggerGizmo is AdventureInteractableEventTriggerGizmo adventureInteractableEventTriggerGizmo && adventureInteractableEventTriggerGizmo.triggerName == triggerName)
			{
				return adventureInteractableEventTriggerGizmo.Active(uniqueness: true, onComplete);
			}
		}
		return false;
	}

	public bool ActiveAllInteractableEventTriggers(string triggerName)
	{
		bool result = false;
		for (int i = 0; i < triggerGizmos.Count; i++)
		{
			AdventureTriggerGizmo adventureTriggerGizmo = triggerGizmos.get_Item(i);
			if (null != adventureTriggerGizmo && adventureTriggerGizmo is AdventureInteractableEventTriggerGizmo adventureInteractableEventTriggerGizmo && adventureInteractableEventTriggerGizmo.triggerName == triggerName)
			{
				adventureInteractableEventTriggerGizmo.Active(uniqueness: false);
				result = true;
			}
		}
		return result;
	}

	public bool ExecuteInteractableEventTrigger(AdventureInteractableEventTriggerGizmo trigger, bool uniqueness, Action onComplete)
	{
		if (uniqueness)
		{
			if (null != activedInteractableEventTriggerGizmo)
			{
				_logger.LogError("可交互事件触发器\"" + activedInteractableEventTriggerGizmo.gameObject.name + "\"正在执行中，不能开始执行新的触发器");
				return false;
			}
			activedInteractableEventTriggerGizmo = trigger;
		}
		StartCoroutine(ExecuteInteractableEventTriggerCoroutine(trigger, uniqueness, onComplete));
		return true;
	}

	protected IEnumerator ExecuteInteractableEventTriggerCoroutine(AdventureInteractableEventTriggerGizmo trigger, bool uniqueness, Action onComplete)
	{
		if (uniqueness)
		{
			activedInteractableEventTriggerGizmo = null;
		}
		onComplete?.Invoke();
		yield break;
	}

	public void SetCurCameraTriggerGizmo(AdventurePlayerCameraTriggerGizmo adventurePlayerCameraTriggerGizmo)
	{
		Debug.Log("SetCurCameraTriggerGizmo===>" + adventurePlayerCameraTriggerGizmo.name);
		curCameraTriggerGizmo = adventurePlayerCameraTriggerGizmo;
	}

	public bool ActivePlayerCameraTrigger(string triggerName)
	{
		for (int i = 0; i < triggerGizmos.Count; i++)
		{
			AdventureTriggerGizmo adventureTriggerGizmo = triggerGizmos.get_Item(i);
			if (!(null != adventureTriggerGizmo) || !(adventureTriggerGizmo is AdventurePlayerCameraTriggerGizmo adventurePlayerCameraTriggerGizmo) || !(adventurePlayerCameraTriggerGizmo.triggerName == triggerName))
			{
				continue;
			}
			if (curCameraTriggerGizmo != null)
			{
				if (curCameraTriggerGizmo.canInterrupt && adventurePlayerCameraTriggerGizmo.priority >= curCameraTriggerGizmo.priority)
				{
					adventurePlayerCameraTriggerGizmo.Active();
					curCameraTriggerGizmo = adventurePlayerCameraTriggerGizmo;
				}
			}
			else
			{
				adventurePlayerCameraTriggerGizmo.Active();
				curCameraTriggerGizmo = adventurePlayerCameraTriggerGizmo;
			}
			return true;
		}
		return false;
	}

	public bool DeactivePlayerCameraTrigger(string triggerName)
	{
		for (int i = 0; i < triggerGizmos.Count; i++)
		{
			AdventureTriggerGizmo adventureTriggerGizmo = triggerGizmos.get_Item(i);
			if (null != adventureTriggerGizmo && adventureTriggerGizmo is AdventurePlayerCameraTriggerGizmo adventurePlayerCameraTriggerGizmo && adventurePlayerCameraTriggerGizmo.triggerName == triggerName)
			{
				adventurePlayerCameraTriggerGizmo.Deactive();
				if (curCameraTriggerGizmo != null && !curCameraTriggerGizmo.IsInTrigger)
				{
					curCameraTriggerGizmo = null;
				}
				return true;
			}
		}
		return false;
	}

	public virtual void PauseTimeLine(bool isPause)
	{
	}

	public virtual void StopTimeLine()
	{
	}

	public virtual void LevelStart_CheckBattleStartMsgTrigger()
	{
		if (!hasBattleStartMsgTrigger)
		{
			AdventureMsgBattleStartEvent aEvent = AdventureMsgBattleStartEvent.Generate();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		}
	}

	protected virtual void MonsterCleared_CheckBattleFinishMsgTrigger()
	{
		if (!hasBattleFinishMsgTrigger)
		{
			AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		}
	}

	protected void OnChangeLevelState(IEvent evt)
	{
		if (evt == null || !(evt is AdventureChangeLevelStateEvent))
		{
			_logger.LogError("空消息包");
			return;
		}
		AdventureChangeLevelStateEvent adventureChangeLevelStateEvent = (AdventureChangeLevelStateEvent)evt;
		if (adventureChangeLevelStateEvent.levelState == HotfixEnum.levelState.Success || adventureChangeLevelStateEvent.levelState == HotfixEnum.levelState.Teleporter)
		{
			isMonsterCleared = true;
			LevelSuccess();
		}
		if (adventureChangeLevelStateEvent.clearMonster)
		{
			KillAllMonsters();
		}
		SendMonsterCleardEvent();
		ClearMonsterGizmos();
	}

	protected void OnLevelTeleporterTriggered(IEvent evt)
	{
		object data = ((GeneralEvent)evt).data;
		if (data != null)
		{
			nextLevelData = (AdventureLevelTeleporter.NextLevelData)data;
		}
		OnLevelTeleporterTriggered(nextLevelData);
	}

	protected void OnLevelTeleporterTriggered(AdventureLevelTeleporter.NextLevelData data)
	{
		HotfixEnum.levelState levelState = HotfixEnum.levelState.Success;
		levelState = (data.enterSettlementState ? ((!data.levelSuccess) ? HotfixEnum.levelState.Failed : HotfixEnum.levelState.Success) : HotfixEnum.levelState.Teleporter);
		LevelStateChanged(levelState, 1, data.fadeTime, data.videoName);
	}

	public void LevelStateChanged(HotfixEnum.levelState result, int doorIdx = 0, float fadeTime = 0f, string vName = "")
	{
		levelStatus = AdventureLevelState.BattleEnd;
		_logger.LogInfo($"关卡状态改变：{result}");
		if (result == HotfixEnum.levelState.Success && doorIdx > 0)
		{
			CurLevelStateChanged(result, 0f, vName);
			return;
		}
		MonoSingleton<ClientManager>.Instance.EnableInputBlock();
		StartCoroutine(DelayLevelStateChanged(result, fadeTime));
	}

	protected IEnumerator DelayLevelStateChanged(HotfixEnum.levelState result, float fadeTIme = 0f)
	{
		Config config = result switch
		{
			HotfixEnum.levelState.Success => Singleton<GameDataController>.Instance.GetConfig("LevelSuccessDelay"), 
			HotfixEnum.levelState.Failed => Singleton<GameDataController>.Instance.GetConfig("LevelDefeatDelay"), 
			HotfixEnum.levelState.Teleporter => Singleton<GameDataController>.Instance.GetConfig("LevelTeleporterDelay"), 
			_ => throw new ArgumentOutOfRangeException("result", result, null), 
		};
		if (config != null)
		{
			CommonHelper.TryParseStringParamToFloat(config.Value, out var floatValue);
			yield return new WaitForSecondsRealtime(floatValue);
		}
		CurLevelStateChanged(result, fadeTIme);
	}

	protected virtual void CurLevelStateChanged(HotfixEnum.levelState result, float fadeTime = 0f, string videoName = "")
	{
		MonoSingleton<ClientManager>.Instance.DisableInputBlock();
		_logger.LogInfo($"关卡状态改变{result},通知lua");
		MonoSingleton<LuaManager>.Instance.FireEvent("LevelStateChanged", (int)result, fadeTime, videoName);
	}

	protected void CheckLevelStatus()
	{
		if (levelStatus != AdventureLevelState.Finish && levelStatus != AdventureLevelState.LevelEnd && levelStatus != AdventureLevelState.BattleEnd && !isMonsterCleared)
		{
			CheckLevelEntitiesStatus();
			isMonsterCleared = IsLevelComplete();
			if (isMonsterCleared)
			{
				isMonsterCleared = CheckMonsterCleard();
			}
			if (isMonsterCleared)
			{
				DestroySurviveQuitSettmentMonsters();
				SendMonsterCleardEvent();
			}
		}
	}

	protected void DestroySurviveQuitSettmentMonsters()
	{
		if (monsterActors == null || monsterActors.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(i) as MonsterAdventureActor;
			if (monsterAdventureActor.monsterInfo.subType == HotfixEnum.monsterSubType.Monster && monsterAdventureActor.state != ActorState.Clear && !monsterAdventureActor.isDeclareDead && (monsterAdventureActor.monsterSummonInfo == null || !(null != monsterAdventureActor.monsterSummonInfo.SummonActor) || !(monsterAdventureActor.monsterSummonInfo.SummonActor is PlayerAdventureActor)) && monsterAdventureActor.spawnerInfo != null && monsterAdventureActor.spawnerInfo.quitSettlement)
			{
				monsterAdventureActor.DestroySelf();
			}
		}
	}

	protected bool CheckMonsterCleard()
	{
		if (monsterActors != null && monsterActors.Count > 0)
		{
			for (int i = 0; i < monsterActors.Count; i++)
			{
				MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(i) as MonsterAdventureActor;
				if (monsterAdventureActor.monsterInfo.subType == HotfixEnum.monsterSubType.Monster && monsterAdventureActor.state != ActorState.Clear && !monsterAdventureActor.isDeclareDead && (monsterAdventureActor.monsterSummonInfo == null || !(null != monsterAdventureActor.monsterSummonInfo.SummonActor) || !(monsterAdventureActor.monsterSummonInfo.SummonActor is PlayerAdventureActor)) && (monsterAdventureActor.spawnerInfo == null || !monsterAdventureActor.spawnerInfo.quitSettlement))
				{
					return false;
				}
			}
		}
		return true;
	}

	protected virtual void ClearMonsterGizmos()
	{
		monsterSpawnWaves?.Clear();
	}

	protected virtual bool IsEmptyLevel()
	{
		if (monsterSpawnWaves != null)
		{
			return monsterSpawnWaves.Count == 0;
		}
		return true;
	}

	private void SendMonsterCleardEvent()
	{
		if (hasSendMonsterClearEvt)
		{
			return;
		}
		hasSendMonsterClearEvt = true;
		_logger.LogInfo("怪物清除");
		if (this is StarTowerLevelController)
		{
			StarTowerLevelController starTowerLevelController = this as StarTowerLevelController;
			starTowerLevelController.FinalDrop();
			if (levelLoadParams.gmOrderLevel)
			{
				starTowerLevelController.ActiveLevelTeleporters(isActive: true);
			}
		}
		AdventureLevelMonsterClearedEvent adventureLevelMonsterClearedEvent = AdventureLevelMonsterClearedEvent.Generate();
		adventureLevelMonsterClearedEvent.isEmptyLevel = IsEmptyLevel();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelMonsterClearedEvent);
		MonoSingleton<LuaManager>.Instance.FireEvent(adventureLevelMonsterClearedEvent.type);
		if (!isViewSceneMode && null != SceneSingleton<AdventurePlayerController>.Instance && null != SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor)
		{
			MonoSingleton<WwiseAudioManager>.Instance?.WwiseVoice_Play(SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.dataID, "clear");
		}
		if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.StarTower && !ModuleController<AdventureModuleController>.Instance.levelLoadParams.isStarTowerPrologue && levelLoadParams.starTowerStage != null)
		{
			HotfixEnum.starTowerRoomType roomType = (HotfixEnum.starTowerRoomType)levelLoadParams.starTowerStage.RoomType;
			if (roomType != HotfixEnum.starTowerRoomType.ShopRoom && roomType != HotfixEnum.starTowerRoomType.EventRoom)
			{
				MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("special_effect_slowmotion");
			}
		}
		MonsterCleared_CheckBattleFinishMsgTrigger();
	}

	public virtual void CheckLevelEntitiesStatus()
	{
		AdventureLevelState adventureLevelState = _levelStatus;
		if (adventureLevelState == AdventureLevelState.BattleEnd || adventureLevelState == AdventureLevelState.LevelEnd || adventureLevelState == AdventureLevelState.Finish || isMonsterCleared)
		{
			return;
		}
		if (monsterSpawnWaves != null)
		{
			for (int i = 0; i < monsterSpawnWaves.Count; i++)
			{
				MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = monsterSpawnWaves.get_Item(i);
				if (monsterSpawnWaveGizmo.IsAllActived() && !monsterSpawnWaveGizmo.hasSendActivedEvent)
				{
					AdventureLevelRoomWaveMonsterActivedEvent adventureLevelRoomWaveMonsterActivedEvent = AdventureLevelRoomWaveMonsterActivedEvent.Generate();
					adventureLevelRoomWaveMonsterActivedEvent.x = -1;
					adventureLevelRoomWaveMonsterActivedEvent.y = -1;
					adventureLevelRoomWaveMonsterActivedEvent.wave = monsterSpawnWaveGizmo.name;
					monsterSpawnWaveGizmo.hasSendActivedEvent = true;
					_logger.LogInfo("波次" + monsterSpawnWaveGizmo.name + "全部激活");
					adventureLevelRoomWaveMonsterActivedEvent.isFinalWave = true;
					for (int j = 0; j < monsterSpawnWaves.Count; j++)
					{
						if (!monsterSpawnWaves.get_Item(j).IsAllActived())
						{
							adventureLevelRoomWaveMonsterActivedEvent.isFinalWave = false;
						}
					}
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelRoomWaveMonsterActivedEvent);
				}
				if (monsterSpawnWaveGizmo.IsAllActivedAndDied() && !monsterSpawnWaveGizmo.hasSendClearedEvent)
				{
					AdventureLevelRoomWaveMonsterClearedEvent adventureLevelRoomWaveMonsterClearedEvent = AdventureLevelRoomWaveMonsterClearedEvent.Generate();
					adventureLevelRoomWaveMonsterClearedEvent.x = -1;
					adventureLevelRoomWaveMonsterClearedEvent.y = -1;
					adventureLevelRoomWaveMonsterClearedEvent.wave = monsterSpawnWaveGizmo.name;
					monsterSpawnWaveGizmo.hasSendClearedEvent = true;
					adventureLevelRoomWaveMonsterClearedEvent.isFinalWave = true;
					for (int k = 0; k < monsterSpawnWaves.Count; k++)
					{
						if (!monsterSpawnWaves.get_Item(k).IsAllActivedAndDied())
						{
							adventureLevelRoomWaveMonsterClearedEvent.isFinalWave = false;
						}
					}
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelRoomWaveMonsterClearedEvent);
					_logger.LogInfo("波次" + monsterSpawnWaveGizmo.name + "全灭");
				}
				if (!monsterSpawnWaveGizmo.IsAllActivedAndDied_NoSummons() || monsterSpawnWaveGizmo.hasSendClearedEventNoSummons)
				{
					continue;
				}
				AdventureLevelRoomWaveMonsterClearedNoSummonsEvent adventureLevelRoomWaveMonsterClearedNoSummonsEvent = AdventureLevelRoomWaveMonsterClearedNoSummonsEvent.Generate();
				adventureLevelRoomWaveMonsterClearedNoSummonsEvent.x = -1;
				adventureLevelRoomWaveMonsterClearedNoSummonsEvent.y = -1;
				adventureLevelRoomWaveMonsterClearedNoSummonsEvent.wave = monsterSpawnWaveGizmo.name;
				monsterSpawnWaveGizmo.hasSendClearedEventNoSummons = true;
				adventureLevelRoomWaveMonsterClearedNoSummonsEvent.isFinalWave = true;
				for (int l = 0; l < monsterSpawnWaves.Count; l++)
				{
					if (!monsterSpawnWaves.get_Item(l).IsAllActivedAndDied_NoSummons())
					{
						adventureLevelRoomWaveMonsterClearedNoSummonsEvent.isFinalWave = false;
					}
				}
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelRoomWaveMonsterClearedNoSummonsEvent);
				_logger.LogInfo("波次" + monsterSpawnWaveGizmo.name + "全灭");
			}
			for (int m = 0; m < monsterSpawnWaves.Count; m++)
			{
				if (!monsterSpawnWaves.get_Item(m).IsAllActivedAndDied())
				{
					isMonsterCleared = false;
					return;
				}
			}
		}
		isMonsterCleared = true;
		MonsterCleared();
	}

	protected virtual void MonsterCleared()
	{
	}

	protected virtual void LevelSuccess()
	{
	}

	public virtual void SetMonsterGizmoAllActivedAndDied()
	{
		if (monsterSpawnWaves != null)
		{
			for (int i = 0; i < monsterSpawnWaves.Count; i++)
			{
				monsterSpawnWaves.get_Item(i).SetAllActiveAndDied();
			}
		}
	}

	private void SetupVisualControllerOnLevelLoaded()
	{
		_allAnimatorsInScene = UnityEngine.Object.FindObjectsByType<Animator>(FindObjectsInactive.Include, FindObjectsSortMode.None);
		_allParticlesInScene = UnityEngine.Object.FindObjectsByType<ParticleSystem>(FindObjectsInactive.Include, FindObjectsSortMode.None);
		_allTimelinesInScene = UnityEngine.Object.FindObjectsByType<PlayableDirector>(FindObjectsInactive.Include, FindObjectsSortMode.None);
	}

	public void SetSceneObjectsIndependentUpdate(bool value)
	{
		for (int i = 0; i < _allAnimatorsInScene.Length; i++)
		{
			Animator animator = _allAnimatorsInScene[i];
			if (animator != null && (animator.gameObject.layer == 0 || animator.gameObject.layer == 18))
			{
				animator.updateMode = (value ? AnimatorUpdateMode.UnscaledTime : AnimatorUpdateMode.Normal);
			}
		}
		for (int j = 0; j < _allParticlesInScene.Length; j++)
		{
			ParticleSystem particleSystem = _allParticlesInScene[j];
			if (particleSystem != null && (particleSystem.gameObject.layer == 0 || particleSystem.gameObject.layer == 18))
			{
				ParticleSystem.MainModule main = particleSystem.main;
				main.useUnscaledTime = value;
			}
		}
		for (int k = 0; k < _allTimelinesInScene.Length; k++)
		{
			PlayableDirector playableDirector = _allTimelinesInScene[k];
			if (playableDirector != null && (playableDirector.gameObject.layer == 0 || playableDirector.gameObject.layer == 18))
			{
				playableDirector.timeUpdateMode = ((!value) ? DirectorUpdateMode.GameTime : DirectorUpdateMode.UnscaledGameTime);
			}
		}
		MonoSingleton<GameCameraStackManager>.Instance.mainCameraAdditionalCameraData.renderUseUnscaledTime = value;
	}
}
