using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Client;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace AIScript.DynamicLevel;

public class JointDrillLevelController : AdventureLevelController
{
	protected new AdventureModuleLevelLoadParams levelLoadParams;

	protected JointDrillLevel levelData;

	protected JointDrillFloor floorData;

	protected new GameObject configPrefab;

	protected bool isStartTime;

	protected FP timeing = 0;

	protected FP totalTime;

	protected int levelTotalTime;

	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	protected float _zoomFreeze;

	protected float _zoomDurationTime;

	protected bool isSettlement;

	protected bool isWaitResult;

	protected new List<PlayerSpawnPointGizmo> playerSpawnPoints = new List<PlayerSpawnPointGizmo>();

	protected new PlayerSpawnPointGizmo playerSpawnPointGizmo;

	protected long bossId;

	protected FP hpLessThanValue;

	protected long damageValue;

	protected Dictionary<int, long> charDamageValue = new Dictionary<int, long>();

	private Coroutine corSettlement;

	private Dictionary<int, long> damageRecordDic = new Dictionary<int, long>();

	protected bool isTestPresetTeam;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		isTestPresetTeam = false;
		damageRecordDic.Clear();
		levelLoadParams = ModuleController<AdventureModuleController>.Instance?.levelLoadParams;
		levelData = Singleton<HotfixDataController>.Instance.GetJointDrillLevel(CommonHelper.ParseStringParamToInt(levelLoadParams.id));
		levelLoadParams.monsterLevel = levelData.Difficulty;
		int num = CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[0]);
		totalTime = (FP)CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[2]) / (FP)1000;
		timeing = totalTime % FP.One;
		foreach (KeyValuePair<int, JointDrillFloor> jointDrillFloorDatum in Singleton<HotfixDataController>.Instance.JointDrillFloorData)
		{
			if (jointDrillFloorDatum.Value.FloorId == levelData.FloorId && jointDrillFloorDatum.Value.BattleLvs == num)
			{
				floorData = jointDrillFloorDatum.Value;
			}
		}
		if (floorData != null)
		{
			scenePath = "Assets/AssetBundles/" + floorData.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string levelSceneName, int process) =>
			{
				LevelLoadProcessUpdate(levelSceneName, process);
				return true;
			});
			musicName = floorData.BGM;
			leaveMusicEvent = floorData.LeaveTriggerEvent;
			levelScript = floorData.LevelScript;
		}
		SceneSingleton<AdventureIndicatorController>.Instance.SetupDefaultBlobIndicators();
		ModuleController<AdventureModuleController>.Instance.StartRecord(levelLoadParams.dmgRecordId, Recorders.Types.LevelType.JointDrill1);
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		ILRuntimeAPI.LoadConfigPrefab(scenePath, floorData.ConfigPrefabName);
		base.LevelLoadComplete(sceneName);
		string[] array = sceneName.Split('/');
		sceneName = array[array.Length - 1];
		GameObject[] rootGameObjects = SceneManager.GetSceneByName(sceneName).GetRootGameObjects();
		foreach (GameObject gameObject in rootGameObjects)
		{
			if (gameObject.name == "==== Navigation ====")
			{
				HandleNavigation(gameObject, sceneName);
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
		damageValue = 0L;
		levelTotalTime = levelData.BattleTime;
		isStartTime = false;
		isSettlement = false;
		isWaitResult = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("JointDrill_Level_GiveUp", GiveUpLevel);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("JointDrill_Level_TimeOut", TimeOutLevel);
		if (floorData.BattleLvsToggle == 1)
		{
			hpLessThanValue = CommonUtils.ParseStringParamToFP(floorData.BattleLvsToggleParam1);
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_HP_CHANGED", OnHpChange);
		}
		playerSpawnPointGizmo?.LevelStart();
		base.LevelStart(callback);
		callback?.Invoke();
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		if (isStartTime)
		{
			timeing += logicDeltaTime;
			totalTime += logicDeltaTime;
			MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_Gameplay_Time", totalTime.AsFloat());
			if (totalTime >= levelTotalTime)
			{
				isStartTime = false;
				ModuleController<AdventureModuleController>.Instance?.RecordStopTimingFrame((uint)LockStepManager.frameCount);
				MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_StopTime");
				LevelStateChangedCall(HotfixEnum.levelState.Failed);
			}
		}
	}

	public override void InitSpawnPoints()
	{
		base.InitSpawnPoints();
		playerSpawnPoints = UnityEngine.Object.FindObjectsOfType<PlayerSpawnPointGizmo>().ToList();
		if (playerSpawnPoints == null || playerSpawnPoints.Count == 0)
		{
			Debug.LogError("关卡中没有配置玩家出生点!");
			return;
		}
		if (null == this.playerSpawnPointGizmo)
		{
			for (int i = 0; i < playerSpawnPoints.Count; i++)
			{
				PlayerSpawnPointGizmo playerSpawnPointGizmo = playerSpawnPoints.get_Item(i);
				if (string.IsNullOrEmpty(playerSpawnPointGizmo.spawnPointID))
				{
					this.playerSpawnPointGizmo = playerSpawnPointGizmo;
					break;
				}
			}
		}
		if (null == this.playerSpawnPointGizmo)
		{
			Debug.LogError("总力战 没有找到合适的角色出生点!");
			return;
		}
		this.playerSpawnPointGizmo.Initialize(0, 0);
		this.playerSpawnPointGizmo.EnableSpawnLogic();
		this.playerSpawnPointGizmo.ExecuteSpawnLogic();
		if (!isViewSceneMode)
		{
			ILRuntimeAPI.HandleSpawnGizmos();
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
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_PLAYER_DIED", OnPlayerDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("LEVEL_START_TIMING", StartTiming);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SPAWN", MonsterSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("JointDrill_Level_GiveUp", GiveUpLevel);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("JointDrill_Level_TimeOut", TimeOutLevel);
		if (floorData.BattleLvsToggle == 1)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChange);
		}
		playerSpawnPoints.Clear();
		playerSpawnPointGizmo?.LevelEnd();
		playerSpawnPointGizmo = null;
		charDamageValue.Clear();
		damageRecordDic.Clear();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearMonsters();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearSkill();
	}

	private void OnPlayerDied(IEvent ievent)
	{
		isStartTime = false;
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_StopTime");
		LevelStateChangedCall(HotfixEnum.levelState.Failed);
	}

	private void StartTiming(IEvent evt)
	{
		isStartTime = true;
		ModuleController<AdventureModuleController>.Instance?.RecordStartTimingFrame((uint)LockStepManager.frameCount);
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_StartTiming");
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_Gameplay_Time", (int)(long)totalTime);
	}

	public void MonsterDeclareDeath(IEvent evt)
	{
		if (((AdventureMonsterDeclareDiedEvent)evt).epicType == HotfixEnum.monsterEpicType.JOINTDRILLBOSS)
		{
			LevelStateChangedCall(HotfixEnum.levelState.Success);
		}
	}

	private void MonsterSpawn(IEvent evt)
	{
		AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = (AdventureMonsterSpawnedEvent)evt;
		if (adventureMonsterSpawnedEvent != null)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(adventureMonsterSpawnedEvent.id) as MonsterAdventureActor;
			if (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.JOINTDRILLBOSS)
			{
				bossId = monsterAdventureActor.Id;
				monsterAdventureActor.monsterInfo.maxEnergy = floorData.MaxEnergyValue;
				MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_MonsterSpawn", bossId, monsterAdventureActor.actorHealthInfo.hp, monsterAdventureActor.actorHealthInfo.hpMax);
			}
		}
	}

	private void OnHpChange(IEvent iEvt)
	{
		if (iEvt is AdventureActorHpChangedEvent adventureActorHpChangedEvent)
		{
			AdventureActor adventureActor = adventureActorHpChangedEvent.sender as AdventureActor;
			if (adventureActor.Id == bossId && adventureActor.actorHealthInfo.hpPercentage <= hpLessThanValue && !isWaitResult)
			{
				isWaitResult = true;
				MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_WaitLvChange");
				StartCoroutine(HpChangeWaitResult());
			}
		}
	}

	private IEnumerator HpChangeWaitResult()
	{
		yield return 1;
		GetDamageValue();
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_CharDamageValue", charDamageValue);
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_BattleLvsToggle", floorData.BattleLvs, totalTime.AsFloat(), damageValue);
		AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
	}

	protected void LevelStateChangedCall(HotfixEnum.levelState levelState)
	{
		if (!isSettlement)
		{
			isStartTime = false;
			ModuleController<AdventureModuleController>.Instance?.RecordStopTimingFrame((uint)LockStepManager.frameCount);
			isSettlement = true;
			AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
			MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_StopTime");
			if (levelState == HotfixEnum.levelState.Success)
			{
				corSettlement = StartCoroutine(CorSettlement((float)floorData.DungeonDelay / 10000f));
				return;
			}
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		}
		void Action()
		{
			GetDamageValue();
			MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_CharDamageValue", charDamageValue);
			MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_Result", (int)levelState, totalTime.AsFloat(), damageValue);
			LevelStateChanged(levelState);
		}
	}

	private IEnumerator CorSettlement(float delayTime)
	{
		yield return new WaitForSecondsRealtime(delayTime);
		GetDamageValue();
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_CharDamageValue", charDamageValue);
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_Result", 2, totalTime.AsFloat(), damageValue);
		LevelStateChanged(HotfixEnum.levelState.Success);
	}

	private void GiveUpLevel(IEvent ievent)
	{
		GetDamageValue();
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_CharDamageValue", charDamageValue);
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_DamageValue", damageValue);
	}

	private void TimeOutLevel(IEvent ievent)
	{
		GetDamageValue();
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_CharDamageValue", charDamageValue);
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_DamageValue", damageValue);
	}

	private void GetDamageValue()
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor != null)
			{
				int dataID = playerAdventureActor.dataID;
				long valueOrDefault = damageRecordDic.GetValueOrDefault(dataID, 0L);
				charDamageValue.set_Item(dataID, valueOrDefault);
				damageValue += valueOrDefault;
			}
		}
	}

	private void OnActorReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.to is DestructibleStateSingle) && adventureActorReceiveDamageEvent.to.Id == bossId)
		{
			PlayerAdventureActor summoner;
			SummonType summonType;
			if (adventureActorReceiveDamageEvent.from is PlayerAdventureActor playerAdventureActor)
			{
				AddPlayerDamage(playerAdventureActor.dataID, adventureActorReceiveDamageEvent.damageToShieldAndHp);
			}
			else if (adventureActorReceiveDamageEvent.from.IsPlayerSummoned(out summoner, out summonType))
			{
				AddPlayerDamage(summoner.dataID, adventureActorReceiveDamageEvent.damageToShieldAndHp);
			}
		}
	}

	private void OnActorReceiveDirectDamage(IEvent evt)
	{
		AdventureActorReceiveDirectEvent adventureActorReceiveDirectEvent = evt as AdventureActorReceiveDirectEvent;
		if (!(adventureActorReceiveDirectEvent.to is DestructibleStateSingle) && adventureActorReceiveDirectEvent.to.Id == bossId)
		{
			PlayerAdventureActor summoner;
			SummonType summonType;
			if (adventureActorReceiveDirectEvent.from is PlayerAdventureActor playerAdventureActor)
			{
				AddPlayerDamage(playerAdventureActor.dataID, adventureActorReceiveDirectEvent.damageToShieldAndHp);
			}
			else if (adventureActorReceiveDirectEvent.from.IsPlayerSummoned(out summoner, out summonType))
			{
				AddPlayerDamage(summoner.dataID, adventureActorReceiveDirectEvent.damageToShieldAndHp);
			}
		}
	}

	private void OnActorReceiveDotDamage(IEvent evt)
	{
		AdventureActorDotDamageEvent adventureActorDotDamageEvent = evt as AdventureActorDotDamageEvent;
		if (!(adventureActorDotDamageEvent.to is DestructibleStateSingle) && adventureActorDotDamageEvent.to.Id == bossId)
		{
			PlayerAdventureActor summoner;
			SummonType summonType;
			if (adventureActorDotDamageEvent.from is PlayerAdventureActor playerAdventureActor)
			{
				AddPlayerDamage(playerAdventureActor.dataID, adventureActorDotDamageEvent.damageToShieldAndHp);
			}
			else if (adventureActorDotDamageEvent.from.IsPlayerSummoned(out summoner, out summonType))
			{
				AddPlayerDamage(summoner.dataID, adventureActorDotDamageEvent.damageToShieldAndHp);
			}
		}
	}

	private void OnActorReceiveKillDamage(IEvent evt)
	{
		AdventureActorReceiveKillEvent adventureActorReceiveKillEvent = evt as AdventureActorReceiveKillEvent;
		if (!(adventureActorReceiveKillEvent.to is DestructibleStateSingle) && adventureActorReceiveKillEvent.to.Id == bossId)
		{
			PlayerAdventureActor summoner;
			SummonType summonType;
			if (adventureActorReceiveKillEvent.from is PlayerAdventureActor playerAdventureActor)
			{
				AddPlayerDamage(playerAdventureActor.dataID, adventureActorReceiveKillEvent.curValue);
			}
			else if (adventureActorReceiveKillEvent.from.IsPlayerSummoned(out summoner, out summonType))
			{
				AddPlayerDamage(summoner.dataID, adventureActorReceiveKillEvent.curValue);
			}
		}
	}

	private void AddPlayerDamage(int dataId, long damage)
	{
		if (damage > 0)
		{
			if (damageRecordDic.ContainsKey(dataId))
			{
				damageRecordDic.get_Item(dataId) += damage;
			}
			else
			{
				damageRecordDic.Add(dataId, damage);
			}
		}
	}
}
