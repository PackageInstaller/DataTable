#define LOG_ERROR
using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Soldier;
using Google.Protobuf.Collections;
using Newtonsoft.Json;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SoldierLevelController : AdventureLevelController, ICoroutineOwner
{
	public struct SoldierMsg(int nSoldierId, bool nBattleRole, int boardIndex, int nSoldierLv, SoldierAttr soldierAttr)
	{
		public int nSoldierId = nSoldierId;

		public bool nBattleRole = nBattleRole;

		public int boardIndex = boardIndex;

		public int nSoldierLv = nSoldierLv;

		public SoldierAttr soldierAttr = soldierAttr;
	}

	public struct SoldierLevelMsg(int a)
	{
		public List<SoldierMsg> SoldierData = new List<SoldierMsg>();

		public Dictionary<int, List<int>> PartnerArrDic = new Dictionary<int, List<int>>();

		public int nHarvestCount = 0;

		public List<int> buffEffectList = new List<int>();

		public void AddPartner(int partnerId, int[] soldiers)
		{
			PartnerArrDic.set_Item(partnerId, (soldiers != null) ? new List<int>(soldiers) : new List<int>());
		}

		public string ToJson()
		{
			return JsonConvert.SerializeObject(this);
		}
	}

	public struct SoldierAttr
	{
		public int Hp;

		public int HpMax;

		public int Atk;

		public int Def;

		public int CritRate;

		public int CritResistance;

		public int CritPower;

		public int HitRate;

		public int Evd;

		public int DefPierce;

		public int DefIgnore;

		public int Suppress;

		public int Energy;

		public int InitialEnergy;

		public float Recovery;

		public int ATKSPD_P;
	}

	public class SoldierSummonData
	{
		public SoldierActor summoner;

		public SoldierActor summoned;

		public long summonerId;

		public long entityId;

		public int dataID;

		public bool isEnemyCamp;

		public bool isAlive;
	}

	private bool isStartTime;

	private FP timeing = 0;

	private int totalTime;

	private int levelTotalTime;

	private bool isDpsCheckStage;

	private long dpsCheckStageTotalDamage;

	private bool isBothAddBuff;

	private SoldierFloor soldierFloor;

	private FP supportAttackCD = 0.1;

	protected const string ZoomFreezeKey = "ZoomFreeze";

	protected const string ZoomDurationTimeKey = "ZoomInDurationTime";

	private float _zoomFreeze;

	private float _zoomDurationTime;

	private bool isSettlement;

	private FP ourLastSupportCastTime = -1000;

	private int ourLastSupportCastActorId;

	private FP enemyLastSupportCastTime = -1000;

	private int enemyLastSupportCastActorId;

	private List<SoldierSpawnPoint> listEnemyCamp = new List<SoldierSpawnPoint>();

	private Dictionary<int, SoldierSpawnPoint> dicOurSide = new Dictionary<int, SoldierSpawnPoint>();

	private List<SoldierActor> ourBattleActors = new List<SoldierActor>();

	private List<SoldierActor> ourSupportActors = new List<SoldierActor>();

	private List<SoldierActor> enemyBattleActors = new List<SoldierActor>();

	private List<SoldierActor> enemySupportActors = new List<SoldierActor>();

	private long enemyBattleTotalHP;

	private List<long> enemyBattleActorsUid = new List<long>();

	private SoldierActor _ourMainControlActor;

	private SoldierActor _enemyMainControlActor;

	private int _ourAliveBattleCount;

	private int _enemyAliveBattleCount;

	private Dictionary<int, int> PartnerLvList = new Dictionary<int, int>();

	public Dictionary<int, List<int>> PartnerDic = new Dictionary<int, List<int>>();

	public Dictionary<int, SoldierMsg> dicSoldierMsg = new Dictionary<int, SoldierMsg>();

	public Dictionary<int, SoldierAttr> dicSoldierAttr = new Dictionary<int, SoldierAttr>();

	private readonly List<AIAdapter> _partnerScripts = new List<AIAdapter>();

	private AIAdapter _bossPassiveScripts;

	private Dictionary<long, long> ourSoldierDamage = new Dictionary<long, long>();

	private int EnemyCampLv = 1;

	public int EnemyAmendLv = 1;

	public int RatioStage = 1;

	private int BossTemPlateId = 1;

	private SoldierLevelMsg soldierMsg;

	public int shopLv = 1;

	private readonly List<SoldierSummonData> soldierSummons = new List<SoldierSummonData>();

	public SoldierActor mainControlActor
	{
		get
		{
			if (_ourMainControlActor == null || _ourMainControlActor.isDead)
			{
				_ourMainControlActor = PickMainControlActor(ourBattleActors);
			}
			return _ourMainControlActor;
		}
	}

	public SoldierActor enemyMainControlActor
	{
		get
		{
			if (_enemyMainControlActor == null || _enemyMainControlActor.isDead)
			{
				_enemyMainControlActor = PickMainControlActor(enemyBattleActors);
			}
			return _enemyMainControlActor;
		}
	}

	public SoldierActor GetMainControlActor(bool isEnemyCamp)
	{
		if (!isEnemyCamp)
		{
			return mainControlActor;
		}
		return enemyMainControlActor;
	}

	private SoldierActor PickMainControlActor(List<SoldierActor> battle)
	{
		SoldierActor soldierActor = null;
		for (int i = 0; i < battle.Count; i++)
		{
			SoldierActor soldierActor2 = battle.get_Item(i);
			if (!(soldierActor2 == null) && !soldierActor2.isDead && (soldierActor == null || soldierActor2.gridIndex < soldierActor.gridIndex))
			{
				soldierActor = soldierActor2;
			}
		}
		return soldierActor;
	}

	public override void Load(AdventureModuleLevelLoadParams param = null, Action callback = null)
	{
		levelLoadParams = param;
		flowCallback = callback;
		isLoadingLevel = true;
		hasBattleStartMsgTrigger = false;
		hasBattleFinishMsgTrigger = false;
		if (param == null)
		{
			callback?.Invoke();
			return;
		}
		if (levelLoadParams.enterDynamicLevelParams.Length > 4)
		{
			EnemyCampLv = CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[0]);
			EnemyAmendLv = CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[1]);
			RatioStage = CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[2]);
			BossTemPlateId = CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[3]);
			soldierMsg = DecodeData(levelLoadParams.enterDynamicLevelParams[4]);
			if (levelLoadParams.enterDynamicLevelParams.Length == 6)
			{
				shopLv = CommonHelper.ParseStringParamToInt(levelLoadParams.enterDynamicLevelParams[5]);
			}
		}
		if (soldierMsg.PartnerArrDic != null)
		{
			foreach (KeyValuePair<int, List<int>> item in soldierMsg.PartnerArrDic)
			{
				SoldierPartner soldierPartner = Singleton<HotfixDataController>.Instance.GetSoldierPartner(item.Key);
				if (soldierPartner != null)
				{
					PartnerLvList.Add(soldierPartner.PartnerType, soldierPartner.Level);
					PartnerDic.Add(soldierPartner.PartnerType, item.Value);
				}
			}
		}
		if (soldierMsg.SoldierData != null)
		{
			for (int i = 0; i < soldierMsg.SoldierData.Count; i++)
			{
				if (soldierMsg.SoldierData.get_Item(i).nSoldierId != 0)
				{
					dicSoldierMsg.Add(soldierMsg.SoldierData.get_Item(i).nSoldierId, soldierMsg.SoldierData.get_Item(i));
				}
			}
		}
		soldierFloor = Singleton<HotfixDataController>.Instance.GetSoldierFloor(CommonHelper.ParseStringParamToInt(param.id));
		if (soldierFloor != null)
		{
			levelTotalTime = soldierFloor.BattleTime;
			isDpsCheckStage = soldierFloor.IsDpsCheckStage;
			scenePath = "Assets/AssetBundles/" + soldierFloor.SceneName;
			MonoSingleton<SceneLoaderController>.Instance.LoadSceneAsync(scenePath, LoadSceneMode.Additive, LocalPhysicsMode.None, (string sceneName, int process) =>
			{
				LevelLoadProcessUpdate(sceneName, process);
				return true;
			});
			musicName = soldierFloor.BGM;
			leaveMusicEvent = string.Empty;
		}
		else
		{
			NovaLogger.Error("soldierFloor data is null");
		}
	}

	protected override void LevelLoadComplete(string sceneName)
	{
		string[] array = sceneName.Split('/');
		Scene sceneByName = SceneManager.GetSceneByName(array[array.Length - 1]);
		string assetName = scenePath + "/" + soldierFloor.ConfigPrefabName + ".prefab";
		GameObject gameObject = MonoSingleton<SceneLoaderController>.Instance.LoadAsset(scenePath, assetName, typeof(GameObject)) as GameObject;
		if (gameObject != null)
		{
			configPrefab = UnityEngine.Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity);
			configPrefab.transform.localScale = Vector3.one;
			configPrefab.name = soldierFloor.ConfigPrefabName;
			SceneManager.MoveGameObjectToScene(configPrefab, sceneByName);
		}
		else
		{
			NovaLogger.Error("策划配置预制体加载失败：" + soldierFloor.ConfigPrefabName);
		}
		hasBattleStartMsgTrigger = true;
		GameObject[] rootGameObjects = sceneByName.GetRootGameObjects();
		foreach (GameObject gameObject2 in rootGameObjects)
		{
			if (!gameObject2.name.Equals(soldierFloor.ConfigPrefabName))
			{
				continue;
			}
			SoldierSpawnPoint[] componentsInChildren = gameObject2.GetComponentsInChildren<SoldierSpawnPoint>(includeInactive: true);
			foreach (SoldierSpawnPoint soldierSpawnPoint in componentsInChildren)
			{
				if (soldierSpawnPoint.EnemyCamp)
				{
					listEnemyCamp.Add(soldierSpawnPoint);
				}
				else if (!dicOurSide.ContainsKey(soldierSpawnPoint.gridIndex))
				{
					soldierSpawnPoint.chessId = 0;
					dicOurSide.set_Item(soldierSpawnPoint.gridIndex, soldierSpawnPoint);
				}
				else
				{
					NovaLogger.Error($"棋盘序号重复：{soldierSpawnPoint.gridIndex}");
				}
			}
			foreach (KeyValuePair<int, SoldierMsg> item in dicSoldierMsg)
			{
				if (item.Value.nBattleRole && dicOurSide.ContainsKey(item.Value.boardIndex))
				{
					dicOurSide.get_Item(item.Value.boardIndex).chessId = item.Value.nSoldierId;
				}
			}
			MonoSingleton<WwiseAudioManager>.Instance.SetAudioListenerPos(new Vector3(0f, 10f, -10f), new Vector3(50f, 0f, 0f));
		}
		base.LevelLoadComplete(sceneName);
	}

	public override void LevelStart(Action callback = null)
	{
		base.LevelStart(callback);
		callback?.Invoke();
		isSettlement = false;
		isStartTime = false;
		timeing = 0;
		totalTime = 0;
		isBothAddBuff = false;
		for (int i = 0; i < listEnemyCamp.Count; i++)
		{
			if (listEnemyCamp.get_Item(i).chessId == 0)
			{
				continue;
			}
			if (!listEnemyCamp.get_Item(i).isSupport)
			{
				SoldierActor soldierActor = SpawnChess(listEnemyCamp.get_Item(i));
				if (!(soldierActor != null))
				{
					continue;
				}
				enemyBattleActors.Add(soldierActor);
				enemyBattleActorsUid.Add(soldierActor.Id);
				if (listEnemyCamp.get_Item(i).gridIndex <= 3)
				{
					SoldierPositionEffect soldierPositionEffect = Singleton<HotfixDataController>.Instance.GetSoldierPositionEffect(listEnemyCamp.get_Item(i).gridIndex);
					if (soldierPositionEffect != null && soldierPositionEffect.OppoEffectId != 0)
					{
						soldierActor.buffComponent.AddBuff(soldierPositionEffect.OppoEffectId, soldierActor);
					}
				}
			}
			else
			{
				SpawnSupport(listEnemyCamp.get_Item(i).chessId, 1, EnemyCampLv, isEnemyCamp: true);
			}
		}
		foreach (KeyValuePair<int, SoldierSpawnPoint> item in dicOurSide)
		{
			if (item.Value.chessId != 0)
			{
				SoldierActor soldierActor2 = SpawnChess(item.Value);
				if (soldierActor2 != null)
				{
					ourBattleActors.Add(soldierActor2);
				}
			}
		}
		foreach (KeyValuePair<int, SoldierMsg> item2 in dicSoldierMsg)
		{
			if (!item2.Value.nBattleRole)
			{
				SpawnSupport(item2.Value.nSoldierId, item2.Value.nSoldierLv, 0);
			}
		}
		_ourAliveBattleCount = ourBattleActors.Count;
		_enemyAliveBattleCount = enemyBattleActors.Count;
		StartLogicCoroutine(yieldBattleStart());
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
		SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
	}

	private IEnumerator yieldBattleStart()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("Soldier_IsStart_Ready", a1: true);
		FP waitSeconds = 1;
		while (waitSeconds > 0)
		{
			waitSeconds -= LockStepManager.deltaTime;
			yield return null;
		}
		EnableAIAdapterScripts();
		MonoSingleton<LuaManager>.Instance.FireEvent("ShowPlayerHudRootCanvas");
		MonoSingleton<LuaManager>.Instance.FireEvent("Soldier_IsStart_Ok");
		AdventureMsgBattleStartEvent aEvent = AdventureMsgBattleStartEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
		isStartTime = true;
		MonoSingleton<LuaManager>.Instance.FireEvent("SoldierLevel_Gameplay_Time", totalTime);
		enemyBattleTotalHP = 0L;
		for (int i = 0; i < enemyBattleActors.Count; i++)
		{
			enemyBattleTotalHP += enemyBattleActors.get_Item(i).actorHealthInfo.hpMax;
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("EnemyBattle_TotalHP", enemyBattleTotalHP);
	}

	public override void UpdateLogic(FP logicDeltaTime)
	{
		base.UpdateLogic(logicDeltaTime);
		DispatchSupportCastRequests();
		UpdateAIAdapterScripts();
		if (isStartTime)
		{
			timeing += logicDeltaTime;
			if (timeing >= 1)
			{
				totalTime++;
				timeing -= (FP)1;
				MonoSingleton<LuaManager>.Instance.FireEvent("SoldierLevel_Gameplay_Time", totalTime);
			}
			if (totalTime >= levelTotalTime && !isBothAddBuff)
			{
				isBothAddBuff = true;
				ApplyBothAddBuffToList(ourBattleActors);
				ApplyBothAddBuffToList(enemyBattleActors);
			}
		}
	}

	public override void LevelEnd()
	{
		base.LevelEnd();
		MonoSingleton<LuaManager>.Instance?.FireEvent("Soldier_IsStart_Ready", a1: true);
		DisableAIAdapterScripts();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DIRECT", OnActorReceiveDirectDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DOT_DAMAGE", OnActorReceiveDotDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_KILL", OnActorReceiveKillDamage);
		listEnemyCamp.Clear();
		dicOurSide.Clear();
		ourBattleActors.Clear();
		ourSupportActors.Clear();
		enemyBattleActors.Clear();
		enemySupportActors.Clear();
		enemyBattleActorsUid.Clear();
		_ourAliveBattleCount = 0;
		_enemyAliveBattleCount = 0;
		PartnerLvList.Clear();
		PartnerDic.Clear();
		dicSoldierMsg.Clear();
		dicSoldierAttr.Clear();
		ourSoldierDamage.Clear();
		soldierSummons.Clear();
		ourLastSupportCastTime = -1000;
		ourLastSupportCastActorId = 0;
		enemyLastSupportCastTime = -1000;
		enemyLastSupportCastActorId = 0;
		dpsCheckStageTotalDamage = 0L;
	}

	private void EnableAIAdapterScripts()
	{
		foreach (KeyValuePair<int, SoldierPartnerGroup> soldierPartnerGroupDatum in Singleton<HotfixDataController>.Instance.SoldierPartnerGroupData)
		{
			if (PartnerLvList.ContainsKey(soldierPartnerGroupDatum.Value.PartnerType) && !string.IsNullOrEmpty(soldierPartnerGroupDatum.Value.Path))
			{
				AIAdapter aIAdapter = new AIAdapter();
				if (!aIAdapter.Initialize(soldierPartnerGroupDatum.Value.Path, gameObject))
				{
					aIAdapter = null;
				}
				aIAdapter?.Start();
				if (aIAdapter != null)
				{
					_partnerScripts.Add(aIAdapter);
				}
			}
		}
		SoldierBossTemplate soldierBossTemplate = Singleton<HotfixDataController>.Instance.GetSoldierBossTemplate(BossTemPlateId);
		if (soldierBossTemplate != null && !string.IsNullOrEmpty(soldierBossTemplate.Path))
		{
			AIAdapter aIAdapter2 = new AIAdapter();
			if (!aIAdapter2.Initialize(soldierBossTemplate.Path, gameObject))
			{
				aIAdapter2 = null;
			}
			aIAdapter2?.Start();
			_bossPassiveScripts = aIAdapter2;
		}
	}

	private void DisableAIAdapterScripts()
	{
		foreach (AIAdapter partnerScript in _partnerScripts)
		{
			partnerScript?.Disable();
		}
		_partnerScripts.Clear();
		if (_bossPassiveScripts != null)
		{
			_bossPassiveScripts.Disable();
			_bossPassiveScripts = null;
		}
	}

	private void UpdateAIAdapterScripts()
	{
		foreach (AIAdapter partnerScript in _partnerScripts)
		{
			partnerScript?.Update();
		}
		_bossPassiveScripts?.Update();
	}

	public void NotifySupportPromoted(SoldierActor actor)
	{
		if (actor == null)
		{
			return;
		}
		if (actor.isEnemyCamp)
		{
			enemySupportActors.Remove(actor);
			if (!enemyBattleActors.Contains(actor))
			{
				enemyBattleActors.Add(actor);
				_enemyAliveBattleCount++;
			}
		}
		else
		{
			ourSupportActors.Remove(actor);
			if (!ourBattleActors.Contains(actor))
			{
				ourBattleActors.Add(actor);
				_ourAliveBattleCount++;
			}
		}
		if (isBothAddBuff)
		{
			ApplyBothAddBuff(actor);
		}
		AdventureSoldierSupportPromotedEvent adventureSoldierSupportPromotedEvent = AdventureSoldierSupportPromotedEvent.Generate();
		adventureSoldierSupportPromotedEvent.actorId = actor.Id;
		adventureSoldierSupportPromotedEvent.dataID = actor.dataID;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureSoldierSupportPromotedEvent);
	}

	private void ApplyBothAddBuff(SoldierActor actor)
	{
		if (actor == null || soldierFloor == null || actor.buffComponent == null)
		{
			return;
		}
		RepeatedField<int> bothAddBuff = soldierFloor.BothAddBuff;
		if (bothAddBuff == null)
		{
			return;
		}
		for (int i = 0; i < bothAddBuff.Count; i++)
		{
			int num = bothAddBuff.get_Item(i);
			if (num != 0)
			{
				actor.buffComponent.AddBuff(num, actor);
			}
		}
	}

	private void ApplyBothAddBuffToList(List<SoldierActor> list)
	{
		if (!isDpsCheckStage)
		{
			for (int i = 0; i < list.Count; i++)
			{
				ApplyBothAddBuff(list.get_Item(i));
			}
		}
	}

	private void DispatchSupportCastRequests()
	{
		DispatchSupportCastForCamp(ourSupportActors);
		DispatchSupportCastForCamp(enemySupportActors);
	}

	private void DispatchSupportCastForCamp(List<SoldierActor> supports)
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if ((object)instance == null || !instance.InBattleState)
		{
			return;
		}
		for (int i = 0; i < supports.Count; i++)
		{
			SoldierActor soldierActor = supports.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !soldierActor.isCastingSupport && soldierActor.supportSkillId != 0 && soldierActor.isEnergyFull && CanCastSupportSkill(soldierActor.dataID, soldierActor.isEnemyCamp))
			{
				SoldierBaseAI soldierAI = soldierActor.soldierAI;
				if (soldierAI != null && soldierAI.TriggerSupportCast())
				{
					MarkSupportCast(soldierActor.dataID, soldierActor.isEnemyCamp);
				}
			}
		}
	}

	public bool CanCastSupportSkill(int actorId, bool isEnemyCamp)
	{
		int num = (isEnemyCamp ? enemyLastSupportCastActorId : ourLastSupportCastActorId);
		FP fP = (isEnemyCamp ? enemyLastSupportCastTime : ourLastSupportCastTime);
		if (num == 0 || num == actorId)
		{
			return true;
		}
		return LockStepManager.time - fP >= supportAttackCD;
	}

	public void MarkSupportCast(int actorId, bool isEnemyCamp)
	{
		if (isEnemyCamp)
		{
			enemyLastSupportCastTime = LockStepManager.time;
			enemyLastSupportCastActorId = actorId;
		}
		else
		{
			ourLastSupportCastTime = LockStepManager.time;
			ourLastSupportCastActorId = actorId;
		}
	}

	private SoldierActor SpawnChess(SoldierSpawnPoint point)
	{
		int num = 1;
		int enemyCampLv = 0;
		if (point.EnemyCamp)
		{
			num = 1;
			enemyCampLv = EnemyCampLv;
		}
		else
		{
			num = dicSoldierMsg.get_Item(point.chessId).nSoldierLv;
		}
		SoldierActor soldierActor = SpawnChessInternal(point.chessId, num, enemyCampLv, SoldierActor.SoldierRole.Battle, point.EnemyCamp, new TSVector2(point.transform.position.x, point.transform.position.z), point.transform.rotation.eulerAngles.y);
		if (soldierActor != null)
		{
			soldierActor.gridIndex = point.gridIndex;
		}
		return soldierActor;
	}

	public SoldierActor SpawnSupport(int chessId, int potentialLv, int enemyCampLv, bool isEnemyCamp = false, TSVector2 position = default(TSVector2), FP rotation = default(FP))
	{
		SoldierActor soldierActor = SpawnChessInternal(chessId, potentialLv, enemyCampLv, SoldierActor.SoldierRole.Support, isEnemyCamp, position, rotation);
		if (soldierActor != null)
		{
			(isEnemyCamp ? enemySupportActors : ourSupportActors).Add(soldierActor);
		}
		return soldierActor;
	}

	private SoldierActor SpawnChessInternal(int chessId, int potentialLv, int enemyCampLv, SoldierActor.SoldierRole role, bool isEnemyCamp, TSVector2 position, FP rotation, SoldierActor summoner = null, bool inheritAttr = true)
	{
		SoldierCharacter soldierCharacter = Singleton<HotfixDataController>.Instance.GetSoldierCharacter(chessId);
		if (soldierCharacter == null)
		{
			NovaLogger.Error($"自走棋角色没有找到数据:{chessId}");
			return null;
		}
		SoldierSkin soldierSkin = Singleton<HotfixDataController>.Instance.GetSoldierSkin(soldierCharacter.Skin);
		if (soldierSkin == null)
		{
			NovaLogger.Error($"{chessId}自走棋角色皮肤没有找到数据:{soldierCharacter.Skin}");
			return null;
		}
		string model = soldierSkin.Model;
		if (string.IsNullOrEmpty(model))
		{
			return null;
		}
		string text = "Assets/AssetBundles/" + model + ".prefab";
		AdventureLevelObjPoolMgr.PoolBase poolBase = SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Player(text);
		if (poolBase == null)
		{
			NovaLogger.Error($"ID={chessId}的角色资源不存在");
			return null;
		}
		poolBase.Enabled(enable: true);
		AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
		GameObject gameObject = poolObj.gameObject;
		if (gameObject == null)
		{
			NovaLogger.Error($"ID={chessId}的角色资源不存在");
			return null;
		}
		SoldierActor soldierActor = gameObject.AddOrGetComponent<SoldierActor>();
		soldierActor.enabled = true;
		soldierActor.isDeclareDead = false;
		soldierActor.isEnemyCamp = isEnemyCamp;
		soldierActor.LoadData(soldierCharacter, soldierSkin, potentialLv, enemyCampLv, role, summoner, inheritAttr);
		soldierActor.spawnPoolObj = poolObj;
		soldierActor.SyncMovementLocation(position, 0, rotation);
		soldierActor.LevelStart();
		if (summoner != null)
		{
			SetSoldierTechEffect(soldierActor);
		}
		ComboGroup comboGroup = soldierActor.comboGroup;
		if (null == comboGroup)
		{
			NovaLogger.Error("没有找到角色comboGroup" + text);
			return soldierActor;
		}
		ActorRelatedResourceConfig relatedResourceConfig = comboGroup.relatedResourceConfig;
		if (null != relatedResourceConfig)
		{
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.PreloadAssets_RelatedRes(relatedResourceConfig, doPreload: true);
		}
		return soldierActor;
	}

	private void SetSoldierTechEffect(SoldierActor actor)
	{
		if (soldierMsg.buffEffectList == null)
		{
			return;
		}
		for (int i = 0; i < soldierMsg.buffEffectList.Count; i++)
		{
			SoldierTechBattleEffect soldierTechBattleEffect = Singleton<HotfixDataController>.Instance.GetSoldierTechBattleEffect(soldierMsg.buffEffectList.get_Item(i));
			if (soldierTechBattleEffect != null)
			{
				if (soldierTechBattleEffect.SoldierTechBattleBuffTarget == 0)
				{
					actor.buffComponent.AddBuff(soldierTechBattleEffect.EffectBattleBuffId, actor);
				}
				else if (soldierTechBattleEffect.SoldierTechBattleBuffTarget == 1 && !actor.isEnemyCamp)
				{
					actor.buffComponent.AddBuff(soldierTechBattleEffect.EffectBattleBuffId, actor);
				}
				else if (soldierTechBattleEffect.SoldierTechBattleBuffTarget == 2 && actor.isEnemyCamp)
				{
					actor.buffComponent.AddBuff(soldierTechBattleEffect.EffectBattleBuffId, actor);
				}
			}
		}
	}

	public SoldierLevelMsg DecodeData(string str)
	{
		if (string.IsNullOrEmpty(str))
		{
			return new SoldierLevelMsg(1);
		}
		try
		{
			return JsonConvert.DeserializeObject<SoldierLevelMsg>(str);
		}
		catch (Exception ex)
		{
			Debug.LogError("[Soldier] Decode failed: " + ex.Message);
			return new SoldierLevelMsg(1);
		}
	}

	public bool IsCoroutineAlive()
	{
		return true;
	}

	public bool IsCoroutineRunning()
	{
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			return !ModuleController<AdventureModuleController>.Instance.isPause;
		}
		return false;
	}

	public FP GetCoroutineDeltaTime()
	{
		return ICoroutineOwner.UseDefaultDeltaTime;
	}

	public CoroutineNode StartLogicCoroutine(IEnumerator routine, bool runImmediately = false)
	{
		if (ModuleController<AdventureModuleController>.Instance != null && IsCoroutineAlive())
		{
			return ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StartCoroutine(routine, this, runImmediately);
		}
		return null;
	}

	public void StopLogicCoroutine(CoroutineNode coroutine)
	{
		if (ModuleController<AdventureModuleController>.Instance != null && IsCoroutineAlive())
		{
			ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StopCoroutine(coroutine);
		}
	}

	public void SetSoldierDamageID(long uId)
	{
		if (!ourSoldierDamage.ContainsKey(uId))
		{
			ourSoldierDamage.set_Item(uId, 0L);
		}
	}

	protected void MonsterDied(IEvent ievent)
	{
		AdventureMonsterDiedEvent adventureMonsterDiedEvent = (AdventureMonsterDiedEvent)ievent;
		MarkSoldierSummonDead(adventureMonsterDiedEvent.id);
		RemoveSoldierSummonsBySummoner(adventureMonsterDiedEvent.id);
		if (BelongsTo(ourBattleActors, adventureMonsterDiedEvent.id))
		{
			_ourAliveBattleCount--;
			if (_ourAliveBattleCount <= 0)
			{
				Debug.Log("我方失败");
				isStartTime = false;
				LevelStateChangedCall(HotfixEnum.levelState.Failed);
			}
		}
		else if (BelongsTo(enemyBattleActors, adventureMonsterDiedEvent.id))
		{
			_enemyAliveBattleCount--;
			if (_enemyAliveBattleCount <= 0)
			{
				Debug.Log("敌方失败");
				isStartTime = false;
				LevelStateChangedCall(HotfixEnum.levelState.Success);
			}
		}
	}

	protected void LevelStateChangedCall(HotfixEnum.levelState levelState)
	{
		if (!isSettlement)
		{
			LockStepManager.globalTimeScaleMultiplier = 1f;
			AdventureMsgBattleFinishEvent aEvent = AdventureMsgBattleFinishEvent.Generate();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
			isSettlement = true;
			_logger.LogInfo($"fixed rog level state changed:{levelState}");
			MonoSingleton<LuaManager>.Instance.FireEvent("Soldier_Settlement_Ready");
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomFreeze").Value, out _zoomFreeze);
			CommonHelper.TryParseStringParamToFloat(Singleton<GameDataController>.Instance.GetConfig("ZoomInDurationTime").Value, out _zoomDurationTime);
			ModuleController<AdventureModuleController>.Instance.FreezeFrame(_zoomFreeze, _zoomDurationTime, Action);
		}
		void Action()
		{
			if (levelState == HotfixEnum.levelState.Success)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("Soldier_Result", a1: true);
			}
			else
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("Soldier_Result", a1: false);
			}
		}
	}

	private bool BelongsTo(List<SoldierActor> list, long entityId)
	{
		for (int i = 0; i < list.Count; i++)
		{
			if (list.get_Item(i).Id == entityId)
			{
				return true;
			}
		}
		return false;
	}

	private void OnActorReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.to is DestructibleStateSingle))
		{
			long uId = ResolveDamageAttributionId(adventureActorReceiveDamageEvent.from.Id);
			SetSoldierDamageValue(uId, adventureActorReceiveDamageEvent.damageToShieldAndHp);
			long id = adventureActorReceiveDamageEvent.to.Id;
			SetEnemyBattleHp(id, adventureActorReceiveDamageEvent.damageToHp);
		}
	}

	private void OnActorReceiveDirectDamage(IEvent evt)
	{
		AdventureActorReceiveDirectEvent adventureActorReceiveDirectEvent = evt as AdventureActorReceiveDirectEvent;
		if (!(adventureActorReceiveDirectEvent.to is DestructibleStateSingle))
		{
			long uId = ResolveDamageAttributionId(adventureActorReceiveDirectEvent.from.Id);
			SetSoldierDamageValue(uId, adventureActorReceiveDirectEvent.damageToShieldAndHp);
			long id = adventureActorReceiveDirectEvent.to.Id;
			SetEnemyBattleHp(id, adventureActorReceiveDirectEvent.damageToHp);
		}
	}

	private void OnActorReceiveDotDamage(IEvent evt)
	{
		AdventureActorDotDamageEvent adventureActorDotDamageEvent = evt as AdventureActorDotDamageEvent;
		if (!(adventureActorDotDamageEvent.to is DestructibleStateSingle))
		{
			long uId = ResolveDamageAttributionId(adventureActorDotDamageEvent.from.Id);
			SetSoldierDamageValue(uId, adventureActorDotDamageEvent.damageToShieldAndHp);
			long id = adventureActorDotDamageEvent.to.Id;
			SetEnemyBattleHp(id, adventureActorDotDamageEvent.damageToHp);
		}
	}

	private void OnActorReceiveKillDamage(IEvent evt)
	{
		AdventureActorReceiveKillEvent adventureActorReceiveKillEvent = evt as AdventureActorReceiveKillEvent;
		if (!(adventureActorReceiveKillEvent.to is DestructibleStateSingle))
		{
			long uId = ResolveDamageAttributionId(adventureActorReceiveKillEvent.from.Id);
			SetSoldierDamageValue(uId, adventureActorReceiveKillEvent.curValue);
			long id = adventureActorReceiveKillEvent.to.Id;
			SetEnemyBattleHp(id, adventureActorReceiveKillEvent.curValue);
		}
	}

	private long ResolveDamageAttributionId(long fromId)
	{
		int num = soldierSummons.Count + 1;
		while (num-- > 0)
		{
			long num2 = fromId;
			for (int i = 0; i < soldierSummons.Count; i++)
			{
				if (soldierSummons.get_Item(i).entityId == fromId)
				{
					num2 = soldierSummons.get_Item(i).summonerId;
					break;
				}
			}
			if (num2 == fromId)
			{
				return fromId;
			}
			fromId = num2;
		}
		return fromId;
	}

	private void SetSoldierDamageValue(long uId, long damageValue)
	{
		if (ourSoldierDamage.ContainsKey(uId))
		{
			ourSoldierDamage.get_Item(uId) += damageValue;
			MonoSingleton<LuaManager>.Instance.FireEvent("Soldier_DamageValue", uId, ourSoldierDamage.get_Item(uId));
		}
	}

	private void SetEnemyBattleHp(long uId, long damageValue)
	{
		if (enemyBattleActorsUid.Contains(uId))
		{
			enemyBattleTotalHP -= damageValue;
			MonoSingleton<LuaManager>.Instance.FireEvent("EnemyBattle_TotalHP", enemyBattleTotalHP);
			if (isDpsCheckStage)
			{
				dpsCheckStageTotalDamage += damageValue;
				MonoSingleton<LuaManager>.Instance.FireEvent("EnemyBattle_DpsCheckStageTotalDamage", dpsCheckStageTotalDamage);
			}
		}
	}

	public List<SoldierActor> GetBattleActors(AdventureActor self, List<SoldierActor> buffer = null)
	{
		return CollectAlive(self, includeBattle: true, includeSupport: false, buffer);
	}

	public List<SoldierActor> GetSupportActors(AdventureActor self, List<SoldierActor> buffer = null)
	{
		return CollectAlive(self, includeBattle: false, includeSupport: true, buffer);
	}

	public List<SoldierActor> GetAllActors(AdventureActor self, List<SoldierActor> buffer = null)
	{
		return CollectAlive(self, includeBattle: true, includeSupport: true, buffer);
	}

	public List<SoldierActor> GetAllActorsAllCamp(List<SoldierActor> buffer = null)
	{
		if (buffer == null)
		{
			buffer = new List<SoldierActor>();
		}
		else
		{
			buffer.Clear();
		}
		AppendAlive(ourBattleActors, buffer);
		AppendAlive(enemyBattleActors, buffer);
		AppendAlive(ourSupportActors, buffer);
		AppendAlive(enemySupportActors, buffer);
		return buffer;
	}

	private List<SoldierActor> CollectAlive(AdventureActor self, bool includeBattle, bool includeSupport, List<SoldierActor> buffer)
	{
		if (buffer == null)
		{
			buffer = new List<SoldierActor>();
		}
		else
		{
			buffer.Clear();
		}
		if (!(self is SoldierActor { isEnemyCamp: var isEnemyCamp }))
		{
			return buffer;
		}
		if (includeBattle)
		{
			AppendAlive(isEnemyCamp ? enemyBattleActors : ourBattleActors, buffer);
		}
		if (includeSupport)
		{
			AppendAlive(isEnemyCamp ? enemySupportActors : ourSupportActors, buffer);
		}
		return buffer;
	}

	private void AppendAlive(List<SoldierActor> source, List<SoldierActor> dest)
	{
		for (int i = 0; i < source.Count; i++)
		{
			SoldierActor soldierActor = source.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.actorHealthInfo != null && soldierActor.actorHealthInfo.isAlive)
			{
				dest.Add(soldierActor);
			}
		}
	}

	public int GetBattlePartnerCount(AdventureActor self, HotfixEnum.ChessPartnerType type)
	{
		return CountPartner(self, type, includeBattle: true, includeSupport: false);
	}

	public int GetSupportPartnerCount(AdventureActor self, HotfixEnum.ChessPartnerType type)
	{
		return CountPartner(self, type, includeBattle: false, includeSupport: true);
	}

	public int GetAllPartnerCount(AdventureActor self, HotfixEnum.ChessPartnerType type)
	{
		return CountPartner(self, type, includeBattle: true, includeSupport: true);
	}

	private int CountPartner(AdventureActor self, HotfixEnum.ChessPartnerType type, bool includeBattle, bool includeSupport)
	{
		if (!(self is SoldierActor { isEnemyCamp: var isEnemyCamp }))
		{
			return 0;
		}
		int num = 0;
		if (includeBattle)
		{
			num += CountPartnerInList(isEnemyCamp ? enemyBattleActors : ourBattleActors, type);
		}
		if (includeSupport)
		{
			num += CountPartnerInList(isEnemyCamp ? enemySupportActors : ourSupportActors, type);
		}
		return num;
	}

	private int CountPartnerInList(List<SoldierActor> source, HotfixEnum.ChessPartnerType type)
	{
		int num = 0;
		for (int i = 0; i < source.Count; i++)
		{
			SoldierActor soldierActor = source.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && soldierActor.HasPartnerType(type))
			{
				num++;
			}
		}
		return num;
	}

	public int GetPartnerLv(HotfixEnum.ChessPartnerType type)
	{
		if (PartnerLvList.TryGetValue((int)type, out var value))
		{
			return value;
		}
		return 0;
	}

	public SoldierPartner GetSoldierPartner(HotfixEnum.ChessPartnerType type, int lv)
	{
		foreach (KeyValuePair<int, SoldierPartner> soldierPartnerDatum in Singleton<HotfixDataController>.Instance.SoldierPartnerData)
		{
			if (type == (HotfixEnum.ChessPartnerType)soldierPartnerDatum.Value.PartnerType && lv == soldierPartnerDatum.Value.Level)
			{
				return soldierPartnerDatum.Value;
			}
		}
		return null;
	}

	public void AddItem(int itemId, int itemCount)
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("SoldierLevel_AddItem", itemId, itemCount);
	}

	public int GetHarvestCount()
	{
		return soldierMsg.nHarvestCount;
	}

	public SoldierActor SpawnSoldierSummon(SoldierActor summoner, int chessId, TSVector2 position, FP rotation = default(FP), bool isClearSelf = true, bool inheritAttr = true, SoldierActor.SoldierRole role = SoldierActor.SoldierRole.Battle)
	{
		if (chessId == 0)
		{
			return null;
		}
		bool flag = summoner != null;
		bool flag2 = flag && summoner.isEnemyCamp;
		int potentialLv = ((!flag) ? 1 : summoner.GetPotentialLv());
		int enemyCampLv = ((!flag2) ? 1 : EnemyCampLv);
		bool inheritAttr2 = flag & inheritAttr;
		SoldierActor soldierActor = SpawnChessInternal(chessId, potentialLv, enemyCampLv, role, flag2, position, rotation, summoner, inheritAttr2);
		if (soldierActor == null)
		{
			return null;
		}
		if (role == SoldierActor.SoldierRole.Battle && !isClearSelf)
		{
			if (flag2)
			{
				_enemyAliveBattleCount++;
				enemyBattleActors.Add(soldierActor);
			}
			else
			{
				_ourAliveBattleCount++;
				ourBattleActors.Add(soldierActor);
			}
		}
		if (isBothAddBuff)
		{
			ApplyBothAddBuff(soldierActor);
		}
		if (flag)
		{
			AddSoldierSummon(summoner, soldierActor);
		}
		return soldierActor;
	}

	public void AddSoldierSummon(SoldierActor summoner, SoldierActor summoned, long entityId, int dataId)
	{
		if (summoner == null || entityId <= 0)
		{
			return;
		}
		for (int i = 0; i < soldierSummons.Count; i++)
		{
			if (soldierSummons.get_Item(i).entityId == entityId)
			{
				soldierSummons.get_Item(i).summoner = summoner;
				soldierSummons.get_Item(i).summoned = summoned;
				soldierSummons.get_Item(i).summonerId = summoner.Id;
				soldierSummons.get_Item(i).dataID = dataId;
				soldierSummons.get_Item(i).isEnemyCamp = summoner.isEnemyCamp;
				soldierSummons.get_Item(i).isAlive = true;
				return;
			}
		}
		soldierSummons.Add(new SoldierSummonData
		{
			summoner = summoner,
			summoned = summoned,
			summonerId = summoner.Id,
			entityId = entityId,
			dataID = dataId,
			isEnemyCamp = summoner.isEnemyCamp,
			isAlive = true
		});
	}

	public void AddSoldierSummon(SoldierActor summoner, SoldierActor summoned)
	{
		if (!(summoned == null))
		{
			AddSoldierSummon(summoner, summoned, summoned.Id, summoned.dataID);
		}
	}

	public void MarkSoldierSummonDead(long entityId)
	{
		for (int i = 0; i < soldierSummons.Count; i++)
		{
			if (soldierSummons.get_Item(i).entityId == entityId)
			{
				soldierSummons.get_Item(i).isAlive = false;
				break;
			}
		}
	}

	public void RemoveSoldierSummon(long entityId)
	{
		for (int num = soldierSummons.Count - 1; num >= 0; num--)
		{
			if (soldierSummons.get_Item(num).entityId == entityId)
			{
				soldierSummons.RemoveAt(num);
			}
		}
	}

	public void RemoveSoldierSummonsBySummoner(long summonerId)
	{
		for (int num = soldierSummons.Count - 1; num >= 0; num--)
		{
			if (soldierSummons.get_Item(num).summonerId == summonerId)
			{
				soldierSummons.RemoveAt(num);
			}
		}
	}

	public int GetSoldierSummonCount(long summonerId, int dataId = -1, bool aliveOnly = true)
	{
		int num = 0;
		for (int i = 0; i < soldierSummons.Count; i++)
		{
			SoldierSummonData soldierSummonData = soldierSummons.get_Item(i);
			if (soldierSummonData.summonerId == summonerId && (!aliveOnly || soldierSummonData.isAlive) && (dataId < 0 || soldierSummonData.dataID == dataId))
			{
				num++;
			}
		}
		return num;
	}

	public List<SoldierSummonData> GetSoldierSummonInfos()
	{
		return soldierSummons;
	}

	public void ClearSoldierSummonData()
	{
		soldierSummons.Clear();
	}
}
