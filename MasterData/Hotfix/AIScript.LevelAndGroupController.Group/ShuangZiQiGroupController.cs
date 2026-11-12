#define LOG_ERROR
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Monster._72001ShuangZiQi;
using TrueSync;
using UnityEngine;

namespace AIScript.LevelAndGroupController.Group;

public class ShuangZiQiGroupController : GroupControllerBase
{
	private int _BossID_Red;

	private int _BossID_Green;

	private int _AI_Difficulty;

	private int _Phase;

	private FP _interval;

	private int _energyDelta_1;

	private int _energyDelta_2;

	private int _dmgEnergyDelta;

	private FP delayKillSkill = 20;

	private Dictionary<int, GridColor> _dicGridColor_1;

	private int _initSeqIndex;

	private int ultraSeqInex = 2;

	private int showSeqInex = 3;

	private MonsterAdventureActor redLeader;

	private MonsterAdventureActor greenLeader;

	private LogicEntity FirstLeader;

	private LogicEntity SecondLeader;

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private List<Cellinfo> mapGrids = new List<Cellinfo>();

	private CoroutineNode corRedAddEnergy;

	private CoroutineNode corGreenAddEnergy;

	private CoroutineNode corBuff;

	private List<int> seqList = new List<int>();

	private int lastSeqIndex;

	private int lastBranchIndex;

	private bool LevelStart;

	private bool inUltra;

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

	protected virtual int energyDelta_1 => _energyDelta_1;

	protected virtual int energyDelta_2 => _energyDelta_2;

	protected virtual int dmgEnergyDelta => _dmgEnergyDelta;

	protected virtual Dictionary<int, GridColor> dicGridColor_1 => _dicGridColor_1;

	protected virtual int initSeqIndex => _initSeqIndex;

	private int EnergyDelta
	{
		get
		{
			if (Phase > 1)
			{
				return energyDelta_2;
			}
			return energyDelta_1;
		}
	}

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
		NovaLogger.Error("进入关卡难度" + AI_Difficulty + "当前阶段" + Phase);
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
		StopCor(corRedAddEnergy);
		StopCor(corGreenAddEnergy);
		StopCor(corBuff);
		monsters.Clear();
		actors.Clear();
		dicActorGrid.Clear();
		ConfigProvide.Inst = null;
	}

	private IEnumerator LevelMonsterInitial()
	{
		while (GetTargetsByDataId(BossID_Red).Count + GetTargetsByDataId(BossID_Green).Count < 2)
		{
			yield return null;
		}
		redLeader = GetTargetsByDataId(BossID_Red).get_Item(0) as MonsterAdventureActor;
		greenLeader = GetTargetsByDataId(BossID_Green).get_Item(0) as MonsterAdventureActor;
		redLeader.monsterInfo.currentEnergy = 0;
		greenLeader.monsterInfo.currentEnergy = 0;
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", redLeader.Id, 0, a2: false);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", greenLeader.Id, 0, a2: false);
		StartCor(ref corRedAddEnergy, DoRedAddEnergy());
		StartCor(ref corGreenAddEnergy, DoGreenAddEnergy());
		Dictionary<int, GridColor> dictionary = dicGridColor_1;
		for (int i = 0; i < Config.cellCount; i++)
		{
			for (int j = 0; j < Config.cellCount; j++)
			{
				TSVector2 index = new TSVector2(j, i);
				TSVector2 cellPosByIndex = Config.GetCellPosByIndex(index);
				int num = j + i * Config.cellCount;
				Cellinfo cellinfo = new Cellinfo
				{
					actor1 = redLeader,
					actor2 = greenLeader,
					index = index,
					cellIndex = num,
					worldPos = cellPosByIndex,
					position = new Vector3(cellPosByIndex.x.AsFloat(), redLeader.transform.position.y, cellPosByIndex.y.AsFloat())
				};
				cellinfo.RefreshColor((long)dictionary.get_Item(num));
				mapGrids.Add(cellinfo);
			}
		}
		RefreshCellColor();
		StartCor(ref corBuff, DoAddBuff());
		LevelStart = true;
		yield return WaitUntil(() => redLeader.state == ActorState.Action && greenLeader.state == ActorState.Action);
		RefreshCellColor();
		ShowCenterHpBar(redLeader);
		ShowCenterHpBar(greenLeader);
	}

	protected override void SetConfig()
	{
		GroupAIType = GroupAIType.SEQUENCE;
		List<BaseGroupBranchInfo> sequenceBranches = new List<BaseGroupBranchInfo>
		{
			new BaseGroupBranchInfo(0, DoCast_Awake),
			new BaseGroupBranchInfo(1, DoCast_Carrier),
			new BaseGroupBranchInfo(2, DoCast_Soilder),
			new BaseGroupBranchInfo(3, DoCast_Artillery),
			new BaseGroupBranchInfo(4, DoCast_General),
			new BaseGroupBranchInfo(5, DoCast_Artillery2),
			new BaseGroupBranchInfo(6, DoCast_General3),
			new BaseGroupBranchInfo(9, DoCast_Ultra),
			new BaseGroupBranchInfo(10, DoCast_ToughnessBrokenShow)
		};
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[0] = new List<int> { 0, 1, 4, 3, 2 },
			[1] = new List<int> { 0, 1, 6, 5, 2 },
			[2] = new List<int> { 9 },
			[3] = new List<int> { 10 },
			[4] = new List<int> { 0, 3 }
		};
		lastSeqIndex = initSeqIndex;
		InitSequenceBranches(lastSeqIndex, sequenceBranches, sequenceDict);
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
		SetLogicTagListLongValue(greenLeader, "MapGrids_Color", list);
		SetLogicTagListLongValue(redLeader, "MapGrids_Color", list);
		int a = Enumerable.Count(list.FindAll((long x) => x == 1));
		int a2 = Enumerable.Count(list.FindAll((long x) => x == 2));
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("RedCellNotify", redLeader.Id, a);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("GreenCellNotify", greenLeader.Id, a2);
	}

	private void OnToughnessBroken(IEvent evt)
	{
		if (!(evt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent) || (!(monsterToughnessStateChangeEvent.actor == redLeader) && !(monsterToughnessStateChangeEvent.actor == greenLeader)))
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = ((monsterToughnessStateChangeEvent.actor == redLeader) ? greenLeader : redLeader);
		if (!monsterAdventureActor.monsterToughnessInfo.isToughnessBroken)
		{
			SendMessageToMonster(monsterAdventureActor.Id, "InterruptAllSkill");
		}
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int num = monsterSummonInfos.Count - 1; num >= 0; num--)
		{
			if (monsterSummonInfos.get_Item(num).SummonActorID == redLeader.Id || monsterSummonInfos.get_Item(num).SummonActorID == greenLeader.Id)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(num).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor2)
				{
					monsterAdventureActor2.DestroySelf(forceDestory: true);
				}
			}
		}
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int nextBranchIndex, bool isSeqEnd)
	{
		if (curSeqIndex != ultraSeqInex && curSeqIndex != showSeqInex)
		{
			lastBranchIndex = nextBranchIndex;
		}
		if (isSeqEnd)
		{
			if (redLeader.monsterToughnessInfo.isToughnessBroken || greenLeader.monsterToughnessInfo.isToughnessBroken)
			{
				SwitchSequence(showSeqInex);
			}
			else if (redLeader.monsterInfo.currentEnergy >= redLeader.monsterInfo.maxEnergy || greenLeader.monsterInfo.currentEnergy >= greenLeader.monsterInfo.maxEnergy)
			{
				SwitchSequence(ultraSeqInex);
			}
			else if (curSeqIndex == ultraSeqInex || curSeqIndex == showSeqInex)
			{
				SwitchSequence(lastSeqIndex, initialIndex: false);
				if (curSeqIndex == ultraSeqInex)
				{
					if (lastBranchIndex == 2)
					{
						lastBranchIndex++;
					}
					if (lastBranchIndex == 4)
					{
						lastBranchIndex = 1;
					}
					SetCurrentSequenceIndex(lastBranchIndex);
				}
			}
			else
			{
				lastSeqIndex = initSeqIndex;
				SwitchSequence(lastSeqIndex);
			}
		}
		else if (redLeader.monsterToughnessInfo.isToughnessBroken || greenLeader.monsterToughnessInfo.isToughnessBroken)
		{
			SwitchSequence(showSeqInex);
		}
		else if (redLeader.monsterInfo.currentEnergy >= redLeader.monsterInfo.maxEnergy || greenLeader.monsterInfo.currentEnergy >= greenLeader.monsterInfo.maxEnergy)
		{
			SwitchSequence(ultraSeqInex);
		}
	}

	private IEnumerator DoRedAddEnergy()
	{
		FP timer = 0;
		while (redLeader != null && !redLeader.IsDead())
		{
			if (!redLeader.monsterToughnessInfo.isToughnessBroken && !inUltra)
			{
				if (timer > interval)
				{
					if (redLeader.monsterInfo.currentEnergy < redLeader.monsterInfo.maxEnergy)
					{
						redLeader.monsterInfo.currentEnergy = Math.Min(redLeader.monsterInfo.currentEnergy + EnergyDelta, redLeader.monsterInfo.maxEnergy);
						MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", redLeader.Id, redLeader.monsterInfo.currentEnergy, a2: true);
					}
					timer = 0;
				}
				yield return null;
				timer += redLeader.LogicDeltaTime;
			}
			else
			{
				yield return null;
			}
		}
	}

	private IEnumerator DoGreenAddEnergy()
	{
		FP timer = 0;
		while (greenLeader != null && !greenLeader.IsDead())
		{
			if (!greenLeader.monsterToughnessInfo.isToughnessBroken && !inUltra)
			{
				if (timer > interval)
				{
					if (greenLeader.monsterInfo.currentEnergy < greenLeader.monsterInfo.maxEnergy)
					{
						greenLeader.monsterInfo.currentEnergy = Math.Min(greenLeader.monsterInfo.currentEnergy + EnergyDelta, greenLeader.monsterInfo.maxEnergy);
						MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", greenLeader.Id, greenLeader.monsterInfo.currentEnergy, a2: true);
					}
					timer = 0;
				}
				yield return null;
				timer += greenLeader.LogicDeltaTime;
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
		if (evt is AdventureActorReceiveDamageEvent { from: var logicEntity, to: var to } && logicEntity is MonsterAdventureActor)
		{
			if (GetLogicTagToggleValue(logicEntity, "Red") && GetBuffNum(to, ConfigProvide.Inst.buffId_red) > 0)
			{
				redLeader.monsterInfo.currentEnergy = Math.Min(redLeader.monsterInfo.currentEnergy + dmgEnergyDelta, redLeader.monsterInfo.maxEnergy);
				MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", redLeader.Id, redLeader.monsterInfo.currentEnergy, a2: true);
			}
			if (!GetLogicTagToggleValue(logicEntity, "Red") && GetBuffNum(to, ConfigProvide.Inst.buffId_green) > 0)
			{
				greenLeader.monsterInfo.currentEnergy = Math.Min(greenLeader.monsterInfo.currentEnergy + dmgEnergyDelta, greenLeader.monsterInfo.maxEnergy);
				MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", greenLeader.Id, greenLeader.monsterInfo.currentEnergy, a2: true);
			}
		}
	}

	private MonsterAdventureActor CheckUnderdog(bool isHP = false)
	{
		List<long> list = mapGrids.Select((Cellinfo x) => x.gridColor).ToList();
		int num = Enumerable.Count(list.FindAll((long x) => x == 1));
		int num2 = Enumerable.Count(list.FindAll((long x) => x == 2));
		long hp = redLeader.actorHealthInfo.hp;
		long hp2 = greenLeader.actorHealthInfo.hp;
		bool flag = hp <= hp2;
		FP fP = (FP)redLeader.actorHealthInfo.hpPercentage;
		FP fP2 = (FP)greenLeader.actorHealthInfo.hpPercentage;
		if (isHP || TSMath.Abs(fP - fP2) >= 0.3 || TSMath.Abs(num - num2) < 3)
		{
			if (flag)
			{
				return redLeader;
			}
			return greenLeader;
		}
		if (num > num2)
		{
			return greenLeader;
		}
		return redLeader;
	}

	private IEnumerator DoCast_Awake()
	{
		while (!LevelStart)
		{
			yield return null;
		}
		yield return WaitTime(2);
		SetLogicTagToggleValue(redLeader, "Red", value: true);
		SetLogicTagToggleValue(greenLeader, "Red", value: false);
		SetLogicTagFpValue(redLeader, "Phase", Phase);
		SetLogicTagFpValue(greenLeader, "Phase", Phase);
		SetLogicTagFpValue(redLeader, "Level", AI_Difficulty);
		SetLogicTagFpValue(greenLeader, "Level", AI_Difficulty);
		SendMessageToMonster(redLeader.Id, "WakeUp");
		SendMessageToMonster(greenLeader.Id, "WakeUp");
	}

	private IEnumerator DoCast_Artillery()
	{
		MonsterAdventureActor castleader = CheckUnderdog();
		SetLogicTagToggleValue(castleader, Config.Skill_Artillery_Finish, value: false);
		SendMessageToMonster(castleader.Id, "Skill_Artillery");
		yield return WaitUntil(() => GetLogicTagToggleValue(castleader, Config.Skill_Artillery_Finish));
	}

	private IEnumerator DoCast_Soilder()
	{
		MonsterAdventureActor castleader = CheckUnderdog();
		SetLogicTagToggleValue(castleader, Config.Skill_Solider_Finish, value: false);
		SendMessageToMonster(castleader.Id, "Skill_Soldier");
		yield return WaitUntil(() => GetLogicTagToggleValue(castleader, Config.Skill_Solider_Finish));
	}

	private IEnumerator DoCast_Carrier()
	{
		MonsterAdventureActor castleader = CheckUnderdog();
		SetLogicTagToggleValue(castleader, Config.Skill_Carrier_Finish, value: false);
		SendMessageToMonster(castleader.Id, "Skill_Carrier");
		yield return WaitUntil(() => GetLogicTagToggleValue(castleader, Config.Skill_Carrier_Finish));
	}

	private IEnumerator DoCast_General()
	{
		MonsterAdventureActor underleader = CheckUnderdog();
		MonsterAdventureActor upleader = ((underleader == redLeader) ? greenLeader : redLeader);
		SetLogicTagToggleValue(underleader, "Attack", value: true);
		SetLogicTagToggleValue(underleader, Config.Skill_General_Finish, value: false);
		SendMessageToMonster(underleader.Id, "Skill_General");
		SetLogicTagToggleValue(upleader, "Attack", value: false);
		SetLogicTagToggleValue(upleader, Config.Skill_General_Finish, value: false);
		SendMessageToMonster(upleader.Id, "Skill_General");
		bool isTriggerDelayKill = false;
		yield return WaitUntil(() =>
		{
			bool logicTagToggleValue = GetLogicTagToggleValue(upleader, Config.Skill_General_Finish);
			bool logicTagToggleValue2 = GetLogicTagToggleValue(underleader, Config.Skill_General_Finish);
			return logicTagToggleValue & logicTagToggleValue2;
		});
		if (!isTriggerDelayKill)
		{
			yield break;
		}
		SendMessageToMonster(upleader.Id, "InterruptAllSkill");
		SendMessageToMonster(underleader.Id, "InterruptAllSkill");
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int num = monsterSummonInfos.Count - 1; num >= 0; num--)
		{
			if (monsterSummonInfos.get_Item(num).SummonActorID == redLeader.Id || monsterSummonInfos.get_Item(num).SummonActorID == greenLeader.Id)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(num).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor monsterAdventureActor)
				{
					monsterAdventureActor.DestroySelf(forceDestory: true);
				}
			}
		}
	}

	private IEnumerator DoCast_Artillery2()
	{
		MonsterAdventureActor castleader = CheckUnderdog();
		SetLogicTagToggleValue(castleader, Config.Skill_Artillery2_Finish, value: false);
		SendMessageToMonster(castleader.Id, "Skill_Artillery2");
		yield return WaitUntil(() => GetLogicTagToggleValue(castleader, Config.Skill_Artillery2_Finish));
	}

	private IEnumerator DoCast_General3()
	{
		MonsterAdventureActor castleader = CheckUnderdog();
		SetLogicTagToggleValue(castleader, Config.Skill_General3_Finish, value: false);
		SendMessageToMonster(castleader.Id, "Skill_General3");
		yield return WaitUntil(() => GetLogicTagToggleValue(castleader, Config.Skill_General3_Finish));
	}

	private IEnumerator DoCast_ToughnessBrokenShow()
	{
		MonsterAdventureActor breakLeader = (redLeader.monsterToughnessInfo.isToughnessBroken ? redLeader : greenLeader);
		MonsterAdventureActor unBreakLeader = (redLeader.monsterToughnessInfo.isToughnessBroken ? greenLeader : redLeader);
		SetLogicTagToggleValue(unBreakLeader, Config.Skill_Show_Finish, value: false);
		SendMessageToMonster(unBreakLeader.Id, "Skill_Show");
		yield return WaitUntil(() => !breakLeader.monsterToughnessInfo.isToughnessBroken);
		SendMessageToMonster(unBreakLeader.Id, "Skill_Show_End");
		yield return WaitUntil(() => GetLogicTagToggleValue(unBreakLeader, Config.Skill_Show_Finish));
		if (unBreakLeader.monsterToughnessInfo.isToughnessBroken)
		{
			yield return WaitUntil(() => !unBreakLeader.monsterToughnessInfo.isToughnessBroken);
		}
	}

	private IEnumerator DoCast_Ultra()
	{
		if (Phase < 2)
		{
			Phase++;
		}
		while (GetMonsterSummonNum(redLeader) + GetMonsterSummonNum(greenLeader) > 0)
		{
			yield return null;
		}
		ConfigProvide.Inst.SetPhase(Phase);
		redLeader.monsterInfo.currentEnergy = 0;
		greenLeader.monsterInfo.currentEnergy = 0;
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", redLeader.Id, 0, a2: false);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("JointDrillBossEnergyChanged", greenLeader.Id, 0, a2: false);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("CastUltra", redLeader.Id);
		MonoSingleton<LuaManager>.Instance.FireEntityEvent("CastUltra", greenLeader.Id);
		SetLogicTagFpValue(redLeader, "Phase", Phase);
		SetLogicTagFpValue(greenLeader, "Phase", Phase);
		SendMessageToMonster(redLeader.Id, "WakeUp");
		SendMessageToMonster(greenLeader.Id, "WakeUp");
		MonsterAdventureActor underleader = CheckUnderdog(isHP: true);
		MonsterAdventureActor upleader = ((underleader == redLeader) ? greenLeader : redLeader);
		SetLogicTagToggleValue(underleader, Config.Skill_RanSe_Finish, value: false);
		SetLogicTagToggleValue(upleader, Config.Skill_GanRao_Finish, value: false);
		SendMessageToMonster(underleader.Id, "Skill_RanSe");
		SendMessageToMonster(upleader.Id, "Skill_GanRao");
		inUltra = true;
		yield return WaitUntil(() =>
		{
			bool logicTagToggleValue = GetLogicTagToggleValue(underleader, Config.Skill_RanSe_Finish);
			bool logicTagToggleValue2 = GetLogicTagToggleValue(upleader, Config.Skill_GanRao_Finish);
			return logicTagToggleValue & logicTagToggleValue2;
		});
		inUltra = false;
	}
}
