using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

public class VampireInstanceLevelController : AdventureLevelController
{
	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	protected float _zoomFreeze;

	protected float _zoomDurationTime;

	protected VampireFloor vampireFloorData;

	protected VampireMap vampireMapData;

	protected bool isStartTime;

	protected FP timeing = 0;

	protected int totalTime;

	protected bool isSettlement;

	protected int poolId;

	protected VampireMonsterSpawnWaveGizmo vmSpawnWaveGizmo;

	protected bool isFirstHalfEnd;

	public override void Initialize(ExtraLevelInfo extraLevelInfo, EventDispatcher eventDispatcher, Action<AdventureLevelState> levelStatusChanged)
	{
		base.Initialize(extraLevelInfo, eventDispatcher, levelStatusChanged);
		if (string.IsNullOrEmpty(AdventureModuleController.Config.FX_VampireSurvivorSimplifyHurtFXPath))
		{
			return;
		}
		string assetName = "Assets/AssetBundles/" + AdventureModuleController.Config.FX_VampireSurvivorSimplifyHurtFXPath + ".prefab";
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			for (int i = 0; i < AdventureModuleController.Config.FX_VampireSurvivorSimplifyHurtFXPreloadCount; i++)
			{
				AdventureFXManager.PreloadFX(null, gameObject);
			}
			ModuleController<AdventureModuleController>.Instance.FX_VampireSurvivorSimplifyHurtFXPrefab = gameObject;
		}
	}

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		vampireFloorData = Singleton<HotfixDataController>.Instance.GetVampireFloor(CommonHelper.ParseStringParamToInt(levelLoadParams.id));
		vampireMapData = Singleton<HotfixDataController>.Instance.GetVampireMap(vampireFloorData.MapId);
		if (vampireMapData != null)
		{
			scenePath = "Assets/AssetBundles/" + vampireMapData.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
			musicName = vampireMapData.BGM;
			leaveMusicEvent = vampireMapData.LeaveTriggerEvent;
		}
		else
		{
			Debug.LogError("VampireMap data is null");
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		string[] array = sceneName.Split('/');
		Scene sceneByName = SceneManager.GetSceneByName(array[array.Length - 1]);
		string assetName = scenePath + "/" + vampireMapData.ConfigPrefabName + ".prefab";
		GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
		if (gameObject == null)
		{
			Debug.LogError("策划配置预制体加载失败：" + vampireMapData.ConfigPrefabName);
			return;
		}
		configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
		configPrefab.transform.localScale = Vector3.one;
		configPrefab.name = vampireMapData.ConfigPrefabName;
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
		}
		else
		{
			Transform transform3 = transform2.transform.Find("---- VampireMonsterSpawnPoints ----");
			vmSpawnWaveGizmo = transform3.GetComponent<VampireMonsterSpawnWaveGizmo>();
			poolId = (levelLoadParams.isVampireFirstHalf ? vampireFloorData.FirstHalfPoolId : vampireFloorData.SecondHalfPoolId);
			List<VampireEnemyPool> list = new List<VampireEnemyPool>();
			List<VampireEnemyPool> vampireEnemyPoolData = Singleton<HotfixDataController>.Instance.VampireEnemyPoolData;
			int num = 0;
			List<int> list2 = new List<int>();
			for (int j = 0; j < vampireEnemyPoolData.Count; j++)
			{
				VampireEnemyPool vampireEnemyPool = vampireEnemyPoolData.get_Item(j);
				if (vampireEnemyPool.PoolId == poolId)
				{
					list.Add(vampireEnemyPool);
					if (vampireEnemyPool.PoolType != 0)
					{
						list2.Add(num);
					}
					num += vampireEnemyPool.WaveKeepTime;
				}
			}
			if (list.Count == 0)
			{
				_logger.LogError($"吸血鬼Floor = {vampireFloorData.Id}找不到合适的Pool数据,poolId = {poolId}");
				return;
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("Vampire_Level_Times", num, list2);
			if (null != vmSpawnWaveGizmo)
			{
				vmSpawnWaveGizmo.InitSpawnMonsterDatas(list, LevelSuccessCallBack, LevelFailedCallBack, levelLoadParams.vampireDropList, vampireFloorData.SpecialEnemySetId, vampireFloorData.TreasureSetId);
				vmSpawnWaveGizmo.EnableSpawnLogic();
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

	public override void LevelStart(Action callback = null)
	{
		base.LevelStart(callback);
		totalTime = 0;
		timeing = 0;
		isStartTime = false;
		isFirstHalfEnd = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("INTERACTIVEID", FirstHalfSettlement);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("GM_SET_Vampire_Wave_Next", GMSetVampireWaveNext);
		callback?.Invoke();
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if (isStartTime)
		{
			timeing += logicDeltaTime;
			if (timeing >= 1)
			{
				timeing -= (FP)1;
				totalTime++;
				if (null != vmSpawnWaveGizmo)
				{
					vmSpawnWaveGizmo.SpwanWaveUpdate(totalTime);
				}
				MonoSingleton<LuaManager>.Instance.FireEvent("VampireSurvivor_Time", totalTime);
			}
		}
		else if (!isStartTime && isFirstHalfEnd && SceneSingleton<DropsManager>.Instance.GetDropChestCount() == 0)
		{
			isFirstHalfEnd = false;
			Singleton<InteractiveManager>.Instance.triggerOpListener("VampireFirstHalf_Settlement");
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		isStartTime = false;
		isFirstHalfEnd = false;
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("INTERACTIVEID", FirstHalfSettlement);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("GM_SET_Vampire_Vampire_Next", GMSetVampireWaveNext);
		for (int i = 0; i < ModuleController<AdventureModuleController>.Instance?.monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.monsterActors.get_Item(i) as MonsterAdventureActor;
			if (monsterAdventureActor != null && monsterAdventureActor.actorHealthInfo.isAlive)
			{
				monsterAdventureActor.ClearSelf();
			}
		}
	}

	public override void LevelFinish()
	{
		base.LevelFinish();
	}

	private void OnPlayerDied(IEvent ievent)
	{
		isStartTime = false;
		LevelFailedCallBack(isPlayerDied: true);
	}

	private void StartTiming(IEvent evt)
	{
		isStartTime = true;
		isSettlement = false;
		if (null != vmSpawnWaveGizmo)
		{
			vmSpawnWaveGizmo.SpwanWaveMonster();
		}
	}

	private void FirstHalfSettlement(IEvent evt)
	{
		if (evt is AdventureInteractiveIDTrigger adventureInteractiveIDTrigger && string.Equals(adventureInteractiveIDTrigger.interactiveID, "SecondHalfStart"))
		{
			LevelStateChangedCallback(HotfixEnum.levelState.Success);
		}
	}

	protected void LevelStateChangedCallback(HotfixEnum.levelState levelState)
	{
		if (!isSettlement)
		{
			isSettlement = true;
			_logger.LogInfo($"fixed rog level state changed:{levelState}");
			if (levelState != HotfixEnum.levelState.Failed && levelState == HotfixEnum.levelState.Success)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("VampireBattleSuccess");
			}
			LevelStateChanged(levelState, 1);
		}
	}

	protected void LevelSuccessCallBack()
	{
		isStartTime = false;
		if (!levelLoadParams.isVampireFirstHalf)
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
		}
		CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
		CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
		ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		void Action()
		{
			if (levelLoadParams.isVampireFirstHalf)
			{
				SceneSingleton<DropsManager>.Instance?.DropsAllFlyToActor();
			}
			if (!levelLoadParams.isHalfVampireBattleMode)
			{
				if (!levelLoadParams.isVampireFirstHalf)
				{
					LevelStateChangedCallback(HotfixEnum.levelState.Success);
				}
				else
				{
					isFirstHalfEnd = true;
					MonoSingleton<LuaManager>.Instance.FireEvent("VampireBattleSuccess");
				}
			}
			else
			{
				LevelStateChangedCallback(HotfixEnum.levelState.Success);
			}
		}
	}

	protected void LevelFailedCallBack(bool isPlayerDied)
	{
		if (isPlayerDied)
		{
			LevelStateChangedCallback(HotfixEnum.levelState.Failed);
			return;
		}
		levelStatus = AdventureLevelState.BattleEnd;
		MonoSingleton<LuaManager>.Instance.FireEvent("LevelStateChanged", 1);
	}

	private void GMSetVampireWaveNext(IEvent ievent)
	{
		if (isStartTime && ievent is GeneralEvent)
		{
			totalTime += vmSpawnWaveGizmo.SetGMNextWave();
			MonoSingleton<LuaManager>.Instance.FireEvent("VampireSurvivor_Time", totalTime);
		}
	}
}
