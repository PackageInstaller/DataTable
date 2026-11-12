using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Monster._72001ShuangZiQi;
using TrueSync;
using UnityEngine;

namespace AIScript.LevelAndGroupController.Group;

public class ShuangZiQiGroupController_P3 : GroupControllerBase
{
	private int _BossID_Red;

	private int _BossID_Green;

	private int _AI_Difficulty;

	private int _Phase;

	private FP _interval;

	private int _energyDelta;

	private int _dmgEnergyDelta;

	private int _initSeqIndex;

	private int ultraSeqInex = 2;

	private MonsterAdventureActor leader;

	private LogicEntity atkLeader;

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private List<Cellinfo> mapGrids = new List<Cellinfo>();

	private CoroutineNode corAddEnergy;

	private CoroutineNode corBuff;

	private List<int> seqList = new List<int>();

	private int seqCount;

	private int lastSeqIndex;

	private int lastBranchIndex;

	private bool LevelStart;

	private bool inUltra;

	private bool isRed;

	private List<AdventureActor> actors = new List<AdventureActor>();

	private Dictionary<long, ActorGrid> dicActorGrid = new Dictionary<long, ActorGrid>();

	protected virtual int BossID_Red => _BossID_Red;

	protected virtual int BossID_Green => _BossID_Green;

	protected virtual int AI_Difficulty => _AI_Difficulty;

	protected virtual int Phase
	{
		get
		{
			return _Phase;
		}
		set
		{
			_Phase = value;
		}
	}

	protected virtual FP interval => _interval;

	protected virtual int dmgEnergyDelta => _dmgEnergyDelta;

	protected virtual int EnergyDelta => _energyDelta;

	protected virtual int initSeqIndex => _initSeqIndex;

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	protected override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ConfigProvide.Inst.SetLv(AI_Difficulty);
		ConfigProvide.Inst.SetPhase(Phase);
		StartCor(LevelMonsterInitial());
		LevelStart = false;
		inUltra = false;
	}

	protected override void OnStop()
	{
		base.OnStop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnActorSpawned);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		for (int i = 0; i < mapGrids.Count; i++)
		{
			mapGrids.get_Item(i).Clear();
		}
		mapGrids.Clear();
		StopCor(corAddEnergy);
		StopCor(corBuff);
		monsters.Clear();
		actors.Clear();
		dicActorGrid.Clear();
		ConfigProvide.Inst = null;
	}

	private IEnumerator LevelMonsterInitial()
	{
		while (GetTargetsByDataId(BossID_Red).Count + GetTargetsByDataId(BossID_Green).Count < 1)
		{
			yield return null;
		}
		if (GetTargetsByDataId(BossID_Red).Count > 0)
		{
			leader = GetTargetsByDataId(BossID_Red).get_Item(0) as MonsterAdventureActor;
			isRed = true;
		}
		else
		{
			leader = GetTargetsByDataId(BossID_Green).get_Item(0) as MonsterAdventureActor;
			isRed = false;
		}
		leader.monsterInfo.currentEnergy = 0;
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", leader.Id, 0, a2: false);
		StartCor(ref corAddEnergy, DoAddEnergy());
		SetLogicTagFpValue(leader, "SoilderCastTime", 0);
		SetLogicTagFpValue(leader, "UltraCastTime", 0);
		SetLogicTagFpValue(leader, "ArtilleryCastTime", 0);
		Dictionary<int, GridColor> dictionary = (isRed ? Config.dicGridColor_3_RedBoss : Config.dicGridColor_3_GreenBoss);
		for (int i = 0; i < Config.cellCount; i++)
		{
			for (int j = 0; j < Config.cellCount; j++)
			{
				TSVector2 index = new TSVector2(j, i);
				TSVector2 cellPosByIndex = Config.GetCellPosByIndex(index);
				int num = j + i * Config.cellCount;
				Cellinfo cellinfo = new Cellinfo
				{
					actor1 = leader,
					actor2 = leader,
					index = index,
					cellIndex = num,
					worldPos = cellPosByIndex,
					position = new Vector3(cellPosByIndex.x.AsFloat(), leader.transform.position.y, cellPosByIndex.y.AsFloat())
				};
				cellinfo.RefreshColor((long)dictionary.get_Item(num));
				mapGrids.Add(cellinfo);
			}
		}
		RefreshCellColor();
		RefreshCellColor();
		StartCor(ref corBuff, DoAddBuff());
		LevelStart = true;
		yield return WaitUntil(() => leader.state == ActorState.Action);
		RefreshCellColor();
		ShowCenterHpBar(leader);
	}

	protected override void SetConfig()
	{
		GroupAIType = GroupAIType.SEQUENCE;
		List<BaseGroupBranchInfo> sequenceBranches = new List<BaseGroupBranchInfo>
		{
			new BaseGroupBranchInfo(0, DoCast_Awake),
			new BaseGroupBranchInfo(1, DoCast_1001),
			new BaseGroupBranchInfo(2, DoCast_1002),
			new BaseGroupBranchInfo(3, DoCast_1003),
			new BaseGroupBranchInfo(4, DoCast_1004),
			new BaseGroupBranchInfo(5, DoCast_1005),
			new BaseGroupBranchInfo(6, DoCast_1006),
			new BaseGroupBranchInfo(9, DoCast_1009)
		};
		Dictionary<int, List<int>> dictionary = new Dictionary<int, List<int>>
		{
			[0] = new List<int> { 0, 1, 3, 4, 2 },
			[1] = new List<int> { 0, 1, 5, 6, 2 },
			[2] = new List<int> { 9 }
		};
		seqCount = dictionary.Count;
		for (int i = 0; i < seqCount; i++)
		{
			seqList.Add(i);
		}
		lastSeqIndex = initSeqIndex;
		InitSequenceBranches(lastSeqIndex, sequenceBranches, dictionary);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(GroupEventType.ToughnessBroken, active: true, OnToughnessBroken);
		InitListenEvent(GroupEventType.DamageToOthers, active: true, OnReciveDamage);
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == Config.ranseEvt)
		{
			List<int> intParamList = adventureActorCustomEvent.intParamList;
			for (int i = 0; i < intParamList.Count; i++)
			{
				int index = intParamList.get_Item(i);
				mapGrids.get_Item(index).RefreshColor(adventureActorCustomEvent.intParam);
			}
			RefreshCellColor();
		}
	}

	private void RefreshCellColor()
	{
		List<long> list = mapGrids.Select((Cellinfo x) => x.gridColor).ToList();
		SetLogicTagListLongValue(leader, "MapGrids_Color", list);
		int a = Enumerable.Count(list.FindAll((long x) => x == 1));
		int a2 = Enumerable.Count(list.FindAll((long x) => x == 2));
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("RedCellNotify", leader.Id, a);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("GreenCellNotify", leader.Id, a2);
	}

	private void OnToughnessBroken(IEvent evt)
	{
		if (!(evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent) || !(monsterToughnessStateChangeEvent.actor == leader))
		{
			return;
		}
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int num = monsterSummonInfos.Count - 1; num >= 0; num--)
		{
			if (monsterSummonInfos.get_Item(num).SummonActorID == leader.Id)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(num).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor)
				{
					monsterAdventureActor.DestroySelf(forceDestory: true);
				}
			}
		}
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int nextBranchIndex, bool isSeqEnd)
	{
		if (curSeqIndex != ultraSeqInex)
		{
			lastBranchIndex = nextBranchIndex;
		}
		if (isSeqEnd)
		{
			if (leader.monsterInfo.currentEnergy >= leader.monsterInfo.maxEnergy)
			{
				leader.monsterInfo.currentEnergy = 0;
				SwitchSequence(ultraSeqInex);
			}
			else if (curSeqIndex == ultraSeqInex)
			{
				SwitchSequence(lastSeqIndex, initialIndex: false);
				SetCurrentSequenceIndex(lastBranchIndex);
			}
			else
			{
				lastSeqIndex = initSeqIndex;
				SwitchSequence(lastSeqIndex);
			}
		}
		else if (leader.monsterInfo.currentEnergy >= leader.monsterInfo.maxEnergy)
		{
			SwitchSequence(ultraSeqInex);
		}
	}

	private IEnumerator DoAddEnergy()
	{
		FP timer = 0;
		while (leader != null && !leader.IsDead())
		{
			if (!leader.monsterToughnessInfo.isToughnessBroken && !inUltra)
			{
				if (timer > interval)
				{
					if (leader.monsterInfo.currentEnergy < leader.monsterInfo.maxEnergy)
					{
						leader.monsterInfo.currentEnergy = Math.Min(leader.monsterInfo.currentEnergy + EnergyDelta, leader.monsterInfo.maxEnergy);
						MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", leader.Id, leader.monsterInfo.currentEnergy, a2: true);
					}
					timer = 0;
				}
				yield return null;
				timer += leader.LogicDeltaTime;
			}
			else
			{
				yield return null;
			}
		}
	}

	private IEnumerator DoAddBuff()
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (dicActorGrid.TryAdd(playerAdventureActor.Id, new ActorGrid()))
			{
				actors.Add(playerAdventureActor);
			}
		}
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		for (int j = 0; j < monsterActors.Count; j++)
		{
			if (monsterActors.get_Item(j) is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.IsPlayerMinion(out var _) && dicActorGrid.TryAdd(monsterAdventureActor.Id, new ActorGrid()))
			{
				actors.Add(monsterAdventureActor);
			}
		}
		while (true)
		{
			for (int k = 0; k < mapGrids.Count; k++)
			{
				mapGrids.get_Item(k).OnUpdate(actors);
			}
			for (int l = 0; l < actors.Count; l++)
			{
				AdventureActor adventureActor = actors.get_Item(l);
				if (adventureActor != null && !adventureActor.isDead)
				{
					int cellIndexByPos = Config.GetCellIndexByPos(adventureActor.tsTransform.Position);
					if (dicActorGrid.TryGetValue(adventureActor.Id, out var value))
					{
						value.Enter(mapGrids.get_Item(cellIndexByPos), adventureActor);
					}
				}
			}
			yield return null;
		}
	}

	private void OnActorSpawned(IEvent _evt)
	{
		AdventurActorSpawned adventurActorSpawned = (AdventurActorSpawned)_evt;
		if (adventurActorSpawned != null && adventurActorSpawned.sender is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.IsPlayerMinion(out var _) && dicActorGrid.TryAdd(monsterAdventureActor.Id, new ActorGrid()))
		{
			actors.Add(monsterAdventureActor);
		}
	}

	private void OnDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent { actor: MonsterAdventureActor actor } && actor.IsPlayerMinion(out var _))
		{
			actors.Remove(actor);
			dicActorGrid.Remove(actor.Id);
		}
	}

	private void OnReciveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.from == leader && leader.buffComponent.CheckBuffByBuffID(ConfigProvide.Inst.buffId_red))
		{
			leader.monsterInfo.currentEnergy = Math.Min(leader.monsterInfo.currentEnergy + dmgEnergyDelta, leader.monsterInfo.maxEnergy);
			MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", leader.Id, leader.monsterInfo.currentEnergy, a2: true);
		}
	}

	private IEnumerator DoCast_Awake()
	{
		while (!LevelStart)
		{
			yield return null;
		}
		yield return WaitTime(2);
		GetCurrentPlayer();
		SetLogicTagToggleValue(leader, "Attack", value: true);
		if (leader.dataID == BossID_Red)
		{
			SetLogicTagToggleValue(leader, "Red", value: true);
		}
		else
		{
			SetLogicTagToggleValue(leader, "Red", value: false);
		}
		SetLogicTagFpValue(leader, "Phase", Phase);
		SetLogicTagFpValue(leader, "Level", AI_Difficulty);
		SendMessageToMonster(leader.Id, "WakeUp");
	}

	private IEnumerator DoCast_1001()
	{
		SetLogicTagToggleValue(leader, Config.Skill_Carrier_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_Carrier");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Carrier_Finish));
	}

	private IEnumerator DoCast_1002()
	{
		SetLogicTagToggleValue(leader, Config.Skill_Solider_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_Soldier");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Solider_Finish));
		FP logicTagFpValue = GetLogicTagFpValue(leader, "SoilderCastTime");
		SetLogicTagFpValue(leader, "SoilderCastTime", logicTagFpValue + 1);
	}

	private IEnumerator DoCast_1003()
	{
		SetLogicTagToggleValue(leader, Config.Skill_Artillery_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_Artillery");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Artillery_Finish));
		FP logicTagFpValue = GetLogicTagFpValue(leader, "ArtilleryCastTime");
		SetLogicTagFpValue(leader, "ArtilleryCastTime", logicTagFpValue + 1);
	}

	private IEnumerator DoCast_1004()
	{
		SetLogicTagToggleValue(leader, Config.Skill_General_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_General");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_General_Finish));
	}

	private IEnumerator DoCast_1005()
	{
		SetLogicTagToggleValue(leader, Config.Skill_Artillery2_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_Artillery2");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_Artillery2_Finish));
	}

	private IEnumerator DoCast_1006()
	{
		SetLogicTagToggleValue(leader, Config.Skill_General3_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_General3");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_General3_Finish));
	}

	private IEnumerator DoCast_1009()
	{
		if (Phase < 2)
		{
			Phase++;
		}
		ConfigProvide.Inst.SetPhase(Phase);
		leader.monsterInfo.currentEnergy = 0;
		leader.monsterInfo.currentEnergy = 0;
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", leader.Id, 0, a2: false);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("CastUltra", leader.Id);
		SetLogicTagFpValue(leader, "Phase", Phase);
		SendMessageToMonster(leader.Id, "WakeUp");
		SetLogicTagToggleValue(leader, Config.Skill_RanSe_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_RanSe");
		inUltra = true;
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_RanSe_Finish));
		SetLogicTagToggleValue(leader, Config.Skill_GanRao_Finish, value: false);
		SendMessageToMonster(leader.Id, "Skill_GanRao");
		yield return WaitUntil(() => GetLogicTagToggleValue(leader, Config.Skill_GanRao_Finish));
		inUltra = false;
		FP logicTagFpValue = GetLogicTagFpValue(leader, "UltraCastTime");
		SetLogicTagFpValue(leader, "UltraCastTime", logicTagFpValue + 1);
	}
}
