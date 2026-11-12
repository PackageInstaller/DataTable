using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Client;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ScoreBossLevelController : AdventureLevelController
{
	private bool isStartTime;

	private FP timeing = 0;

	private int totalTime;

	private int levelTotalTime;

	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	private float _zoomFreeze;

	private float _zoomDurationTime;

	private Coroutine corSettlement;

	protected ScoreBossLevel levelData;

	protected ScoreBossFloor floorData;

	public bool isSettlement;

	protected long bossId;

	protected bool isTestPresetTeam;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		isTestPresetTeam = false;
		ModuleController<AdventureModuleController>.Instance.StartRecord(AdventureGameContext.LevelLoadParam.dmgRecordId, Recorders.Types.LevelType.Scoreboss);
		levelData = Singleton<HotfixDataController>.Instance.GetScoreBossLevel(CommonHelper.ParseStringParamToInt(param.id));
		floorData = Singleton<HotfixDataController>.Instance.GetScoreBossFloor(levelData.FloorId);
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
			levelScript = floorData.LevelScript;
		}
		else
		{
			Debug.LogError("scoreBossFloor data is null");
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
		totalTime = 0;
		timeing = 0;
		levelTotalTime = CommonHelper.ParseStringParamToInt(Singleton<GameDataController>.Instance.GetConfig("ScoreBossTimeLimit").Value);
		isStartTime = false;
		isSettlement = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN_BEFORE", MonsterSpawnBefore);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
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
				totalTime++;
				timeing -= (FP)1;
				MonoSingleton<LuaManager>.Instance.FireEvent("ScoreBoss_Gameplay_Time", levelTotalTime - totalTime);
			}
			if (totalTime >= levelTotalTime)
			{
				ModuleController<AdventureModuleController>.Instance?.RecordStopTimingFrame((uint)LockStepManager.frameCount);
				LevelStateChangedCall(HotfixEnum.levelState.Success);
			}
		}
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
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN_BEFORE", MonsterSpawnBefore);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearMonsters();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearSkill();
	}

	private void OnActor_Died(IEvent ievent)
	{
		_ = ((AdventureActorDiedEvent)ievent).actor is PlayerAdventureActor;
	}

	private void OnPlayerDied(IEvent ievent)
	{
		LevelStateChangedCall(HotfixEnum.levelState.Failed);
	}

	private void StartTiming(IEvent evt)
	{
		isStartTime = true;
		ModuleController<AdventureModuleController>.Instance?.RecordStartTimingFrame((uint)LockStepManager.frameCount);
	}

	public void MonsterDeclareDeath(IEvent evt)
	{
		if (((AdventureMonsterDeclareDiedEvent)evt).epicType == HotfixEnum.monsterEpicType.BOSSRUSH)
		{
			LevelStateChangedCall(HotfixEnum.levelState.Success);
		}
	}

	private void MonsterSpawnBefore(IEvent evt)
	{
		AdventureMonsterSpawnedBeforeEvent adventureMonsterSpawnedBeforeEvent = (AdventureMonsterSpawnedBeforeEvent)evt;
		if (adventureMonsterSpawnedBeforeEvent.MonsterActor == null)
		{
			return;
		}
		int scoreBossAbility = levelData.ScoreBossAbility;
		ScoreBossAbility scoreBossAbility2 = Singleton<HotfixDataController>.Instance.GetScoreBossAbility(scoreBossAbility);
		if (scoreBossAbility2 != null)
		{
			List<AddEffectInfo> list = new List<AddEffectInfo>();
			foreach (int item in scoreBossAbility2.EffectID)
			{
				list.Add(new AddEffectInfo(item, -1, 0L));
			}
			string[] array = scoreBossAbility2.ScriptID.ToArray();
			adventureMonsterSpawnedBeforeEvent.MonsterActor.effectManage?.AddEffectByTalent(list);
			string[] array2 = array;
			foreach (string myTag in array2)
			{
				adventureMonsterSpawnedBeforeEvent.MonsterActor.AddTag(myTag);
			}
		}
		int nonDamageScoreGet = levelData.NonDamageScoreGet;
		ScoreBossGetControl scoreBossGetControl = Singleton<HotfixDataController>.Instance.GetScoreBossGetControl(nonDamageScoreGet);
		if (scoreBossGetControl != null)
		{
			adventureMonsterSpawnedBeforeEvent.MonsterActor.SetScoreBossBehaviour(scoreBossGetControl.ScoreBossBehavior);
		}
		adventureMonsterSpawnedBeforeEvent.MonsterActor.summonMonsterUseBattleLevelAsDifficultLevel = levelData.SummonLevelUp;
	}

	private void MonsterSpawn(IEvent evt)
	{
		AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = (AdventureMonsterSpawnedEvent)evt;
		if (adventureMonsterSpawnedEvent != null)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(adventureMonsterSpawnedEvent.id) as MonsterAdventureActor;
			if (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.BOSSRUSH)
			{
				bossId = monsterAdventureActor.Id;
				MonoSingleton<LuaManager>.Instance.FireEvent("BossRush_Spawn_Id", monsterAdventureActor.Id);
			}
		}
	}

	protected void LevelStateChangedCall(HotfixEnum.levelState levelState)
	{
		if (!isSettlement)
		{
			isStartTime = false;
			AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
			ModuleController<AdventureModuleController>.Instance?.RecordStopTimingFrame((uint)LockStepManager.frameCount);
			isSettlement = true;
			_logger.LogInfo($"fixed rog level state changed:{levelState}");
			MonoSingleton<LuaManager>.Instance.FireEvent("ScoreBoss_Settlement_Ready");
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		}
		void Action()
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("ScoreBoss_Result_Time", totalTime);
			LevelStateChanged(levelState);
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

	private void OnActorReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.to is DestructibleStateSingle) && adventureActorReceiveDamageEvent.to.Id == bossId)
		{
			MonoSingleton<LuaManager>.Instance.FireEntityEvent("BossRushMonsterDamageValue", bossId, adventureActorReceiveDamageEvent.damageToHp);
		}
	}

	private void OnActorReceiveDirectDamage(IEvent evt)
	{
		AdventureActorReceiveDirectEvent adventureActorReceiveDirectEvent = evt as AdventureActorReceiveDirectEvent;
		if (!(adventureActorReceiveDirectEvent.to is DestructibleStateSingle) && adventureActorReceiveDirectEvent.to.Id == bossId)
		{
			MonoSingleton<LuaManager>.Instance.FireEntityEvent("BossRushMonsterDamageValue", bossId, adventureActorReceiveDirectEvent.damageToHp);
		}
	}

	private void OnActorReceiveDotDamage(IEvent evt)
	{
		AdventureActorDotDamageEvent adventureActorDotDamageEvent = evt as AdventureActorDotDamageEvent;
		if (!(adventureActorDotDamageEvent.to is DestructibleStateSingle) && adventureActorDotDamageEvent.to.Id == bossId)
		{
			MonoSingleton<LuaManager>.Instance.FireEntityEvent("BossRushMonsterDamageValue", bossId, adventureActorDotDamageEvent.damageToHp);
		}
	}

	private void OnActorReceiveKillDamage(IEvent evt)
	{
		AdventureActorReceiveKillEvent adventureActorReceiveKillEvent = evt as AdventureActorReceiveKillEvent;
		if (!(adventureActorReceiveKillEvent.to is DestructibleStateSingle) && adventureActorReceiveKillEvent.to.Id == bossId)
		{
			MonoSingleton<LuaManager>.Instance.FireEntityEvent("BossRushMonsterDamageValue", bossId, adventureActorReceiveKillEvent.curValue);
		}
	}
}
