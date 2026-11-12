using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ActivityLevelsInstanceController : AdventureLevelController
{
	private bool isStartTime;

	private FP timeing = 0;

	private int totalTime;

	private int levelTime;

	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	private float _zoomFreeze;

	private float _zoomDurationTime;

	private Coroutine corSettlement;

	private ActivityLevelsLevel levelData;

	private ActivityLevelsFloor floorData;

	private bool isLastlv;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		levelData = Singleton<HotfixDataController>.Instance.GetActivityLevelsLevel(CommonHelper.ParseStringParamToInt(levelLoadParams.id));
		levelTime = levelData.OneStarCondition.get_Item(0);
		int num = CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[0]);
		totalTime = CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[1]);
		isLastlv = num == levelData.FloorId.Count;
		floorData = Singleton<HotfixDataController>.Instance.GetActivityLevelsFloor(levelData.FloorId.get_Item(num - 1));
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
			param.monsterLevel = floorData.MonsterLv;
			levelScript = floorData.LevelScript;
		}
		else
		{
			Debug.LogError("ActivityLevelsFloor data is null");
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		string[] array = sceneName.Split('/');
		string sceneName2 = array[array.Length - 1];
		Scene sceneByName = SceneManager.GetSceneByName(sceneName2);
		bool mir = floorData.Mir;
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
		AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
		if (null != instance)
		{
			instance.reversalCameraRotationAngle = ((!mir) ? 1 : (-1));
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
					List<AdventureLevelTeleporter> list = transform.GetComponentsInChildren<AdventureLevelTeleporter>().ToList();
					if (list != null && list.Count > 0)
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

	protected override void LevelTeleporterTriggered(AdventureLevelTeleporter.NextLevelData nextData)
	{
		if (nextData.enterSettlementState)
		{
			isStartTime = false;
			if (!isLastlv)
			{
				nextData.levelSuccess = true;
				OnLevelTeleporterTriggered(nextData);
			}
			else
			{
				levelEndSendMsg(isWin: true);
			}
		}
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
			MonoSingleton<LuaManager>.Instance.FireEvent("CloseJumpOverTimeLine");
			MonoSingleton<LuaManager>.Instance.FireEvent("TimeLineFinishBattleDashboardVisible", a1: true);
		}, needLimitPlayTimes);
	}

	public override void LevelStart(Action callback = null)
	{
		timeing = 0;
		isStartTime = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", OnActor_Died);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", TaskSettlement);
		base.LevelStart(callback);
		callback?.Invoke();
	}

	protected void TaskSettlement(IEvent evt)
	{
		object data = ((GeneralEvent)evt).data;
		if (data != null)
		{
			_ = (AdventureLevelTeleporter.NextLevelData)data;
			isStartTime = false;
			levelEndSendMsg(isWin: true);
		}
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
			totalTime++;
			MonoSingleton<LuaManager>.Instance.FireEvent("ActivityLevels_Instance_Gameplay_Time", totalTime);
			timeing -= (FP)1;
			if (totalTime >= levelTime)
			{
				isStartTime = false;
				levelEndSendMsg(isWin: false);
			}
		}
	}

	private void OnActor_Died(IEvent ievent)
	{
		if (((AdventureActorDiedEvent)ievent).actor is PlayerAdventureActor)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Region_Boss_PlayerDied");
		}
	}

	private void StartTiming(IEvent evt)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("ActivityLevels_Instance_Gameplay_Time", totalTime);
		isStartTime = true;
	}

	private void OnPlayerDied(IEvent ievent)
	{
		isStartTime = false;
		levelEndSendMsg(isWin: false);
	}

	private void levelEndSendMsg(bool isWin)
	{
		if (!isWin || isLastlv)
		{
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		}
		void Action()
		{
			if (isWin)
			{
				LevelStateChanged(HotfixEnum.levelState.Success);
				MonoSingleton<LuaManager>.Instance.FireEvent("ActivityInstance_Result", a1: true, totalTime);
			}
			else
			{
				LevelStateChanged(HotfixEnum.levelState.Failed);
				MonoSingleton<LuaManager>.Instance.FireEvent("ActivityInstance_Result", a1: false, totalTime);
			}
		}
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
		if (floorData == null)
		{
			Debug.LogError("主线层数据为空");
			return;
		}
		string[] array = floorData.SceneName.Split('/');
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
			if (!gameObject.name.Equals(floorData.ConfigPrefabName))
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

	public override void LevelEnd()
	{
		base.LevelEnd();
		isStartTime = false;
		if (corSettlement != null)
		{
			StopCoroutine(corSettlement);
			corSettlement = null;
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActor_Died);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_ON_TELEPORTER_TRIGGERED", TaskSettlement);
	}
}
