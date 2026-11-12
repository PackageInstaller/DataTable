using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;
using XLua;

public class TraceHuntLevelController : AdventureLevelController
{
	private int totalTime;

	private int levelTotalTime;

	private FP timeing;

	protected bool isTestPresetTeam;

	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	protected float _zoomFreeze;

	protected float _zoomDurationTime;

	protected TraceHuntFloor floorData;

	protected TraceHuntFloorGroup floorGroupData;

	protected bool isStartTime;

	protected bool isSettlement;

	protected List<TraceHuntDropSpawnGizmo> dropSpawnGizmos = new List<TraceHuntDropSpawnGizmo>(8);

	protected HashSet<long> _aliveDropIds = new HashSet<long>();

	protected FP _dropRefreshTimer;

	protected FP _dropRefreshInterval;

	protected int _lastDropIndex = -1;

	protected const int DropMaxCount = 2;

	protected const int DefaultDropRefreshInterval = 8;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		isTestPresetTeam = false;
		floorGroupData = Singleton<HotfixDataController>.Instance.GetTraceHuntFloorGroup(CommonHelper.ParseStringParamToInt(param.id));
		if (floorGroupData == null)
		{
			Debug.LogError("TraceHuntFloorGroup data is null, id = " + param.id);
			return;
		}
		int floorId = floorGroupData.FloorId;
		floorData = Singleton<HotfixDataController>.Instance.GetTraceHuntFloor(floorId);
		if (floorData != null)
		{
			scenePath = "Assets/AssetBundles/" + floorData.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
			musicName = floorData.BGM;
			leaveMusicEvent = floorData.LeaveTriggerEvent;
		}
		else
		{
			Debug.LogError("TraceHuntFloor data is null");
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
			Debug.LogError("策划配置预制体加载失败: " + floorData.ConfigPrefabName);
		}
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject2 in rootGameObjects)
		{
			if (gameObject2.name.Equals(floorData.ConfigPrefabName))
			{
				Transform transform = gameObject2.transform.Find("==== Triggers ====");
				if (transform != null)
				{
					TriggerCom[] componentsInChildren = transform.GetComponentsInChildren<TriggerCom>();
					Singleton<TriggerManager>.Instance.AddTriggers(componentsInChildren, -1, -1);
					teleporters = transform.GetComponentsInChildren<AdventureLevelTeleporter>().ToList();
					if (teleporters != null)
					{
						for (int j = 0; j < teleporters.Count; j++)
						{
							teleporters.get_Item(j).SetPosition(-1, -1);
						}
					}
				}
			}
			if (gameObject2.name.Equals("==== Navigation ===="))
			{
				HandleNavigation(gameObject2, sceneName2);
			}
		}
		base.LevelLoadComplete(sceneName);
	}

	public override void InitSpawnPoints()
	{
		base.InitSpawnPoints();
		StarTowerPorts starTowerPorts = UnityEngine.Object.FindObjectOfType<StarTowerPorts>();
		if (null != starTowerPorts)
		{
			starTowerPorts.gameObject.SetActive(value: false);
		}
		playerSpawnPoints = UnityEngine.Object.FindObjectsOfType<PlayerSpawnPointGizmo>().ToList();
		if (playerSpawnPoints == null || playerSpawnPoints.Count == 0)
		{
			Debug.LogError("关卡中没有配置玩家出生点!");
			return;
		}
		if (!string.IsNullOrEmpty(nextLevelData.bornID))
		{
			for (int i = 0; i < playerSpawnPoints.Count; i++)
			{
				PlayerSpawnPointGizmo playerSpawnPointGizmo = playerSpawnPoints.get_Item(i);
				if (nextLevelData.bornID.Equals(playerSpawnPointGizmo.spawnPointID))
				{
					base.playerSpawnPointGizmo = playerSpawnPointGizmo;
					break;
				}
			}
		}
		if (null == base.playerSpawnPointGizmo)
		{
			for (int j = 0; j < playerSpawnPoints.Count; j++)
			{
				PlayerSpawnPointGizmo playerSpawnPointGizmo2 = playerSpawnPoints.get_Item(j);
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
		for (int k = 0; k < trapGroups.Count; k++)
		{
			trapGroups.get_Item(k).Initialize(-1, -1);
		}
		PreloadAssets();
		for (int l = 0; l < monsterSpawnWaves.Count; l++)
		{
			if (!monsterSpawnWaves.get_Item(l).isTriggerActived)
			{
				monsterSpawnWaves.get_Item(l).EnableSpawnLogic();
			}
		}
		for (int m = 0; m < trapGroups.Count; m++)
		{
			trapGroups.get_Item(m).EnableSpawnLogic();
		}
		dropSpawnGizmos.Clear();
		TraceHuntDropSpawnGizmo[] array = UnityEngine.Object.FindObjectsOfType<TraceHuntDropSpawnGizmo>();
		for (int n = 0; n < array.Length; n++)
		{
			if (array[n].isActiveAndEnabled)
			{
				dropSpawnGizmos.Add(array[n]);
			}
		}
		HandleTreasureBoxSpawnPoints();
	}

	protected override void HandleTreasureBoxSpawnPoints()
	{
	}

	public override void LevelStart(Action callback)
	{
		base.LevelStart(callback);
		isStartTime = false;
		isSettlement = false;
		totalTime = 0;
		timeing = 0;
		if (floorGroupData.Difficult > 1)
		{
			levelTotalTime = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("TraceHuntHardBossTimeLimit").Value);
		}
		else
		{
			levelTotalTime = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("TraceHuntBossTimeLimit").Value);
		}
		_dropRefreshInterval = 8;
		_dropRefreshTimer = 0;
		_aliveDropIds.Clear();
		_lastDropIndex = -1;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN_BEFORE", MonsterSpawnBefore);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN", MonsterSpawn);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("TraceHunt_MaxStar", OnLevelMaxStar);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("GM_TraceHuntChangeLevelTime", GMChangeLevelTime);
		callback?.Invoke();
	}

	private void OnLevelMaxStar(IEvent evt)
	{
		LevelStateChangedCall(HotfixEnum.levelState.Success);
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if (isStartTime)
		{
			timeing += logicDeltaTime;
			if (timeing >= 1)
			{
				totalTime++;
				timeing -= (FP)1;
				MonoSingleton<LuaManager>.Instance.FireEvent("TraceHunt_Gameplay_Time", levelTotalTime - totalTime);
			}
			if (totalTime >= levelTotalTime)
			{
				LevelStateChangedCall(HotfixEnum.levelState.Success);
			}
		}
		if (isStartTime && _aliveDropIds.Count < 2)
		{
			_dropRefreshTimer += logicDeltaTime;
			if (_dropRefreshTimer >= _dropRefreshInterval)
			{
				_dropRefreshTimer = 0;
				TrySpawnDrop();
			}
		}
	}

	protected void TrySpawnDrop()
	{
		if (dropSpawnGizmos == null || dropSpawnGizmos.Count == 0 || _aliveDropIds.Count >= 2)
		{
			return;
		}
		int num = TSRandom.Range(0, dropSpawnGizmos.Count);
		if (dropSpawnGizmos.Count > 1 && num == _lastDropIndex)
		{
			num = (num + 1) % dropSpawnGizmos.Count;
		}
		_lastDropIndex = num;
		TraceHuntDropSpawnGizmo traceHuntDropSpawnGizmo = dropSpawnGizmos.get_Item(num);
		if (traceHuntDropSpawnGizmo == null || traceHuntDropSpawnGizmo.dropId <= 0)
		{
			return;
		}
		AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
		if (!(adventureActor == null))
		{
			Vector3 position = traceHuntDropSpawnGizmo.transform.position;
			TSVector2 spawnPos = new TSVector2(position.x, position.z);
			long num2 = SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(adventureActor, traceHuntDropSpawnGizmo.dropId, spawnPos, position.y);
			if (num2 > 0)
			{
				_aliveDropIds.Add(num2);
			}
		}
	}

	protected void OnDropFinish(IEvent evt)
	{
		if (evt is AdventureDropFinishEvent adventureDropFinishEvent)
		{
			_aliveDropIds.Remove(adventureDropFinishEvent.entityID);
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		isStartTime = false;
		_aliveDropIds.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DROP_EFFECT_FINISH", OnDropFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN_BEFORE", MonsterSpawnBefore);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN", MonsterSpawn);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("TraceHunt_MaxStar", OnLevelMaxStar);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("GM_TraceHuntChangeLevelTime", GMChangeLevelTime);
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearMonsters();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearSkill();
	}

	private void OnPlayerDied(IEvent ievent)
	{
		LevelStateChangedCall(HotfixEnum.levelState.Failed);
	}

	private void StartTiming(IEvent evt)
	{
		isStartTime = true;
		_dropRefreshTimer = 0;
	}

	private void MonsterDeclareDeath(IEvent evt)
	{
		_ = ((AdventureMonsterDeclareDiedEvent)evt).epicType;
		_ = 2;
	}

	private void MonsterSpawnBefore(IEvent evt)
	{
		AdventureMonsterSpawnedBeforeEvent adventureMonsterSpawnedBeforeEvent = (AdventureMonsterSpawnedBeforeEvent)evt;
		if (!(adventureMonsterSpawnedBeforeEvent.MonsterActor == null))
		{
			adventureMonsterSpawnedBeforeEvent.MonsterActor.summonMonsterUseBattleLevelAsDifficultLevel = floorGroupData.SummonLevelUp;
		}
	}

	private void MonsterSpawn(IEvent evt)
	{
		AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = (AdventureMonsterSpawnedEvent)evt;
		if (adventureMonsterSpawnedEvent != null)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(adventureMonsterSpawnedEvent.id) as MonsterAdventureActor;
			if (monsterAdventureActor.monsterInfo.subBossType == HotfixEnum.subBossType.HUNTBOSS)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("TraceHunt_Spawn_Id", monsterAdventureActor.Id);
			}
		}
	}

	protected void LevelStateChangedCall(HotfixEnum.levelState levelState)
	{
		if (!isSettlement)
		{
			isStartTime = false;
			isSettlement = true;
			AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
			_logger.LogInfo($"trace hunt level state changed:{levelState}");
			MonoSingleton<LuaManager>.Instance.FireEvent("TraceHunt_Settlement_Ready");
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		}
		void Action()
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("TraceHunt_Result_Time", totalTime);
			LevelStateChanged(levelState);
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

	private void GMChangeLevelTime(IEvent ievent)
	{
		if (isStartTime && ievent is GeneralEvent generalEvent)
		{
			CommonHelper.TryParseStringParamToInt((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var intValue);
			totalTime = intValue;
			MonoSingleton<LuaManager>.Instance.FireEvent("TraceHunt_Gameplay_Time", levelTotalTime - totalTime);
		}
	}
}
