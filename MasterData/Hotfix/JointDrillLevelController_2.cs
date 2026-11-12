using System;
using System.Collections;
using System.Collections.Generic;
using System.IO.Compression;
using System.Linq;
using System.Text;
using AdventureBehaviour;
using Newtonsoft.Json;
using Nova.Client;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;
using XLua;

public class JointDrillLevelController_2 : AdventureLevelController
{
	public class bossMsgData
	{
		public long bossId;

		public int index;

		public bool isDead;
	}

	public class JDBoss
	{
		public int nDataId { get; set; }

		public long nBossId { get; set; }

		public int nIndex { get; set; }

		public int nFloor { get; set; }

		public long nHp { get; set; }

		public long nHpMax { get; set; }

		public long nToughness { get; set; }

		public int nEnergyValue { get; set; }

		public List<Lua2CSharpInfo_ResetBuffInfo> nbuffInfos { get; set; }

		public JDBoss()
		{
		}

		public JDBoss(int nDataId, long nBossId, int nIndex, int nFloor, long nHp, long nHpMax, long nToughness, int nEnergyValue, List<Lua2CSharpInfo_ResetBuffInfo> nbuffInfos)
		{
			this.nDataId = nDataId;
			this.nBossId = nBossId;
			this.nIndex = nIndex;
			this.nFloor = nFloor;
			this.nHp = nHp;
			this.nHpMax = nHpMax;
			this.nToughness = nToughness;
			this.nEnergyValue = nEnergyValue;
			this.nbuffInfos = nbuffInfos;
		}

		public JDBoss(int nDataId, int nIndex, int nFloor)
		{
			this.nDataId = nDataId;
			nBossId = 0L;
			this.nIndex = nIndex;
			this.nFloor = nFloor;
			nHp = 0L;
			nHpMax = 0L;
			nToughness = 0L;
			nEnergyValue = 0;
			nbuffInfos = null;
		}
	}

	public struct JDTempData(int a)
	{
		public List<JDBoss> bossInfo = new List<JDBoss>();

		public List<StarTowerSkill> skillInfo = new List<StarTowerSkill>();

		public List<JointDrillCharacter> characterInfo = new List<JointDrillCharacter>();

		public List<Lua2CSharpInfo_SummonMonsterInfo> summonMonsterInfo = new List<Lua2CSharpInfo_SummonMonsterInfo>();

		public List<Lua2CSharpInfo_ReseShieldInfo> shieldInfo = new List<Lua2CSharpInfo_ReseShieldInfo>();
	}

	protected new AdventureModuleLevelLoadParams levelLoadParams;

	protected JointDrill_2_Level levelData;

	protected JointDrill_2_Floor floorData;

	protected JointDrill_2_MonsterGroup monsterGroupData;

	protected JointDrill_2_FloorChange floorChangeData;

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

	protected new List<PlayerSpawnPointGizmo> playerSpawnPoints = new List<PlayerSpawnPointGizmo>();

	protected new PlayerSpawnPointGizmo playerSpawnPointGizmo;

	protected Dictionary<long, bossMsgData> monsterPosDic = new Dictionary<long, bossMsgData>();

	protected long damageValue;

	protected Dictionary<int, long> charDamageValue = new Dictionary<int, long>();

	private Coroutine corSettlement;

	private Dictionary<int, long> damageRecordDic = new Dictionary<int, long>();

	private int monsterDieTag;

	public List<JDBoss> JDBossInfo;

	public JDTempData JDTempDataInfo;

	protected bool isTestPresetTeam;

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		base.Load(param, callback);
		isTestPresetTeam = false;
		damageRecordDic.Clear();
		monsterPosDic.Clear();
		monsterDieTag = 0;
		levelLoadParams = ModuleController<AdventureModuleController>.Instance?.levelLoadParams;
		levelData = Singleton<HotfixDataController>.Instance.GetJointDrill_2_Level(CommonHelper.ParseStringParamToInt(levelLoadParams.id));
		levelLoadParams.monsterLevel = levelData.Difficulty;
		string str = levelLoadParams.enterDynamicLevelParams[3];
		JDTempDataInfo = DecodeDataCompressed(str);
		JDBossInfo = JDTempDataInfo.bossInfo;
		monsterGroupData = Singleton<HotfixDataController>.Instance.GetJointDrill_2_MonsterGroup(levelData.MonsterGroupId);
		if (JDBossInfo.Count == 0)
		{
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId1, 1, 1));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId2, 2, 1));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId3, 3, 1));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId4, 1, 2));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId5, 2, 2));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId6, 3, 2));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId7, 1, 3));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId8, 2, 3));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId9, 3, 3));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId10, 1, 4));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId11, 2, 4));
			JDBossInfo.Add(new JDBoss(monsterGroupData.MateId12, 3, 4));
		}
		int num = CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[0]);
		totalTime = (FP)CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[2]) / (FP)1000;
		timeing = totalTime % FP.One;
		foreach (KeyValuePair<int, JointDrill_2_Floor> jointDrill_2_FloorDatum in Singleton<HotfixDataController>.Instance.JointDrill_2_FloorData)
		{
			if (jointDrill_2_FloorDatum.Value.FloorId == levelData.FloorId && jointDrill_2_FloorDatum.Value.BattleLvs == num)
			{
				floorData = jointDrill_2_FloorDatum.Value;
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
			if (floorData.FloorChangeID != 0)
			{
				floorChangeData = Singleton<HotfixDataController>.Instance.GetJointDrill_2_FloorChange(floorData.FloorChangeID);
			}
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
		Singleton<EventDispatchManager>.Instance?.AddEventListener("JointDrill_CacheTempData_Start", CacheTempData);
		Singleton<EventDispatchManager>.Instance?.AddEventListener("JointDrill_ResetCharacter", ResetCharacter);
		playerSpawnPointGizmo?.LevelStart();
		base.LevelStart(callback);
		callback?.Invoke();
	}

	public void ResetBuff()
	{
		List<JointDrillCharacter> characterInfo = JDTempDataInfo.characterInfo;
		if (characterInfo == null)
		{
			return;
		}
		for (int i = 0; i < characterInfo.Count; i++)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID((int)characterInfo.get_Item(i).nCharId);
			if (logicEntity == null)
			{
				continue;
			}
			BuffCom logicComponent = logicEntity.GetLogicComponent<BuffCom>();
			if (!(logicComponent == null))
			{
				for (int j = 0; j < characterInfo.get_Item(i).tbBuff.Count; j++)
				{
					logicComponent.ResetBuff((int)characterInfo.get_Item(i).tbBuff.get_Item(j).Id, (int)characterInfo.get_Item(i).tbBuff.get_Item(j).nNum, new FP(characterInfo.get_Item(i).tbBuff.get_Item(j).CD));
				}
			}
		}
	}

	public void SetActorHP()
	{
		List<JointDrillCharacter> characterInfo = JDTempDataInfo.characterInfo;
		if (characterInfo == null)
		{
			return;
		}
		for (int i = 0; i < characterInfo.Count; i++)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID((int)characterInfo.get_Item(i).nCharId);
			if (!(logicEntity == null) && logicEntity is PlayerAdventureActor { actorHealthInfo: not null } playerAdventureActor)
			{
				if (characterInfo.get_Item(i).nHp == 0L)
				{
					(logicEntity as AdventureActor).DestroySelf();
				}
				else if (characterInfo.get_Item(i).nHp > 0)
				{
					playerAdventureActor.actorHealthInfo.hp = characterInfo.get_Item(i).nHp;
				}
				else
				{
					playerAdventureActor.actorHealthInfo.hp = playerAdventureActor.actorHealthInfo.hpMax;
				}
			}
		}
	}

	public void ResetSkill()
	{
		List<StarTowerSkill> skillInfo = JDTempDataInfo.skillInfo;
		if (skillInfo == null)
		{
			return;
		}
		for (int i = 0; i < skillInfo.Count; i++)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID((int)skillInfo.get_Item(i).nCharId);
			if (!(logicEntity == null))
			{
				logicEntity.GetLogicComponent<PlayerSkillCd>()?.ResetSkillInfo((int)skillInfo.get_Item(i).nSkillId, skillInfo.get_Item(i).nCd, (int)skillInfo.get_Item(i).nSectionAmount, skillInfo.get_Item(i).nSectionResumeTime, skillInfo.get_Item(i).nUseTimeHint, skillInfo.get_Item(i).nEnergy);
			}
		}
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
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("JointDrill_CacheTempData_Start", CacheTempData);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("JointDrill_ResetCharacter", ResetCharacter);
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
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_Gameplay_Time", totalTime.AsInt());
	}

	public void MonsterDeclareDeath(IEvent evt)
	{
		AdventureMonsterDeclareDiedEvent adventureMonsterDeclareDiedEvent = (AdventureMonsterDeclareDiedEvent)evt;
		if (adventureMonsterDeclareDiedEvent.epicType != HotfixEnum.monsterEpicType.JOINTDRILLBOSS)
		{
			return;
		}
		monsterDieTag++;
		if (monsterDieTag > 1)
		{
			return;
		}
		if (floorChangeData != null && floorChangeData.BattleLvsToggle == 1)
		{
			int num = 0;
			if (floorChangeData.BossID1 != 0 && adventureMonsterDeclareDiedEvent.monsterID == floorChangeData.BossID1)
			{
				num = CommonHelper.ParseStringParamToInt(floorChangeData.BattleLvsToggleParam1End);
			}
			else if (floorChangeData.BossID2 != 0 && adventureMonsterDeclareDiedEvent.monsterID == floorChangeData.BossID2)
			{
				num = CommonHelper.ParseStringParamToInt(floorChangeData.BattleLvsToggleParam2End);
			}
			else if (floorChangeData.BossID3 != 0 && adventureMonsterDeclareDiedEvent.monsterID == floorChangeData.BossID3)
			{
				num = CommonHelper.ParseStringParamToInt(floorChangeData.BattleLvsToggleParam3End);
			}
			if (num != 0)
			{
				GetDamageValue();
				AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
				MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_CharDamageValue", charDamageValue);
				MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_BossDeath_Type2", floorData.BattleLvs, totalTime.AsFloat(), damageValue, num);
				isStartTime = false;
				MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_StopTime");
				AdventureMsgBattleFinishEvent aEvent2 = AdventureMsgBattleFinishEvent.Generate();
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent2);
				return;
			}
		}
		monsterPosDic.get_Item(adventureMonsterDeclareDiedEvent.id).isDead = true;
		bool flag = true;
		foreach (KeyValuePair<long, bossMsgData> item in monsterPosDic)
		{
			if (!item.Value.isDead)
			{
				flag = false;
			}
		}
		if (flag)
		{
			isStartTime = false;
			MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_StopTime");
			MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_BossDeath_Type2", floorData.BattleLvs, totalTime.AsFloat(), damageValue, floorData.BattleLvs);
			LevelStateChangedCall(HotfixEnum.levelState.Success);
		}
	}

	private void MonsterSpawn(IEvent evt)
	{
		AdventureMonsterSpawnedEvent adventureMonsterSpawnedEvent = (AdventureMonsterSpawnedEvent)evt;
		if (adventureMonsterSpawnedEvent == null)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(adventureMonsterSpawnedEvent.id) as MonsterAdventureActor;
		if (monsterAdventureActor.monsterInfo.epicType != HotfixEnum.monsterEpicType.JOINTDRILLBOSS)
		{
			return;
		}
		long id = monsterAdventureActor.Id;
		monsterAdventureActor.monsterInfo.maxEnergy = floorData.MaxEnergyValue;
		int dataID = monsterAdventureActor.dataID;
		int num = 0;
		if (monsterGroupData.MateId1 == dataID || monsterGroupData.MateId4 == dataID || monsterGroupData.MateId7 == dataID || monsterGroupData.MateId10 == dataID)
		{
			num = 1;
		}
		else if (monsterGroupData.MateId2 == dataID || monsterGroupData.MateId5 == dataID || monsterGroupData.MateId8 == dataID || monsterGroupData.MateId11 == dataID)
		{
			num = 2;
		}
		else if (monsterGroupData.MateId3 == dataID || monsterGroupData.MateId6 == dataID || monsterGroupData.MateId9 == dataID || monsterGroupData.MateId12 == dataID)
		{
			num = 3;
		}
		for (int i = 0; i < JDBossInfo.Count; i++)
		{
			if (floorData.BattleLvs == JDBossInfo.get_Item(i).nFloor && dataID == JDBossInfo.get_Item(i).nDataId)
			{
				JDBossInfo.get_Item(i).nBossId = id;
				if (JDBossInfo.get_Item(i).nHpMax == 0L)
				{
					JDBossInfo.get_Item(i).nHp = monsterAdventureActor.actorHealthInfo.hp;
					JDBossInfo.get_Item(i).nHpMax = monsterAdventureActor.actorHealthInfo.hpMax;
					JDBossInfo.get_Item(i).nEnergyValue = monsterAdventureActor.monsterInfo.currentEnergy;
					JDBossInfo.get_Item(i).nToughness = monsterAdventureActor.monsterToughnessInfo.toughness;
				}
				else
				{
					SetJDBossData(id, JDBossInfo.get_Item(i));
				}
			}
		}
		bossMsgData bossMsgData2 = new bossMsgData();
		bossMsgData2.bossId = id;
		bossMsgData2.index = num;
		bossMsgData2.isDead = false;
		monsterPosDic.set_Item(id, bossMsgData2);
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_MonsterSpawn_Type2", id, dataID, num, monsterAdventureActor.actorHealthInfo.hp, monsterAdventureActor.actorHealthInfo.hpMax);
	}

	protected void LevelStateChangedCall(HotfixEnum.levelState levelState)
	{
		if (!isSettlement)
		{
			ModuleController<AdventureModuleController>.Instance?.RecordStopTimingFrame((uint)LockStepManager.frameCount);
			isSettlement = true;
			AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
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
		if (!(adventureActorReceiveDamageEvent.to is DestructibleStateSingle) && monsterPosDic.ContainsKey(adventureActorReceiveDamageEvent.to.Id))
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
		if (!(adventureActorReceiveDirectEvent.to is DestructibleStateSingle) && monsterPosDic.ContainsKey(adventureActorReceiveDirectEvent.to.Id))
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
		if (!(adventureActorDotDamageEvent.to is DestructibleStateSingle) && monsterPosDic.ContainsKey(adventureActorDotDamageEvent.to.Id))
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
		if (!(adventureActorReceiveKillEvent.to is DestructibleStateSingle) && monsterPosDic.ContainsKey(adventureActorReceiveKillEvent.to.Id))
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

	private void CacheTempData(IEvent ievent)
	{
		if (!(ievent is GeneralEvent generalEvent))
		{
			return;
		}
		LuaTable obj = generalEvent.data as LuaTable;
		bool flag = bool.Parse(obj.get_Item((object)1).ToString());
		bool flag2 = bool.Parse(obj.get_Item((object)2).ToString());
		bool flag3 = bool.Parse(obj.get_Item((object)3).ToString());
		bool flag4 = bool.Parse(obj.get_Item((object)4).ToString());
		int num = CommonHelper.ParseStringParamToInt(obj.get_Item((object)5).ToString());
		int num2 = CommonHelper.ParseStringParamToInt(obj.get_Item((object)6).ToString());
		if (!flag && !flag2)
		{
			return;
		}
		JDTempData data = new JDTempData(1);
		if (flag)
		{
			data.skillInfo = new List<StarTowerSkill>();
			data.summonMonsterInfo = AdventureModuleHelper.GetSummonMonsterInfos();
			List<long> currentGroupPlayers = AdventureModuleHelper.GetCurrentGroupPlayers();
			for (int i = 0; i < currentGroupPlayers.Count; i++)
			{
				int characterId = AdventureModuleHelper.GetCharacterId(currentGroupPlayers.get_Item(i));
				PlayerSkillCd playerSkillCd = AdventureModuleHelper.GetPlayerSkillCd(currentGroupPlayers.get_Item(i));
				int playerActorStatus = AdventureModuleHelper.GetPlayerActorStatus(currentGroupPlayers.get_Item(i));
				long playerActorSpecialStatusTime = AdventureModuleHelper.GetPlayerActorSpecialStatusTime(currentGroupPlayers.get_Item(i));
				int[] playerActorAmmoCount = AdventureModuleHelper.GetPlayerActorAmmoCount(currentGroupPlayers.get_Item(i));
				int playerActorAmmoType = AdventureModuleHelper.GetPlayerActorAmmoType(currentGroupPlayers.get_Item(i));
				AdventureModuleHelper.GetPlayerActorLocalDataJson(currentGroupPlayers.get_Item(i));
				ActorHealthInfo entityHealthInfo = AdventureModuleHelper.GetEntityHealthInfo(currentGroupPlayers.get_Item(i));
				if (entityHealthInfo == null)
				{
					data = new JDTempData(1);
					break;
				}
				JointDrillCharacter item = new JointDrillCharacter(characterId, (int)entityHealthInfo.hp);
				if (playerSkillCd != null)
				{
					List<SkillInfo> skillInfos = playerSkillCd.skillInfos;
					for (int j = 0; j < skillInfos.Count; j++)
					{
						SkillInfo skillInfo = skillInfos.get_Item(j);
						Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(skillInfo.skillId);
						if (skill == null)
						{
							return;
						}
						if (!skill.IsCleanSkillCD)
						{
							StarTowerSkill item2 = new StarTowerSkill(characterId, skillInfo.skillId, skillInfo.currentUseInterval.RawValue, skillInfo.currentSectionAmount, skillInfo.currentResumeTime.RawValue, skillInfo.currentUseTimeHint.RawValue, skillInfo.currentEnergy._raw);
							data.skillInfo.Add(item2);
						}
					}
				}
				item.tbEffect = new List<StarTowerEffect>();
				List<BuffEntity> entityBuffList = AdventureModuleHelper.GetEntityBuffList(currentGroupPlayers.get_Item(i));
				if (entityBuffList != null)
				{
					for (int k = 0; k < entityBuffList.Count; k++)
					{
						BuffEntity buffEntity = entityBuffList.get_Item(k);
						Buff buff = Singleton<HotfixDataController>.Instance.GetBuff(buffEntity.buffConfig.Id);
						if (buff == null)
						{
							return;
						}
						if (buff.NotRemove)
						{
							StarTowerBuffInfo item3 = new StarTowerBuffInfo(buffEntity.buffConfig.Id, buffEntity.GetBuffLeftTime().RawValue, buffEntity.GetBuffNum());
							item.tbBuff.Add(item3);
						}
					}
				}
				StarTowerState stateInfo = new StarTowerState(playerActorStatus, playerActorSpecialStatusTime);
				item.stateInfo = stateInfo;
				if (playerActorAmmoCount != null)
				{
					StarTowerAmmoInfo ammoInfo = new StarTowerAmmoInfo(playerActorAmmoType, playerActorAmmoCount[0], playerActorAmmoCount[1], playerActorAmmoCount[2], playerActorAmmoCount[3], playerActorAmmoCount[4], playerActorAmmoCount[5]);
					item.ammoInfo = ammoInfo;
				}
				if (currentGroupPlayers.get_Item(i) == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id)
				{
					data.shieldInfo = AdventureModuleHelper.GetEntityShieldList(currentGroupPlayers.get_Item(i));
				}
				data.characterInfo.Add(item);
			}
		}
		if (flag2)
		{
			bool saveEnergy = false;
			bool saveResilience = false;
			if (flag4)
			{
				saveEnergy = floorData.SaveEnergyValue;
				saveResilience = floorData.SaveResilience;
			}
			else if (flag3)
			{
				saveEnergy = floorData.TeamSaveEnergyValue;
				saveResilience = floorData.TeamSaveResilience;
			}
			List<JDBoss> list = new List<JDBoss>();
			for (int l = 0; l < JDBossInfo.Count; l++)
			{
				if (JDBossInfo.get_Item(l).nBossId != 0L && JDBossInfo.get_Item(l).nDataId != 0)
				{
					JDBoss bossData = GetBossData(JDBossInfo.get_Item(l).nDataId, JDBossInfo.get_Item(l).nBossId, JDBossInfo.get_Item(l).nIndex, JDBossInfo.get_Item(l).nFloor, flag3, saveEnergy, saveResilience);
					JDBossInfo.set_Item(l, bossData);
					if (bossData.nFloor == num)
					{
						list.Add(bossData);
					}
				}
			}
			if (flag4)
			{
				for (int m = 0; m < JDBossInfo.Count; m++)
				{
					if (JDBossInfo.get_Item(m).nFloor != num2)
					{
						continue;
					}
					for (int n = 0; n < list.Count; n++)
					{
						if (JDBossInfo.get_Item(m).nDataId != 0 && JDBossInfo.get_Item(m).nIndex == list.get_Item(n).nIndex)
						{
							JDBossInfo.get_Item(m).nHpMax = list.get_Item(n).nHpMax;
							JDBossInfo.get_Item(m).nHp = list.get_Item(n).nHp;
							JDBossInfo.get_Item(m).nEnergyValue = list.get_Item(n).nEnergyValue;
							JDBossInfo.get_Item(m).nToughness = list.get_Item(n).nToughness;
							JDBossInfo.get_Item(m).nbuffInfos = list.get_Item(n).nbuffInfos;
						}
					}
				}
				for (int num3 = 0; num3 < JDBossInfo.Count; num3++)
				{
					if (JDBossInfo.get_Item(num3).nFloor == num)
					{
						for (int num4 = 0; num4 < list.Count; num4++)
						{
							JDBossInfo.get_Item(num3).nBossId = 0L;
							JDBossInfo.get_Item(num3).nHpMax = 0L;
							JDBossInfo.get_Item(num3).nHp = 0L;
							JDBossInfo.get_Item(num3).nEnergyValue = 0;
							JDBossInfo.get_Item(num3).nToughness = 0L;
							JDBossInfo.get_Item(num3).nbuffInfos = null;
						}
					}
				}
			}
			data.bossInfo = JDBossInfo;
		}
		string a = ParseDataCompressed(data, out var length);
		MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_CacheTempData_Suc", a, length, JDBossInfo);
	}

	private void ResetCharacter(IEvent ievent)
	{
		ResetBuff();
		SetActorHP();
		ResetSkill();
	}

	public JDBoss GetBossData(int dataId, long bossId, int index, int floor, bool changeTeam, bool saveEnergy, bool saveResilience)
	{
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(bossId) as MonsterAdventureActor;
		if (monsterAdventureActor == null)
		{
			return new JDBoss(dataId, 0L, index, floor, 0L, 0L, 0L, 0, null);
		}
		List<Lua2CSharpInfo_ResetBuffInfo> list = null;
		BuffCom logicComponent = monsterAdventureActor.GetLogicComponent<BuffCom>();
		if (logicComponent != null)
		{
			List<BuffEntity> buffList = logicComponent.BuffList;
			if (buffList != null && buffList.Count > 0)
			{
				list = new List<Lua2CSharpInfo_ResetBuffInfo>();
				foreach (BuffEntity buff in logicComponent.BuffList)
				{
					if (!buff.Removed && (changeTeam ? buff.buffConfig.ChangeTeamNotRemove : buff.buffConfig.NotRemove))
					{
						Lua2CSharpInfo_ResetBuffInfo item = new Lua2CSharpInfo_ResetBuffInfo
						{
							Id = buff.buffConfig.Id,
							buffNum = buff.GetBuffNum(),
							Cd = buff.GetBuffLeftTime().RawValue
						};
						list.Add(item);
					}
				}
			}
		}
		return new JDBoss(monsterAdventureActor.dataID, monsterAdventureActor.Id, index, floor, monsterAdventureActor.actorHealthInfo.hp, monsterAdventureActor.actorHealthInfo.hpMax, saveResilience ? monsterAdventureActor.monsterToughnessInfo.toughness : 0, saveEnergy ? monsterAdventureActor.monsterInfo.currentEnergy : 0, list);
	}

	private Dictionary<int, long> GetActorHp()
	{
		Dictionary<int, long> dictionary = new Dictionary<int, long>();
		List<long> currentGroupPlayers = AdventureModuleHelper.GetCurrentGroupPlayers();
		for (int i = 0; i < currentGroupPlayers.Count; i++)
		{
			int characterId = AdventureModuleHelper.GetCharacterId(currentGroupPlayers.get_Item(i));
			ActorHealthInfo entityHealthInfo = AdventureModuleHelper.GetEntityHealthInfo(currentGroupPlayers.get_Item(i));
			if (entityHealthInfo != null)
			{
				dictionary.set_Item(characterId, entityHealthInfo.hp);
			}
		}
		return dictionary;
	}

	public JDTempData DecodeDataCompressed(string str)
	{
		if (string.IsNullOrEmpty(str))
		{
			return new JDTempData(1);
		}
		try
		{
			string value = GZipUtils.DecompressString(Convert.FromBase64String(str));
			if (string.IsNullOrEmpty(value))
			{
				return new JDTempData(1);
			}
			return JsonConvert.DeserializeObject<JDTempData>(value);
		}
		catch (Exception ex)
		{
			Debug.LogError("Decompress failed: " + ex.Message);
			return new JDTempData(1);
		}
	}

	public string ParseDataCompressed(JDTempData data, out int length)
	{
		string text = JsonConvert.SerializeObject(data);
		Encoding.Default.GetBytes(text);
		Debug.Log("Origin Length:" + Encoding.Default.GetByteCount(text));
		string text2 = Convert.ToBase64String(GZipUtils.CompressString(text, System.IO.Compression.CompressionLevel.Optimal));
		length = Encoding.Default.GetByteCount(text2);
		Debug.Log("Bytes Length:" + length);
		return text2;
	}

	public void SetJDBossData(long bossId, JDBoss data)
	{
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(bossId) as MonsterAdventureActor;
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		monsterAdventureActor.actorHealthInfo.hp = data.nHp;
		if (data.nToughness != 0L)
		{
			monsterAdventureActor.monsterToughnessInfo.toughness = data.nToughness;
		}
		monsterAdventureActor.monsterInfo.currentEnergy = data.nEnergyValue;
		List<Lua2CSharpInfo_ResetBuffInfo> nbuffInfos = data.nbuffInfos;
		if (nbuffInfos == null || nbuffInfos.Count <= 0)
		{
			return;
		}
		BuffCom logicComponent = monsterAdventureActor.GetLogicComponent<BuffCom>();
		if (logicComponent == null)
		{
			return;
		}
		foreach (Lua2CSharpInfo_ResetBuffInfo nbuffInfo in data.nbuffInfos)
		{
			logicComponent.ResetBuff(nbuffInfo.Id, nbuffInfo.buffNum, new FP(nbuffInfo.Cd));
		}
	}
}
