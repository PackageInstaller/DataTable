using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

public class DailyInstanceLevelController : AdventureLevelController
{
	private DailyInstance dailyInstanceData;

	private DailyInstanceFloor dailyInstanceFloor;

	private GameplayRoom room;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		if (isViewSceneMode)
		{
			dailyInstanceFloor = Singleton<HotfixDataController>.Instance.GetDailyInstanceFloor(param.floor);
		}
		else
		{
			dailyInstanceData = Singleton<HotfixDataController>.Instance.GetDailyInstance(CommonHelper.ParseStringParamToInt(param.id));
			dailyInstanceFloor = Singleton<HotfixDataController>.Instance.GetDailyInstanceFloor(dailyInstanceData.FloorId);
		}
		if (dailyInstanceFloor != null)
		{
			scenePath = "Assets/AssetBundles/" + dailyInstanceFloor.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
			param.monsterLevel = dailyInstanceFloor.MonsterLv;
			param.dropEntityGroupId = dailyInstanceFloor.DropEntityGroupId;
			param.dropEntityRate = (float)dailyInstanceFloor.DropEntityRate / 10000f;
			param.dropMaxNum = dailyInstanceFloor.DropMaxNum;
			musicName = dailyInstanceFloor.BGM;
			leaveMusicEvent = dailyInstanceFloor.LeaveTriggerEvent;
		}
		else
		{
			Debug.LogError("DailyInstanceFloor data is null");
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		string[] array = sceneName.Split('/');
		string sceneName2 = array[array.Length - 1];
		Scene sceneByName = SceneManager.GetSceneByName(sceneName2);
		string assetName = scenePath + "/" + dailyInstanceFloor.ConfigPrefabName + ".prefab";
		GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
			configPrefab.transform.localScale = Vector3.one;
			configPrefab.name = dailyInstanceFloor.ConfigPrefabName;
			SceneManager.MoveGameObjectToScene(configPrefab, sceneByName);
		}
		else
		{
			Debug.LogError("策划配置预制体加载失败：" + dailyInstanceFloor.ConfigPrefabName);
		}
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject2 in rootGameObjects)
		{
			if (gameObject2.name.Equals(dailyInstanceFloor.ConfigPrefabName))
			{
				Transform transform = gameObject2.transform.Find("==== Triggers ====");
				if (transform != null)
				{
					TriggerCom[] componentsInChildren = transform.GetComponentsInChildren<TriggerCom>();
					Singleton<TriggerManager>.Instance.AddTriggers(componentsInChildren, -1, -1);
					List<AdventureLevelTeleporter> list = transform.GetComponentsInChildren<AdventureLevelTeleporter>().ToList();
					if (list.Count > 0)
					{
						for (int j = 0; j < list.Count; j++)
						{
							AdventureLevelTeleporter adventureLevelTeleporter = list.get_Item(j);
							adventureLevelTeleporter.SetPosition(-1, -1);
							adventureLevelTeleporter.RegisterTeleporterCallback(LevelTeleporterTriggered);
						}
						teleporters.AddRange(list);
					}
				}
			}
			else if (gameObject2.name.Equals("==== Triggers ===="))
			{
				AdventureLevelTeleporter[] componentsInChildren2 = gameObject2.GetComponentsInChildren<AdventureLevelTeleporter>();
				if (componentsInChildren2 != null && componentsInChildren2.Length > 0)
				{
					foreach (AdventureLevelTeleporter obj in componentsInChildren2)
					{
						obj.SetPosition(-1, -1);
						obj.RegisterTeleporterCallback(LevelTeleporterTriggered);
					}
					teleporters.AddRange(componentsInChildren2);
				}
			}
			if (gameObject2.name.Equals("==== Navigation ===="))
			{
				HandleNavigation(gameObject2, sceneName2);
			}
		}
		base.LevelLoadComplete(sceneName);
	}

	public override bool HasTimelinePerformance()
	{
		int num;
		if (dailyInstanceFloor != null)
		{
			num = ((!string.IsNullOrEmpty(dailyInstanceFloor.IntroCutscene)) ? 1 : 0);
			if (num != 0)
			{
				timelineName = dailyInstanceFloor.IntroCutscene;
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
		if (!isViewSceneMode)
		{
			InitRoom();
			room?.EntryRoom();
		}
		base.LevelStart(callback);
		callback?.Invoke();
	}

	private void InitRoom()
	{
		DailyInstance dailyInstance = dailyInstanceData;
		if (dailyInstance == null)
		{
			Debug.LogError("日常副本【DailyInstanceLevel】数据为空!");
			return;
		}
		GameplayRoomData gameplayRoomData = new GameplayRoomData
		{
			worldLevelType = HotfixEnum.worldLevelType.DailyInstance,
			floorId = dailyInstanceFloor.Id,
			isReconnected = isReconnected,
			isBattleFinish = isBattleFinish,
			eventId = dailyInstanceData.DailyType,
			monsterSpawnPointsGizmos = monsterSpawnWaves
		};
		switch ((HotfixEnum.dailyType)gameplayRoomData.eventId)
		{
		case HotfixEnum.dailyType.ExpDungeon:
		case HotfixEnum.dailyType.PresentsExpDungeon:
		case HotfixEnum.dailyType.OutfitExpDungeon:
		case HotfixEnum.dailyType.Common:
			room = new DailyInstanceGameplayRoom_Experience();
			break;
		case HotfixEnum.dailyType.MoneyDungeon:
			room = new DailyInstanceGameplayRoom_Gold();
			break;
		}
		if (room == null)
		{
			Debug.LogError("副本房间为空!");
		}
		else
		{
			room?.InitRoom(gameplayRoomData, LevelStateChangedCallback);
		}
	}

	protected void LevelStateChangedCallback(HotfixEnum.levelState levelState, int star)
	{
		_logger.LogInfo($"daily level state changed:{levelState}");
		LevelStateChanged(levelState);
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		room?.UpdateLogic(logicDeltaTime);
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
		HandleTreasureBoxSpawnPoints();
	}

	protected override void HandleTreasureBoxSpawnPoints()
	{
		if (levelLoadParams == null)
		{
			Debug.LogError("主线关卡加载参数为空");
			return;
		}
		if (dailyInstanceFloor == null)
		{
			Debug.LogError("主线层数据为空");
			return;
		}
		string[] array = dailyInstanceFloor.SceneName.Split('/');
		string text = array[array.Length - 1];
		Scene sceneByName = SceneManager.GetSceneByName(text);
		if (!sceneByName.IsValid())
		{
			Debug.LogError("没有找到场景" + text);
			return;
		}
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject in rootGameObjects)
		{
			if (!gameObject.name.Equals(dailyInstanceFloor.ConfigPrefabName))
			{
				continue;
			}
			Transform transform = gameObject.transform.Find("==== SpawnPoints ====");
			if (!(transform != null))
			{
				break;
			}
			for (int j = 0; j < transform.childCount; j++)
			{
				Transform child = transform.transform.GetChild(j);
				if (child.name.Equals("---- TreasureBoxSpawnPoints ----"))
				{
					treasureBoxSpawnPoints = child.GetComponentsInChildren<TreasureBoxSpawnPoint>().ToList();
					break;
				}
			}
			break;
		}
		if (treasureBoxSpawnPoints.Count == 0)
		{
			return;
		}
		string text2 = "已开启宝箱：";
		int[] mainlineOpenedTreasureBoxs = levelLoadParams.mainlineOpenedTreasureBoxs;
		if (mainlineOpenedTreasureBoxs != null)
		{
			for (int k = 0; k < mainlineOpenedTreasureBoxs.Length; k++)
			{
				int num = mainlineOpenedTreasureBoxs[k];
				text2 = text2 + num + "_";
				for (int l = 0; l < treasureBoxSpawnPoints.Count; l++)
				{
					TreasureBoxSpawnPoint treasureBoxSpawnPoint = treasureBoxSpawnPoints.get_Item(l);
					if (treasureBoxSpawnPoint.boxID == num)
					{
						treasureBoxSpawnPoint.enabled = false;
						treasureBoxSpawnPoint.gameObject.SetActive(value: false);
						break;
					}
				}
			}
		}
		ConsoleProDebug.LogToFilter(text2, "宝箱");
		for (int m = 0; m < treasureBoxSpawnPoints.Count; m++)
		{
			TreasureBoxSpawnPoint treasureBoxSpawnPoint2 = treasureBoxSpawnPoints.get_Item(m);
			treasureBoxSpawnPoint2.Initialize(-1, -1);
			if (treasureBoxSpawnPoint2.isActiveAndEnabled && !treasureBoxSpawnPoint2.isTriggerActived)
			{
				treasureBoxSpawnPoint2.EnableSpawnLogic();
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

	public override void PreloadAssets()
	{
		base.PreloadAssets();
		List<int> list = new List<int>();
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			if (monsterSpawnWaves.get_Item(i).waveType != MonsterSpawnWaveGizmo.WaveType.Default)
			{
				continue;
			}
			List<MonsterSpawnPointGizmo> list2 = monsterSpawnWaves.get_Item(i).transform.GetComponentsInChildren<MonsterSpawnPointGizmo>().ToList();
			for (int j = 0; j < list2.Count; j++)
			{
				int monsterID = list2.get_Item(j).monsterID;
				if (!list.Contains(monsterID))
				{
					list.Add(monsterID);
				}
			}
		}
		if (list.Count > 0)
		{
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.PreloadMonsters_IDList(list, isRoguelikeMonster: false);
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		room?.LeaveRoom();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.LevelFinish();
	}
}
