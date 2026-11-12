using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;
using XLua;

public class WeeklyCopiesLevelController : AdventureLevelController
{
	private bool isStartTime;

	private FP timeing = 0;

	private int totalTime;

	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	private float _zoomFreeze;

	private float _zoomDurationTime;

	private Coroutine corSettlement;

	private WeekBossFloor weekBossFloor;

	private RegionBossSummonMonsterGroupGizmo regionBossSummonMonsterGroupGizmo;

	public WeekBossLevel weekBossLevel { get; private set; }

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		weekBossLevel = Singleton<HotfixDataController>.Instance.GetWeekBossLevel(CommonHelper.ParseStringParamToInt(param.id));
		if (weekBossLevel == null)
		{
			Debug.LogError("没有找到weekbosslevel:" + param.id);
			return;
		}
		weekBossFloor = Singleton<HotfixDataController>.Instance.GetWeekBossFloor(weekBossLevel.FloorId);
		if (weekBossFloor == null)
		{
			Debug.LogError($"没有找到weekBossFloor:{weekBossLevel.FloorId}");
			return;
		}
		param.dynamicParam = weekBossLevel.BossShowTime;
		param.monsterLevel = weekBossFloor.MonsterLv;
		if (weekBossFloor != null)
		{
			scenePath = "Assets/AssetBundles/" + weekBossFloor.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
			musicName = weekBossFloor.BGM;
			leaveMusicEvent = weekBossFloor.LeaveTriggerEvent;
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		string[] array = sceneName.Split('/');
		string sceneName2 = array[array.Length - 1];
		Scene sceneByName = SceneManager.GetSceneByName(sceneName2);
		string assetName = scenePath + "/" + weekBossFloor.ConfigPrefabName + ".prefab";
		GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
			configPrefab.transform.localScale = Vector3.one;
			configPrefab.name = weekBossFloor.ConfigPrefabName;
			SceneManager.MoveGameObjectToScene(configPrefab, sceneByName);
		}
		else
		{
			Debug.LogError("策划配置预制体加载失败：" + weekBossFloor.ConfigPrefabName);
		}
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject2 in rootGameObjects)
		{
			if (gameObject2.name.Equals(weekBossFloor.ConfigPrefabName))
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

	public override bool HasTimelinePerformance()
	{
		int num;
		if (weekBossFloor != null)
		{
			num = ((!string.IsNullOrEmpty(weekBossFloor.IntroCutscene)) ? 1 : 0);
			if (num != 0)
			{
				timelineName = weekBossFloor.IntroCutscene;
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
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActor_Died);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_CHANGE_LEVEL_STATE", ChangeLevelState);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("GM_SET_LEVEL_COUNTTIMR", GMSetLevelCountTime);
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
				MonoSingleton<LuaManager>.Instance.FireEvent("RegionBoss_Time_CountUp", totalTime);
				timeing -= (FP)1;
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
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActor_Died);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_CHANGE_LEVEL_STATE", ChangeLevelState);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("GM_SET_LEVEL_COUNTTIMR", GMSetLevelCountTime);
	}

	private void OnActor_Died(IEvent ievent)
	{
		if (((AdventureActorDiedEvent)ievent).actor is PlayerAdventureActor)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Region_Boss_PlayerDied");
		}
	}

	private void OnPlayerDied(IEvent ievent)
	{
		isStartTime = false;
		LevelStateChanged(HotfixEnum.levelState.Failed);
		MonoSingleton<LuaManager>.Instance.FireEvent("Region_Boss_Result", a1: false, totalTime);
	}

	private void StartTiming(IEvent evt)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("RegionBoss_StartTime");
		isStartTime = true;
	}

	protected void ChangeLevelState(IEvent evt)
	{
		isStartTime = false;
		float delayTime = (float)weekBossFloor.DungeonDelay * 0.0001f;
		corSettlement = StartCoroutine(CorSettlementsssss(delayTime));
		if (((AdventureChangeLevelStateEvent)evt).levelState == HotfixEnum.levelState.Success)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("RegionBoss_Success");
		}
	}

	private IEnumerator CorSettlementsssss(float delayTime)
	{
		yield return new WaitForSecondsRealtime(delayTime);
		MonoSingleton<LuaManager>.Instance.FireEvent("Region_Boss_Result", a1: true, totalTime);
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
			HandleSpawnGizmos();
			regionBossSummonMonsterGroupGizmo = UnityEngine.Object.FindObjectOfType<RegionBossSummonMonsterGroupGizmo>();
			if (regionBossSummonMonsterGroupGizmo != null)
			{
				regionBossSummonMonsterGroupGizmo.EnableSpawnLogic();
			}
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
		HandleTreasureBoxSpawnPoints();
	}

	protected override void HandleTreasureBoxSpawnPoints()
	{
		if (levelLoadParams == null)
		{
			Debug.LogError("地区boss关卡加载参数为空");
			return;
		}
		if (weekBossFloor == null)
		{
			Debug.LogError("地区boss层数据为空");
			return;
		}
		string[] array = weekBossFloor.SceneName.Split('/');
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
			if (!gameObject.name.Equals(weekBossFloor.ConfigPrefabName))
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
		_ = treasureBoxSpawnPoints.Count;
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

	private void GMSetLevelCountTime(IEvent ievent)
	{
		if (isStartTime && ievent is GeneralEvent generalEvent)
		{
			CommonHelper.TryParseStringParamToInt((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var intValue);
			int num = 9999 - intValue;
			totalTime = num;
			MonoSingleton<LuaManager>.Instance.FireEvent("RegionBoss_Time_CountUp", totalTime);
		}
	}
}
