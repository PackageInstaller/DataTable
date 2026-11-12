using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

public class AutoBattleBalanceLevelController : AdventureLevelController
{
	private bool isStartTime;

	private FP _totalTimeFP;

	private int levelTotalTime;

	private int eet;

	private MainlineFloor floorData;

	private bool isActiveBalanceTest;

	private bool isConfigTeam;

	private long monsterId;

	private MonsterAdventureActor _monsterAdventureActor;

	private FP hpPre;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		floorData = param.mainlineFloorData;
		eet = (int)param.autoBattleBalanceEET;
		isConfigTeam = param.autoBattleBalanceConfig != null;
		hpPre = param.balanceMainPlayHPPre;
		if (floorData != null)
		{
			scenePath = "Assets/AssetBundles/" + floorData.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
		}
		else
		{
			Debug.LogError("平衡性测试关卡 data is null");
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

	public override void LevelStart(Action callback)
	{
		base.LevelStart(callback);
		_totalTimeFP = FP.Zero;
		levelTotalTime = 180;
		isStartTime = false;
		isActiveBalanceTest = false;
		monsterId = 0L;
		_monsterAdventureActor = null;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnDotDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnDirectDamage);
		callback?.Invoke();
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if (isStartTime)
		{
			_totalTimeFP += logicDeltaTime;
			if (_totalTimeFP >= levelTotalTime)
			{
				isStartTime = false;
				LevelStateChangedCall(HotfixEnum.levelState.Success);
			}
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		isStartTime = false;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnDotDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnDirectDamage);
	}

	private void MonsterSpawn(IEvent evt)
	{
		AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = (AdventureMonsterSpawnedEvent)evt;
		if (adventureMonsterSpawnedEvent != null)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(adventureMonsterSpawnedEvent.id) as MonsterAdventureActor;
			if (monsterAdventureActor != null && _monsterAdventureActor == null)
			{
				monsterId = adventureMonsterSpawnedEvent.id;
				_monsterAdventureActor = monsterAdventureActor;
				_monsterAdventureActor.actorHealthInfo.hp = (long)(_monsterAdventureActor.actorHealthInfo.hpMax / 100 * CommonHelper.ParseStringParamToFDP(Singleton<HotfixDataController>.Instance.GetTestCharacterAtt("MonsterHP").Value));
			}
			if (!isActiveBalanceTest)
			{
				isStartTime = true;
				isActiveBalanceTest = true;
				StartCoroutine(DoAutoBattleMode());
				PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
				activedPlayerActor.actorHealthInfo.hp = (long)(activedPlayerActor.actorHealthInfo.hpMax * hpPre);
			}
		}
	}

	private IEnumerator DoAutoBattleMode()
	{
		yield return new WaitForSeconds(1f);
		AdventureModuleHelper.SetSemiAutoBattleMode(enable: true);
		AdventureModuleHelper.SetAutoCastUltimateSkill(enable: true);
	}

	private void OnDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.to.Id == monsterId)
		{
			_monsterAdventureActor.actorHealthInfo.hp += adventureActorReceiveDamageEvent.damageToHp;
		}
	}

	private void OnDotDamage(IEvent evt)
	{
		if (evt is AdventureActorDotDamageEvent adventureActorDotDamageEvent && adventureActorDotDamageEvent.to.Id == monsterId)
		{
			_monsterAdventureActor.actorHealthInfo.hp += adventureActorDotDamageEvent.damageToHp;
		}
	}

	private void OnDirectDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDirectEvent adventureActorReceiveDirectEvent && adventureActorReceiveDirectEvent.to.Id == monsterId)
		{
			_monsterAdventureActor.actorHealthInfo.hp += adventureActorReceiveDirectEvent.damageToHp;
		}
	}

	public void LevelStateChangedCall(HotfixEnum.levelState levelState)
	{
		if (!isConfigTeam)
		{
			string path = Application.dataPath.Replace("Assets", $"AutoBattleBCTeam/{eet}/TestingProgress.txt");
			int balanceTeamIndex = levelLoadParams.balanceTeamIndex;
			FileStream fileStream = new FileStream(path, FileMode.OpenOrCreate, FileAccess.Write);
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append(balanceTeamIndex);
			UTF8Encoding encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);
			StreamWriter streamWriter = new StreamWriter(fileStream, encoding);
			streamWriter.Write(stringBuilder.ToString());
			streamWriter.Close();
			fileStream.Close();
		}
		else
		{
			_ = $"({DateTime.Now.Month:D2}_{DateTime.Now.Day:D2}_{DateTime.Now.Hour:D2}_{DateTime.Now.Minute:D2}_{DateTime.Now.Second:D2})";
		}
		LevelStateChanged(levelState);
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
	}

	public override void CheckLevelEntitiesStatus()
	{
		AdventureLevelState adventureLevelState = _levelStatus;
		if (adventureLevelState == AdventureLevelState.BattleEnd || adventureLevelState == AdventureLevelState.LevelEnd || adventureLevelState == AdventureLevelState.Finish)
		{
			return;
		}
		base.CheckLevelEntitiesStatus();
		for (int i = 0; i < monsterSpawnWaves.Count; i++)
		{
			MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = monsterSpawnWaves.get_Item(i);
			if (monsterSpawnWaveGizmo.IsAllActived() && !monsterSpawnWaveGizmo.hasSendActivedEvent)
			{
				AdventureLevelRoomWaveMonsterActivedEvent adventureLevelRoomWaveMonsterActivedEvent = AdventureLevelRoomWaveMonsterActivedEvent.Generate();
				adventureLevelRoomWaveMonsterActivedEvent.x = -1;
				adventureLevelRoomWaveMonsterActivedEvent.y = -1;
				adventureLevelRoomWaveMonsterActivedEvent.wave = monsterSpawnWaveGizmo.name;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelRoomWaveMonsterActivedEvent);
				monsterSpawnWaveGizmo.hasSendActivedEvent = true;
			}
			if (monsterSpawnWaveGizmo.IsAllActivedAndDied() && !monsterSpawnWaveGizmo.hasSendClearedEvent)
			{
				AdventureLevelRoomWaveMonsterClearedEvent adventureLevelRoomWaveMonsterClearedEvent = AdventureLevelRoomWaveMonsterClearedEvent.Generate();
				adventureLevelRoomWaveMonsterClearedEvent.x = -1;
				adventureLevelRoomWaveMonsterClearedEvent.y = -1;
				adventureLevelRoomWaveMonsterClearedEvent.wave = monsterSpawnWaveGizmo.name;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureLevelRoomWaveMonsterClearedEvent);
				monsterSpawnWaveGizmo.hasSendClearedEvent = true;
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
