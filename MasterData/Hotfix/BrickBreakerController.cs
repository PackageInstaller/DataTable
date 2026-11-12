#define LOG_ERROR
using System;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;
using XLua;

public class BrickBreakerController : AdventureLevelController
{
	private BreakOutFloor floorData;

	private bool isStartTime;

	private FP timeing = 0;

	private int totalTime;

	private int timeLimit;

	private int currentLife;

	private int exceptLife;

	private int currentScrole;

	private int destructCount;

	private int roleId;

	private bool uiOpRestart;

	protected bool isSettlement;

	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	protected float _zoomFreeze;

	protected float _zoomDurationTime;

	protected UIGameSystemSetup.TimeLinePlayType timeLinePlayType;

	protected readonly string desDie_fx = "fx_breakout_hit_box";

	protected readonly string lifeRe_fx = "fx_screen_actor_hit";

	private int lockLife;

	private readonly Dictionary<string, Transform> _brickWaves = new Dictionary<string, Transform>();

	private bool _brickWaveEnabled;

	private string _currentBrickWaveName;

	private int _currentWaveAliveBricks;

	private int _currentWaveDestroyedBricks;

	private bool _isClearingBrickWave;

	private List<int> dropIdsPool;

	private List<int> dropParmas;

	public void InitActor()
	{
		if (roleId <= 0)
		{
			NovaLogger.Error("打砖块角色 id==" + roleId);
		}
		else
		{
			SpawnRole(roleId, TSVector2.zero, -100, 0, RoleSpawn);
		}
		static void RoleSpawn(BrickActor _actor)
		{
			Singleton<BrickBreakerManager>.Instance.InitActor(_actor);
			SceneSingleton<AdventurePlayerController>.Instance.SetDynamicActor(_actor);
			_actor.LogicActive();
		}
	}

	private void SpawnRole(int roleID, TSVector2 pos, FP posY, FP rot, Action<BrickActor> callback)
	{
		BreakOutCharacter breakOutCharacter = Singleton<HotfixDataController>.Instance.GetBreakOutCharacter(roleID);
		if (breakOutCharacter == null)
		{
			NovaLogger.Error($"打砖块角色没有找到数据:{roleID}");
			return;
		}
		string model = breakOutCharacter.Model;
		if (string.IsNullOrEmpty(model))
		{
			return;
		}
		string loadPath = "Assets/AssetBundles/" + model + ".prefab";
		AdventureLevelObjPoolMgr.PoolBase poolBase = SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Player(loadPath);
		if (poolBase == null)
		{
			NovaLogger.Error($"ID={roleID}的角色资源不存在");
			return;
		}
		poolBase.Enabled(enable: true);
		AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
		GameObject gameObject = poolObj.gameObject;
		if (gameObject == null)
		{
			NovaLogger.Error($"ID={roleID}的角色资源不存在");
			return;
		}
		BrickActor brickActor = gameObject.AddOrGetComponent<BrickActor>();
		if (brickActor == null)
		{
			NovaLogger.Error($"ID={roleID}BrickActor get fail");
			return;
		}
		brickActor.SyncMovementLocation(pos, posY, rot);
		brickActor.enabled = true;
		brickActor.isDeclareDead = false;
		brickActor.LoadData(breakOutCharacter);
		brickActor.spawnPoolObj = poolObj;
		brickActor.LevelStart();
		callback(brickActor);
	}

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		uiOpRestart = false;
		AdventureGameContext.TeamConfig = null;
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		floorData = Singleton<HotfixDataController>.Instance.GetBreakOutFloor(CommonHelper.ParseStringParamToInt(param.id));
		string[] enterDynamicLevelParams = param.enterDynamicLevelParams;
		if (enterDynamicLevelParams != null && enterDynamicLevelParams.Length != 0)
		{
			roleId = CommonHelper.ParseStringParamToInt(param.enterDynamicLevelParams[0]);
		}
		if (floorData != null)
		{
			timeLimit = floorData.Time;
			musicName = floorData.BGM;
			leaveMusicEvent = floorData.LeaveTriggerEvent;
			currentLife = floorData.Heart;
			exceptLife = 0;
			currentScrole = 0;
			scenePath = "Assets/AssetBundles/" + floorData.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
		}
		else
		{
			Debug.LogError("打砖块关卡 data is null");
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		string[] array = sceneName.Split('/');
		string sceneName2 = array[array.Length - 1];
		Scene sceneByName = SceneManager.GetSceneByName(sceneName2);
		string assetName = scenePath + "/" + floorData.ConfigPrefabName + ".prefab";
		GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
			configPrefab.transform.localScale = Vector3.one;
			configPrefab.name = floorData.ConfigPrefabName;
			SceneManager.MoveGameObjectToScene(configPrefab, sceneByName);
		}
		else
		{
			Debug.LogError("策划配置预制体加载失败：" + floorData.ConfigPrefabName);
		}
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject2 in rootGameObjects)
		{
			if (gameObject2.name.Equals("==== SceneData ===="))
			{
				Transform transform = gameObject2.transform.Find("==== Obstacles ====");
				if (transform != null)
				{
					Singleton<BrickBreakerManager>.Instance.InitRangeAreaInfo(transform.transform);
				}
			}
			if (gameObject2.name.Equals(floorData.ConfigPrefabName))
			{
				Transform transform2 = gameObject2.transform.Find("==== Triggers ====");
				if (transform2 != null)
				{
					TriggerCom[] componentsInChildren = transform2.GetComponentsInChildren<TriggerCom>();
					Singleton<TriggerManager>.Instance.AddTriggers(componentsInChildren, -1, -1);
				}
				Transform transform3 = gameObject2.transform.Find("==== BrikNode ====");
				if (transform3 != null)
				{
					DestructibleObject[] componentsInChildren2 = transform3.GetComponentsInChildren<DestructibleObject>(includeInactive: true);
					destructCount = componentsInChildren2.Length;
					InitBrickWaves(transform3);
					Transform transform4 = transform3.transform.Find("Paddle");
					if (transform4 != null)
					{
						transform4.gameObject.AddOrGetComponent<Brick_Paddle>();
					}
					else
					{
						NovaLogger.Error("Paddle IS NULL");
					}
					Transform transform5 = transform3.transform.Find("Ball");
					if (transform5 != null)
					{
						transform5.gameObject.AddOrGetComponent<Brick_Ball>();
					}
					else
					{
						NovaLogger.Error("ball IS NULL");
					}
					MonoSingleton<WwiseAudioManager>.Instance.SetAudioListenerPos(new Vector3(0f, 5f, -9f), Vector3.zero);
				}
			}
			if (gameObject2.name.Equals("==== Navigation ===="))
			{
				HandleNavigation(gameObject2, sceneName2);
			}
		}
		InitActor();
		if (!SceneSingleton<AdventurePlayerController>.Instance.inputEnabled)
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
		}
		base.LevelLoadComplete(sceneName);
	}

	private void OnRestart(IEvent ievent)
	{
		if (ievent is GeneralEvent)
		{
			uiOpRestart = true;
		}
	}

	public override void LevelStart(Action callback = null)
	{
		base.LevelStart();
		timeLinePlayType = Singleton<UIGameSystemSetup>.Instance.PlayType;
		Singleton<UIGameSystemSetup>.Instance.PlayType = UIGameSystemSetup.TimeLinePlayType.everyTime;
		totalTime = 0;
		timeing = 0;
		isStartTime = true;
		isSettlement = false;
		callback?.Invoke();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("DESTRUCTIBLEOBJECT_DIE", OnDestructDie);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("BreakOut_InRestart", OnRestart);
		OnDropEventLisenterAdd();
		OnGmEventLisenterAdd();
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		isStartTime = false;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DESTRUCTIBLEOBJECT_DIE", OnDestructDie);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("BreakOut_InRestart", OnRestart);
		OnDropEventLisenterRemove();
		OnGmEventLisenterRemove();
		Singleton<UIGameSystemSetup>.Instance.PlayType = timeLinePlayType;
		Singleton<BrickBreakerManager>.Instance?.OnClear();
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		Singleton<BrickBreakerManager>.Instance?.OnUpdate(logicDeltaTime);
		if (!isStartTime)
		{
			return;
		}
		timeing += logicDeltaTime;
		if (timeing >= 1)
		{
			totalTime++;
			timeing -= (FP)1;
			if (totalTime >= timeLimit)
			{
				isStartTime = false;
				MonoSingleton<LuaManager>.Instance.FireEvent("BrickBreaker_Time", 0);
				LevelStateChangedCall(HotfixEnum.levelState.Failed);
			}
			else
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("BrickBreaker_Time", timeLimit - totalTime);
			}
		}
	}

	private void StartTiming(IEvent evt)
	{
		isStartTime = true;
	}

	public override bool HasTimelinePerformance()
	{
		int num;
		if (floorData != null)
		{
			num = ((!string.IsNullOrEmpty(floorData.IntroCutscene)) ? 1 : 0);
			if (num != 0)
			{
				timelineName = floorData.IntroCutscene;
			}
		}
		else
		{
			num = 0;
		}
		return (byte)num != 0;
	}

	public override void PlayTimelinePerformance(Action callback = null, bool needLimitPlayTimes = true)
	{
		base.PlayTimelinePerformance(() =>
		{
			callback?.Invoke();
		}, needLimitPlayTimes: false);
	}

	private void OnDestructDie(IEvent evt)
	{
		if (uiOpRestart || !(evt is DestructibleObjectBeDestoryEvent destructibleObjectBeDestoryEvent))
		{
			return;
		}
		if (_isClearingBrickWave)
		{
			ShowDropItem(destructibleObjectBeDestoryEvent.pos);
			return;
		}
		ShowDropItem(destructibleObjectBeDestoryEvent.pos);
		if (_brickWaveEnabled)
		{
			_currentWaveAliveBricks = Mathf.Max(0, _currentWaveAliveBricks - 1);
			_currentWaveDestroyedBricks++;
			TrySwitchBrickWave();
		}
		long configID = destructibleObjectBeDestoryEvent.configID;
		DestroyObjectSpr destroyObjectSpr = Singleton<HotfixDataController>.Instance.GetDestroyObjectSpr((int)configID);
		if (destroyObjectSpr == null)
		{
			NovaLogger.Error("NULL tDestroyObjectSpr===" + configID);
			return;
		}
		UpdateScrole(destroyObjectSpr.Score);
		ActivityEventToLua("Brick_Wall", configID);
		Singleton<BrickBreakerManager>.Instance?.PlayBrickFx(desDie_fx, new Vector3((float)destructibleObjectBeDestoryEvent.pos.x, 0.5f, (float)destructibleObjectBeDestoryEvent.pos.y));
		if (Singleton<BrickBreakerManager>.Instance.BrickBall != null)
		{
			bool flag = Singleton<BrickBreakerManager>.Instance.BrickBall.ICrossBall();
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound(flag ? "mode_breakout_game_fireBall_brickCrash" : "mode_breakout_game_brickCrash");
		}
	}

	private void OnMonsterDie(IEvent evt)
	{
		if (!_isClearingBrickWave && evt is AdventureMonsterDiedEvent adventureMonsterDiedEvent)
		{
			if (adventureMonsterDiedEvent.sender is LogicEntity logicEntity)
			{
				ShowDropItem(logicEntity.tsTransform.Position);
			}
			int monsterID = adventureMonsterDiedEvent.monsterID;
			BreakOutEnemySpr breakOutEnemySpr = Singleton<HotfixDataController>.Instance.GetBreakOutEnemySpr(monsterID);
			if (breakOutEnemySpr == null)
			{
				NovaLogger.Error("NULL BreakOutEnemySp===" + monsterID);
				return;
			}
			UpdateScrole(breakOutEnemySpr.Score);
			ActivityEventToLua("Brick_Monster", monsterID);
		}
	}

	protected void LevelStateChangedCall(HotfixEnum.levelState levelState)
	{
		if (!isSettlement)
		{
			isStartTime = false;
			isSettlement = true;
			MonoSingleton<LuaManager>.Instance.FireEvent("BrickBreaker_GameEnd_Pre", (int)levelState);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		}
		void Action()
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("BrickBreaker_GameEnd", (int)levelState);
			LevelStateChanged(levelState);
		}
	}

	public void UpdateLife(int life, int addExLf = 0)
	{
		if (lockLife == 1)
		{
			return;
		}
		if (life < 0)
		{
			if (Singleton<BrickBreakerManager>.Instance.InvincibleStar)
			{
				return;
			}
			Singleton<BrickBreakerManager>.Instance?.PlayBrickFx(lifeRe_fx, Vector3.zero);
		}
		exceptLife += addExLf;
		currentLife += life;
		if (currentLife > floorData.Heart + exceptLife)
		{
			currentLife = floorData.Heart + exceptLife;
		}
		if (currentLife < 0)
		{
			currentLife = 0;
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("BrickBreaker_Life", currentLife);
		if (currentLife == 0)
		{
			LevelStateChangedCall(HotfixEnum.levelState.Failed);
		}
	}

	public void UpdateScrole(int scrole)
	{
		currentScrole += scrole;
		MonoSingleton<LuaManager>.Instance.FireEvent("BrickBreaker_Scrole", currentScrole);
		BrickActor actor = Singleton<BrickBreakerManager>.Instance.Actor;
		if (actor != null)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("HudBreakScore", actor.Id, scrole);
		}
		if (currentScrole >= floorData.Score)
		{
			LevelStateChangedCall(HotfixEnum.levelState.Success);
		}
	}

	public void ActivityEventToLua(string eventName, long id)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent(eventName, id);
	}

	public override bool IsLevelComplete()
	{
		if (floorData == null)
		{
			return true;
		}
		return false;
	}

	public override void InitSpawnPoints()
	{
		base.InitSpawnPoints();
		if (!isViewSceneMode)
		{
			HandleSpawnGizmos();
		}
	}

	public override void HandleSpawnGizmos()
	{
		base.HandleSpawnGizmos();
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			monsterSpawnWaves.get_Item(i).Initialize(-1, -1);
		}
		for (int j = 0; j < trapGroups.Count; j++)
		{
			trapGroups.get_Item(j).Initialize(-1, -1);
		}
		PreloadAssets();
		for (int k = 0; k < monsterSpawnWaves.Count; k++)
		{
			if (!monsterSpawnWaves.get_Item(k).isTriggerActived)
			{
				monsterSpawnWaves.get_Item(k).EnableSpawnLogic();
			}
		}
		InitMonsterAndDestructCount();
		for (int l = 0; l < trapGroups.Count; l++)
		{
			trapGroups.get_Item(l).EnableSpawnLogic();
		}
	}

	private void InitBrickWaves(Transform brickRoot)
	{
		_brickWaves.Clear();
		_brickWaveEnabled = false;
		_currentBrickWaveName = null;
		_currentWaveAliveBricks = 0;
		_currentWaveDestroyedBricks = 0;
		_isClearingBrickWave = false;
		if (null == brickRoot)
		{
			return;
		}
		BrickWave[] componentsInChildren = brickRoot.GetComponentsInChildren<BrickWave>(includeInactive: true);
		if (componentsInChildren == null || componentsInChildren.Length == 0)
		{
			return;
		}
		Transform transform = null;
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			Transform transform2 = componentsInChildren[i].transform;
			_brickWaves.set_Item(transform2.name, transform2);
			if (!componentsInChildren[i].isTriggerActived && transform == null)
			{
				transform = transform2;
			}
		}
		if (_brickWaves.Count <= 1)
		{
			return;
		}
		if (transform == null)
		{
			using Dictionary<string, Transform>.Enumerator enumerator = _brickWaves.GetEnumerator();
			if (enumerator.MoveNext())
			{
				transform = enumerator.Current.Value;
			}
		}
		foreach (KeyValuePair<string, Transform> brickWave in _brickWaves)
		{
			brickWave.Value.gameObject.SetActive(brickWave.Value == transform);
		}
		_brickWaveEnabled = true;
		_currentBrickWaveName = transform.name;
		_currentWaveAliveBricks = CountActiveBricks(transform);
		_currentWaveDestroyedBricks = 0;
	}

	private static int CountActiveBricks(Transform wave)
	{
		if (null == wave)
		{
			return 0;
		}
		return wave.GetComponentsInChildren<DestructibleObject>().Length;
	}

	private void TrySwitchBrickWave()
	{
		if (!_brickWaveEnabled || _isClearingBrickWave || isSettlement || string.IsNullOrEmpty(_currentBrickWaveName) || !_brickWaves.TryGetValue(_currentBrickWaveName, out var value) || value == null)
		{
			return;
		}
		BrickWave component = value.GetComponent<BrickWave>();
		if (component == null || component.switchTriggerType == BrickWave.SwitchTriggerType.None || string.IsNullOrEmpty(component.nextWaveName))
		{
			return;
		}
		bool flag = false;
		switch (component.switchTriggerType)
		{
		case BrickWave.SwitchTriggerType.AliveNum:
			if (_currentWaveAliveBricks <= component.switchThreshold)
			{
				flag = true;
			}
			break;
		case BrickWave.SwitchTriggerType.DestroyNum:
			if (_currentWaveDestroyedBricks >= component.switchThreshold)
			{
				flag = true;
			}
			break;
		}
		if (flag && CanStartBrickWave(component.nextWaveName, out var _))
		{
			StartBrickWave(component.nextWaveName);
		}
	}

	private bool CanStartBrickWave(string waveName, out Transform targetWave)
	{
		targetWave = null;
		if (!_brickWaveEnabled)
		{
			return false;
		}
		if (_isClearingBrickWave || isSettlement)
		{
			return false;
		}
		if (string.IsNullOrEmpty(waveName))
		{
			return false;
		}
		if (!_brickWaves.TryGetValue(waveName, out targetWave) || targetWave == null)
		{
			return false;
		}
		if (waveName == _currentBrickWaveName)
		{
			return false;
		}
		return true;
	}

	public void StartBrickWave(string waveName)
	{
		if (!CanStartBrickWave(waveName, out var targetWave))
		{
			return;
		}
		_isClearingBrickWave = true;
		try
		{
			if (_brickWaves.TryGetValue(_currentBrickWaveName, out var value) && value != null)
			{
				value.gameObject.SetActive(value: false);
			}
			targetWave.gameObject.SetActive(value: true);
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_breakout_rebuild");
			DestructibleObject[] componentsInChildren = targetWave.GetComponentsInChildren<DestructibleObject>();
			if (componentsInChildren != null)
			{
				foreach (DestructibleObject destructibleObject in componentsInChildren)
				{
					if (!(destructibleObject == null) && !(destructibleObject.spawnFx == null))
					{
						AdventureFXPlayer.PlayFX(destructibleObject.spawnFx, 1f, destructibleObject.transform.position, Quaternion.identity);
					}
				}
			}
			_currentBrickWaveName = waveName;
			_currentWaveAliveBricks = CountActiveBricks(targetWave);
			_currentWaveDestroyedBricks = 0;
		}
		finally
		{
			_isClearingBrickWave = false;
		}
	}

	private void ClearAliveMonstersWithDrop()
	{
		if (monsterActors == null || monsterActors.Count <= 0)
		{
			return;
		}
		for (int num = monsterActors.Count - 1; num >= 0; num--)
		{
			if (monsterActors.get_Item(num) is MonsterAdventureActor { isDead: false, actorHealthInfo: not null } monsterAdventureActor && monsterAdventureActor.actorHealthInfo.isAlive && monsterAdventureActor.state > ActorState.Spawn)
			{
				ShowDropItem(monsterAdventureActor.tsTransform.Position);
				monsterAdventureActor.ClearSelf();
			}
		}
	}

	private void OnGmEventLisenterAdd()
	{
		Singleton<EventDispatchManager>.Instance?.AddEventListener("GM_SET_BRICKER", OnGMSetBriker);
	}

	private void OnGmEventLisenterRemove()
	{
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("GM_SET_BRICKER", OnGMSetBriker);
	}

	private void OnGMSetBriker(IEvent ievent)
	{
		if (!(ievent is GeneralEvent { data: LuaTable data }))
		{
			return;
		}
		CommonHelper.TryParseStringParamToInt(data.get_Item((object)1).ToString(), out var intValue);
		if (!isStartTime)
		{
			if (intValue == 4 || intValue == 5 || intValue == 6)
			{
				FireGMTip("游戏尚未开始");
			}
			return;
		}
		switch (intValue)
		{
		case 1:
		{
			CommonHelper.TryParseStringParamToInt(data.get_Item((object)2).ToString(), out var intValue3);
			CommonHelper.TryParseStringParamToInt(data.get_Item((object)3).ToString(), out var intValue4);
			int index = floorData.Drops.IndexOf(intValue3);
			BrickDrop brickDrop = SceneSingleton<DropsManager>.Instance.PlayBrickDrop(intValue3, new TSVector2(999, 0)) as BrickDrop;
			if (brickDrop != null)
			{
				brickDrop.SetParamasValue(floorData.DropParam.get_Item(index), intValue3);
			}
			if (intValue4 > 0)
			{
				for (int i = 0; i < intValue4; i++)
				{
					Singleton<BrickBreakerManager>.Instance.OnGetDropItem(brickDrop);
				}
			}
			break;
		}
		case 2:
		{
			CommonHelper.TryParseStringParamToInt(data.get_Item((object)2).ToString(), out var intValue2);
			Singleton<BrickBreakerManager>.Instance.BrickBall.SetMaxSpeed(intValue2);
			lockLife = intValue2;
			break;
		}
		case 3:
		{
			float currentSpeed = Singleton<BrickBreakerManager>.Instance.BrickBall.GetCurrentSpeed();
			MonoSingleton<LuaManager>.Instance.FireEvent("GM_Brick_BallSpeed", currentSpeed);
			break;
		}
		case 4:
			GMSkipBrickWave();
			break;
		case 5:
			GMSkipMonsterWave();
			break;
		case 6:
			GMResetBall();
			break;
		}
	}

	private static void FireGMTip(string tip)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("GM_Brick_GMTip", tip);
	}

	private void GMSkipBrickWave()
	{
		if (!_brickWaveEnabled)
		{
			FireGMTip("当前关卡没有多波次砖块");
			return;
		}
		if (string.IsNullOrEmpty(_currentBrickWaveName) || !_brickWaves.TryGetValue(_currentBrickWaveName, out var value) || value == null)
		{
			FireGMTip("当前砖块波次无效");
			return;
		}
		BrickWave component = value.GetComponent<BrickWave>();
		if (component == null || component.switchTriggerType == BrickWave.SwitchTriggerType.None || string.IsNullOrEmpty(component.nextWaveName))
		{
			FireGMTip("已经是最后一波砖块");
			return;
		}
		if (!CanStartBrickWave(component.nextWaveName, out var _))
		{
			FireGMTip("切波失败");
			return;
		}
		StartBrickWave(component.nextWaveName);
		FireGMTip("已切换到下一波砖块");
	}

	private void GMSkipMonsterWave()
	{
		if (monsterSpawnWaves == null || monsterSpawnWaves.Count == 0)
		{
			FireGMTip("当前关卡没有怪物波次");
			return;
		}
		MonsterSpawnWaveGizmo currentWave = null;
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = monsterSpawnWaves.get_Item(i);
			if (monsterSpawnWaveGizmo != null && monsterSpawnWaveGizmo.isSpawnEnabled && !monsterSpawnWaveGizmo.IsAllActivedAndDied())
			{
				currentWave = monsterSpawnWaveGizmo;
				break;
			}
		}
		MonsterSpawnWaveGizmo monsterSpawnWaveGizmo2 = FindNextMonsterWave(currentWave);
		_isClearingBrickWave = true;
		try
		{
			for (int j = 0; j < monsterSpawnWaves.Count; j++)
			{
				MonsterSpawnWaveGizmo monsterSpawnWaveGizmo3 = monsterSpawnWaves.get_Item(j);
				if (monsterSpawnWaveGizmo3 != null && monsterSpawnWaveGizmo3.isSpawnEnabled && !monsterSpawnWaveGizmo3.IsAllActivedAndDied())
				{
					monsterSpawnWaveGizmo3.DisableSpawnLogic();
				}
			}
			if (monsterSpawnWaveGizmo2 == null)
			{
				FireGMTip("已经是最后一波怪物，已清场");
				return;
			}
			monsterSpawnWaveGizmo2.EnableSpawnLogic();
		}
		finally
		{
			_isClearingBrickWave = false;
		}
		FireGMTip("已切换到下一波怪物");
	}

	private MonsterSpawnWaveGizmo FindNextMonsterWave(MonsterSpawnWaveGizmo currentWave)
	{
		string text = null;
		if (currentWave != null && _brickWaves.TryGetValue(currentWave.name, out var value) && value != null)
		{
			BrickWave component = value.GetComponent<BrickWave>();
			if (component != null && !string.IsNullOrEmpty(component.nextWaveName))
			{
				text = component.nextWaveName;
			}
		}
		MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = null;
		MonsterSpawnWaveGizmo monsterSpawnWaveGizmo2 = null;
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			MonsterSpawnWaveGizmo monsterSpawnWaveGizmo3 = monsterSpawnWaves.get_Item(i);
			if (!(monsterSpawnWaveGizmo3 == null) && !monsterSpawnWaveGizmo3.isSpawnEnabled)
			{
				if (!string.IsNullOrEmpty(text) && monsterSpawnWaveGizmo3.name == text)
				{
					monsterSpawnWaveGizmo = monsterSpawnWaveGizmo3;
				}
				else if (monsterSpawnWaveGizmo3.isTriggerActived && monsterSpawnWaveGizmo2 == null)
				{
					monsterSpawnWaveGizmo2 = monsterSpawnWaveGizmo3;
				}
			}
		}
		if (!(monsterSpawnWaveGizmo != null))
		{
			return monsterSpawnWaveGizmo2;
		}
		return monsterSpawnWaveGizmo;
	}

	private void GMResetBall()
	{
		BrickBreakerManager instance = Singleton<BrickBreakerManager>.Instance;
		if (instance == null || instance.BrickBall == null)
		{
			FireGMTip("球不存在");
			return;
		}
		instance.SwitchBall(BrickBallType.Normal);
		FireGMTip("已重置为普通球");
	}

	private void OnDropEventLisenterAdd()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
	}

	private void OnDropEventLisenterRemove()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
	}

	private void GetMonsterCount(BaseSpawnPointGizmo pointGizmo, ref int count)
	{
		if (pointGizmo is MonsterSpawnPointGizmo { monsterID: >0 })
		{
			count++;
			return;
		}
		List<BaseSpawnPointGizmo> childrenGizmos = pointGizmo.childrenGizmos;
		if (childrenGizmos != null && childrenGizmos.Count > 0)
		{
			for (int i = 0; i < pointGizmo.childrenGizmos.Count; i++)
			{
				GetMonsterCount(pointGizmo.childrenGizmos.get_Item(i), ref count);
			}
		}
	}

	private void InitMonsterAndDestructCount()
	{
		int count = destructCount;
		if (monsterSpawnWaves.Count > 0)
		{
			for (int i = 0; i < monsterSpawnWaves.Count; i++)
			{
				GetMonsterCount(monsterSpawnWaves.get_Item(i), ref count);
			}
		}
		InitDropPool((floorData.Drops != null) ? floorData.Drops.Count : 0, count);
	}

	private void Shuffle<T>(List<T> list, List<T> listP)
	{
		for (int num = list.Count - 1; num > 0; num--)
		{
			int num2 = TSRandom.Range(0, num + 1);
			int index = num2;
			List<T> list2 = list;
			int index2 = num;
			T val = list.get_Item(num);
			T val2 = list.get_Item(num2);
			T val3;
			list.set_Item(index, val3 = val);
			list2.set_Item(index2, val3 = val2);
			index2 = num2;
			list2 = listP;
			index = num;
			val2 = listP.get_Item(num);
			val = listP.get_Item(num2);
			listP.set_Item(index2, val3 = val2);
			list2.set_Item(index, val3 = val);
		}
	}

	private void InitDropPool(int indexCount, int monsterCount)
	{
		if (indexCount <= 0)
		{
			return;
		}
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		for (int i = 0; i < indexCount; i++)
		{
			int num = floorData.Counts.get_Item(i);
			for (int j = 0; j < num; j++)
			{
				list.Add(floorData.Drops.get_Item(i));
				list2.Add(floorData.DropParam.get_Item(i));
			}
		}
		if (list.Count >= monsterCount)
		{
			Shuffle(list, list2);
			dropIdsPool = list;
			dropParmas = list2;
			return;
		}
		dropIdsPool = new List<int>();
		dropParmas = new List<int>();
		List<int> list3 = new List<int>(monsterCount);
		for (int k = 0; k < monsterCount; k++)
		{
			list3.Add(k);
			dropIdsPool.Add(0);
			dropParmas.Add(0);
		}
		for (int l = 0; l < list.Count; l++)
		{
			int index = TSRandom.Range(0, list3.Count);
			int index2 = list3.get_Item(index);
			dropIdsPool.set_Item(index2, list.get_Item(l));
			dropParmas.set_Item(index2, list2.get_Item(l));
			list3.RemoveAt(index);
		}
	}

	private (int, int) GetRandomDropId()
	{
		if (dropIdsPool.Count > 0)
		{
			int item = dropIdsPool.get_Item(0);
			int item2 = dropParmas.get_Item(0);
			dropIdsPool.RemoveAt(0);
			dropParmas.RemoveAt(0);
			return (item, item2);
		}
		return (0, 0);
	}

	private void ShowDropItem(TSVector2 pos)
	{
		var (num, paramas) = GetRandomDropId();
		if (num > 0)
		{
			(SceneSingleton<DropsManager>.Instance.PlayBrickDrop(num, pos) as BrickDrop)?.SetParamasValue(paramas, num);
		}
	}

	private void OnDropFinish(IEvent evt)
	{
		AdventureDropFinishEvent adventureDropFinishEvent = evt as AdventureDropFinishEvent;
		if (adventureDropFinishEvent.isPickUp && adventureDropFinishEvent.sender is BrickDrop dropItem)
		{
			Singleton<BrickBreakerManager>.Instance.OnGetDropItem(dropItem);
		}
	}
}
