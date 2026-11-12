using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ActivityStoryLevelController : AdventureLevelController
{
	private FP timing = 0;

	private int totalTime;

	private bool isTestingSceneMode;

	private bool doMir;

	private ActivityLevelsFloor activityFloorData;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		if (!isViewSceneMode)
		{
			activityFloorData = Singleton<HotfixDataController>.Instance.GetActivityLevelsFloor(CommonHelper.ParseStringParamToInt(levelLoadParams.id));
		}
		doMir = activityFloorData.Mir;
		if (1 != 0)
		{
			BGSceneLoadComplete(default);
		}
		void BGSceneLoadComplete(Scene scene)
		{
			if (activityFloorData != null)
			{
				scenePath = "Assets/AssetBundles/" + activityFloorData.SceneName;
				MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
				{
					LevelLoadProcessUpdate(sceneName, process);
					return true;
				});
				param.monsterLevel = activityFloorData.MonsterLv;
				musicName = activityFloorData.BGM;
				leaveMusicEvent = activityFloorData.LeaveTriggerEvent;
				levelScript = activityFloorData.LevelScript;
			}
			else
			{
				Debug.LogError("ActivityStoryLevel data is null");
			}
		}
	}

	public override bool HasTimelinePerformance()
	{
		int num;
		if (activityFloorData != null)
		{
			num = ((!string.IsNullOrEmpty(activityFloorData.IntroCutscene)) ? 1 : 0);
			if (num != 0)
			{
				timelineName = activityFloorData.IntroCutscene;
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
		timing = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		callback?.Invoke();
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		timing += logicDeltaTime;
		if (timing >= 1)
		{
			totalTime++;
			MonoSingleton<LuaManager>.Instance.FireEvent("Mainline_Time_CountUp", totalTime);
			timing -= (FP)1;
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.LevelFinish();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
	}

	private void OnPlayerDied(IEvent ievent)
	{
		LevelStateChanged(HotfixEnum.levelState.Failed);
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		string[] array = sceneName.Split('/');
		string sceneName2 = array[array.Length - 1];
		Scene sceneByName = SceneManager.GetSceneByName(sceneName2);
		GameObject gameObject = null;
		if (!isTestingSceneMode)
		{
			string assetName = scenePath + "/" + activityFloorData.ConfigPrefabName + ".prefab";
			gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
		}
		if (gameObject != null)
		{
			configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
			configPrefab.transform.localScale = Vector3.one;
			configPrefab.name = activityFloorData.ConfigPrefabName;
			SceneManager.MoveGameObjectToScene(configPrefab, sceneByName);
		}
		else
		{
			Debug.LogError("策划配置预制体加载失败：" + activityFloorData.ConfigPrefabName);
		}
		if (doMir)
		{
			SceneSingleton<AdventurePlayerController>.Instance.reversalCameraRotationAngle = -1;
		}
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject2 in rootGameObjects)
		{
			if (gameObject2.name.Equals(activityFloorData.ConfigPrefabName))
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

	protected override void LevelTeleporterTriggered(AdventureLevelTeleporter.NextLevelData nextData)
	{
		if (!nextData.enterSettlementState)
		{
			if (!nextData.isCurScene)
			{
				return;
			}
			string bornID = nextData.bornID;
			if (string.IsNullOrEmpty(bornID))
			{
				for (int i = 0; i < playerSpawnPoints.Count; i++)
				{
					PlayerSpawnPointGizmo playerSpawnPointGizmo = playerSpawnPoints.get_Item(i);
					if (string.IsNullOrEmpty(playerSpawnPointGizmo.spawnPointID))
					{
						base.playerSpawnPointGizmo = playerSpawnPointGizmo;
						break;
					}
				}
			}
			else
			{
				List<PlayerSpawnPointGizmo> list = new List<PlayerSpawnPointGizmo>();
				for (int j = 0; j < playerSpawnPoints.Count; j++)
				{
					PlayerSpawnPointGizmo playerSpawnPointGizmo2 = playerSpawnPoints.get_Item(j);
					if (bornID.Equals(playerSpawnPointGizmo2.spawnPointID))
					{
						list.Add(playerSpawnPointGizmo2);
					}
				}
				int count = list.Count;
				switch (count)
				{
				case 0:
					_logger.LogError("找不到ID为" + bornID + "的角色出生点!");
					break;
				case 1:
					base.playerSpawnPointGizmo = list.get_Item(0);
					break;
				default:
				{
					int index = MonoSingleton<GameController>.Instance.Random_Roguelike(0, count);
					base.playerSpawnPointGizmo = list.get_Item(index);
					break;
				}
				}
			}
			if (null == base.playerSpawnPointGizmo)
			{
				_logger.LogError("找不到ID为" + bornID + "的角色出生点!");
			}
			else
			{
				base.playerSpawnPointGizmo.PlayerTransfer();
			}
		}
		else
		{
			nextData.levelSuccess = true;
			OnLevelTeleporterTriggered(nextData);
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
		if (null == base.playerSpawnPointGizmo && !string.IsNullOrEmpty(nextLevelData.bornID))
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
		PreloadAssets();
	}

	protected override void HandleTreasureBoxSpawnPoints()
	{
		if (levelLoadParams == null)
		{
			Debug.LogError("主线关卡加载参数为空");
			return;
		}
		if (activityFloorData == null)
		{
			Debug.LogError("主线层数据为空");
			return;
		}
		string[] array = activityFloorData.SceneName.Split('/');
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
			if (!gameObject.name.Equals(activityFloorData.ConfigPrefabName))
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
}
