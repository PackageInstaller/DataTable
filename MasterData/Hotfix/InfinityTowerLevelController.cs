using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;
using XLua;

public class InfinityTowerLevelController : AdventureLevelController
{
	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	private float _zoomFreeze;

	private float _zoomDurationTime;

	protected bool isStartTime;

	protected FP timeing = 0;

	protected int totalTime;

	protected int limitTime;

	protected InfinityTowerFloor floorData;

	protected InfinityTowerMap mapData;

	protected bool isContinue;

	protected List<InfinityTowerEnemySet> enemySetList;

	protected InfinityTowerGameplayTypeGizmo itGameplayTypeGizmo;

	protected HotfixEnum.infinityTowerGameplayType levelType;

	protected MonsterSpawnWaveGizmo firstMonsterSpawnWave;

	protected HotfixEnum.fixedRoguelikeFunc0 floorFunc;

	protected InfinityTowerPlayerSpawnPointGizmo itPlayerPointGizmo;

	public bool isSettlement;

	private int MaxMonsterCount;

	private int RemainingMonsterCount;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		isSettlement = false;
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		floorData = Singleton<HotfixDataController>.Instance.GetInfinityTowerFloor(CommonHelper.ParseStringParamToInt(levelLoadParams.id));
		mapData = Singleton<HotfixDataController>.Instance.GetInfinityTowerMap(floorData.MapId);
		param.monsterLevel = floorData.MonsterLv;
		isContinue = param.isInfinityContinueBattle;
		limitTime = floorData.LimitTime;
		MaxMonsterCount = 0;
		RemainingMonsterCount = 0;
		if (mapData != null)
		{
			scenePath = "Assets/AssetBundles/" + mapData.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
			musicName = mapData.BGM;
			leaveMusicEvent = mapData.LeaveTriggerEvent;
		}
		else
		{
			Debug.LogError("infinityTowerMap data is null");
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		string[] array = sceneName.Split('/');
		Scene sceneByName = SceneManager.GetSceneByName(array[array.Length - 1]);
		string text = (isContinue ? mapData.ContinuePrefabName : mapData.ConfigPrefabName);
		string assetName = scenePath + "/" + text + ".prefab";
		GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("无尽塔:map配置项没有找到对应的prefab!");
			return;
		}
		configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
		configPrefab.transform.localScale = Vector3.one;
		configPrefab.name = mapData.ConfigPrefabName;
		SceneManager.MoveGameObjectToScene(configPrefab, sceneByName);
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject2 in rootGameObjects)
		{
			if (gameObject2.name.Equals("==== Navigation ===="))
			{
				HandleNavigation(gameObject2, sceneName);
			}
		}
		Transform transform = configPrefab.transform.Find("==== Triggers ====");
		TriggerCom[] array2 = null;
		if (null == transform)
		{
			Debug.LogError("没有找到触发器节点==== Triggers ====");
		}
		else
		{
			array2 = transform.GetComponentsInChildren<TriggerCom>();
			Singleton<TriggerManager>.Instance.AddTriggers(array2, -1, -1);
		}
		Transform transform2 = configPrefab.transform.Find("==== SpawnPoints ====");
		if (null == transform2)
		{
			Debug.LogError("没有找到出生节点==== SpawnPoints ====");
			return;
		}
		if (!isViewSceneMode)
		{
			floorFunc = (HotfixEnum.fixedRoguelikeFunc0)floorData.FloorFunc;
			if (floorFunc == HotfixEnum.fixedRoguelikeFunc0.Boss)
			{
				Transform transform3 = transform2.transform.Find("---- MonsterSpawnPoints ----");
				if (null != transform3)
				{
					monsterSpawnWaves = transform2.transform.GetComponentsInChildren<MonsterSpawnWaveGizmo>().ToList();
					virtualMonsterSpawnWaves = transform2.transform.GetComponentsInChildren<VirtualMonsterSpawnWaveGizmo>().ToList();
				}
			}
			else
			{
				Transform transform4 = transform2.transform.Find("---- InfinityTowerMonsterSpawnPoints ----");
				if (null == transform4)
				{
					_logger.LogInfo("无尽塔怪物出生点为空!");
				}
				else
				{
					if (!transform4.gameObject.activeSelf)
					{
						transform4.gameObject.SetActive(value: true);
					}
					enemySetList = new List<InfinityTowerEnemySet>();
					List<InfinityTowerEnemySet> infinityTowerEnemySetData = Singleton<HotfixDataController>.Instance.InfinityTowerEnemySetData;
					for (int j = 0; j < infinityTowerEnemySetData.Count; j++)
					{
						InfinityTowerEnemySet infinityTowerEnemySet = infinityTowerEnemySetData.get_Item(j);
						if (infinityTowerEnemySet.SetId == floorData.SetId)
						{
							levelType = (HotfixEnum.infinityTowerGameplayType)infinityTowerEnemySet.CommonGameplayType;
							MaxMonsterCount += infinityTowerEnemySet.MaxNumPerWave;
							RemainingMonsterCount += infinityTowerEnemySet.MaxNumPerWave;
							enemySetList.Add(infinityTowerEnemySet);
						}
					}
					if (enemySetList.Count == 0)
					{
						_logger.LogError($"无尽塔Floor = {floorData.Id}找不到合适的Set数据,SetId = {floorData.SetId}");
						return;
					}
					InfinityTowerGameplayTypeGizmo[] componentsInChildren = transform2.GetComponentsInChildren<InfinityTowerGameplayTypeGizmo>();
					for (int k = 0; k < componentsInChildren.Length; k++)
					{
						if (componentsInChildren[k].waveModel == levelType)
						{
							itGameplayTypeGizmo = componentsInChildren[k];
							break;
						}
					}
					if (!(null != itGameplayTypeGizmo))
					{
						_logger.LogInfo($"无尽塔Floor = {floorData.Id},Map = {mapData.Id},找不到合适的玩法类型,CommonGameplayType = {levelType}");
					}
				}
			}
		}
		base.LevelLoadComplete(sceneName);
	}

	public override bool HasTimelinePerformance()
	{
		int num;
		if (levelLoadParams != null && mapData != null)
		{
			num = ((!string.IsNullOrEmpty(mapData.IntroCutscene)) ? 1 : 0);
			if (num != 0)
			{
				timelineName = mapData.IntroCutscene;
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
			MonoSingleton<LuaManager>.Instance.FireEvent("CloseJumpOverTimeLine");
			MonoSingleton<LuaManager>.Instance.FireEvent("TimeLineFinishBattleDashboardVisible", a1: true);
		}, needLimitPlayTimes);
	}

	public override void LevelStart(Action callback = null)
	{
		base.LevelStart(callback);
		totalTime = 0;
		timeing = 0;
		isStartTime = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("GM_SET_LEVEL_COUNTTIMR", GMSetLevelCountTime);
		if (floorFunc == HotfixEnum.fixedRoguelikeFunc0.Boss)
		{
			HandleBossMode();
		}
		itPlayerPointGizmo?.LevelStart();
		callback?.Invoke();
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if (!isStartTime)
		{
			return;
		}
		timeing += logicDeltaTime;
		if (timeing >= 1)
		{
			timeing -= (FP)1;
			totalTime++;
			MonoSingleton<LuaManager>.Instance.FireEvent("Infinity_Tower_RunTime", totalTime);
			if (totalTime >= limitTime)
			{
				LevelFailedCallBack();
				isStartTime = false;
			}
		}
	}

	public override void LevelEnd()
	{
		itPlayerPointGizmo?.LevelEnd();
		itPlayerPointGizmo = null;
		base.LevelEnd();
		isStartTime = false;
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", MonsterClear);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("GM_SET_LEVEL_COUNTTIMR", GMSetLevelCountTime);
		enemySetList?.Clear();
		floorData = null;
		mapData = null;
		itGameplayTypeGizmo = null;
		firstMonsterSpawnWave = null;
		if (floorFunc == HotfixEnum.fixedRoguelikeFunc0.Boss)
		{
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearMonsters();
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearSkill();
		}
	}

	public override void LevelFinish()
	{
		base.LevelFinish();
	}

	private void OnPlayerDied(IEvent ievent)
	{
		isStartTime = false;
		LevelFailedCallBack();
	}

	private void StartTiming(IEvent evt)
	{
		isStartTime = true;
		if (null != itGameplayTypeGizmo)
		{
			itGameplayTypeGizmo.InitTypeMonsterDatas(enemySetList, LevelSuccessCallBack, RefreshMonsterCount);
			itGameplayTypeGizmo.EnableSpawnLogic();
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("Infinity_Tower_StartTime");
	}

	private void MonsterClear(IEvent evt)
	{
		if (floorFunc == HotfixEnum.fixedRoguelikeFunc0.Boss)
		{
			LevelSuccessCallBack();
		}
	}

	public override void InitSpawnPoints()
	{
		base.InitSpawnPoints();
		if (floorFunc == HotfixEnum.fixedRoguelikeFunc0.Battle)
		{
			InfinityTowerPlayerSpawnPointGizmo[] array = UnityEngine.Object.FindObjectsOfType<InfinityTowerPlayerSpawnPointGizmo>();
			if (array == null || array.Length == 0)
			{
				Debug.LogError("关卡中没有配置玩家出生点!");
				return;
			}
			if (!string.IsNullOrEmpty(nextLevelData.bornID))
			{
				foreach (InfinityTowerPlayerSpawnPointGizmo infinityTowerPlayerSpawnPointGizmo in array)
				{
					if (nextLevelData.bornID.Equals(infinityTowerPlayerSpawnPointGizmo.spawnPointID) && infinityTowerPlayerSpawnPointGizmo.groupIndex == levelType)
					{
						itPlayerPointGizmo = infinityTowerPlayerSpawnPointGizmo;
						break;
					}
				}
			}
			if (null == itPlayerPointGizmo)
			{
				foreach (InfinityTowerPlayerSpawnPointGizmo infinityTowerPlayerSpawnPointGizmo2 in array)
				{
					if (string.IsNullOrEmpty(infinityTowerPlayerSpawnPointGizmo2.spawnPointID))
					{
						itPlayerPointGizmo = infinityTowerPlayerSpawnPointGizmo2;
						break;
					}
				}
			}
			if (null == itPlayerPointGizmo)
			{
				_logger.LogError("没有找到合适的角色出生点!");
				return;
			}
			itPlayerPointGizmo.Initialize(0, 0);
			itPlayerPointGizmo.EnableSpawnLogic();
			itPlayerPointGizmo.ExecuteSpawnLogic();
		}
		else
		{
			PlayerSpawnPointGizmo[] array2 = UnityEngine.Object.FindObjectsOfType<PlayerSpawnPointGizmo>();
			if (array2 == null || array2.Length == 0)
			{
				Debug.LogError("关卡中没有配置玩家出生点!");
				return;
			}
			if (!string.IsNullOrEmpty(nextLevelData.bornID))
			{
				foreach (PlayerSpawnPointGizmo playerSpawnPointGizmo in array2)
				{
					if (nextLevelData.bornID.Equals(playerSpawnPointGizmo.spawnPointID))
					{
						base.playerSpawnPointGizmo = playerSpawnPointGizmo;
						break;
					}
				}
			}
			if (null == base.playerSpawnPointGizmo)
			{
				foreach (PlayerSpawnPointGizmo playerSpawnPointGizmo2 in array2)
				{
					if (string.IsNullOrEmpty(playerSpawnPointGizmo2.spawnPointID))
					{
						base.playerSpawnPointGizmo = playerSpawnPointGizmo2;
						break;
					}
				}
			}
			if (null == base.playerSpawnPointGizmo)
			{
				_logger.LogError("没有找到合适的角色出生点!");
				return;
			}
			base.playerSpawnPointGizmo.Initialize(0, 0);
			base.playerSpawnPointGizmo.EnableSpawnLogic();
			base.playerSpawnPointGizmo.ExecuteSpawnLogic();
		}
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
		for (int j = 0; j < virtualMonsterSpawnWaves.Count; j++)
		{
			virtualMonsterSpawnWaves.get_Item(j).Initialize(-1, -1);
		}
		for (int k = 0; k < monsterSpawnWaves.Count; k++)
		{
			if (!monsterSpawnWaves.get_Item(k).isTriggerActived)
			{
				monsterSpawnWaves.get_Item(k).EnableSpawnLogic();
			}
		}
	}

	public override List<BaseSpawnPointGizmo> GetWaves(string waveName, int x = -1, int y = -1)
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

	public override List<BaseSpawnPointGizmo> GetPlans(string planName, int x = -1, int y = -1)
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

	public override List<BaseSpawnPointGizmo> GetGroups(string groupName, int x = -1, int y = -1)
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

	public void HandleBossMode()
	{
		if (isLevelLogicComplete)
		{
			return;
		}
		bool flag = true;
		if (monsterSpawnWaves == null || monsterSpawnWaves.Count == 0)
		{
			Debug.Log("怪物波次为空!");
		}
		else
		{
			for (int i = 0; i < monsterSpawnWaves.Count; i++)
			{
				MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = monsterSpawnWaves.get_Item(i);
				if (!monsterSpawnWaveGizmo.isTriggerActived && !(monsterSpawnWaveGizmo is RandomMonsterSpawnWaveGizmo))
				{
					flag = false;
					firstMonsterSpawnWave = monsterSpawnWaveGizmo;
					break;
				}
			}
		}
		if (!flag)
		{
			if (null == firstMonsterSpawnWave)
			{
				Debug.LogError("无尽塔:没有找到无指令激活的怪物波次!");
				return;
			}
			firstMonsterSpawnWave.Initialize(-1, -1);
			firstMonsterSpawnWave.EnableSpawnLogic();
			firstMonsterSpawnWave = null;
		}
		else
		{
			firstMonsterSpawnWave = null;
		}
	}

	protected void LevelStateChangedCallback(HotfixEnum.levelState levelState)
	{
		AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		_logger.LogInfo($"fixed rog level state changed:{levelState}");
		if (levelState != HotfixEnum.levelState.Failed && levelState == HotfixEnum.levelState.Success)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("LevelUseTotalTime", totalTime);
		}
		LevelStateChanged(levelState);
		MonoSingleton<LuaManager>.Instance.FireEvent("InfinityTowerEnd", (int)levelState);
	}

	protected void LevelSuccessCallBack()
	{
		if (!isSettlement)
		{
			isSettlement = true;
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		}
		void Action()
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("InfinityTowerEnd_ZoomTime", a1: false);
			LevelStateChangedCallback(HotfixEnum.levelState.Success);
		}
	}

	protected void LevelFailedCallBack()
	{
		if (!isSettlement)
		{
			isSettlement = true;
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		}
		void Action()
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("InfinityTowerEnd_ZoomTime", a1: false);
			LevelStateChangedCallback(HotfixEnum.levelState.Failed);
		}
	}

	private void GMSetLevelCountTime(IEvent ievent)
	{
		if (isStartTime && ievent is GeneralEvent generalEvent)
		{
			CommonHelper.TryParseStringParamToInt((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var intValue);
			totalTime = floorData.LimitTime - intValue;
			MonoSingleton<LuaManager>.Instance.FireEvent("Infinity_Tower_RunTime", totalTime);
		}
	}

	public void RefreshMonsterCount()
	{
		RemainingMonsterCount--;
		MonoSingleton<LuaManager>.Instance.FireEvent("Infinity_RefreshCountRemaining", RemainingMonsterCount, MaxMonsterCount);
	}
}
