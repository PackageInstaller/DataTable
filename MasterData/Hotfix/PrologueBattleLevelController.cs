using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PrologueBattleLevelController : AdventureLevelController
{
	protected bool isThreePlayer;

	protected Vector3 revivalPoint = Vector3.zero;

	protected List<string> btnNames = new List<string>();

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		MainlineFloor mainlineFloor = (isViewSceneMode ? param.mainlineFloorData : param.Mainline_GenerateFloorData());
		if (mainlineFloor != null)
		{
			scenePath = "Assets/AssetBundles/" + mainlineFloor.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
		}
		else
		{
			Debug.LogError("Mainline data is null");
		}
	}

	public override void LevelStart(Action callback = null)
	{
		base.LevelStart(callback);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("INTERACTIVEID", OnInteractiveId);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("PROLOGUELEVEL_REVIVAPOINT", OnRevivalMsg);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("PROLOGUELEVEL_SELECTPERK", OnSelectperk);
		callback?.Invoke();
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.LevelFinish();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("INTERACTIVEID", OnInteractiveId);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("PROLOGUELEVEL_REVIVAPOINT", OnRevivalMsg);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("PROLOGUELEVEL_SELECTPERK", OnSelectperk);
	}

	private void OnInteractiveId(IEvent evt)
	{
		if (evt is AdventureInteractiveIDTrigger adventureInteractiveIDTrigger && string.Equals(adventureInteractiveIDTrigger.interactiveID, "prologue_3_player"))
		{
			isThreePlayer = true;
			isPrologueBattleCanSwitchActor = true;
		}
	}

	private void OnRevivalMsg(IEvent evt)
	{
		AdventurePrologueBattleRevival adventurePrologueBattleRevival = evt as AdventurePrologueBattleRevival;
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		revivalPoint = new Vector3((float)adventurePrologueBattleRevival.revivalPos.x, (float)activedPlayerActor.tsTransform.PositionY, (float)adventurePrologueBattleRevival.revivalPos.y);
		btnNames = adventurePrologueBattleRevival.names;
		boxID = adventurePrologueBattleRevival.boxID;
		MonoSingleton<LuaManager>.Instance.FireEvent("PrologueBattleArchive", isThreePlayer, revivalPoint, btnNames, boxID);
	}

	private void OnDamage(IEvent evt)
	{
		if (!isThreePlayer && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.to != SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor) && (adventureActorReceiveDamageEvent.to as AdventureActor).actorHealthInfo.hp <= 0)
		{
			MonoSingleton<ClientManager>.Instance.OpenLoadingView(() =>
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.InterruptPassiveBehaviour();
				MonoSingleton<LuaManager>.Instance.FireEvent("PrologueBattleOpenBattleDash", a1: false);
				MonoSingleton<LuaManager>.Instance.FireEvent("PrologueBattleReload", isThreePlayer, revivalPoint, btnNames);
				MonoSingleton<LuaManager>.Instance.FireEvent("BattlePopupTips", 0, 0, a3: false);
			}, 0f, 1f);
		}
	}

	private void OnSelectperk(IEvent evt)
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (PrologueBattleLevelMsg.Instance != null)
		{
			TSVector2 revivalPos = PrologueBattleLevelMsg.Instance.revivalPos;
			Debug.Log(revivalPos);
			revivalPoint = new Vector3(revivalPos.x.AsFloat(), (float)activedPlayerActor.tsTransform.PositionY, revivalPos.y.AsFloat());
			btnNames = PrologueBattleLevelMsg.Instance.btnNames;
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("PrologueBattleArchive", isThreePlayer, revivalPoint, btnNames);
	}

	private void OnPlayerDied(IEvent ievent)
	{
		if (isThreePlayer)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("PrologueBattleReload", isThreePlayer, revivalPoint, btnNames);
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		string[] array = sceneName.Split('/');
		string sceneName2 = array[array.Length - 1];
		Scene sceneByName = SceneManager.GetSceneByName(sceneName2);
		MainlineFloor mainlineFloorData = levelLoadParams.mainlineFloorData;
		string assetName = scenePath + "/" + mainlineFloorData.ConfigPrefabName + ".prefab";
		GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
			configPrefab.transform.localScale = Vector3.one;
			configPrefab.name = mainlineFloorData.ConfigPrefabName;
			SceneManager.MoveGameObjectToScene(configPrefab, sceneByName);
		}
		else
		{
			Debug.LogError("策划配置预制体加载失败：" + mainlineFloorData.ConfigPrefabName);
		}
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject2 in rootGameObjects)
		{
			if (gameObject2.name.Equals(mainlineFloorData.ConfigPrefabName))
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
		Vector3 vector = ModuleController<AdventureModuleController>.Instance.levelLoadParams.revivalPoint;
		if (vector != Vector3.zero)
		{
			revivalPoint = ModuleController<AdventureModuleController>.Instance.levelLoadParams.revivalPoint;
			btnNames = ModuleController<AdventureModuleController>.Instance.levelLoadParams.btnNames;
			base.playerSpawnPointGizmo._showType = PlayerSpawnPointGizmo.showType.defaultShow;
			base.playerSpawnPointGizmo.transform.position = vector;
			if (ModuleController<AdventureModuleController>.Instance.levelLoadParams.isThreePlayer)
			{
				isThreePlayer = true;
				isPrologueBattleCanSwitchActor = true;
			}
		}
		base.playerSpawnPointGizmo.Initialize(0, 0);
		base.playerSpawnPointGizmo.EnableSpawnLogic();
		base.playerSpawnPointGizmo.ExecuteSpawnLogic();
		MonoSingleton<LuaManager>.Instance.FireEvent("PrologueBattleOpenBattleDash", a1: true);
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
	}

	protected override void HandleTreasureBoxSpawnPoints()
	{
		if (levelLoadParams == null)
		{
			Debug.LogError("主线关卡加载参数为空");
			return;
		}
		MainlineFloor mainlineFloorData = levelLoadParams.mainlineFloorData;
		if (mainlineFloorData == null)
		{
			Debug.LogError("主线层数据为空");
			return;
		}
		string[] array = mainlineFloorData.SceneName.Split('/');
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
			if (!gameObject.name.Equals(mainlineFloorData.ConfigPrefabName))
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
}
