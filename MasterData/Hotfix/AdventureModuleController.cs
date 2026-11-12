#define LOG_ERROR
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using AdventureBehaviour;
using DG.Tweening;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Nova.Client;
using Nova.Hotfix;
using Pathfinding.RVO;
using TrueSync;
using TrueSync.Physics2D;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI.Extensions;
using XLua;

public class AdventureModuleController : ModuleController<AdventureModuleController>, IEventDispatcher
{
	public class BattleEntity
	{
		public long lId;

		public uint Id;

		public Recorder.Types.EntityType Type;

		public long Hp;
	}

	public class MonsterDamageInfo
	{
		public long Damage;

		public long InitialMaxHP;

		public uint MonsterId;
	}

	public class BattleSample
	{
		public int fromSrcAtk;

		public float fromPerkIntensityRatio;

		public float fromSlotDmgRatio;

		public float fromEE;

		public float fromGenDmgRatio;

		public int fromDmgPlus;

		public float fromCritRatio;

		public float fromFinalDmgRatio;

		public int fromFinalDmgPlus;

		public float toErAmend;

		public float toDefAmend;

		public float toRcdSlotDmgRatio;

		public float toEERCD;

		public float toGenDmgRcdRatio;

		public int toDmgPlusRcd;

		public long dmg;

		public uint dmgType;

		public float critRate;

		public long maxHP;
	}

	private enum AttType
	{
		ATK,
		PERK_IR,
		SLOT_DMG,
		EE,
		GEN_DMG,
		DMG_PLUS,
		CRIT_RATIO,
		FINAL_DMG,
		FINAL_DMG_PLUS,
		CRIT_RATE,
		MAX
	}

	public class MonsterSummonData
	{
		public MonsterAdventureActor monster;

		public int dataID;

		public long SummonActorID;

		public long entityID;

		public bool iAlive;

		public bool isPlayerSummons;
	}

	public enum SceneLimitZoneType
	{
		_1024x1024,
		_256x256
	}

	internal AdventureObjectOrderByLocationComparer _objectOrderByLocationComparer = new AdventureObjectOrderByLocationComparer();

	protected LogManager.Logger _logger;

	public FP BaseSuppress;

	public FP DynamicSuppress;

	protected List<AdventureActor> _collisionDetectionEntities = new List<AdventureActor>();

	private AIAdapter _levelManagerAdapter;

	private readonly string _levelManagerTypeStr = "AIScript.Level.LevelManager";

	public GameObject controllerContent;

	private bool paused;

	protected Queue<Action> _actionsOnEndOfLogicFrame = new Queue<Action>();

	private Dictionary<long, FakeAdventureActor> _fakeActors;

	private List<MonsterCloneAdventureActor> _monsterCloneActors;

	private readonly Dictionary<int, int> _themePerkInfos = new Dictionary<int, int>();

	private readonly Dictionary<int, FP> _perkTriggerTimeDic = new Dictionary<int, FP>(4);

	public List<Lua2CSharpInfo_FateCardThemeInfo> FateCardThemeInfos = new List<Lua2CSharpInfo_FateCardThemeInfo>(20);

	private readonly Dictionary<int, Lua2CSharpInfo_FateCardInfo> _fateInfoDic = new Dictionary<int, Lua2CSharpInfo_FateCardInfo>();

	private Dictionary<int, Dictionary<int, int>> _personalPerkInfos = new Dictionary<int, Dictionary<int, int>>();

	private readonly Dictionary<int, Lua2CSharpInfo_DiscInfo> _discInfos = new Dictionary<int, Lua2CSharpInfo_DiscInfo>();

	private readonly Dictionary<int, int> _noteCountDic = new Dictionary<int, int>();

	private readonly Dictionary<int, int> _actorLevelInfos = new Dictionary<int, int>();

	private readonly Dictionary<int, int> _actorBreakCountInfos = new Dictionary<int, int>();

	private readonly Dictionary<int, List<bool>> _actorTalentActiveInfos = new Dictionary<int, List<bool>>();

	private readonly Dictionary<int, Lua2CSharpInfo_CharAttribute> _actorInitAttributes = new Dictionary<int, Lua2CSharpInfo_CharAttribute>();

	private readonly Dictionary<int, Lua2CSharpInfo_ActorStatus> _actorStatusInfos = new Dictionary<int, Lua2CSharpInfo_ActorStatus>(3);

	public int BuildLevel;

	private readonly Dictionary<int, Lua2CSharpInfo_ActorAmmoInfo> _actorAmmoInfos = new Dictionary<int, Lua2CSharpInfo_ActorAmmoInfo>(3);

	public Dictionary<string, int> dicCount = new Dictionary<string, int>();

	private readonly Dictionary<int, long> _damageRecordDic = new Dictionary<int, long>(3);

	private readonly Dictionary<int, long> _stageDamageRecordDic = new Dictionary<int, long>(3);

	private readonly Dictionary<int, long> _totalDamageRecordDic = new Dictionary<int, long>(3);

	private static readonly Dictionary<int, Dictionary<long, FP>> _triggerElementMarkTimeDic = new Dictionary<int, Dictionary<long, FP>>(3);

	private int _enterBattleStateTimes;

	private List<int> _unFinishedAchievementInfos;

	public bool InBattleState;

	public bool SemiAutoBattle;

	public bool FullAutoBattle;

	public bool AutoCastUltimateSkill = true;

	public int OverrideBuffId_Glimmer;

	[Header("Configure:")]
	public AdventureModuleConfigureData sharedConfigureData;

	[NonSerialized]
	[HideInInspector]
	[BlackList]
	public GameObject FX_VampireSurvivorSimplifyHurtFXPrefab;

	private Dictionary<long, BattleEntity> battleEntities;

	private uint battleId;

	private uint damageId;

	private string UID;

	private Recorder gameRecorder;

	private Recorders.Types.LevelType recordLevelType;

	private List<int> excludes = new List<int>();

	private Dictionary<long, SkillPhaseFeatureFlag> entityLastCastFlag;

	private Dictionary<long, MonsterDamageInfo> monsterDamageInfoMap;

	private uint startTimingFrame;

	private uint stopTimingFrame;

	private bool isTimingLevel;

	[Header("Entity Manage:")]
	public UnityEngine.Transform actorRootNode;

	public UnityEngine.Transform weaponRootNode;

	public UnityEngine.Transform skillRootNode;

	public UnityEngine.Transform minmapRootNode;

	private readonly Dictionary<UnityEngine.Transform, GameObject> minimapObjects = new Dictionary<UnityEngine.Transform, GameObject>();

	protected List<LogicEntity> removeEntities = new List<LogicEntity>();

	protected List<MonsterSummonData> monsterSummonInfos = new List<MonsterSummonData>(50);

	public const long INTERNAL_UID = 10000L;

	protected long _uidCounter = 10000L;

	internal const long INVALID_UID = -1L;

	private static Type playerType = typeof(PlayerAdventureActor);

	private static Type monsterType = typeof(MonsterAdventureActor);

	private static Type obstacleType = typeof(AdventureObstacle);

	private static Type weaponType = typeof(AdventureWeapon);

	protected Dictionary<long, LogicEntity> _entityIDCache = new Dictionary<long, LogicEntity>(250);

	protected EventDispatcher _dispatcher;

	protected readonly Dictionary<string, List<BaseAdventureEvent>> _eventPool = new Dictionary<string, List<BaseAdventureEvent>>(50);

	protected const int LevelSuccessDelayKey = 34;

	protected const int LevelDefeatDelayKey = 48;

	protected const int LevelTeleporterDelayKey = 49;

	protected AdventureLevelTeleporter.NextLevelData nextLevelData;

	public AdventureLevelState adventureLevelState;

	public Dictionary<string, bool> _LogicValue = new Dictionary<string, bool>(10);

	public int currentFloor = 10;

	public Weather weather = Weather.ClearDay;

	public TimeOfDay timeOfDay = TimeOfDay.Daytime;

	public static SceneLimitZoneType sceneLimitZoneType = SceneLimitZoneType._1024x1024;

	public static TSRect sceneLimitZone = new TSRect(new TSVector2(-50, -50), new TSVector2(100, 100));

	private AdventureTimeControlManager _globalTimeControlManager;

	protected int _pauseRC;

	protected readonly List<DeterministicCollider> _collisionDetectList = new List<DeterministicCollider>(20);

	public bool isStandaloneMode { get; protected set; }

	public CoroutineScheduler logicCoroutineScheduler { get; protected set; }

	public List<int> PerkThemes { get; set; }

	public Dictionary<int, Dictionary<int, int>> PersonalPerkInfos => _personalPerkInfos;

	public List<Lua2CSharpInfo_DiscInfo> DiscInfos => _discInfos.Values.ToList();

	public List<Lua2CSharpInfo_SummonMonsterInfo> SummonMonsters { get; set; }

	public int EnterBattleStateTimes
	{
		get
		{
			return _enterBattleStateTimes;
		}
		set
		{
			if (value != _enterBattleStateTimes)
			{
				_enterBattleStateTimes = value;
				if (_enterBattleStateTimes == 1)
				{
					AdventureActorPlayerFirstEnterBattleStateEvent aEvent = AdventureActorPlayerFirstEnterBattleStateEvent.Generate();
					DispatchEvent(aEvent);
				}
			}
		}
	}

	public int BuffId_Glimmer
	{
		get
		{
			if (OverrideBuffId_Glimmer > 0)
			{
				return OverrideBuffId_Glimmer;
			}
			return sharedConfigureData.BuffId_Glimmer;
		}
	}

	public static AdventureModuleConfigureData Config => ModuleController<AdventureModuleController>.Instance.sharedConfigureData;

	public bool uploadDamageData { get; private set; }

	public string CurrentBuildName { get; private set; }

	public string CurrentBuildJson { get; private set; }

	protected ExtraLevelInfo extraLevelInfo => new ExtraLevelInfo
	{
		actorRootNode = actorRootNode,
		weaponRootNode = weaponRootNode,
		skillRootNode = skillRootNode,
		minimapRootNode = minmapRootNode
	};

	public List<LogicEntity> entities => levelInstance?.entities;

	public List<LogicEntity> playerActors => levelInstance?.playerActors;

	public List<LogicEntity> monsterActors => levelInstance?.monsterActors;

	public List<LogicEntity> weapons => levelInstance?.weapons;

	public List<Searchable> searchables => levelInstance?.searchables;

	public List<LogicEntity> obstacles => levelInstance?.obstacles;

	public List<LogicEntity> traps => levelInstance?.trapActors;

	public List<LogicEntity> areaEffects => levelInstance?.areaEffects;

	public List<LogicEntity> forzenTimeChildren => levelInstance?.forzenTimeChildren;

	public List<LogicEntity> placeHolders => levelInstance?.placeHolders;

	public List<LogicEntity> dynamicActors => levelInstance?.dynamicActors;

	public List<LogicEntity> specialEntities => levelInstance?.specialEntities;

	public List<MonsterSummonData> MonsterSummonInfos => monsterSummonInfos;

	public AdventureInteractableEventTriggerGizmo activedInteractableEventTriggerGizmo => levelInstance?.activedInteractableEventTriggerGizmo;

	public bool banPlayerSpawn { get; set; }

	public bool banMonsterSpawn { get; set; }

	public bool banBattleUIShow { get; set; }

	public HotfixEnum.worldLevelType levelType { get; protected set; }

	public AdventureModuleLevelLoadParams levelLoadParams { get; protected set; }

	public GameTeamConfig teamConfig { get; protected set; }

	public bool isModuleInit { get; protected set; }

	public AdventureLevelController levelInstance { get; set; }

	public AdventureAutoBattleController autoBattleController { get; private set; }

	public bool isReconnected => levelInstance.isReconnected;

	public bool isPrologueBattleCanSwitchActor => levelInstance.isPrologueBattleCanSwitchActor;

	public bool isMonsterCleared
	{
		get
		{
			if (!(null == levelInstance))
			{
				return levelInstance.isMonsterCleared;
			}
			return true;
		}
	}

	public bool limitlessMode { get; private set; }

	public bool isLoadingLevel
	{
		get
		{
			if (null != levelInstance)
			{
				return levelInstance.isLoadingLevel;
			}
			return false;
		}
	}

	public bool isUnloadingLevel
	{
		get
		{
			if (null != levelInstance)
			{
				return levelInstance.isUnloadingLevel;
			}
			return false;
		}
	}

	public bool autoBattle { get; private set; }

	public AdventurePlayerCameraTriggerGizmo CurCameraTriggerGizmo => levelInstance?.CurCameraTriggerGizmo;

	public string levelMusicName { get; protected set; }

	public string leaveMusicEvent { get; protected set; }

	protected AdventureTimeControlManager globalTimeControlManager
	{
		get
		{
			if (_globalTimeControlManager == null)
			{
				_globalTimeControlManager = new AdventureTimeControlManager(20);
			}
			return _globalTimeControlManager;
		}
	}

	public bool isPause => _pauseRC > 0;

	protected override void Awake()
	{
		base.Awake();
		_dispatcher = new EventDispatcher();
		_logger = Singleton<LogManager>.Instance.get_Item("Adventure");
	}

	protected void OnEnable()
	{
		Singleton<EventDispatchManager>.Instance.AddEventListener("PLAYER_CHANGE_STAY_SCENEROOM", OnChangeStayRoom);
		AddEventListener("USE_FAKEACTOR_CASTSKILL", OnUseFakeActorCastSkill);
		AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		AddEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		AddEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		AddEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
		AddEventListener("LEVEL_TIMELINE_LOADINGVIEW", OnTimelineLoadingViewChange);
		AddEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
		AddEventListener("ADVENTURE_BATTLE_FINISH_MSG", OnBattleFinish);
	}

	protected void OnDisable()
	{
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("PLAYER_CHANGE_STAY_SCENEROOM", OnChangeStayRoom);
		RemoveEventListener("USE_FAKEACTOR_CASTSKILL", OnUseFakeActorCastSkill);
		RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		RemoveEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		RemoveEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
		RemoveEventListener("LEVEL_TIMELINE_LOADINGVIEW", OnTimelineLoadingViewChange);
		RemoveEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
		RemoveEventListener("ADVENTURE_BATTLE_FINISH_MSG", OnBattleFinish);
		RemoveAllEventListeners();
		ClearMonsterSummonData();
		ClearTriggerElementMarkCDDic();
		ClearActorDamageRecord();
	}

	public override void OnEnter(Action flowCallback)
	{
		if (_levelManagerAdapter == null)
		{
			_levelManagerAdapter = new AIAdapter();
			if (!_levelManagerAdapter.Initialize(_levelManagerTypeStr, gameObject))
			{
				_levelManagerAdapter = null;
			}
		}
		if (controllerContent == null)
		{
			controllerContent = new GameObject("LevelController");
			controllerContent.transform.SetParent(transform);
		}
		TSRandom.GenerateEncryptionKey();
		MonoSingleton<LuaManager>.Instance?.FireEvent("AdventureModuleEnter");
		TSVector2 tSVector = Config.Level_MaxSceneSize;
		SceneLimitZoneType sceneLimitZoneType = SceneLimitZoneType._1024x1024;
		if (MonoSingleton<GameController>.Instance.metaData is AdventureModuleLevelLoadParams adventureModuleLevelLoadParams)
		{
			InitLevelType(adventureModuleLevelLoadParams);
			HotfixEnum.worldLevelType worldLevelType = levelType;
			if (worldLevelType == HotfixEnum.worldLevelType.RegionBoss || (uint)(worldLevelType - 8) <= 1u || worldLevelType == HotfixEnum.worldLevelType.StarTower)
			{
				tSVector = Config.Level_MaxSceneSize_Min;
				sceneLimitZoneType = SceneLimitZoneType._256x256;
			}
			else
			{
				tSVector = Config.Level_MaxSceneSize;
				sceneLimitZoneType = SceneLimitZoneType._1024x1024;
			}
		}
		AdventureModuleController.sceneLimitZoneType = sceneLimitZoneType;
		sceneLimitZone = new TSRect(-tSVector.x * 0.5f, -tSVector.y * 0.5, tSVector.x, tSVector.y);
		StandaloneLockStepManager standaloneLockStepManager = gameObject.AddComponent<StandaloneLockStepManager>();
		standaloneLockStepManager.onUpdate = (Action)Delegate.Combine(standaloneLockStepManager.onUpdate, new Action(LockStepUpdate));
		isStandaloneMode = true;
		TSRandom.instance = TSRandom.New(DateTime.Now.Millisecond);
		VisualSmooth.visualPositionSmoothFactor = Config.Network_DeterministicTransformSyncSmoothFactorPos;
		VisualSmooth.visualRotationSmoothFactor = Config.Network_DeterministicTransformSyncSmoothFactorRot;
		SceneSingleton<DeterministicCollisionManager>.Instance.Initialize(TSMath.Max(sceneLimitZone.width, sceneLimitZone.height), TSMath.Max(Config.Level_SceneCellSize.x, Config.Level_SceneCellSize.y));
		logicCoroutineScheduler = new CoroutineScheduler();
		LoadLevel(flowCallback, isFirstEnterModule: true);
		SceneSingleton<AdventurePlayerController>.Instance.SetupCameraStack();
		SceneSingleton<AdventureIndicatorController>.Instance.Setup(levelType);
		AdventureSelfFXHandler.ManualInitialize = true;
		CommonHelper.ResetConfigCache();
		Config config = Singleton<GameDataController>.Instance.GetConfig("BaseSuppress");
		if (config != null)
		{
			CommonHelper.TryParseStringParamToFP(config.Value, out var fpValue);
			BaseSuppress = fpValue;
		}
		config = Singleton<GameDataController>.Instance.GetConfig("DynamicSuppress");
		if (config != null)
		{
			CommonHelper.TryParseStringParamToFP(config.Value, out var fpValue2);
			DynamicSuppress = fpValue2;
		}
		AdventureRuntimeBridge.Register();
		isModuleInit = true;
	}

	public override void OnAfterEnter()
	{
	}

	public override void OnBeforeExit()
	{
		TimeControlReset();
		if (MonoSingleton<GameController>.Instance.currentModuleName == "AdventureModuleScene")
		{
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent(leaveMusicEvent);
			MonoSingleton<WwiseAudioManager>.Instance.StopMusice(isCombat: true);
		}
	}

	public override void OnExit(Action flowCallback)
	{
		MonoSingleton<GameController>.Instance.ClearSeed();
		GameRenderUtils.ResetSceneRenderingSetting(isExit: true);
		AdventureSelfFXHandler.ManualInitialize = false;
		SceneSingleton<AdventureIndicatorController>.Instance.Release();
		SceneSingleton<AdventurePlayerController>.Instance.UnSetupCameraStack();
		logicCoroutineScheduler.StopAllCoroutines();
		StandaloneLockStepManager component = gameObject.GetComponent<StandaloneLockStepManager>();
		component.onUpdate = (Action)Delegate.Remove(component.onUpdate, new Action(LockStepUpdate));
		Time.timeScale = 1f;
		flowCallback?.Invoke();
		_levelManagerAdapter = null;
		if (controllerContent != null)
		{
			UnityEngine.Object.Destroy(controllerContent);
			controllerContent = null;
		}
		Screen.sleepTimeout = -2;
		AdventureRuntimeBridge.Unregister();
	}

	protected void OnApplicationPause(bool pause)
	{
		if (pause != paused)
		{
			paused = pause;
			if (pause)
			{
				PauseLogic();
			}
			else
			{
				ResumeLogic();
			}
		}
	}

	public void EqueueActionOnEndOfLogicFrame(Action action)
	{
		_actionsOnEndOfLogicFrame.Enqueue(action);
	}

	public void HandleActionsOnEndOfLogicFrame()
	{
		while (_actionsOnEndOfLogicFrame.Count > 0)
		{
			_actionsOnEndOfLogicFrame.Dequeue()();
		}
	}

	private void OnUseFakeActorCastSkill(IEvent evt)
	{
		if (evt is AdventureUseFakeActorCastSkillEvent adventureUseFakeActorCastSkillEvent)
		{
			FakeAdventureActor fakeActor = GetFakeActor(adventureUseFakeActorCastSkillEvent.templeteId, adventureUseFakeActorCastSkillEvent.attributeId, createNew: true, adventureUseFakeActorCastSkillEvent.factionId);
			fakeActor.tsTransform.Position = adventureUseFakeActorCastSkillEvent.position;
			fakeActor.tsTransform.PositionY = adventureUseFakeActorCastSkillEvent.positionY;
			fakeActor.tsTransform.Forward = adventureUseFakeActorCastSkillEvent.direction;
			ILRuntimeAPI.CreateSkill(adventureUseFakeActorCastSkillEvent.skillId, fakeActor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.FakeActor);
		}
	}

	public FakeAdventureActor GetFakeActor(int templeteId, long attributeId, bool createNew = true, int factionID = 6)
	{
		if (_fakeActors == null)
		{
			_fakeActors = new Dictionary<long, FakeAdventureActor>();
		}
		if (_fakeActors.TryGetValue(attributeId, out var value))
		{
			return value;
		}
		if (createNew)
		{
			GameObject gameObject = new GameObject("fakeActor-" + attributeId);
			value = gameObject.AddComponent<FakeAdventureActor>();
			value.SetAttrInfo(templeteId, attributeId, factionID);
			gameObject.transform.SetParent(actorRootNode);
			_fakeActors.Add(attributeId, value);
		}
		return value;
	}

	public void UseMonsterCloneActorCastSkill(MonsterAdventureActor master, int skillId)
	{
		MonsterCloneAdventureActor cloneActor = GetMonsterCloneActor(master);
		cloneActor.actorHealthInfo.isAlive = true;
		cloneActor.isDead = false;
		cloneActor.tsTransform.Position = master.tsTransform.Position;
		cloneActor.tsTransform.PositionY = master.tsTransform.PositionY;
		cloneActor.tsTransform.Forward = master.tsTransform.Forward;
		cloneActor.SetAttr(master);
		ILRuntimeAPI.CreateSkill(skillId, cloneActor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.FakeActor, isInterruptAttack: true, isBreakable: true, SkillCountdownTiming.Start, (bool result) =>
		{
			cloneActor.isFree = true;
		});
	}

	public bool CheckAllMonsterCloneActorFinish()
	{
		if (_monsterCloneActors != null)
		{
			return !_monsterCloneActors.Any((MonsterCloneAdventureActor actor) => !actor.isFree);
		}
		return true;
	}

	private MonsterCloneAdventureActor GetMonsterCloneActor(MonsterAdventureActor master)
	{
		MonsterCloneAdventureActor monsterCloneAdventureActor = null;
		if (_monsterCloneActors == null)
		{
			_monsterCloneActors = new List<MonsterCloneAdventureActor>();
		}
		foreach (MonsterCloneAdventureActor monsterCloneActor in _monsterCloneActors)
		{
			if (monsterCloneActor.isFree)
			{
				monsterCloneAdventureActor = monsterCloneActor;
				break;
			}
		}
		if (monsterCloneAdventureActor == null)
		{
			GameObject gameObject = new GameObject();
			monsterCloneAdventureActor = gameObject.AddComponent<MonsterCloneAdventureActor>();
			gameObject.transform.SetParent(actorRootNode);
			_monsterCloneActors.Add(monsterCloneAdventureActor);
		}
		monsterCloneAdventureActor.name = "monsterCloneActor-" + master.dataID + "_" + master.Id;
		return monsterCloneAdventureActor;
	}

	public void SetThemePerks(Lua2CSharpInfo_TPPerkInfo[] infos)
	{
		for (int i = 0; i < infos.Length; i++)
		{
			if (_themePerkInfos.ContainsKey(infos[i].perkId))
			{
				_themePerkInfos.set_Item(infos[i].perkId, infos[i].nCount);
			}
			else
			{
				_themePerkInfos.Add(infos[i].perkId, infos[i].nCount);
			}
		}
	}

	public bool GetThemePerkLevel(int perkId, out int perkLevel)
	{
		perkLevel = 0;
		if (_themePerkInfos.TryGetValue(perkId, out perkLevel))
		{
			return perkLevel > 0;
		}
		return false;
	}

	[Obsolete]
	public void TriggerPerk(int perkIndex, FP logicTime)
	{
		if (_perkTriggerTimeDic.ContainsKey(perkIndex))
		{
			_perkTriggerTimeDic.set_Item(perkIndex, logicTime);
		}
		else
		{
			_perkTriggerTimeDic.Add(perkIndex, logicTime);
		}
	}

	[Obsolete]
	public bool CheckPerkCDTimeout(int perkIndex, FP logicTime, FP cd)
	{
		if (_perkTriggerTimeDic.TryGetValue(perkIndex, out var value))
		{
			return logicTime - value > cd;
		}
		return true;
	}

	[Obsolete]
	public void ModifyPerkCD(int perkIndex, FP reduceCd)
	{
		if (_perkTriggerTimeDic.TryGetValue(perkIndex, out var value))
		{
			_perkTriggerTimeDic.set_Item(perkIndex, value - reduceCd);
		}
	}

	public void SetFateCardThemes(Lua2CSharpInfo_FateCardThemeInfo[] infos)
	{
		FateCardThemeInfos = infos.ToList();
		ActorRefreshFateCardTheme actorRefreshFateCardTheme = ActorRefreshFateCardTheme.Generate();
		actorRefreshFateCardTheme.sender = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(actorRefreshFateCardTheme);
	}

	public void SetFateCardInfos(Lua2CSharpInfo_FateCardInfo[] infos)
	{
		for (int i = 0; i < infos.Length; i++)
		{
			_fateInfoDic.Add(infos[i].fateCardId, infos[i]);
		}
	}

	public void UpdateFateCardInfos(Lua2CSharpInfo_FateCardInfo[] infos)
	{
		for (int i = 0; i < infos.Length; i++)
		{
			int fateCardId = infos[i].fateCardId;
			if (_fateInfoDic.ContainsKey(infos[i].fateCardId))
			{
				_fateInfoDic.set_Item(fateCardId, infos[i]);
			}
			else
			{
				_fateInfoDic.Add(fateCardId, infos[i]);
			}
		}
		if (infos.Length != 0)
		{
			ActorRefreshFateCardInfo aEvent = ActorRefreshFateCardInfo.Generate();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		}
	}

	public int GetAllFateCardCount()
	{
		return _fateInfoDic.Count;
	}

	public void SetPersonalPerks(int actorDataId, Lua2CSharpInfo_TPPerkInfo[] infos)
	{
		if (_personalPerkInfos.TryGetValue(actorDataId, out var value))
		{
			for (int i = 0; i < infos.Length; i++)
			{
				value.set_Item(infos[i].perkId, infos[i].nCount);
			}
			return;
		}
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		for (int j = 0; j < infos.Length; j++)
		{
			if (dictionary.ContainsKey(infos[j].perkId))
			{
				dictionary.set_Item(infos[j].perkId, infos[j].nCount);
				_logger.LogError($"重复添加信条ID:{infos[j].perkId}");
				continue;
			}
			dictionary.Add(infos[j].perkId, infos[j].nCount);
			AdventureActorPersonalPerkUpdateEvent adventureActorPersonalPerkUpdateEvent = AdventureActorPersonalPerkUpdateEvent.Generate();
			adventureActorPersonalPerkUpdateEvent.actorDataId = actorDataId;
			adventureActorPersonalPerkUpdateEvent.perkId = infos[j].perkId;
			adventureActorPersonalPerkUpdateEvent.isNew = true;
			DispatchEvent(adventureActorPersonalPerkUpdateEvent);
		}
		_personalPerkInfos.Add(actorDataId, dictionary);
	}

	public void UpdatePersonalPerks(int actorDataId, Lua2CSharpInfo_TPPerkInfo[] infos)
	{
		if (!_personalPerkInfos.TryGetValue(actorDataId, out var value))
		{
			return;
		}
		for (int i = 0; i < infos.Length; i++)
		{
			AdventureActorPersonalPerkUpdateEvent adventureActorPersonalPerkUpdateEvent = AdventureActorPersonalPerkUpdateEvent.Generate();
			adventureActorPersonalPerkUpdateEvent.actorDataId = actorDataId;
			adventureActorPersonalPerkUpdateEvent.perkId = infos[i].perkId;
			if (value.ContainsKey(infos[i].perkId))
			{
				int num = value.get_Item(infos[i].perkId);
				int num2 = num + infos[i].nCount;
				value.set_Item(infos[i].perkId, num2);
				adventureActorPersonalPerkUpdateEvent.isNew = false;
				adventureActorPersonalPerkUpdateEvent.oldLevel = num;
				adventureActorPersonalPerkUpdateEvent.newLevel = num2;
			}
			else
			{
				value.Add(infos[i].perkId, infos[i].nCount);
				adventureActorPersonalPerkUpdateEvent.isNew = true;
				adventureActorPersonalPerkUpdateEvent.oldLevel = 0;
				adventureActorPersonalPerkUpdateEvent.newLevel = infos[i].nCount;
			}
			DispatchEvent(adventureActorPersonalPerkUpdateEvent);
		}
	}

	public bool GetPersonalPerkLevel(int actorDataId, int perkId, out int perkLevel)
	{
		perkLevel = 0;
		if (_personalPerkInfos.TryGetValue(actorDataId, out var value) && value != null && value.TryGetValue(perkId, out perkLevel))
		{
			return perkLevel > 0;
		}
		return false;
	}

	public int GetPersonalPerkLevel(int perkId)
	{
		int value = 0;
		using (Dictionary<int, Dictionary<int, int>>.ValueCollection.Enumerator enumerator = _personalPerkInfos.Values.GetEnumerator())
		{
			while (enumerator.MoveNext() && !enumerator.Current.TryGetValue(perkId, out value))
			{
			}
		}
		return value;
	}

	public void ClearDiscInfos()
	{
		_discInfos.Clear();
	}

	public void SetDiscInfos(Lua2CSharpInfo_DiscInfo[] infos)
	{
		for (int i = 0; i < infos.Length; i++)
		{
			Lua2CSharpInfo_DiscInfo value = infos[i];
			_discInfos.set_Item(value.discId, value);
		}
	}

	public bool GetDiscSkillLevel(int discId, int skillId, out int skillLevel)
	{
		skillLevel = 0;
		if (_discInfos.TryGetValue(discId, out var value))
		{
			Lua2CSharpInfo_DiscSkillInfo[] skillInfos = value.skillInfos;
			if (skillInfos != null && skillInfos.Length > 0)
			{
				for (int i = 0; i < value.skillInfos.Length; i++)
				{
					if (value.skillInfos[i].skillId == skillId)
					{
						skillLevel = value.skillInfos[i].skillLevel;
						return skillLevel > 0;
					}
				}
			}
		}
		return false;
	}

	public int GetDiscSkillLevel(int skillId)
	{
		foreach (Lua2CSharpInfo_DiscInfo value in _discInfos.Values)
		{
			Lua2CSharpInfo_DiscSkillInfo[] skillInfos = value.skillInfos;
			if (skillInfos == null || skillInfos.Length <= 0)
			{
				continue;
			}
			for (int i = 0; i < value.skillInfos.Length; i++)
			{
				if (value.skillInfos[i].skillId == skillId)
				{
					return value.skillInfos[i].skillLevel;
				}
			}
		}
		return 0;
	}

	public int GetDiscNumByMainNoteId(int mainNoteId)
	{
		return 0;
	}

	public void SetNoteInfos(Lua2CSharpInfo_NoteInfo[] infos)
	{
		for (int i = 0; i < infos.Length; i++)
		{
			Lua2CSharpInfo_NoteInfo lua2CSharpInfo_NoteInfo = infos[i];
			_noteCountDic.set_Item(lua2CSharpInfo_NoteInfo.noteId, lua2CSharpInfo_NoteInfo.noteCount);
		}
	}

	public int GetNoteCount(int noteId)
	{
		return _noteCountDic.GetValueOrDefault(noteId, 0);
	}

	public int GetAllNoteCount()
	{
		int num = 0;
		foreach (int value in _noteCountDic.Values)
		{
			num += value;
		}
		return num;
	}

	public void SetActorLevelInfo(int actorDataId, int level)
	{
		if (_actorLevelInfos.ContainsKey(actorDataId))
		{
			_actorLevelInfos.set_Item(actorDataId, level);
		}
		else
		{
			_actorLevelInfos.Add(actorDataId, level);
		}
	}

	public int GetActorLevel(int actorDataId)
	{
		if (!_actorLevelInfos.TryGetValue(actorDataId, out var value))
		{
			return 0;
		}
		return value;
	}

	public void SetActorBreakCountInfo(int actorDataId, int breakCount)
	{
		if (_actorBreakCountInfos.ContainsKey(actorDataId))
		{
			_actorBreakCountInfos.set_Item(actorDataId, breakCount);
		}
		else
		{
			_actorBreakCountInfos.Add(actorDataId, breakCount);
		}
	}

	public int GetActorBreakCount(int actorDataId)
	{
		if (!_actorBreakCountInfos.TryGetValue(actorDataId, out var value))
		{
			return 0;
		}
		return value;
	}

	public void SetActorTalentActiveInfo(int actorId, List<bool> activeInfos)
	{
		if (_actorTalentActiveInfos.ContainsKey(actorId))
		{
			_actorTalentActiveInfos.set_Item(actorId, activeInfos);
		}
		else
		{
			_actorTalentActiveInfos.Add(actorId, activeInfos);
		}
	}

	public bool CheckActorActiveTalentLevel(int actorId, int level)
	{
		int b = level - 1;
		b = Mathf.Max(0, b);
		if (_actorTalentActiveInfos.TryGetValue(actorId, out var value) && value != null && value.Count > b)
		{
			return value.get_Item(b);
		}
		return false;
	}

	public void SetActorInitAttribute(int actorId, Lua2CSharpInfo_CharAttribute actorInitAttribute)
	{
		if (_actorInitAttributes.ContainsKey(actorId))
		{
			_actorInitAttributes.set_Item(actorId, actorInitAttribute);
		}
		else
		{
			_actorInitAttributes.Add(actorId, actorInitAttribute);
		}
	}

	public void ResetActorSkillSlotLevel(int actorId, int[] levels, bool isInit)
	{
		if (GetActorAttribute(actorId, out var attribute))
		{
			for (int i = 0; i < levels.Length; i++)
			{
				if (levels[i] > 0)
				{
					attribute.SkillLevel[i] = levels[i];
				}
			}
			SetActorInitAttribute(actorId, attribute);
		}
		if (isInit)
		{
			return;
		}
		List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance?.ActorLs;
		if (list == null)
		{
			return;
		}
		foreach (PlayerAdventureActor item in list)
		{
			if (item.dataID == actorId)
			{
				if (levels[0] > 0)
				{
					item.playerSkillCd.SetSkillSlotBaseLevelForBootConfig(ActionKey.Normal, levels[0]);
				}
				if (levels[1] > 0)
				{
					item.playerSkillCd.SetSkillSlotBaseLevelForBootConfig(ActionKey.B, levels[1]);
				}
				if (levels[2] > 0)
				{
					item.playerSkillCd.SetSkillSlotBaseLevelForBootConfig(ActionKey.D, levels[2]);
				}
				break;
			}
		}
	}

	public bool GetActorAttribute(int actorId, out Lua2CSharpInfo_CharAttribute attribute)
	{
		return _actorInitAttributes.TryGetValue(actorId, out attribute);
	}

	public void SetActorStatus(Lua2CSharpInfo_ActorStatus[] actorStatusInfos)
	{
		for (int i = 0; i < actorStatusInfos.Length; i++)
		{
			int actorID = actorStatusInfos[i].actorID;
			if (_actorStatusInfos.ContainsKey(actorID))
			{
				_actorStatusInfos.set_Item(actorID, actorStatusInfos[i]);
			}
			else
			{
				_actorStatusInfos.Add(actorID, actorStatusInfos[i]);
			}
		}
	}

	public bool GetActorStatus(int actorId, out Lua2CSharpInfo_ActorStatus actorStatusInfo)
	{
		return _actorStatusInfos.TryGetValue(actorId, out actorStatusInfo);
	}

	public void SetActorAmmoInfos(Lua2CSharpInfo_ActorAmmoInfo[] actorAmmoInfos)
	{
		for (int i = 0; i < actorAmmoInfos.Length; i++)
		{
			int actorID = actorAmmoInfos[i].actorID;
			if (_actorAmmoInfos.ContainsKey(actorID))
			{
				_actorAmmoInfos.set_Item(actorID, actorAmmoInfos[i]);
			}
			else
			{
				_actorAmmoInfos.Add(actorID, actorAmmoInfos[i]);
			}
		}
	}

	public bool GetActorAmmoInfo(int actorId, out Lua2CSharpInfo_ActorAmmoInfo actorAmmoInfo)
	{
		return _actorAmmoInfos.TryGetValue(actorId, out actorAmmoInfo);
	}

	private void OnActorReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.to is DestructibleStateSingle))
		{
			PlayerAdventureActor summoner;
			SummonType summonType;
			if (adventureActorReceiveDamageEvent.from is PlayerAdventureActor playerAdventureActor)
			{
				AddPlayerDamage(playerAdventureActor.dataID, adventureActorReceiveDamageEvent.damageToShieldAndHp);
			}
			else if (adventureActorReceiveDamageEvent.from.IsPlayerSummoned(out summoner, out summonType))
			{
				AddPlayerDamage(summoner.dataID, adventureActorReceiveDamageEvent.damageToShieldAndHp);
			}
		}
	}

	private void OnActorReceiveDirectDamage(IEvent evt)
	{
		AdventureActorReceiveDirectEvent adventureActorReceiveDirectEvent = evt as AdventureActorReceiveDirectEvent;
		if (!(adventureActorReceiveDirectEvent.to is DestructibleStateSingle))
		{
			PlayerAdventureActor summoner;
			SummonType summonType;
			if (adventureActorReceiveDirectEvent.from is PlayerAdventureActor playerAdventureActor)
			{
				AddPlayerDamage(playerAdventureActor.dataID, adventureActorReceiveDirectEvent.damageToShieldAndHp);
			}
			else if (adventureActorReceiveDirectEvent.from.IsPlayerSummoned(out summoner, out summonType))
			{
				AddPlayerDamage(summoner.dataID, adventureActorReceiveDirectEvent.damageToShieldAndHp);
			}
		}
	}

	private void OnActorReceiveDotDamage(IEvent evt)
	{
		AdventureActorDotDamageEvent adventureActorDotDamageEvent = evt as AdventureActorDotDamageEvent;
		if (!(adventureActorDotDamageEvent.to is DestructibleStateSingle))
		{
			PlayerAdventureActor summoner;
			SummonType summonType;
			if (adventureActorDotDamageEvent.from is PlayerAdventureActor playerAdventureActor)
			{
				AddPlayerDamage(playerAdventureActor.dataID, adventureActorDotDamageEvent.damageToShieldAndHp);
			}
			else if (adventureActorDotDamageEvent.from.IsPlayerSummoned(out summoner, out summonType))
			{
				AddPlayerDamage(summoner.dataID, adventureActorDotDamageEvent.damageToShieldAndHp);
			}
		}
	}

	private void OnActorReceiveKillDamage(IEvent evt)
	{
		AdventureActorReceiveKillEvent adventureActorReceiveKillEvent = evt as AdventureActorReceiveKillEvent;
		if (!(adventureActorReceiveKillEvent.to is DestructibleStateSingle))
		{
			PlayerAdventureActor summoner;
			SummonType summonType;
			if (adventureActorReceiveKillEvent.from is PlayerAdventureActor playerAdventureActor)
			{
				AddPlayerDamage(playerAdventureActor.dataID, adventureActorReceiveKillEvent.curValue);
			}
			else if (adventureActorReceiveKillEvent.from.IsPlayerSummoned(out summoner, out summonType))
			{
				AddPlayerDamage(summoner.dataID, adventureActorReceiveKillEvent.curValue);
			}
		}
	}

	private void AddPlayerDamage(int dataId, long damage)
	{
		if (damage > 0)
		{
			if (_damageRecordDic.ContainsKey(dataId))
			{
				_damageRecordDic.get_Item(dataId) += damage;
			}
			else
			{
				_damageRecordDic.Add(dataId, damage);
			}
			if (_stageDamageRecordDic.ContainsKey(dataId))
			{
				_stageDamageRecordDic.get_Item(dataId) += damage;
			}
			else
			{
				_stageDamageRecordDic.Add(dataId, damage);
			}
		}
	}

	public long GetActorDamageInfo(int dataId, bool isStage)
	{
		if (!isStage)
		{
			return _damageRecordDic.GetValueOrDefault(dataId, 0L);
		}
		return _stageDamageRecordDic.GetValueOrDefault(dataId, 0L);
	}

	public long GetActorTotalDamageInfo(int dataId)
	{
		return 0L;
	}

	public void ClearActorDamageRecord(bool isStage)
	{
		if (isStage)
		{
			_stageDamageRecordDic.Clear();
		}
		else
		{
			_damageRecordDic.Clear();
		}
	}

	private void ClearActorDamageRecord()
	{
		_stageDamageRecordDic.Clear();
		_damageRecordDic.Clear();
		_totalDamageRecordDic.Clear();
	}

	public void RecordTriggerElementMark(int actorDataId, long targetEntityId)
	{
		_triggerElementMarkTimeDic.TryAdd(actorDataId, new Dictionary<long, FP>());
		if (!_triggerElementMarkTimeDic.get_Item(actorDataId).TryAdd(targetEntityId, LockStepManager.time))
		{
			_triggerElementMarkTimeDic.get_Item(actorDataId).set_Item(targetEntityId, LockStepManager.time);
		}
	}

	public bool CheckTriggerElementMarkCD(int actorDataId, long targetEntityId, FP overrideTriggerCD = default(FP))
	{
		if (_triggerElementMarkTimeDic.TryGetValue(actorDataId, out var value) && value.TryGetValue(targetEntityId, out var value2))
		{
			FP fP = ((overrideTriggerCD != default(FP) && overrideTriggerCD > 0) ? overrideTriggerCD : Config.TriggerElementMarkCD);
			return LockStepManager.time - value2 > fP;
		}
		return true;
	}

	public void ClearTriggerElementMarkCDDic()
	{
		_triggerElementMarkTimeDic.Clear();
	}

	public void SetUnFinishedAchievementInfo(List<int> achievementInfos)
	{
		_unFinishedAchievementInfos = achievementInfos;
	}

	public bool CheckAchievementFinished(AdventureActor actor, HotfixEnum.questCompleteCondClient type)
	{
		if (actor is MonsterAdventureActor monsterAdventureActor && !monsterAdventureActor.monsterAIInfo.checkAchievement)
		{
			return true;
		}
		List<int> unFinishedAchievementInfos = _unFinishedAchievementInfos;
		if (unFinishedAchievementInfos == null)
		{
			return true;
		}
		return !unFinishedAchievementInfos.Contains((int)type);
	}

	public void SetAchievementFinish(HotfixEnum.questCompleteCondClient type)
	{
		AdventureBattleAchievementFinishEvent adventureBattleAchievementFinishEvent = AdventureBattleAchievementFinishEvent.Generate();
		adventureBattleAchievementFinishEvent.achievementType = type;
		DispatchEvent(adventureBattleAchievementFinishEvent);
	}

	private void OnBattleStart(IEvent evt)
	{
		if (evt is AdventureMsgBattleStartEvent)
		{
			InBattleState = true;
			if (!levelLoadParams.isStarTowerPrologue && levelType == HotfixEnum.worldLevelType.StarTower)
			{
				AdventureTrapActive adventureTrapActive = AdventureTrapActive.Generate();
				adventureTrapActive.isActive = true;
				adventureTrapActive.GroupId = 0;
				DispatchEvent(adventureTrapActive);
			}
		}
	}

	private void OnBattleFinish(IEvent evt)
	{
		if (evt is AdventureMsgBattleFinishEvent)
		{
			InBattleState = false;
			if (levelType == HotfixEnum.worldLevelType.StarTower)
			{
				AdventureTrapActive adventureTrapActive = AdventureTrapActive.Generate();
				adventureTrapActive.isActive = false;
				adventureTrapActive.GroupId = 0;
				DispatchEvent(adventureTrapActive);
			}
		}
	}

	public void RefreshCenterHpBar()
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("RefreshCenterHpBar");
	}

	public void ClearData()
	{
		_themePerkInfos.Clear();
		_personalPerkInfos.Clear();
		PerkThemes?.Clear();
		_actorLevelInfos.Clear();
		_actorInitAttributes.Clear();
		_perkTriggerTimeDic.Clear();
		dicCount.Clear();
		SummonMonsters?.Clear();
		SummonMonsters = null;
		FateCardThemeInfos.Clear();
		_actorTalentActiveInfos.Clear();
		_discInfos.Clear();
		_noteCountDic.Clear();
		_fateInfoDic.Clear();
		_enterBattleStateTimes = 0;
		_unFinishedAchievementInfos?.Clear();
		InBattleState = false;
		Dictionary<long, FakeAdventureActor> fakeActors = _fakeActors;
		if (fakeActors != null && fakeActors.Count > 0)
		{
			foreach (FakeAdventureActor value in _fakeActors.Values)
			{
				value.ClearBindSkill();
				UnityEngine.Object.Destroy(value.gameObject);
			}
			_fakeActors.Clear();
		}
		List<MonsterCloneAdventureActor> monsterCloneActors = _monsterCloneActors;
		if (monsterCloneActors != null && monsterCloneActors.Count > 0)
		{
			foreach (MonsterCloneAdventureActor monsterCloneActor in _monsterCloneActors)
			{
				monsterCloneActor.ClearBindSkill();
				UnityEngine.Object.Destroy(monsterCloneActor.gameObject);
			}
			_monsterCloneActors.Clear();
		}
		SemiAutoBattle = false;
		FullAutoBattle = false;
		BuildLevel = 0;
		OverrideBuffId_Glimmer = 0;
	}

	public void SetFloorId(int id)
	{
		if (gameRecorder != null)
		{
			gameRecorder.FloorId = (uint)id;
		}
	}

	public void SetBuildData(string buildJson, string buildName, BuildCharData[] buildCharData, BuildDiscData[] buildDiscData, int[] secondarySkills, int[][] notes)
	{
		CurrentBuildJson = buildJson ?? string.Empty;
		CurrentBuildName = buildName ?? string.Empty;
		if (gameRecorder == null)
		{
			return;
		}
		gameRecorder.BuildInfo = new Recorder.Types.Build
		{
			Name = CurrentBuildName
		};
		gameRecorder.BuildInfo.Chars.Clear();
		if (buildCharData != null && buildCharData.Length != 0)
		{
			for (int i = 0; i < buildCharData.Length; i++)
			{
				BuildCharData buildCharData2 = buildCharData[i];
				Recorder.Types.BuildChar buildChar = new Recorder.Types.BuildChar
				{
					Id = (uint)buildCharData2.charId
				};
				buildChar.Potentials.Clear();
				if (buildCharData2.potentialIds != null && buildCharData2.potentialIds.Length != 0)
				{
					for (int j = 0; j < buildCharData2.potentialIds.Length; j++)
					{
						int[] array = buildCharData2.potentialIds[j];
						Recorder.Types.Potential item = new Recorder.Types.Potential
						{
							Id = array[0],
							Level = array[1]
						};
						buildChar.Potentials.Add(item);
					}
				}
				buildChar.EquipmentEffects.Clear();
				if (buildCharData2.equipmentEffects != null && buildCharData2.equipmentEffects.Length != 0)
				{
					buildChar.EquipmentEffects.AddRange(buildCharData2.equipmentEffects);
				}
				gameRecorder.BuildInfo.Chars.Add(buildChar);
			}
		}
		gameRecorder.BuildInfo.Discs.Clear();
		if (buildDiscData != null && buildDiscData.Length != 0)
		{
			for (int i = 0; i < buildDiscData.Length; i++)
			{
				BuildDiscData buildDiscData2 = buildDiscData[i];
				Recorder.Types.Disc item2 = new Recorder.Types.Disc
				{
					Id = (uint)buildDiscData2.discId,
					BreakCount = buildDiscData2.breakCount,
					Advance = buildDiscData2.advance,
					Level = (uint)buildDiscData2.level
				};
				gameRecorder.BuildInfo.Discs.Add(item2);
			}
		}
		gameRecorder.BuildInfo.SecondarySkills.Clear();
		if (secondarySkills != null && secondarySkills.Length != 0)
		{
			gameRecorder.BuildInfo.SecondarySkills.AddRange(secondarySkills);
		}
		gameRecorder.BuildInfo.Notes.Clear();
		if (notes != null && notes.Length != 0)
		{
			for (int k = 0; k < notes.Length; k++)
			{
				Recorder.Types.Note item3 = new Recorder.Types.Note
				{
					Id = notes[k][0],
					Count = notes[k][1]
				};
				gameRecorder.BuildInfo.Notes.Add(item3);
			}
		}
	}

	public void SetExcludeIds(List<int> ids)
	{
		excludes.Clear();
		excludes.AddRange(ids);
	}

	public void StartRecord(string uid, Recorders.Types.LevelType levelType)
	{
		Debug.Log("开始记录:" + uid + ",t -> " + levelType);
		recordLevelType = levelType;
		gameRecorder = new Recorder
		{
			FloorId = (uint)AdventureGameContext.LevelLoadParam.floor
		};
		UID = uid;
		damageId = 1u;
		uploadDamageData = true;
		battleEntities = new Dictionary<long, BattleEntity>(10);
		battleId = 1u;
		entityLastCastFlag = new Dictionary<long, SkillPhaseFeatureFlag>();
		monsterDamageInfoMap = new Dictionary<long, MonsterDamageInfo>();
		isTimingLevel = levelType == Recorders.Types.LevelType.JointDrill1 || levelType == Recorders.Types.LevelType.Scoreboss;
		startTimingFrame = 0u;
		stopTimingFrame = 0u;
	}

	public void StopRecord()
	{
		if (gameRecorder == null)
		{
			return;
		}
		gameRecorder.MaxFrame = (uint)LockStepManager.frameCount;
		if (isTimingLevel)
		{
			gameRecorder.StartTimingFrame = startTimingFrame;
			gameRecorder.StopTimingFrame = stopTimingFrame;
		}
		ulong num = 0uL;
		foreach (KeyValuePair<long, MonsterDamageInfo> item3 in monsterDamageInfoMap)
		{
			MonsterDamageInfo value = item3.Value;
			num += (ulong)value.Damage;
			bool isBoss = battleEntities.TryGetValue(item3.Key, out var value2) && value2.Type == Recorder.Types.EntityType.Boss;
			Recorder.Types.MonsterDamage item = new Recorder.Types.MonsterDamage
			{
				MonsterId = value.MonsterId,
				Damage = (ulong)value.Damage,
				IsBoss = isBoss,
				InitialMaxHP = value.InitialMaxHP
			};
			gameRecorder.MonsterDamages.Add(item);
		}
		gameRecorder.TotalDamage = num;
		string text = System.IO.Path.Combine(Application.persistentDataPath, "Recorder");
		if (!Directory.Exists(text))
		{
			Directory.CreateDirectory(text);
		}
		string text2 = System.IO.Path.Combine(text, UID + ".rec");
		int towerId = 0;
		if (recordLevelType == Recorders.Types.LevelType.StarTower)
		{
			towerId = AdventureGameContext.LevelLoadParam.fixedRoguelikeInfo.startowerId;
		}
		else if (recordLevelType == Recorders.Types.LevelType.TravelerDuel)
		{
			towerId = CommonHelper.ParseStringParamToInt(AdventureGameContext.LevelLoadParam.id);
		}
		else if (recordLevelType == Recorders.Types.LevelType.JointDrill1)
		{
			towerId = CommonHelper.ParseStringParamToInt(AdventureGameContext.LevelLoadParam.id);
		}
		else if (recordLevelType == Recorders.Types.LevelType.Scoreboss)
		{
			towerId = CommonHelper.ParseStringParamToInt(AdventureGameContext.LevelLoadParam.id);
		}
		Recorders recorders = null;
		if (File.Exists(text2))
		{
			try
			{
				using (FileStream stream = new FileStream(text2, FileMode.Open, FileAccess.Read))
				{
					using GZipStream input = new GZipStream(stream, CompressionMode.Decompress);
					recorders = Recorders.Parser.ParseFrom(input);
				}
				File.Delete(text2);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
			}
		}
		if (recorders == null)
		{
			recorders = new Recorders
			{
				LvlType = recordLevelType,
				TowerId = (uint)towerId,
				UId = (ulong)AdventureModuleHelper.playerUid
			};
		}
		recorders.TowerId = (uint)towerId;
		gameRecorder.RoleList.Clear();
		foreach (KeyValuePair<int, Lua2CSharpInfo_CharAttribute> actorInitAttribute in _actorInitAttributes)
		{
			Recorder.Types.Role role = new Recorder.Types.Role
			{
				Id = (uint)actorInitAttribute.Key,
				Level = actorInitAttribute.Value.actorLevel,
				BreakCount = actorInitAttribute.Value.breakCount,
				Hp = actorInitAttribute.Value.Hp,
				Atk = actorInitAttribute.Value.Atk,
				Def = actorInitAttribute.Value.Def,
				MDef = actorInitAttribute.Value.MDef,
				CritRate = actorInitAttribute.Value.CritRate,
				CritResistance = actorInitAttribute.Value.CritResistance,
				CritPower = actorInitAttribute.Value.CritPower,
				HitRate = actorInitAttribute.Value.HitRate,
				Evd = actorInitAttribute.Value.Evd,
				DefIgnore = actorInitAttribute.Value.DefIgnore,
				DefPierce = actorInitAttribute.Value.DefPierce,
				WEP = actorInitAttribute.Value.WEP,
				FEP = actorInitAttribute.Value.FEP,
				SEP = actorInitAttribute.Value.SEP,
				AEP = actorInitAttribute.Value.AEP,
				LEP = actorInitAttribute.Value.LEP,
				DEP = actorInitAttribute.Value.DEP,
				WEE = actorInitAttribute.Value.WEE,
				FEE = actorInitAttribute.Value.FEE,
				SEE = actorInitAttribute.Value.SEE,
				AEE = actorInitAttribute.Value.AEE,
				LEE = actorInitAttribute.Value.LEE,
				DEE = actorInitAttribute.Value.DEE,
				WEI = actorInitAttribute.Value.WEI,
				FEI = actorInitAttribute.Value.FEI,
				SEI = actorInitAttribute.Value.SEI,
				AEI = actorInitAttribute.Value.AEI,
				LEI = actorInitAttribute.Value.LEI,
				DEI = actorInitAttribute.Value.DEI,
				WER = actorInitAttribute.Value.WER,
				FER = actorInitAttribute.Value.FER,
				SER = actorInitAttribute.Value.SER,
				AER = actorInitAttribute.Value.AER,
				LER = actorInitAttribute.Value.LER,
				DER = actorInitAttribute.Value.DER,
				WEERCD = actorInitAttribute.Value.WEERCD,
				FEERCD = actorInitAttribute.Value.FEERCD,
				SEERCD = actorInitAttribute.Value.SEERCD,
				AEERCD = actorInitAttribute.Value.AEERCD,
				LEERCD = actorInitAttribute.Value.LEERCD,
				DEERCD = actorInitAttribute.Value.DEERCD,
				ShieldBonus = actorInitAttribute.Value.ShieldBonus,
				IncomingShieldBonus = actorInitAttribute.Value.IncomingShieldBonus,
				SkinId = actorInitAttribute.Value.skinId,
				Suppress = actorInitAttribute.Value.Suppress,
				NormalDmgRatio = actorInitAttribute.Value.NormalDmgRatio,
				SkillDmgRatio = actorInitAttribute.Value.SkillDmgRatio,
				UltraDmgRatio = actorInitAttribute.Value.UltraDmgRatio,
				OtherDmgRatio = actorInitAttribute.Value.OtherDmgRatio,
				RcdNormalDmgRatio = actorInitAttribute.Value.RcdNormalDmgRatio,
				RcdSkillDmgRatio = actorInitAttribute.Value.RcdSkillDmgRatio,
				RcdUltraDmgRatio = actorInitAttribute.Value.RcdUltraDmgRatio,
				RcdOtherDmgRatio = actorInitAttribute.Value.RcdOtherDmgRatio,
				MarkDmgRatio = actorInitAttribute.Value.MarkDmgRatio,
				SummonDmgRatio = actorInitAttribute.Value.SummonDmgRatio,
				RcdSummonDmgRatio = actorInitAttribute.Value.RcdSummonDmgRatio,
				ProjectileDmgRatio = actorInitAttribute.Value.ProjectileDmgRatio,
				GENDMG = actorInitAttribute.Value.GENDMG,
				RcdProjectileDmgRatio = actorInitAttribute.Value.RcdProjectileDmgRatio,
				DMGPLUS = actorInitAttribute.Value.DMGPLUS,
				FINALDMG = actorInitAttribute.Value.FINALDMG,
				FINALDMGPLUS = actorInitAttribute.Value.FINALDMGPLUS,
				GENDMGRCD = actorInitAttribute.Value.GENDMGRCD,
				DMGPLUSRCD = actorInitAttribute.Value.DMGPLUSRCD,
				EnergyConvRatio = actorInitAttribute.Value.EnergyConvRatio,
				EnergyEfficiency = actorInitAttribute.Value.EnergyEfficiency,
				NormalCritRate = actorInitAttribute.Value.NormalCritRate,
				SkillCritRate = actorInitAttribute.Value.SkillCritRate,
				UltraCritRate = actorInitAttribute.Value.UltraCritRate,
				MarkCritRate = actorInitAttribute.Value.MarkCritRate,
				SummonCritRate = actorInitAttribute.Value.SummonCritRate,
				ProjectileCritRate = actorInitAttribute.Value.ProjectileCritRate,
				OtherCritRate = actorInitAttribute.Value.OtherCritRate,
				NormalCritPower = actorInitAttribute.Value.NormalCritPower,
				SkillCritPower = actorInitAttribute.Value.SkillCritPower,
				UltraCritPower = actorInitAttribute.Value.UltraCritPower,
				MarkCritPower = actorInitAttribute.Value.MarkCritPower,
				SummonCritPower = actorInitAttribute.Value.SummonCritPower,
				ProjectileCritPower = actorInitAttribute.Value.ProjectileCritPower,
				OtherCritPower = actorInitAttribute.Value.OtherCritPower,
				AttrId = actorInitAttribute.Value.attrId
			};
			if (actorInitAttribute.Value.SkillLevel != null && actorInitAttribute.Value.SkillLevel.Length != 0)
			{
				int[] skillLevel = actorInitAttribute.Value.SkillLevel;
				foreach (int item2 in skillLevel)
				{
					role.SkillLevelList.Add(item2);
				}
			}
			if (actorInitAttribute.Value.activeTalentInfos != null && actorInitAttribute.Value.activeTalentInfos.Count > 0)
			{
				foreach (bool activeTalentInfo in actorInitAttribute.Value.activeTalentInfos)
				{
					role.TalentInfoList.Add(activeTalentInfo);
				}
			}
			gameRecorder.RoleList.Add(role);
		}
		recorders.RecorderList.Add(gameRecorder);
		if (excludes.Count > 0)
		{
			RepeatedField<Recorder> repeatedField = new RepeatedField<Recorder>();
			repeatedField.AddRange(recorders.RecorderList);
			recorders.RecorderList.Clear();
			foreach (Recorder item4 in repeatedField)
			{
				if (!excludes.Contains((int)item4.FloorId))
				{
					recorders.RecorderList.Add(item4);
				}
			}
		}
		uint num2 = 0u;
		uint num3 = 0u;
		uint num4 = 0u;
		uint num5 = 0u;
		uint num6 = 0u;
		foreach (Recorder recorder in recorders.RecorderList)
		{
			num2 += recorder.FloorId;
			num3 += recorder.MaxFrame;
			num4 += (uint)recorder.Spawners.Count;
			num5 += (uint)recorder.Damages.Count;
			num6 += (uint)recorder.Deaths.Count;
		}
		uint val = num2 ^ num3 ^ num4 ^ num5 ^ num6;
		NovaAPI.AddRecorderKey(UID, (int)val);
		try
		{
			string text3 = text2 + ".tmp";
			using (FileStream stream2 = File.Create(text3))
			{
				using GZipStream output = new GZipStream(stream2, System.IO.Compression.CompressionLevel.Optimal);
				recorders.WriteTo(output);
			}
			File.Move(text3, text2);
		}
		catch (Exception exception2)
		{
			Debug.LogException(exception2);
			return;
		}
		Debug.Log("写入:" + text2);
		UID = string.Empty;
		damageId = 0u;
		battleId = 0u;
	}

	public void RecordStartTimingFrame(uint frame)
	{
		if (gameRecorder != null && isTimingLevel)
		{
			startTimingFrame = frame;
		}
	}

	public void RecordStopTimingFrame(uint frame)
	{
		if (gameRecorder != null && isTimingLevel && stopTimingFrame == 0)
		{
			stopTimingFrame = frame;
		}
	}

	private Recorder.Types.DamageSource GetDamageSource(SkillPhaseFeatureFlag flag)
	{
		if ((flag & SkillPhaseFeatureFlag.Ultimate) != 0)
		{
			return Recorder.Types.DamageSource.UltraSkill;
		}
		if ((flag & (SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Skill2 | SkillPhaseFeatureFlag.CertainSkillId)) != 0)
		{
			return Recorder.Types.DamageSource.NormalSkill;
		}
		return Recorder.Types.DamageSource.NormalAttack;
	}

	public void RecordEffectDamage(AdventureActor actor, long value, Recorder.Types.DamageType type, bool isHpLock = false, bool isShieldAbsorb = false)
	{
		if (uploadDamageData && AdventureActor.IsRecordActor(actor))
		{
			uint num = (isHpLock ? 4u : 0u);
			num = (isShieldAbsorb ? (num | 2) : num);
			Recorder.Types.Damage damage = new Recorder.Types.Damage
			{
				From = new Recorder.Types.Attacker(),
				To = new Recorder.Types.Defender(),
				DmgType = type,
				Value = value,
				FinalValue = value,
				DmgFlag = num
			};
			damage.To.ProtoId = (uint)actor.dataID;
			damage.To.HP = actor.actorHealthInfo.hp;
			damage.To.MaxHP = actor.actorHealthInfo.hpMax;
			damage.To.EntClass = ((!(actor is PlayerAdventureActor)) ? Recorder.Types.EntityClass.Monster : Recorder.Types.EntityClass.Role);
			RecordDamage(damage, 0L, actor.Id);
			RecordFinalDamage(actor.Id, value);
		}
	}

	public void RecordDamage(Recorder.Types.Damage damageData, long fromId, long toId)
	{
		if (gameRecorder == null)
		{
			return;
		}
		BattleEntity longEntity = GetLongEntity(toId);
		if (longEntity != null)
		{
			BattleEntity longEntity2 = GetLongEntity(fromId);
			damageData.From.Id = longEntity2?.Id ?? 0;
			damageData.To.Id = longEntity.Id;
			damageData.FrameId = (uint)LockStepManager.frameCount;
			damageData.Id = damageId++;
			if (fromId != 0L && entityLastCastFlag.TryGetValue(fromId, out var value))
			{
				damageData.DamageSource = GetDamageSource(value);
			}
			gameRecorder.Damages.Add(damageData);
		}
	}

	public void RecordFinalDamage(long targetEntityId, long finalDamageValue)
	{
		if (gameRecorder == null)
		{
			return;
		}
		BattleEntity longEntity = GetLongEntity(targetEntityId);
		if (longEntity != null && (longEntity.Type == Recorder.Types.EntityType.Boss || longEntity.Type == Recorder.Types.EntityType.Leader || longEntity.Type == Recorder.Types.EntityType.Elite))
		{
			if (!monsterDamageInfoMap.TryGetValue(targetEntityId, out var value))
			{
				value = new MonsterDamageInfo
				{
					MonsterId = 0u,
					InitialMaxHP = 0L,
					Damage = finalDamageValue
				};
				monsterDamageInfoMap.set_Item(targetEntityId, value);
			}
			else
			{
				value.Damage += finalDamageValue;
			}
		}
	}

	public void RecordBossRushBossLevelUp(AdventureActor actor, long hp, long maxHp, int bossLevel)
	{
		if (gameRecorder != null)
		{
			Recorder.Types.BossLevelUp item = new Recorder.Types.BossLevelUp
			{
				FrameId = (uint)LockStepManager.frameCount,
				Level = bossLevel,
				ProtoId = actor.dataID,
				HP = hp,
				MaxHP = maxHp
			};
			gameRecorder.BossLevelUps.Add(item);
		}
	}

	public void RecordCastSkill(long entityId, bool isPlayer, int skillId, int actorDataId, SkillPhaseFeatureFlag castFlag)
	{
		if (gameRecorder != null)
		{
			Recorder.Types.EntityClass entClass = ((!isPlayer) ? Recorder.Types.EntityClass.Monster : Recorder.Types.EntityClass.Role);
			Recorder.Types.CastSkill item = new Recorder.Types.CastSkill
			{
				FrameId = (uint)LockStepManager.frameCount,
				ProtoId = actorDataId,
				SkillId = skillId,
				EntClass = entClass
			};
			gameRecorder.CastSkills.Add(item);
			if (isPlayer)
			{
				entityLastCastFlag.set_Item(entityId, castFlag);
			}
		}
	}

	public void RecordMonsterSpawn(MonsterAdventureActor actor)
	{
		if (gameRecorder != null && (actor.monsterInfo.epicType == HotfixEnum.monsterEpicType.LORD || actor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || actor.monsterInfo.epicType == HotfixEnum.monsterEpicType.LEADER || actor.monsterInfo.epicType == HotfixEnum.monsterEpicType.BOSSRUSH || actor.monsterInfo.epicType == HotfixEnum.monsterEpicType.JOINTDRILLBOSS))
		{
			Recorder.Types.EntityType type = Recorder.Types.EntityType.Boss;
			if (actor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE)
			{
				type = Recorder.Types.EntityType.Elite;
			}
			else if (actor.monsterInfo.epicType == HotfixEnum.monsterEpicType.LEADER)
			{
				type = Recorder.Types.EntityType.Leader;
			}
			RecordSpawn(type, actor.Id, actor.dataID, actor.actorHealthInfo.hp, actor.actorHealthInfo.hpMax);
			monsterDamageInfoMap.set_Item(actor.Id, new MonsterDamageInfo
			{
				MonsterId = (uint)actor.dataID,
				InitialMaxHP = actor.actorHealthInfo.hpMax,
				Damage = 0L
			});
		}
	}

	public void RecordPlayerSpawn(PlayerAdventureActor actor)
	{
		if (gameRecorder != null)
		{
			Recorder.Types.EntityType type = Recorder.Types.EntityType.Player;
			RecordSpawn(type, actor.Id, actor.dataID, actor.actorHealthInfo.hp, actor.actorHealthInfo.hpMax);
		}
	}

	private void RecordSpawn(Recorder.Types.EntityType type, long id, int protoId, long hp, long maxhp)
	{
		BattleEntity battleEntity = new BattleEntity
		{
			lId = id,
			Type = type,
			Id = battleId++,
			Hp = hp
		};
		Recorder.Types.Spawn item = new Recorder.Types.Spawn
		{
			FrameId = (uint)LockStepManager.frameCount,
			Id = battleEntity.Id,
			EntType = type,
			ProtoId = (uint)protoId,
			HP = hp
		};
		battleEntities.set_Item(id, battleEntity);
		gameRecorder.Spawners.Add(item);
	}

	private BattleEntity GetLongEntity(long id)
	{
		battleEntities.TryGetValue(id, out var value);
		return value;
	}

	public void RecordDeath(long id)
	{
		if (gameRecorder != null)
		{
			BattleEntity longEntity = GetLongEntity(id);
			if (longEntity != null)
			{
				Recorder.Types.Death item = new Recorder.Types.Death
				{
					FrameId = (uint)LockStepManager.frameCount,
					Id = longEntity.Id
				};
				gameRecorder.Deaths.Add(item);
			}
		}
	}

	public List<BattleSample> UploadDamageList(string fileName)
	{
		string text = System.IO.Path.Combine(System.IO.Path.Combine(Application.persistentDataPath, "Recorder"), fileName + ".rec");
		if (!File.Exists(text))
		{
			Debug.LogError("文件 " + text + " 不存在");
			return null;
		}
		Recorders recorders = null;
		try
		{
			using FileStream stream = new FileStream(text, FileMode.Open, FileAccess.Read);
			using GZipStream input = new GZipStream(stream, CompressionMode.Decompress);
			recorders = Recorders.Parser.ParseFrom(input);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		if (recorders == null)
		{
			return null;
		}
		BattleSample battleSample = Trans2ServerNeed(recorders);
		if (battleSample == null)
		{
			return null;
		}
		uploadDamageData = false;
		return new List<BattleSample> { battleSample };
	}

	private BattleSample Trans2ServerNeed(Recorders gameRecorders)
	{
		if (gameRecorders == null || gameRecorders.RecorderList.Count == 0)
		{
			return null;
		}
		float[] array = new float[10];
		long num = 0L;
		for (int i = 0; i < gameRecorders.RecorderList.Count; i++)
		{
			Recorder recorder = gameRecorders.RecorderList.get_Item(i);
			if (recorder == null)
			{
				continue;
			}
			for (int j = 0; j < recorder.Damages.Count; j++)
			{
				Recorder.Types.Damage damage = recorder.Damages.get_Item(j);
				if (damage.From.EntClass == Recorder.Types.EntityClass.Role)
				{
					if (damage.From.Atk > array[0])
					{
						array[0] = damage.From.Atk;
					}
					if (damage.From.PerkIntensityRatio > array[1])
					{
						array[1] = damage.From.PerkIntensityRatio;
					}
					if (damage.From.SlotDmgRatio > array[2])
					{
						array[2] = damage.From.SlotDmgRatio;
					}
					if (damage.From.EE > array[3])
					{
						array[3] = damage.From.EE;
					}
					if (damage.From.GenDmgRatio > array[4])
					{
						array[4] = damage.From.GenDmgRatio;
					}
					if (damage.From.DmgPlus > array[5])
					{
						array[5] = damage.From.DmgPlus;
					}
					if (damage.From.CritRatio > array[6])
					{
						array[6] = damage.From.CritRatio;
					}
					if (damage.From.FinalDmgRatio > array[7])
					{
						array[7] = damage.From.FinalDmgRatio;
					}
					if (damage.From.FinalDmgPlus > array[8])
					{
						array[8] = damage.From.FinalDmgPlus;
					}
					if (damage.FinalValue > num)
					{
						num = damage.FinalValue;
					}
					if (damage.From.CritRate > array[9])
					{
						array[9] = damage.From.CritRate;
					}
				}
			}
		}
		return new BattleSample
		{
			fromSrcAtk = (int)array[0],
			fromPerkIntensityRatio = array[1],
			fromSlotDmgRatio = array[2],
			fromEE = array[3],
			fromGenDmgRatio = array[4],
			fromDmgPlus = (int)array[5],
			fromCritRatio = array[6],
			fromFinalDmgRatio = array[7],
			fromFinalDmgPlus = (int)array[8],
			dmg = num,
			critRate = array[9]
		};
	}

	internal long GenerateUniqueID()
	{
		_uidCounter++;
		return _uidCounter;
	}

	public void RegisterSearchable(Searchable search)
	{
		levelInstance?.RegisterSearchable(search);
	}

	public void UnRegisterSearchable(Searchable search)
	{
		levelInstance?.UnRegisterSearchable(search);
	}

	public void RegisterEntity(LogicEntity entity)
	{
		levelInstance?.RegisterEntity(entity);
	}

	public void UnRegisterEntity(LogicEntity entity, bool delayDrop = false)
	{
		levelInstance?.UnRegisterEntity(entity);
	}

	public void AddMonsterSummons(MonsterAdventureActor actor, long entityID, long summonID, bool isPlayerSummons, bool iDead = false, bool iAdd = true)
	{
		if (iAdd)
		{
			if (!iDead)
			{
				MonsterSummonData item = new MonsterSummonData
				{
					monster = actor,
					dataID = actor.dataID,
					SummonActorID = summonID,
					entityID = entityID,
					iAlive = true,
					isPlayerSummons = isPlayerSummons
				};
				monsterSummonInfos.Add(item);
			}
			else
			{
				if (monsterSummonInfos.Count <= 0)
				{
					return;
				}
				for (int i = 0; i < monsterSummonInfos.Count; i++)
				{
					if (monsterSummonInfos.get_Item(i).entityID == entityID)
					{
						monsterSummonInfos.get_Item(i).iAlive = false;
						break;
					}
				}
			}
		}
		else
		{
			if (monsterSummonInfos.Count <= 0)
			{
				return;
			}
			for (int num = monsterSummonInfos.Count - 1; num > -1; num--)
			{
				if (monsterSummonInfos.get_Item(num).entityID == entityID)
				{
					monsterSummonInfos.RemoveAt(num);
				}
			}
		}
	}

	public int GetMonsterSummonNum(long summonActorID, int monsterID = -1, bool iaLive = true)
	{
		if (monsterSummonInfos.Count <= 0)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < monsterSummonInfos.Count; i++)
		{
			if (monsterSummonInfos.get_Item(i).iAlive == iaLive && monsterSummonInfos.get_Item(i).SummonActorID == summonActorID && (monsterID < 0 || monsterSummonInfos.get_Item(i).dataID == monsterID))
			{
				num++;
			}
		}
		return num;
	}

	public void ClearMonsterSummonData()
	{
		monsterSummonInfos.Clear();
	}

	public void SetForzenTimeChildren(bool iAdd, LogicEntity cEntity = null)
	{
		if (levelInstance == null)
		{
			return;
		}
		if (!iAdd && forzenTimeChildren.Count > 0)
		{
			for (int i = 0; i < forzenTimeChildren.Count; i++)
			{
				forzenTimeChildren.get_Item(i).ignoreGlobalLogicTimeScale = false;
			}
			forzenTimeChildren.Clear();
		}
		else if (cEntity != null && !forzenTimeChildren.Contains(cEntity))
		{
			cEntity.ignoreGlobalLogicTimeScale = true;
			forzenTimeChildren.Add(cEntity);
		}
	}

	public void SetObstacleSate(string targetName, bool active)
	{
		levelInstance?.SetObstacleSate(targetName, active);
	}

	public void SpawnMinimapObject(HotfixEnum.monsterEpicType type, UnityEngine.Transform target)
	{
		levelInstance.SpawnMinimapObject(type, target);
	}

	public void SpawnMinimapTreasureBox(UnityEngine.Transform target)
	{
		if (SceneSingleton<AdventureMiniMapController>.Instance.isActived && !minimapObjects.ContainsKey(target))
		{
			string assetName = "Assets/AssetBundles/Environment/Minimap/baoxiang.prefab";
			GameObject gameObject = UnityEngine.Object.Instantiate(GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject, minmapRootNode);
			gameObject.transform.localEulerAngles = new Vector3(0f, -90f, 0f);
			gameObject.GetComponent<MinmapObject>().SetTarget(target);
			minimapObjects.Add(target, gameObject);
		}
	}

	public void ShowMinimap(UnityEngine.Transform target, bool show)
	{
		if (minimapObjects.TryGetValue(target, out var value))
		{
			value.SetActive(show);
		}
	}

	public void SpawnTreasureBox(ActorSpawnInfo spawnInfo, out Chest boxData, Action<AdventureLevelObjPoolMgr.PoolObj> callback)
	{
		boxData = null;
		levelInstance?.SpawnTreasureBox(spawnInfo, out boxData, callback);
	}

	public void SpawnMonster(ActorSpawnInfo spawnInfo, Action<AdventureLevelObjPoolMgr.PoolObj, bool> callback, SummonCfg cfg = null)
	{
		levelInstance?.SpawnMonster(spawnInfo, callback, cfg);
	}

	public AdventureLevelObjPoolMgr.PoolBase SpawnPlayer(ActorSpawnInfo spawnInfo)
	{
		return levelInstance?.SpawnPlayer(spawnInfo);
	}

	public void SpawnPlayer(int actorID, TSVector2 pos, FP posY, FP rot, Action<PlayerAdventureActor> callback)
	{
		levelInstance?.SpawnPlayer(actorID, pos, posY, rot, callback);
	}

	public void SpawnTrap(TrapSpawnInfo spawnInfo, Action<AdventureLevelObjPoolMgr.PoolObj> callback)
	{
		levelInstance?.SpawnTrap(spawnInfo, callback);
	}

	public void SpawnNPC(int npcID, int npcSkinID, TSVector2 pos, FP posY, FP rot, Action<NPCAdventureActor> callback)
	{
		levelInstance?.SpawnNPC(npcID, npcSkinID, pos, posY, rot, callback);
	}

	public void DespawnActor<T>(T instance) where T : AdventureActor
	{
		levelInstance?.DespawnActor(instance);
	}

	public void PreSpawnWeapon<T>(GameObject prefab) where T : AdventureWeapon
	{
		levelInstance?.PreSpawnWeapon<T>(prefab, weaponRootNode);
		SpawnWeapon<T>(prefab).gameObject.SetActive(value: false);
	}

	public T SpawnWeapon<T>(GameObject prefab, AdventureActor owner = null) where T : AdventureWeapon
	{
		AdventureLevelController adventureLevelController = levelInstance;
		if ((object)adventureLevelController == null)
		{
			return null;
		}
		return adventureLevelController.SpawnWeapon<T>(prefab, weaponRootNode, owner);
	}

	public void DespawnWeapon<T>(T instance) where T : AdventureWeapon
	{
		levelInstance?.DespawnWeapon(instance);
	}

	public void ReduceMonsterWeapon()
	{
		levelInstance?.ReduceMonsterWeaponCount();
	}

	public AdventureSkill SpawnSkill(int skillId)
	{
		if (string.IsNullOrEmpty(sharedConfigureData.SkillTemplatePath))
		{
			_logger.LogError("战斗模块配置中没有指定技能模板prefab!");
			return null;
		}
		return levelInstance?.SpawnSkill(skillId);
	}

	public void DespawnSkill(AdventureSkill instance)
	{
		levelInstance?.DespawnSkill(instance);
	}

	public LogicEntity QueryEntityByID(long id)
	{
		return levelInstance?.QueryEntityByID(id);
	}

	public LogicEntity QueryPlayerEntityByDataID(int dataID)
	{
		return levelInstance?.QueryPlayerEntityByDataID(dataID);
	}

	public LogicEntity QueryPlayerEntityByID(long id)
	{
		return levelInstance?.QueryPlayerEntityByID(id);
	}

	public LogicEntity QueryMonsterEntityByID(long id)
	{
		return levelInstance?.QueryMonsterEntityByID(id);
	}

	public List<LogicEntity> QueryMonsterEntitiesByDataID(int dataID)
	{
		return levelInstance?.QueryMonsterEntitiesByDataID(dataID);
	}

	public long SummonPlayerId(long id)
	{
		for (int i = 0; i < monsterSummonInfos.Count; i++)
		{
			if (monsterSummonInfos.get_Item(i).entityID == id && monsterSummonInfos.get_Item(i).isPlayerSummons)
			{
				return monsterSummonInfos.get_Item(i).SummonActorID;
			}
		}
		return 0L;
	}

	public int QueryMonsterActorAliveCount(bool excludePlayerSummoned = false)
	{
		if (!(levelInstance == null))
		{
			return levelInstance.QueryMonsterActorAliveCount(excludePlayerSummoned);
		}
		return 0;
	}

	public List<BaseSpawnPointGizmo> GetPlans(string planName, int x = -1, int y = -1)
	{
		return levelInstance?.GetPlans(planName, x, y);
	}

	public List<BaseSpawnPointGizmo> GetWaves(string waveName, int x = -1, int y = -1)
	{
		return levelInstance?.GetWaves(waveName, x, y);
	}

	public List<BaseSpawnPointGizmo> GetGroups(string groupName, int x = -1, int y = -1)
	{
		return levelInstance?.GetGroups(groupName, x, y);
	}

	public List<AdventureLevelTeleporter> GetTeleporters(string teleporterName, int x, int y)
	{
		return levelInstance?.GetTeleporters(teleporterName, x, y);
	}

	public List<BaseSpawnPointGizmo> GetTreasureBoxs(string boxName, int x = -1, int y = -1)
	{
		return levelInstance?.GetTreasureBoxs(boxName, x, y);
	}

	public void OpenTreasureAndNpcNew(List<int[]> prizeList, bool showNpc)
	{
		levelInstance?.OpenTreasureAndNpc(prizeList, showNpc);
	}

	public void RegionBossSummonMonster()
	{
		if (levelType == HotfixEnum.worldLevelType.RegionBoss)
		{
			levelInstance?.BossSummonMonster();
		}
	}

	public List<Vector3> GetBossSummonMonsterPoint(long bossEntityId, float innerRadius, float outsideRadius, int summonMonsterID, int summonCount)
	{
		if (levelType != HotfixEnum.worldLevelType.RegionBoss)
		{
			return null;
		}
		return levelInstance?.BossSummonMonsterPoint(bossEntityId, innerRadius, outsideRadius, summonMonsterID, summonCount);
	}

	public List<AdventureLevelTeleporter> GetTeleporters()
	{
		return levelInstance?.GetTeleporters();
	}

	public List<LogicEntity> GetPlayerSummons()
	{
		List<LogicEntity> list = monsterActors;
		if (list == null || list.Count == 0)
		{
			return null;
		}
		List<LogicEntity> list2 = new List<LogicEntity>();
		for (int i = 0; i < list.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = list.get_Item(i) as MonsterAdventureActor;
			if (monsterAdventureActor.monsterSummonInfo != null && monsterAdventureActor.monsterSummonInfo.SummonActor != null && monsterAdventureActor.monsterSummonInfo.SummonActor is PlayerAdventureActor)
			{
				list2.Add(monsterAdventureActor);
			}
		}
		return list2;
	}

	public List<LogicEntity> GetMonsters()
	{
		return monsterActors;
	}

	public List<NPCSpawnPointGizmo> GetNPCSpawnPoints(HotfixEnum.npcNewType npcType)
	{
		return levelInstance?.GetNPCs(npcType);
	}

	public TSVector2 GetPlaceHolderPosition(string name)
	{
		AdventurePlaceHolder placeHolder = GetPlaceHolder(name);
		if (!(placeHolder != null))
		{
			return TSVector2.zero;
		}
		return placeHolder.tsTransform.Position;
	}

	public void ActivePlaceHolder(string name, bool isActive)
	{
		AdventurePlaceHolder placeHolder = GetPlaceHolder(name);
		if (!(placeHolder != null))
		{
			return;
		}
		if (isActive)
		{
			foreach (LogicEntity placeHolder2 in placeHolders)
			{
				AdventurePlaceHolder component = placeHolder2.GetComponent<AdventurePlaceHolder>();
				if (component != null)
				{
					component.isActive = false;
				}
			}
		}
		placeHolder.isActive = isActive;
	}

	public bool GetActivePlaceHolderPosition(out TSVector2 position)
	{
		position = TSVector2.zero;
		foreach (LogicEntity placeHolder in placeHolders)
		{
			AdventurePlaceHolder component = placeHolder.GetComponent<AdventurePlaceHolder>();
			if (component != null && component.isActive)
			{
				position = component.tsTransform.Position;
				return true;
			}
		}
		return false;
	}

	public AdventurePlaceHolder GetActivePlaceHolder()
	{
		foreach (LogicEntity placeHolder in placeHolders)
		{
			AdventurePlaceHolder component = placeHolder.GetComponent<AdventurePlaceHolder>();
			if (component != null && component.isActive)
			{
				return component;
			}
		}
		return null;
	}

	private AdventurePlaceHolder GetPlaceHolder(string name)
	{
		foreach (LogicEntity placeHolder in placeHolders)
		{
			AdventurePlaceHolder component = placeHolder.GetComponent<AdventurePlaceHolder>();
			if (component?.holderName == name)
			{
				return component;
			}
		}
		return null;
	}

	public GameObject GetTimelineByAlias(AdventureActor actor, string alias, bool forceUseCommonConfig = false)
	{
		return GetRelatedResourceByAlias(actor, alias, forceUseCommonConfig, RelatedResourceGroupType.Timeline);
	}

	public GameObject GetMonsterTimelineByAlias(AdventureActor actor, string alias, bool forceUseCommonConfig = false)
	{
		return GetRelatedResourceByAlias(actor, alias, forceUseCommonConfig, RelatedResourceGroupType.MonsterTimeline);
	}

	public GameObject GetFxByAlias(AdventureActor actor, string alias, bool forceUseCommonConfig = false)
	{
		return GetRelatedResourceByAlias(actor, alias, forceUseCommonConfig, RelatedResourceGroupType.Fx);
	}

	public GameObject GetAreaEffectByAlias(AdventureActor actor, string alias, bool forceUseCommonConfig = false)
	{
		return GetRelatedResourceByAlias(actor, alias, forceUseCommonConfig, RelatedResourceGroupType.AreaEffect);
	}

	public GameObject GetDropByAlias(AdventureActor actor, string alias, bool forceUseCommonConfig = false)
	{
		return GetRelatedResourceByAlias(actor, alias, forceUseCommonConfig, RelatedResourceGroupType.Drops);
	}

	public GameObject GetBulletByAlias(AdventureActor actor, string alias, bool forceUseCommonConfig = false)
	{
		return GetRelatedResourceByAlias(actor, alias, forceUseCommonConfig, RelatedResourceGroupType.Bullet);
	}

	public AdventurePlayerFeedbackEffectConfigureData GetFeedbackEffectConfigureDataByAlias(AdventureActor actor, string alias, bool forceUseCommonConfig = false)
	{
		if (string.IsNullOrEmpty(alias))
		{
			return null;
		}
		AdventurePlayerFeedbackEffectConfigureData adventurePlayerFeedbackEffectConfigureData = null;
		if (forceUseCommonConfig)
		{
			adventurePlayerFeedbackEffectConfigureData = Config.CommonRelatedResourceConfig?.GetFeedbackEffectConfigureData(alias);
		}
		else
		{
			if (actor is PlayerAdventureActor { isSkin: not false } playerAdventureActor && playerAdventureActor.comboGroupForSkin != null)
			{
				adventurePlayerFeedbackEffectConfigureData = playerAdventureActor.comboGroupForSkin?.relatedResourceConfig?.GetFeedbackEffectConfigureData(alias);
			}
			if (adventurePlayerFeedbackEffectConfigureData == null)
			{
				adventurePlayerFeedbackEffectConfigureData = actor.comboGroup?.relatedResourceConfig?.GetFeedbackEffectConfigureData(alias);
			}
			if (adventurePlayerFeedbackEffectConfigureData == null)
			{
				adventurePlayerFeedbackEffectConfigureData = Config.CommonRelatedResourceConfig?.GetFeedbackEffectConfigureData(alias);
			}
		}
		return adventurePlayerFeedbackEffectConfigureData;
	}

	private GameObject GetRelatedResourceByAlias(AdventureActor actor, string alias, bool forceUseCommonConfig, RelatedResourceGroupType groupType)
	{
		if (string.IsNullOrEmpty(alias))
		{
			return null;
		}
		GameObject prefab = null;
		if (forceUseCommonConfig)
		{
			GetCommonRelatedResourceByAlias();
		}
		else
		{
			if (actor is PlayerAdventureActor { isSkin: not false } playerAdventureActor && playerAdventureActor.comboGroupForSkin != null)
			{
				GetActorRelatedResourceByAlias(playerAdventureActor.comboGroupForSkin);
			}
			if (prefab == null)
			{
				GetActorRelatedResourceByAlias(actor.comboGroup);
			}
			if (prefab == null)
			{
				GetCommonRelatedResourceByAlias();
			}
		}
		return prefab;
		void GetActorRelatedResourceByAlias(ComboGroup comboGroup)
		{
			prefab = groupType switch
			{
				RelatedResourceGroupType.Timeline => comboGroup?.relatedResourceConfig?.GetTimelineByAlias(alias), 
				RelatedResourceGroupType.MonsterTimeline => comboGroup?.relatedResourceConfig?.GetMonsterTimelineByAlias(alias), 
				RelatedResourceGroupType.Fx => comboGroup?.relatedResourceConfig?.GetFXByAlias(alias), 
				RelatedResourceGroupType.AreaEffect => comboGroup?.relatedResourceConfig?.GetAreaEffectByAlias(alias), 
				RelatedResourceGroupType.Drops => comboGroup?.relatedResourceConfig?.GetDropByAlias(alias), 
				RelatedResourceGroupType.Bullet => comboGroup?.relatedResourceConfig?.GetBulletByAlias(alias), 
				_ => prefab, 
			};
		}
		void GetCommonRelatedResourceByAlias()
		{
			prefab = groupType switch
			{
				RelatedResourceGroupType.Timeline => Config.CommonRelatedResourceConfig?.GetTimelineByAlias(alias), 
				RelatedResourceGroupType.MonsterTimeline => Config.CommonRelatedResourceConfig?.GetMonsterTimelineByAlias(alias), 
				RelatedResourceGroupType.Fx => Config.CommonRelatedResourceConfig?.GetFXByAlias(alias), 
				RelatedResourceGroupType.AreaEffect => Config.CommonRelatedResourceConfig?.GetAreaEffectByAlias(alias), 
				RelatedResourceGroupType.Drops => Config.CommonRelatedResourceConfig?.GetDropByAlias(alias), 
				RelatedResourceGroupType.Bullet => Config.CommonRelatedResourceConfig?.GetBulletByAlias(alias), 
				_ => prefab, 
			};
		}
	}

	public bool AddEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return AddEventListener(aEventName_string, aEventDelegate, EventDispatchMode.Default);
	}

	public bool AddEventListener(string aEventName_string, EventDelegate aEventDelegate, EventDispatchMode aEventDispatchMode)
	{
		return _dispatcher.AddEventListener(aEventName_string, aEventDelegate, aEventDispatchMode);
	}

	public bool HasEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return _dispatcher.HasEventListener(aEventName_string, aEventDelegate);
	}

	public bool RemoveEventListener(string aEventName_string, EventDelegate aEventDelegate)
	{
		return _dispatcher.RemoveEventListener(aEventName_string, aEventDelegate);
	}

	public bool RemoveAllEventListeners()
	{
		return _dispatcher.RemoveAllEventListeners();
	}

	public T GenerateEvent<T>(string eventType) where T : BaseAdventureEvent, new()
	{
		if (!_eventPool.ContainsKey(eventType))
		{
			_eventPool.Add(eventType, new List<BaseAdventureEvent>());
		}
		T val = null;
		List<BaseAdventureEvent> list = _eventPool.get_Item(eventType);
		if (list.Count > 0)
		{
			int index = list.Count - 1;
			val = list.get_Item(index) as T;
			list.RemoveAt(index);
		}
		else
		{
			val = new T();
		}
		val.Clear();
		return val;
	}

	public void ReleaseEvent(BaseAdventureEvent aEvent)
	{
		if (aEvent != null)
		{
			string type = aEvent.type;
			_eventPool.get_Item(type).Add(aEvent);
		}
	}

	public bool DispatchEvent(BaseAdventureEvent aEvent)
	{
		bool result = _dispatcher.DispatchEvent(aEvent);
		ReleaseEvent(aEvent);
		return result;
	}

	public bool DispatchEvent(IEvent aIEvent)
	{
		return _dispatcher.DispatchEvent(aIEvent);
	}

	public bool DispatchEventWithData(string type, object sender, object data)
	{
		return _dispatcher.DispatchEventWithData(type, sender, data);
	}

	public bool DispatchEventWithReturnData(string type, object sender, object data, out int returnInt, out object returnData)
	{
		return _dispatcher.DispatchEventWithReturnData(type, sender, data, out returnInt, out returnData);
	}

	public override void OnExitGame()
	{
		LevelEndDirect();
	}

	public bool ActiveInteractableEventTrigger(string triggerName, Action onComplete)
	{
		if (null != levelInstance)
		{
			return levelInstance.ActiveInteractableEventTrigger(triggerName, onComplete);
		}
		return false;
	}

	public bool ActiveAllInteractableEventTriggers(string triggerName)
	{
		if (null != levelInstance)
		{
			return levelInstance.ActiveAllInteractableEventTriggers(triggerName);
		}
		return false;
	}

	public bool ExecuteInteractableEventTrigger(AdventureInteractableEventTriggerGizmo trigger, bool uniqueness, Action onComplete)
	{
		if (null != levelInstance)
		{
			return levelInstance.ExecuteInteractableEventTrigger(trigger, uniqueness, onComplete);
		}
		return false;
	}

	public void SetCurCameraTriggerGizmo(AdventurePlayerCameraTriggerGizmo adventurePlayerCameraTriggerGizmo)
	{
		levelInstance?.SetCurCameraTriggerGizmo(adventurePlayerCameraTriggerGizmo);
	}

	public bool ActivePlayerCameraTrigger(string triggerName)
	{
		if (null != levelInstance)
		{
			return levelInstance.ActivePlayerCameraTrigger(triggerName);
		}
		return false;
	}

	public bool DeactivePlayerCameraTrigger(string triggerName)
	{
		if (null != levelInstance)
		{
			return levelInstance.DeactivePlayerCameraTrigger(triggerName);
		}
		return false;
	}

	public void SetLevelLogicValue(string strName, bool value)
	{
		if (_LogicValue.TryGetValue(strName, out var _))
		{
			_LogicValue.set_Item(strName, value);
		}
		else
		{
			_LogicValue.Add(strName, value);
		}
	}

	public void InitLevelType(AdventureModuleLevelLoadParams levelLoadParams)
	{
		if (levelLoadParams != null)
		{
			levelType = levelLoadParams.levelType;
			switch (levelLoadParams.loadType)
			{
			case AdventureModuleLevelLoadParams.BootConfigLoadType.Prologue:
				levelType = HotfixEnum.worldLevelType.Prologue;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.PrologueBattleLevel:
				levelType = HotfixEnum.worldLevelType.PrologueBattleLevel;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.Mainline:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.BattleTestBedComboClip:
				levelType = HotfixEnum.worldLevelType.Mainline;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.RegionBoss:
				levelType = HotfixEnum.worldLevelType.RegionBoss;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.WeeklyCopies:
				levelType = HotfixEnum.worldLevelType.WeeklyCopies;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_Formal:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_ByRandom:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_ByFixedId:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_ByFixedId_ThroughBootConfig:
				levelType = HotfixEnum.worldLevelType.StarTower;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_Limitless:
				levelType = HotfixEnum.worldLevelType.StarTower;
				limitlessMode = true;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.TravelerDuel:
				levelType = HotfixEnum.worldLevelType.TravelerDuel;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.DailyInstance_Formal:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.DailyInstance_BootConfig:
				levelType = HotfixEnum.worldLevelType.DailyInstance;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.InfinityTower_Fromal:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.InfinityTower_BootConfig:
				levelType = HotfixEnum.worldLevelType.InfinityTower;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.EquipmentInstance_Formal:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.EquipmentInstance_BootConfig:
				levelType = HotfixEnum.worldLevelType.EquipmentInstance;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.VampireSurvivor_Fromal:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.VampireSurvivor_BootConfig:
				levelType = HotfixEnum.worldLevelType.VampireInstance;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.SceneView:
				levelType = levelLoadParams.levelType;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.ScoreBoss_Fromal:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.ScoreBoss_BootConfig:
				levelType = HotfixEnum.worldLevelType.ScoreBoss;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.SkillInstance_Formal:
			case AdventureModuleLevelLoadParams.BootConfigLoadType.SkillInstance_BootConfig:
				levelType = HotfixEnum.worldLevelType.SkillInstance;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.AutoBattleBalance_BootConfig:
				levelType = HotfixEnum.worldLevelType.AutoBalance;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.ActivityLevelsInstance_Formal:
				levelType = HotfixEnum.worldLevelType.ActivityLevels;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.TowerDefense:
				levelType = HotfixEnum.worldLevelType.TowerDefense;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.BreakOut_BootConfig:
				levelType = HotfixEnum.worldLevelType.BrickBreaker;
				break;
			case AdventureModuleLevelLoadParams.BootConfigLoadType.ActivityStoryLevels:
				levelType = HotfixEnum.worldLevelType.ActivityStory;
				break;
			}
		}
	}

	public void LoadLevel(Action flowCallback = null, bool isFirstEnterModule = false)
	{
		MonoSingleton<GameController>.Instance.uploadDamageData = false;
		if (MonoSingleton<GameController>.Instance.metaData is AdventureModuleLevelLoadParams)
		{
			levelLoadParams = MonoSingleton<GameController>.Instance.metaData as AdventureModuleLevelLoadParams;
			if (null == levelInstance)
			{
				InitLevelType(levelLoadParams);
				_levelManagerAdapter?.LoadLevelController();
				AdventureLevelController adventureLevelController = null;
				switch (levelType)
				{
				case HotfixEnum.worldLevelType.StarTower:
				{
					adventureLevelController = controllerContent?.AddComponent<StarTowerLevelController>();
					bool flag = levelLoadParams.fixedRoguelikeInfo.nMapId != 0;
					if (isFirstEnterModule && !flag)
					{
						MonoSingleton<GameController>.Instance.ClearMapStageCount();
					}
					if (adventureLevelController is StarTowerLevelController starTowerLevelController)
					{
						starTowerLevelController.limitlessMode = limitlessMode;
					}
					break;
				}
				case HotfixEnum.worldLevelType.Prologue:
					adventureLevelController = controllerContent?.AddComponent<PrologueLevelControler>();
					break;
				case HotfixEnum.worldLevelType.PrologueBattleLevel:
					adventureLevelController = controllerContent?.AddComponent<PrologueBattleLevelController>();
					break;
				case HotfixEnum.worldLevelType.AutoBalance:
					adventureLevelController = controllerContent?.AddComponent<AutoBattleBalanceLevelController>();
					break;
				}
				if (adventureLevelController != null)
				{
					levelInstance = adventureLevelController;
				}
				if (levelInstance == null)
				{
					NovaLogger.Error($"错误的关卡类型:{levelType}");
					return;
				}
				levelInstance.Initialize(extraLevelInfo, _dispatcher, LevelStateChanged);
			}
			levelInstance.boxID = MonoSingleton<GameController>.Instance.boxID;
			teamConfig = AdventureGameContext.TeamConfig;
			GameRenderUtils.ResetSceneRenderingSetting(isExit: false);
			levelInstance.Load(levelLoadParams, () =>
			{
				DispatchEvent(AdventureLevelLoadCompleteEvent.Generate());
				InitLevel();
				List<AdventureActor> hideActors = null;
				if (levelInstance.HasTimelinePerformance())
				{
					MonoSingleton<GameCameraStackManager>.Instance.StartMainCameraBlackScreenTransition(0f);
					if (SceneSingleton<AdventurePlayerController>.Instance.inputEnabled)
					{
						SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
					}
					SceneSingleton<AdventureHUDController>.Instance.HideAllHUD();
					hideActors = new List<AdventureActor>();
					for (int i = 0; i < playerActors.Count; i++)
					{
						AdventureActor adventureActor = playerActors.get_Item(i) as AdventureActor;
						if (!adventureActor.isHide)
						{
							adventureActor.Hide();
							hideActors.Add(adventureActor);
						}
					}
				}
				else
				{
					MonoSingleton<GameCameraStackManager>.Instance.StartMainCameraBlackScreenTransition(0f);
				}
				StartCoroutine(DelayCallBack(() =>
				{
					Callback();
					MonoSingleton<ClientManager>.Instance.CloseLoadingView(CloseLoadingCallback);
				}));
				void CloseLoadingCallback()
				{
					if (levelInstance.HasTimelinePerformance())
					{
						for (int j = 0; j < entities.Count; j++)
						{
							LogicEntity logicEntity = entities.get_Item(j);
							if (logicEntity is MonsterAdventureActor)
							{
								AdventureActor adventureActor2 = logicEntity as AdventureActor;
								if (!adventureActor2.isHide)
								{
									adventureActor2.Hide();
									hideActors.Add(adventureActor2);
								}
							}
						}
						MonoSingleton<GameCameraStackManager>.Instance.StopMainCameraBlackScreenTransition(0.5f);
						levelInstance.PlayTimelinePerformance(() =>
						{
							LevelStart();
							if (hideActors != null)
							{
								for (int k = 0; k < hideActors.Count; k++)
								{
									hideActors.get_Item(k).Visible();
								}
								hideActors.Clear();
							}
							if (!SceneSingleton<AdventurePlayerController>.Instance.inputEnabled)
							{
								SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
							}
							SceneSingleton<AdventureHUDController>.Instance.ShowAllHUD();
							levelInstance.LevelStart_CheckBattleStartMsgTrigger();
						});
					}
					else
					{
						LevelStart();
						MonoSingleton<GameCameraStackManager>.Instance.StopMainCameraBlackScreenTransition(0.7f, () =>
						{
							levelInstance.LevelStart_CheckBattleStartMsgTrigger();
						});
					}
				}
			});
		}
		else
		{
			_logger.LogError("读取模块参数错误:load param is empty!");
		}
		void Callback()
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("LoadLevelComplete");
			flowCallback?.Invoke();
		}
	}

	private IEnumerator DelayCallBack(Action callBack)
	{
		yield return null;
		callBack?.Invoke();
	}

	private void LevelStateChanged(AdventureLevelState levelState)
	{
		adventureLevelState = levelState;
		_logger.LogInfo($"关卡状态:{levelState}");
	}

	protected void LevelLogicInit()
	{
		if (obstacles != null)
		{
			for (int i = 0; i < obstacles.Count; i++)
			{
				LogicEntity logicEntity = obstacles.get_Item(i);
				if (!(null == logicEntity))
				{
					UnityEngine.Transform transform = logicEntity.transform;
					Vector3 position = transform.position;
					logicEntity.tsTransform.PositionY = position.y;
					logicEntity.tsTransform.Position = new TSVector2(position.x, position.z);
					logicEntity.tsTransform.Rotation = 0f - transform.eulerAngles.y;
				}
			}
		}
		for (int j = 0; j < SceneSingleton<DeterministicCollisionManager>.Instance.colliders.Count; j++)
		{
			SceneSingleton<DeterministicCollisionManager>.Instance.colliders.get_Item(j).tsTransform.ActiveSelf = true;
		}
		SceneSingleton<DeterministicCollisionManager>.Instance.isSetTsEnable = true;
		if (AstarPath.active != null)
		{
			AstarPath.active.navmeshUpdates.updateInterval = Config.Level_NavmeshUpdateInterval;
			AstarPath.active.maxNearestNodeDistance = Config.Level_NavigationMaxNearestNodeDistance;
		}
		if (null != levelInstance)
		{
			levelInstance.InitTriggerGizmos();
			levelInstance.InitSpawnPoints();
		}
	}

	protected void LevelLogicUpdate()
	{
		levelInstance?.UpdateLogic(LockStepManager.deltaTime);
	}

	protected void InitLevel()
	{
		SetupSceneRenderingSetting();
		PlayLevelMusic();
		LockStepManager.Instance.Reset();
		AstarPath.active?.navmeshUpdates?.ResetLastUpdateTime();
		SceneSingleton<AdventurePlayerController>.Instance.ClearInputBuffer();
		LevelLogicInit();
		DispatchEvent(AdventureLevelReadyEvent.Generate());
	}

	protected void OnChangeStayRoom(IEvent evt)
	{
		if (evt is GeneralEvent generalEvent)
		{
			MinmapQuad minmapQuad = generalEvent.data as MinmapQuad;
			if (!(null == minmapQuad))
			{
				minmapQuad.Explore();
			}
		}
	}

	protected void LevelStart()
	{
		MonoSingleton<WwiseAudioManager>.Instance?.PostEvent("ui_loading_combatSFX_active", null, temporaryRes: false);
		_logger.LogInfo("level start");
		DispatchEvent(AdventureLevelStartEvent.Generate());
		levelInstance?.LevelStart(() =>
		{
		});
		SceneSingleton<AdventurePlayerController>.Instance.InitSwitchPlayerStatus();
		MonoSingleton<LuaManager>.Instance.FireEvent("LoadLevelRefresh");
		SceneSingleton<AdventurePlayerController>.Instance.EnableFateCardThemeManager();
		SceneSingleton<AdventurePlayerController>.Instance.EnableDiscScripts();
		SceneSingleton<AdventurePlayerController>.Instance.SaveGroupAttributeSnapshot();
		PlayerAdventureActor actor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		RecordPlayerSpawn(actor);
		SceneSingleton<AdventurePlayerController>.Instance.SummonMonsters();
		SceneSingleton<AdventurePlayerController>.Instance.InitAutoBattle();
		DispatchEvent(AdventureLevelStartFinishEvent.Generate());
	}

	public void Lua2CSharp_LevelStateChanged(bool isLevelFinish, float fadetime, bool isFailOrAbandon)
	{
		LevelEnd(isLevelFinish, notFade: false, fadetime, isFailOrAbandon);
	}

	public void LevelEndDirect()
	{
		LevelEnd(isLevelFinish: true, notFade: false, 0f, isFailOrAbandon: true);
	}

	protected void LevelEnd(bool isLevelFinish, bool notFade = false, float fadeT = 0f, bool isFailOrAbandon = false)
	{
		_logger.LogInfo("本关卡结束");
		PauseLogic();
		MonoSingleton<ClientManager>.Instance.OpenLoadingView(() =>
		{
			ResumeLogic();
			AdventureLevelEndEvent aEvent = AdventureLevelEndEvent.Generate();
			DispatchEvent(aEvent);
			levelInstance?.LevelEnd();
			SceneSingleton<AdventurePlayerController>.Instance.LevelEnd();
			SceneSingleton<AdventurePlayerController>.Instance.DisableFateCardThemeManager();
			SceneSingleton<AdventurePlayerController>.Instance.DisableDiscScripts();
			for (int num = entities.Count - 1; num >= 0; num--)
			{
				LogicEntity logicEntity = entities.get_Item(num);
				if (!FilterObject(logicEntity))
				{
					logicEntity.ActiveSelf = false;
				}
			}
			ClearData();
			AdventureFXManager.IsPlayingTimeline = false;
			ILRuntimeAPI.Clear();
			SceneSingleton<DeterministicCollisionManager>.Instance.isSetTsEnable = false;
			Singleton<InteractiveManager>.Instance.ClearData();
			Singleton<TriggerManager>.Instance.triggerComps.Clear();
			Singleton<BuffManager>.Instance.ClearBuffDatas();
			if (MonoSingleton<SoundBankManager>.Instance != null)
			{
				MonoSingleton<SoundBankManager>.Instance.UnLoadTemporaryBank(iTemp: true);
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("ADVENTURE_LEVEL_END");
			Singleton<TriggerManager>.Instance.ClearTrigger();
			UnloadLevel(isLevelFinish, () =>
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("ADVENTURE_LEVEL_UNLOAD_COMPLETE");
				AdventureLevelUnloadCompleteEvent aEvent2 = AdventureLevelUnloadCompleteEvent.Generate();
				DispatchEvent(aEvent2);
				if (isLevelFinish)
				{
					LevelFinish(isLevelFinish);
				}
				else
				{
					LoadLevel();
				}
			});
			if (!string.IsNullOrEmpty(leaveMusicEvent))
			{
				MonoSingleton<WwiseAudioManager>.Instance.PostEvent(leaveMusicEvent);
			}
		}, 0f, fadeT, null, isFailOrAbandon ? 17 : 3);
	}

	private bool FilterObject(LogicEntity entity)
	{
		if (entity is AdventurePlayerCameraTriggerGizmo adventurePlayerCameraTriggerGizmo)
		{
			return adventurePlayerCameraTriggerGizmo.dontDestory;
		}
		return false;
	}

	protected void UnloadLevel(bool levelFinish, Action callback)
	{
		if (null == levelInstance)
		{
			_logger.LogError("关卡实例为空");
			callback?.Invoke();
		}
		else if (!levelFinish)
		{
			levelInstance.Unload(callback);
		}
		else
		{
			levelInstance.Unload(callback);
			levelInstance.Clear();
		}
	}

	protected void LevelFinish(bool result)
	{
		_logger.LogInfo("冒险结束!");
		levelLoadParams = null;
		levelInstance.LevelFinish();
		levelInstance = null;
		AdventureLevelFinishEvent aEvent = AdventureLevelFinishEvent.Generate();
		DispatchEvent(aEvent);
		SceneSingleton<AdventureHUDController>.Instance.HideAllHUD();
		StopLevelMusic();
		MonoSingleton<GameController>.Instance.ClearMapStageCount();
		MonoSingleton<GameController>.Instance.ClearMetaData();
	}

	public void ActiveVirtualMonsterSpawnWave(string virtualSpawnWaveID, AdventureActor summoner = null)
	{
		levelInstance?.ActiveVirtualMonsterSpawnWave(virtualSpawnWaveID, summoner);
	}

	public void KillAllMonsters(bool clearOrDestroy = false, bool ignoreAll = false, bool ignoreSpawnState = true, bool ignoreDiedState = false, int appointID = 0)
	{
		levelInstance?.KillAllMonsters(clearOrDestroy, ignoreAll, ignoreSpawnState, ignoreDiedState, appointID);
	}

	public void OpenActiveTeleporter()
	{
		if (null == levelInstance)
		{
			_logger.LogError("关卡实例为空");
		}
		else if (levelType == HotfixEnum.worldLevelType.StarTower)
		{
			(levelInstance as StarTowerLevelController).ActiveLevelTeleporters(isActive: true);
		}
		else
		{
			_logger.LogError($"错误的关卡类型:{levelType}");
		}
	}

	private void OnTimelineLoadingViewChange(IEvent evt)
	{
		if ((evt as AdventureLevelTimelineLoadingViewEvent).isStart)
		{
			MonoSingleton<GameCameraStackManager>.Instance.StopMainCameraBlackScreenTransition();
		}
		else
		{
			MonoSingleton<GameCameraStackManager>.Instance.StartMainCameraBlackScreenTransition(0.5f);
		}
	}

	public void AutoBattle(bool autoBattle)
	{
		this.autoBattle = autoBattle;
		if (null == autoBattleController)
		{
			AdventureAutoBattleConfig autoBattleConfig = AdventureGameContext.AutoBattleConfig;
			autoBattleController = gameObject.GetOrAddComponent<AdventureAutoBattleController>();
			autoBattleController.Initialize(autoBattleConfig);
		}
		if (this.autoBattle)
		{
			autoBattleController.Active();
		}
		else
		{
			autoBattleController.DeActive();
		}
	}

	public void JumpOverCurLevel()
	{
		AdventureChangeLevelStateEvent adventureChangeLevelStateEvent = AdventureChangeLevelStateEvent.Generate();
		adventureChangeLevelStateEvent.levelState = HotfixEnum.levelState.Success;
		adventureChangeLevelStateEvent.clearMonster = true;
		DispatchEvent(adventureChangeLevelStateEvent);
		if (null != levelInstance)
		{
			levelInstance.SetMonsterGizmoAllActivedAndDied();
			if (levelInstance is StarTowerLevelController)
			{
				(levelInstance as StarTowerLevelController).CloseDoorObstacle();
			}
		}
	}

	protected void LoadMainlineLevelScene(string loadSceneName, Action flowCallback)
	{
		string scenePath = "Assets/AssetBundles/" + loadSceneName;
		MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
		{
			MonoSingleton<ClientManager>.Instance.UpdateLoadingView((float)process / 100f);
			if (process == 200)
			{
				_logger.LogInfo("关卡场景加载完毕");
				if (adventureLevelState == AdventureLevelState.Init)
				{
					flowCallback?.Invoke();
				}
				else
				{
					MonoSingleton<ClientManager>.Instance.CloseLoadingView(() =>
					{
						flowCallback?.Invoke();
					}, 1f);
				}
			}
			return true;
		});
	}

	protected void SetupSceneRenderingSetting()
	{
		string text = levelInstance.scenePath;
		switch (levelType)
		{
		case HotfixEnum.worldLevelType.Prologue:
			text = "Assets/AssetBundles/" + levelLoadParams.mainlineFloorData.SceneName;
			break;
		case HotfixEnum.worldLevelType.PrologueBattleLevel:
			text = "Assets/AssetBundles/" + levelLoadParams.mainlineFloorData.SceneName;
			break;
		case HotfixEnum.worldLevelType.RegionBoss:
			text = "Assets/AssetBundles/" + levelLoadParams.regionBossFloor.SceneName;
			break;
		case HotfixEnum.worldLevelType.Mainline:
			text = "Assets/AssetBundles/" + levelLoadParams.mainlineFloorData.SceneName;
			break;
		case HotfixEnum.worldLevelType.StarTower:
			text = "Assets/AssetBundles/" + levelLoadParams.starTowerScenePath;
			break;
		case HotfixEnum.worldLevelType.AutoBalance:
			text = "Assets/AssetBundles/" + levelLoadParams.mainlineFloorData.SceneName;
			break;
		case HotfixEnum.worldLevelType.TowerDefense:
			text = "Assets/AssetBundles/" + levelLoadParams.dynamicSceneName;
			break;
		}
		if (!string.IsNullOrEmpty(text))
		{
			Scene sceneByName = BundleHandler.GetSceneByName(text);
			if (sceneByName.IsValid())
			{
				GameRenderUtils.SetupSceneRenderingSetting(sceneByName);
			}
		}
	}

	public void PlayLevelMusic()
	{
		string soundName = levelInstance.musicName;
		leaveMusicEvent = levelInstance.leaveMusicEvent;
		switch (levelType)
		{
		case HotfixEnum.worldLevelType.Mainline:
		case HotfixEnum.worldLevelType.Prologue:
		case HotfixEnum.worldLevelType.PrologueBattleLevel:
			soundName = levelLoadParams.mainlineFloorData.BGM;
			leaveMusicEvent = levelLoadParams.mainlineFloorData.LeaveTriggerEvent;
			break;
		case HotfixEnum.worldLevelType.RegionBoss:
			soundName = levelLoadParams.regionBossFloor.BGM;
			leaveMusicEvent = levelLoadParams.regionBossFloor.LeaveTriggerEvent;
			break;
		case HotfixEnum.worldLevelType.StarTower:
			if (levelLoadParams != null && levelLoadParams.starTowerMap != null)
			{
				soundName = levelLoadParams.starTowerMap.BGMRes;
				leaveMusicEvent = levelLoadParams.starTowerMap.CompleteSoundEffectRes;
			}
			break;
		case HotfixEnum.worldLevelType.AutoBalance:
			if (levelLoadParams != null && levelLoadParams.mainlineFloorData != null)
			{
				soundName = levelLoadParams.mainlineFloorData.BGM;
				leaveMusicEvent = levelLoadParams.mainlineFloorData.LeaveTriggerEvent;
			}
			break;
		case HotfixEnum.worldLevelType.TowerDefense:
			if (levelLoadParams != null)
			{
				soundName = levelLoadParams.dynamicBGM;
				leaveMusicEvent = levelLoadParams.dynamicLeaveMusicEvent;
			}
			break;
		}
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound(soundName);
	}

	public void PlayBossBgm()
	{
		if (levelType == HotfixEnum.worldLevelType.StarTower && levelLoadParams != null && levelLoadParams.starTowerFloorSet != null)
		{
			HotfixEnum.starTowerRoomType roomType = (HotfixEnum.starTowerRoomType)levelLoadParams.starTowerFloorSet.RoomType;
			if (roomType == HotfixEnum.starTowerRoomType.BossRoom || roomType == HotfixEnum.starTowerRoomType.FinalBossRoom)
			{
				string bGMRes = levelLoadParams.starTowerMap.BGMRes;
				MonoSingleton<WwiseAudioManager>.Instance.PlaySound(bGMRes);
			}
		}
	}

	public void StopLevelMusic()
	{
		MonoSingleton<WwiseAudioManager>.Instance.StopMusice(isCombat: true);
	}

	public void PauseLevelMusic()
	{
		MonoSingleton<WwiseAudioManager>.Instance.PauseOrResumeMusice();
	}

	public void ResumeLevelMusic()
	{
		MonoSingleton<WwiseAudioManager>.Instance.PauseOrResumeMusice(isPause: false);
	}

	protected void TimeControlUpdate()
	{
		if (_globalTimeControlManager != null)
		{
			FP fP = _globalTimeControlManager.Update(LockStepManager.fixedDeltaTime, LockStepManager.unscaledDeltaTime);
			if (LockStepManager.logicTimeScale != _globalTimeControlManager.finalLogicScaleValue)
			{
				LockStepManager.logicTimeScale = _globalTimeControlManager.finalLogicScaleValue;
				AdventureFXManager.globalTimeScale = (float)_globalTimeControlManager.finalLogicScaleValue;
			}
			if (LockStepManager.globalTimeScale != fP)
			{
				LockStepManager.globalTimeScale = fP;
			}
		}
	}

	public void TimeControlReset()
	{
		if (_globalTimeControlManager != null)
		{
			_globalTimeControlManager.Stop();
		}
		LockStepManager.globalTimeScale = 1f;
		LockStepManager.globalPerformTimeScale = 1f;
		LockStepManager.globalTimeScaleMultiplier = 1f;
		LockStepManager.logicTimeScale = 1f;
		AdventureFXManager.globalTimeScale = 1f;
	}

	public AdventureTimeControlHandler FreezeFrame(FP timeScale, FP duration, Action onFinish = null)
	{
		AdventureTimeControlHandler adventureTimeControlHandler = globalTimeControlManager.GenerateTimeControlHandler();
		adventureTimeControlHandler.duration = ((duration <= FP.Zero) ? FP.MaxValue : duration);
		adventureTimeControlHandler.timeScaleTo = TSMath.Max(FP.Zero, timeScale);
		adventureTimeControlHandler.onFinish = onFinish;
		return adventureTimeControlHandler;
	}

	public AdventureTimeControlHandler LogicTimeScale(FP timeScale, FP duration = default(FP), Action onFinish = null)
	{
		AdventureTimeControlHandler adventureTimeControlHandler = globalTimeControlManager.GenerateTimeControlHandler(isLogicTime: true);
		adventureTimeControlHandler.duration = ((duration <= FP.Zero) ? FP.MaxValue : duration);
		adventureTimeControlHandler.timeScaleTo = TSMath.Max(FP.Zero, timeScale);
		adventureTimeControlHandler.onFinish = onFinish;
		return adventureTimeControlHandler;
	}

	public bool InGlobalFreezeFrame()
	{
		return globalTimeControlManager.TimeControlHandlerCount > 0;
	}

	protected void LockStepUpdate()
	{
		if (isPause)
		{
			return;
		}
		DeterministicCollisionManager instance = SceneSingleton<DeterministicCollisionManager>.Instance;
		RVOSimulator active = RVOSimulator.active;
		instance.lockCollidersListUpdate = true;
		if (adventureLevelState == AdventureLevelState.LevelStart || adventureLevelState == AdventureLevelState.BattleEnd)
		{
			TimeControlUpdate();
			logicCoroutineScheduler.UpdateAllCoroutines(LockStepManager.deltaTime);
			SceneSingleton<ActorGroupManager>.Instance.UpdateActorGroups();
			Singleton<TriggerManager>.Instance.LogicUpdate();
			LevelLogicUpdate();
			DOTween.ManualUpdate((float)LockStepManager.deltaTime, (float)LockStepManager.unscaledDeltaTime);
			for (int i = 0; i < playerActors.Count; i++)
			{
				_collisionDetectionEntities.Add((AdventureActor)playerActors.get_Item(i));
			}
			for (int j = 0; j < monsterActors.Count; j++)
			{
				_collisionDetectionEntities.Add((AdventureActor)monsterActors.get_Item(j));
			}
			CollisionDetectionSolve(_collisionDetectionEntities);
			_collisionDetectionEntities.Clear();
			if (active != null)
			{
				active.GetSimulator().Update();
			}
			SceneSingleton<AdventurePlayerController>.Instance?.UpdateSwitchTargetCD(LockStepManager.deltaTime);
		}
		instance.lockCollidersListUpdate = false;
		instance.UpdateCollidersList();
		UpdateLogicTimesList();
		HandleActionsOnEndOfLogicFrame();
	}

	public void PauseLogic()
	{
		EqueueActionOnEndOfLogicFrame(Pause_Internal);
	}

	protected void Pause_Internal()
	{
		_pauseRC++;
		if (_pauseRC == 1)
		{
			LockStepManager.Instance.Pause();
			AdventurePauseLogicEvent aEvent = AdventurePauseLogicEvent.Generate();
			DispatchEvent(aEvent);
		}
	}

	public void ResumeLogic()
	{
		EqueueActionOnEndOfLogicFrame(Resume_Internal);
	}

	protected void Resume_Internal()
	{
		_pauseRC--;
		if (_pauseRC == 0)
		{
			LockStepManager.Instance.Resume();
			AdventureResumeLogicEvent aEvent = AdventureResumeLogicEvent.Generate();
			DispatchEvent(aEvent);
		}
	}

	protected void UpdateLogicEntities()
	{
		levelInstance?.UpdateLogicEntities();
	}

	protected void UpdateLogicTimesList()
	{
		RemoveNoActiveEntitied();
	}

	private void RemoveNoActiveEntitied()
	{
		levelInstance?.RemoveNoActiveEntitied();
	}

	protected void CollisionDetectionSolve(List<AdventureActor> playerActorsAndMonsters)
	{
		int frameCount = LockStepManager.frameCount;
		DeterministicCollisionManager instance = SceneSingleton<DeterministicCollisionManager>.Instance;
		instance.CollisionDetectionPreSolve();
		for (int num = playerActorsAndMonsters.Count - 1; num >= 0; num--)
		{
			AdventureActor adventureActor = playerActorsAndMonsters.get_Item(num);
			ActorHealthInfo actorHealthInfo = ((adventureActor == null) ? null : adventureActor.GetLogicComponent<ActorHealthInfo>());
			if (actorHealthInfo != null && adventureActor != null && actorHealthInfo.isAlive)
			{
				AABB checkBounds = adventureActor.dtCollider.ColliderBounds;
				instance.quadTree.GetColliding(ref checkBounds, _collisionDetectList);
				DeterministicCollider dtCollider = adventureActor.dtCollider;
				for (int num2 = _collisionDetectList.Count - 1; num2 >= 0; num2--)
				{
					DeterministicCollider deterministicCollider = _collisionDetectList.get_Item(num2);
					if (deterministicCollider.priority < 0)
					{
						_collisionDetectList.RemoveAt(num2);
					}
					else if (dtCollider == deterministicCollider)
					{
						_collisionDetectList.RemoveAt(num2);
					}
					else
					{
						actorHealthInfo = deterministicCollider.Entity.GetLogicComponent<ActorHealthInfo>();
						if (actorHealthInfo != null && !actorHealthInfo.isAlive)
						{
							_collisionDetectList.RemoveAt(num2);
						}
					}
				}
				_collisionDetectList.Sort((DeterministicCollider a, DeterministicCollider b) => a.priority.CompareTo(b.priority));
				for (int num3 = 0; num3 < _collisionDetectList.Count; num3++)
				{
					instance.ContactEvaluate(frameCount, dtCollider, _collisionDetectList.get_Item(num3), duplex: true);
				}
				dtCollider.SeparateWithRemaining(frameCount);
			}
		}
	}

	internal void DriveUpdate()
	{
		levelInstance?.VisualUpdateEntities();
		if (isPause)
		{
			HandleActionsOnEndOfLogicFrame();
		}
	}
}
