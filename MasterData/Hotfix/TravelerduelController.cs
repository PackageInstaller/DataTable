using System;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;
using XLua;

public class TravelerduelController : AdventureLevelController
{
	private bool isStartTime;

	private FP timeing = 0;

	private int totalTime;

	private int timeLimit;

	private List<int> affixIds = new List<int>();

	private List<int> monsterHardEft = new List<int>();

	private PlayableDirector playableDirector;

	protected TravelerDuelFloor floorData;

	private RegionBossSummonMonsterGroupGizmo regionBossSummonMonsterGroupGizmo;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", LevelEnd);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SETSFM", MonsterSetSFM);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN_BEFORE", MonsterSpawnBefore);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_SPAWN", PlayerSpawn);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("GM_SET_LEVEL_COUNTTIMR", GMSetLevelCountTime);
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		if (!isViewSceneMode)
		{
			TravelerDuelBossLevel travelerDuelBossLevel = Singleton<HotfixDataController>.Instance.GetTravelerDuelBossLevel(CommonHelper.ParseStringParamToInt(param.id));
			monsterHardEft.Clear();
			affixIds.Clear();
			GameTeamConfig teamConfig = AdventureGameContext.TeamConfig;
			affixIds.AddRange(teamConfig.TravelerDuelAffixes);
			timeLimit = travelerDuelBossLevel.Timelimit;
			int num = 0;
			for (int i = 0; i < affixIds.Count; i++)
			{
				TravelerDuelChallengeAffix travelerDuelChallengeAffix = Singleton<HotfixDataController>.Instance.GetTravelerDuelChallengeAffix(affixIds.get_Item(i));
				if (travelerDuelChallengeAffix != null)
				{
					num += travelerDuelChallengeAffix.Difficulty;
				}
			}
			TravelerDuelChallengeDifficulty travelerDuelChallengeDifficulty = Singleton<HotfixDataController>.Instance.GetTravelerDuelChallengeDifficulty(num);
			if (travelerDuelChallengeDifficulty != null)
			{
				monsterHardEft.AddRange(travelerDuelChallengeDifficulty.EffectId);
			}
		}
		floorData = Singleton<HotfixDataController>.Instance.GetTravelerDuelFloor(param.floor);
		if (floorData != null)
		{
			scenePath = "Assets/AssetBundles/" + floorData.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
			param.monsterLevel = floorData.MonsterLv;
			musicName = floorData.BGM;
			leaveMusicEvent = floorData.LeaveTriggerEvent;
		}
		else
		{
			Debug.LogError($"Floor Data Missing：{param.floor}");
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
			if (gameObject2.name.Equals(floorData.IntroCutscene))
			{
				playableDirector = gameObject2.GetComponent<PlayableDirector>();
				gameObject2.SetActive(value: true);
			}
		}
		base.LevelLoadComplete(sceneName);
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
		base.LevelStart(callback);
		totalTime = 0;
		timeing = 0;
		isStartTime = false;
		callback?.Invoke();
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if (!isViewSceneMode && isStartTime)
		{
			timeing += logicDeltaTime;
			if (totalTime >= timeLimit)
			{
				isStartTime = false;
				LevelStateChanged(HotfixEnum.levelState.Failed);
				MonoSingleton<LuaManager>.Instance.FireEvent("TravelerDuel_Result", a1: false, totalTime);
			}
			else if (timeing >= 1)
			{
				totalTime++;
				MonoSingleton<LuaManager>.Instance.FireEvent("TravelerDuel_Time_CountUp", timeLimit - totalTime);
				timeing -= (FP)1;
			}
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		affixIds.Clear();
		isStartTime = false;
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_CLEARED", LevelEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SETSFM", MonsterSetSFM);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN_BEFORE", MonsterSpawnBefore);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", PlayerSpawn);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("GM_SET_LEVEL_COUNTTIMR", GMSetLevelCountTime);
	}

	private void OnPlayerDied(IEvent ievent)
	{
		isStartTime = false;
		LevelStateChanged(HotfixEnum.levelState.Failed);
		MonoSingleton<LuaManager>.Instance.FireEvent("TravelerDuel_Result", a1: false, totalTime);
	}

	private void StartTiming(IEvent evt)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("TravelerDuel_StartTime", timeLimit);
		isStartTime = true;
	}

	private void LevelEnd(IEvent evt)
	{
		isStartTime = false;
		MonoSingleton<LuaManager>.Instance.FireEvent("TravelerDuel_Result", a1: true, totalTime);
	}

	private void MonsterSetSFM(IEvent evt)
	{
		MonsterAdventureActor owner = ((AdventureMonsterSetSFMEvent)evt).owner;
		if (owner == null || Singleton<HotfixDataController>.Instance.GetMonster(owner.dataID) == null)
		{
			return;
		}
		for (int i = 0; i < affixIds.Count; i++)
		{
			TravelerDuelChallengeAffix travelerDuelChallengeAffix = Singleton<HotfixDataController>.Instance.GetTravelerDuelChallengeAffix(affixIds.get_Item(i));
			if (travelerDuelChallengeAffix == null)
			{
				continue;
			}
			bool flag = travelerDuelChallengeAffix.AddCamp.Contains(owner.actorInfo.factionID);
			bool flag2 = false;
			for (int j = 0; j < travelerDuelChallengeAffix.AddClass.Count; j++)
			{
				if (travelerDuelChallengeAffix.AddClass.get_Item(j) == (int)owner.monsterInfo.epicType || travelerDuelChallengeAffix.AddClass.get_Item(j) == 1)
				{
					flag2 = true;
					break;
				}
			}
			if ((flag2 & flag) && travelerDuelChallengeAffix.BranchId != 0)
			{
				owner.monsterAIInfo.actionBranchs.Add(Singleton<HotfixDataController>.Instance.GetMonsterActionBranch(travelerDuelChallengeAffix.BranchId));
			}
		}
	}

	private void MonsterSpawn(IEvent evt)
	{
		AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = (AdventureMonsterSpawnedEvent)evt;
		if (Singleton<HotfixDataController>.Instance.GetMonster(adventureMonsterSpawnedEvent.dataID) == null)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(adventureMonsterSpawnedEvent.id) as MonsterAdventureActor;
		bool flag = monsterAdventureActor.IsPlayerSummoned(out var _, out var _);
		if ((monsterAdventureActor == null) | flag)
		{
			return;
		}
		List<int> list = new List<int>();
		for (int i = 0; i < affixIds.Count; i++)
		{
			TravelerDuelChallengeAffix travelerDuelChallengeAffix = Singleton<HotfixDataController>.Instance.GetTravelerDuelChallengeAffix(affixIds.get_Item(i));
			if (travelerDuelChallengeAffix == null)
			{
				continue;
			}
			bool flag2 = travelerDuelChallengeAffix.AddCamp.Contains(monsterAdventureActor.actorInfo.factionID);
			bool flag3 = false;
			for (int j = 0; j < travelerDuelChallengeAffix.AddClass.Count; j++)
			{
				if (travelerDuelChallengeAffix.AddClass.get_Item(j) == (int)monsterAdventureActor.monsterInfo.epicType || travelerDuelChallengeAffix.AddClass.get_Item(j) == 1)
				{
					flag3 = true;
					break;
				}
			}
			if ((flag3 & flag2) && travelerDuelChallengeAffix.SkillId.Count > 0)
			{
				for (int k = 0; k < travelerDuelChallengeAffix.SkillId.Count; k++)
				{
					list.Add(travelerDuelChallengeAffix.SkillId.get_Item(k));
				}
			}
		}
		list.AddRange(monsterHardEft);
		monsterAdventureActor.effectManage.AddEffectByAI(list);
	}

	private void MonsterSpawnBefore(IEvent evt)
	{
		AdventureMonsterSpawnedBeforeEvent adventureMonsterSpawnedBeforeEvent = (AdventureMonsterSpawnedBeforeEvent)evt;
		if (adventureMonsterSpawnedBeforeEvent.MonsterActor == null)
		{
			return;
		}
		for (int i = 0; i < affixIds.Count; i++)
		{
			TravelerDuelChallengeAffix travelerDuelChallengeAffix = Singleton<HotfixDataController>.Instance.GetTravelerDuelChallengeAffix(affixIds.get_Item(i));
			if (travelerDuelChallengeAffix != null && !string.IsNullOrEmpty(travelerDuelChallengeAffix.LogicTag))
			{
				adventureMonsterSpawnedBeforeEvent.MonsterActor.logicVariable.ToggleLogicTag(travelerDuelChallengeAffix.LogicTag, value: true);
			}
		}
	}

	private void PlayerSpawn(IEvent evt)
	{
		AdventurActorSpawned adventurActorSpawned = (AdventurActorSpawned)evt;
		if (!(adventurActorSpawned.sender is PlayerAdventureActor))
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor = (PlayerAdventureActor)adventurActorSpawned.sender;
		List<int> list = new List<int>();
		for (int i = 0; i < affixIds.Count; i++)
		{
			TravelerDuelChallengeAffix travelerDuelChallengeAffix = Singleton<HotfixDataController>.Instance.GetTravelerDuelChallengeAffix(affixIds.get_Item(i));
			if (travelerDuelChallengeAffix != null && travelerDuelChallengeAffix.AddCamp.Contains(playerAdventureActor.actorInfo.factionID) && travelerDuelChallengeAffix.SkillId.Count > 0)
			{
				for (int j = 0; j < travelerDuelChallengeAffix.SkillId.Count; j++)
				{
					list.Add(travelerDuelChallengeAffix.SkillId.get_Item(j));
				}
			}
		}
		playerAdventureActor.effectManage.AddEffectByAI(list);
	}

	public override void InitSpawnPoints()
	{
		base.InitSpawnPoints();
		PlayerSpawnPointGizmo[] array = UnityEngine.Object.FindObjectsOfType<PlayerSpawnPointGizmo>();
		if (array == null || array.Length == 0)
		{
			Debug.LogError("关卡中没有配置玩家出生点!");
			return;
		}
		if (!string.IsNullOrEmpty(nextLevelData.bornID))
		{
			foreach (PlayerSpawnPointGizmo playerSpawnPointGizmo in array)
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
			foreach (PlayerSpawnPointGizmo playerSpawnPointGizmo2 in array)
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
		if (!isViewSceneMode)
		{
			regionBossSummonMonsterGroupGizmo = UnityEngine.Object.FindObjectOfType<RegionBossSummonMonsterGroupGizmo>();
			if (regionBossSummonMonsterGroupGizmo != null)
			{
				regionBossSummonMonsterGroupGizmo.EnableSpawnLogic();
			}
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

	public override void BossSummonMonster()
	{
		if (regionBossSummonMonsterGroupGizmo != null)
		{
			regionBossSummonMonsterGroupGizmo.SetSummonMonsterMsg();
		}
	}

	public override List<Vector3> BossSummonMonsterPoint(long bossEntityId, float innerRadius, float outsideRadius, int summonMonsterID, int summonCount)
	{
		if (regionBossSummonMonsterGroupGizmo != null)
		{
			return regionBossSummonMonsterGroupGizmo.GetRandomPoint(bossEntityId, innerRadius, outsideRadius, summonMonsterID, summonCount);
		}
		return null;
	}

	public override void PauseTimeLine(bool isPause)
	{
		if (playableDirector != null)
		{
			if (isPause)
			{
				SceneSingleton<PerformManager>.Instance.PauseTimeLinePerform(isPause: true);
			}
			else
			{
				SceneSingleton<PerformManager>.Instance.PauseTimeLinePerform(isPause: false);
			}
		}
	}

	public override void StopTimeLine()
	{
		SceneSingleton<PerformManager>.Instance.StopTimeLinePerform();
	}

	private void GMSetLevelCountTime(IEvent ievent)
	{
		if (isStartTime && ievent is GeneralEvent generalEvent)
		{
			CommonHelper.TryParseStringParamToInt((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var intValue);
			int num = timeLimit - intValue;
			totalTime = num;
			MonoSingleton<LuaManager>.Instance.FireEvent("TravelerDuel_Time_CountUp", timeLimit - totalTime);
		}
	}
}
