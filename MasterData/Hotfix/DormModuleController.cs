using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;
using XLua;

public class DormModuleController : ModuleController<DormModuleController>, IEventDispatcher
{
	private LogManager.Logger _logger;

	private AIAdapter _levelManagerAdapter;

	private StandaloneLockStepManager _lockStepManager;

	internal const long INVALID_UID = -1L;

	private long _uidCounter;

	private bool _lockEntitiesListUpdate;

	private List<DynamicSimpleEntity> _delayDespawnEntities = new List<DynamicSimpleEntity>();

	private Dictionary<long, DynamicSimpleEntity> _entityIDMap = new Dictionary<long, DynamicSimpleEntity>();

	private const string DORM_LEVEL_STATE_CHANGED = "DORM_LEVEL_STATE_CHANGED";

	private const string DORM_LEVEL_FINISH = "DORM_LEVEL_FINISH";

	private EventDispatcher _dispatcher;

	protected readonly Dictionary<string, List<BaseAdventureEvent>> _eventPool = new Dictionary<string, List<BaseAdventureEvent>>(50);

	private readonly string _levelManagerTypeStr = "AIScript.Level.LevelManager";

	private GameObject dynamicLevelControllerContent;

	private AdventureTimeControlManager _globalTimeControlManager;

	private List<DynamicSimpleEntity> entities { get; set; } = new List<DynamicSimpleEntity>();

	public List<DynamicSimpleEntity> ActorEntities => levelInstance?.ActorEntities;

	private DynamicLevelController _levelInstance { get; set; }

	public DynamicLevelController levelInstance
	{
		get
		{
			return _levelInstance;
		}
		set
		{
			_levelInstance = value;
		}
	}

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

	protected override void Awake()
	{
		base.Awake();
		_dispatcher = new EventDispatcher();
		_logger = Singleton<LogManager>.Instance.get_Item("DynamicModule");
	}

	private void OnEnable()
	{
		RegisterEventListeners();
	}

	private void OnDisable()
	{
		RemoveAllEventListeners();
	}

	public override void OnEnter(Action flowCallback)
	{
		if (TSRandom.instance == null)
		{
			TSRandom.instance = TSRandom.New(Environment.TickCount);
		}
		EnsureLockStepManager();
		if (_levelManagerAdapter == null)
		{
			_levelManagerAdapter = new AIAdapter();
			if (!_levelManagerAdapter.Initialize(_levelManagerTypeStr, gameObject))
			{
				_levelManagerAdapter = null;
			}
		}
		SceneSingleton<DormCameraController>.Instance.InitCameraController();
		if (dynamicLevelControllerContent == null)
		{
			dynamicLevelControllerContent = new GameObject("DynamicModuleLevelController");
			dynamicLevelControllerContent.transform.SetParent(transform);
		}
		AdventureSelfFXHandler.ManualInitialize = true;
		LoadLevel(flowCallback);
	}

	public override void OnBeforeExit()
	{
		TimeControlReset();
	}

	public override void OnExit(Action flowCallback)
	{
		MonoSingleton<GameController>.Instance.ClearSeed();
		GameRenderUtils.ResetSceneRenderingSetting(isExit: true);
		AdventureSelfFXHandler.ManualInitialize = false;
		SceneSingleton<DormCameraController>.Instance.ReleaseCameraController();
		ReleaseLockStepManager();
		base.OnExit(flowCallback);
	}

	private void EnsureLockStepManager()
	{
		if (!(LockStepManager.Instance != null))
		{
			_lockStepManager = gameObject.AddComponent<StandaloneLockStepManager>();
		}
	}

	private void ReleaseLockStepManager()
	{
		if (_lockStepManager != null)
		{
			UnityEngine.Object.Destroy(_lockStepManager);
			_lockStepManager = null;
		}
	}

	public DynamicSimpleEntity QueryEntityByID(long id)
	{
		_entityIDMap.TryGetValue(id, out var value);
		if (value != null && !value.isInvalid)
		{
			return value;
		}
		return null;
	}

	public void RegisterEntity(DynamicSimpleEntity entity)
	{
		levelInstance?.RegisterEntity(entity);
	}

	public void UnRegisterEntity(DynamicSimpleEntity entity)
	{
		levelInstance?.UnRegisterEntity(entity);
	}

	private void UpdateEntitiesList()
	{
		for (int i = 0; i < _delayDespawnEntities.Count; i++)
		{
			DynamicSimpleEntity entity = _delayDespawnEntities.get_Item(i);
			UnRegisterEntity(entity);
		}
		_delayDespawnEntities.Clear();
	}

	private void RegisterEventListeners()
	{
		Singleton<EventDispatchManager>.Instance?.AddEventListener("DORM_LEVEL_STATE_CHANGED", LevelStateChanged);
	}

	private void LevelStateChanged(IEvent iEvent)
	{
		if (iEvent is GeneralEvent generalEvent)
		{
			LuaTable obj = generalEvent.data as LuaTable;
			float floatValue = 0f;
			bool result = false;
			bool.TryParse(obj.get_Item((object)1).ToString(), out result);
			CommonHelper.TryParseStringParamToFloat(obj.get_Item((object)2).ToString(), out floatValue);
			LevelStateChanged(result, floatValue);
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
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("DORM_LEVEL_STATE_CHANGED", LevelStateChanged);
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

	public DynamicLevelController InitDynamicLevelControllerContent(Type levelController)
	{
		if (null == dynamicLevelControllerContent)
		{
			return null;
		}
		if (dynamicLevelControllerContent.GetComponent(levelController) is DynamicLevelController result)
		{
			return result;
		}
		return dynamicLevelControllerContent.AddComponent(levelController) as DynamicLevelController;
	}

	private void InitModuleLevel()
	{
		levelInstance.Initialize(_dispatcher);
	}

	public void LoadLevel(Action flowCallback = null)
	{
		_levelManagerAdapter?.LoadDynamicModuleLevelController();
		if (levelInstance == null)
		{
			_logger.LogError("错误的关卡类型");
			return;
		}
		levelInstance.Load(() =>
		{
			MonoSingleton<GameCameraStackManager>.Instance.StopMainCameraBlackScreenTransition(0.2f);
			StartCoroutine(DelayCallBack(() =>
			{
				flowCallback?.Invoke();
				MonoSingleton<ClientManager>.Instance.CloseLoadingView(() =>
				{
					LevelStart();
				});
			}));
		});
		GameRenderUtils.ResetSceneRenderingSetting(isExit: false);
	}

	protected void UnloadLevel(bool levelFinish, Action callback)
	{
		if (null == levelInstance)
		{
			_logger.LogError("关卡实例为空");
			callback?.Invoke();
		}
		else
		{
			levelInstance.Unload(callback);
		}
	}

	private void LevelStart()
	{
		levelInstance?.LevelStart();
	}

	private IEnumerator DelayCallBack(Action callBack)
	{
		yield return null;
		callBack?.Invoke();
	}

	public void LevelStateChanged(bool isLevelFinish, float fadeTime)
	{
		LevelEnd(isLevelFinish, fadeTime);
	}

	private void LevelEnd(bool isLevelFinish, float fadeTime = 0f)
	{
		MonoSingleton<ClientManager>.Instance.OpenLoadingView(() =>
		{
			levelInstance?.LevelEnd();
			if (MonoSingleton<SoundBankManager>.Instance != null)
			{
				MonoSingleton<SoundBankManager>.Instance.UnLoadTemporaryBank(iTemp: true);
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("ADVENTURE_LEVEL_END");
			UnloadLevel(isLevelFinish, () =>
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("ADVENTURE_LEVEL_UNLOAD_COMPLETE");
				if (isLevelFinish)
				{
					LevelFinish();
				}
				else
				{
					LoadLevel();
				}
			});
		}, fadeTime);
	}

	protected void LevelFinish()
	{
		levelInstance.LevelFinish();
		levelInstance = null;
		UnityEngine.Object.DestroyImmediate(dynamicLevelControllerContent);
		dynamicLevelControllerContent = null;
		MonoSingleton<WwiseAudioManager>.Instance.StopMusice(isCombat: true);
		MonoSingleton<GameController>.Instance.ClearMapStageCount();
		MonoSingleton<GameController>.Instance.ClearMetaData();
		MonoSingleton<LuaManager>.Instance.FireEvent("DORM_LEVEL_FINISH");
	}

	private void InitModule()
	{
		ModuleLogicInit();
	}

	protected void ModuleLogicInit()
	{
		if (AstarPath.active != null)
		{
			AstarPath.active.navmeshUpdates.updateInterval = 0.25f;
			AstarPath.active.maxNearestNodeDistance = 100f;
		}
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
}
