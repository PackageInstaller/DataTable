using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class MainLine_Action_Stage2 : MonsterActionBase
{
	private string moveTag = "Move";

	private int Skill_Attack01 = 7000108;

	private int Skill_Attack02 = 7000109;

	private int Skill_Attack03 = 7000110;

	private int Skill_Attack04 = 7000111;

	private int Skill_Attack05 = 7000112;

	private int Skill_Attack06 = 7000113;

	private int Skill_Attack07 = 7000114;

	private List<int> moveSummonIds = new List<int> { 1652007, 1652008, 1652009, 1652010 };

	private List<string> summonPosList_Move = new List<string> { "Zuo_01_01", "Zuo_02_01", "You_01_01", "You_02_01" };

	private FP reviveTime = 30f;

	private Dictionary<int, string> dicSpawnPoint = new Dictionary<int, string>
	{
		[1652007] = "Zuo_01_01",
		[1652008] = "Zuo_02_01",
		[1652009] = "You_01_01",
		[1652010] = "You_02_01"
	};

	private List<int> seqList = new List<int>();

	private int seqCount;

	private SummonCfg summonCfg = new SummonCfg();

	private int lastSeqIndex;

	private MonsterAdventureActor actor => _actor as MonsterAdventureActor;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		SpawnSummon();
		AddMonsterIdToList();
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Independent;
		summonCfg.attrPercent = 100;
		summonCfg.leftTime = -1;
		summonCfg.retainWhenCrossLevel = false;
	}

	protected override void OnActionStop()
	{
		base.OnActionStop();
		OnSequenceBranchOperateComplete(CurrentSeqIndex, CurrentIndex, CurrentIndex == 0);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	protected override void SetListenEvents()
	{
		//IL_001b: Field data (rva=0x6a8) could not be found in any section!
		//IL_001b: Field data (rva=0x6a8) could not be found in any section!
		Action<IEvent> operation = OnMonsterDied;
		int[] array = new int[4];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._2CE0D05BC6A0EF1203C6C4AD808E929C55D4D92015420C5A6B0E4375F4202115));
		InitListenEvent(MonsterEventType.MonsterDie, active: true, operation, array);
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Attack01;
		list.Add(new BaseBranchInfo(1, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack02;
		list.Add(new BaseBranchInfo(2, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack03;
		list.Add(new BaseBranchInfo(3, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack04;
		list.Add(new BaseBranchInfo(4, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack05;
		list.Add(new BaseBranchInfo(5, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack06;
		list.Add(new BaseBranchInfo(6, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack07;
		list.Add(new BaseBranchInfo(7, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Attack08;
		list.Add(new BaseBranchInfo(99, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> dictionary = new Dictionary<int, List<int>>
		{
			[0] = new List<int>
			{
				99, 2, 99, 1, 99, 4, 99, 3, 99, 6,
				99, 5
			},
			[1] = new List<int>
			{
				99, 4, 99, 2, 99, 3, 99, 1, 99, 5,
				99, 6
			},
			[2] = new List<int> { 7 }
		};
		seqCount = dictionary.Count - 1;
		for (int i = 0; i < seqCount; i++)
		{
			seqList.Add(i);
		}
		lastSeqIndex = RandomIndexFromLeft();
		InitSequenceBranches(lastSeqIndex, sequenceBranches, dictionary);
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int nextBranchIndex, bool isSeqEnd)
	{
		if (isSeqEnd)
		{
			lastSeqIndex = RandomIndexFromLeft();
			SwitchSequence(lastSeqIndex);
		}
	}

	private int RandomIndexFromLeft()
	{
		if (seqCount == seqList.Count)
		{
			seqList.RemoveAt(0);
			return 0;
		}
		int index = TSRandom.Range(0, seqList.Count);
		int result = seqList.get_Item(index);
		seqList.RemoveAt(index);
		if (seqList.Count == 0)
		{
			for (int i = 1; i < seqCount; i++)
			{
				seqList.Add(i);
			}
		}
		return result;
	}

	private IEnumerator Attack01()
	{
		CastSkill(Skill_Attack01);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack02()
	{
		CastSkill(Skill_Attack02);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack03()
	{
		CastSkill(Skill_Attack03);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack04()
	{
		CastSkill(Skill_Attack04);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack05()
	{
		CastSkill(Skill_Attack05);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack06()
	{
		CastSkill(Skill_Attack06);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack07()
	{
		CastSkill(Skill_Attack07);
		yield return WaitSkillFinish();
	}

	private IEnumerator Attack08()
	{
		yield return WaitTime(2);
	}

	private void OnDied(IEvent evt)
	{
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		if (adventureActorDiedEvent.deadType == DeadType.ClearSelf && adventureActorDiedEvent.actor is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.monsterInfo.Tag4.Equals(moveTag))
		{
			StartCor(DoRevive(adventureActorDiedEvent.actor.dataID));
		}
	}

	private void OnMonsterDied(IEvent evt)
	{
		AdventureMonsterDiedEvent adventureMonsterDiedEvent = evt as AdventureMonsterDiedEvent;
		if (adventureMonsterDiedEvent.summonId == _actor.Id && ModuleController<AdventureModuleController>.Instance.QueryEntityByID(adventureMonsterDiedEvent.id) is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.monsterInfo.Tag4.Equals(moveTag))
		{
			StartCor(DoRevive(adventureMonsterDiedEvent.monsterID));
		}
	}

	private IEnumerator DoRevive(int monsterId)
	{
		FP curTime = 0;
		while (curTime < reviveTime)
		{
			yield return null;
			if (!_actor.logicVariable.GetLogicTagToggle("guild"))
			{
				curTime += _actor.LogicDeltaTime;
			}
		}
		TSVector2 placeHolderPosition = GetPlaceHolderPosition(dicSpawnPoint.get_Item(monsterId));
		ILRuntimeAPI.SummonMonster(_actor, 0, monsterId, placeHolderPosition, _actor.tsTransform.Forward, summonCfg);
	}

	private void SpawnSummon()
	{
		for (int i = 0; i < 4; i++)
		{
			TSVector2 placeHolderPosition = GetPlaceHolderPosition(summonPosList_Move.get_Item(i));
			ILRuntimeAPI.SummonMonster(dir: new TSVector2(0, -7.5) - placeHolderPosition, actor: _actor, groupId: 0, monsterId: moveSummonIds.get_Item(i), pos: placeHolderPosition);
		}
	}

	private void AddMonsterIdToList()
	{
		SetLogicTagListLongValue(_actor, "MonsterSpawnList", new List<long> { 1652007L, 1652008L, 1652009L, 1652010L });
	}
}
