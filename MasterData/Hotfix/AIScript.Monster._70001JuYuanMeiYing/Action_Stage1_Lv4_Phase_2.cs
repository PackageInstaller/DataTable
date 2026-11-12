using System;
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Action_Stage1_Lv4_Phase_2 : MonsterActionBase
{
	private int lockHp = 59;

	private int Skill_Attack01 = 7000102;

	private int Skill_Attack02 = 7000103;

	private int Skill_Attack03 = 7000104;

	private int Skill_Attack04 = 7000105;

	private int Skill_Attack05 = 7000106;

	private int Skill_Attack06 = 7000141;

	private int ultraSeqInex = 2;

	private List<int> moveSummonIds = new List<int> { 7010050, 7010049, 7010052, 7010051 };

	private List<string> summonPosList_Move = new List<string> { "Zuo_01_01", "Zuo_02_01", "You_01_01", "You_02_01" };

	private List<int> seqList = new List<int>();

	private int seqCount;

	private int lastSeqIndex;

	private int lastBranchIndex;

	private MonsterAdventureActor actor => _actor as MonsterAdventureActor;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_actor.LockHpPercent(lockHp);
		SpawnSummon();
		AddMonsterIdToList();
	}

	protected override void OnActionStop()
	{
		base.OnActionStop();
		OnSequenceBranchOperateComplete(CurrentSeqIndex, CurrentIndex, CurrentIndex == 0);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_actor.UnlockHp();
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptStrong);
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
		list.Add(new BaseBranchInfo(99, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> dictionary = new Dictionary<int, List<int>>
		{
			[0] = new List<int> { 99, 1, 99, 2, 99, 3, 99, 4, 99, 5 },
			[1] = new List<int> { 99, 2, 99, 3, 99, 1, 99, 5, 99, 4 },
			[2] = new List<int> { 6 }
		};
		seqCount = dictionary.Count - 1;
		for (int i = 0; i < seqCount; i++)
		{
			seqList.Add(i);
		}
		lastSeqIndex = RandomIndexFromLeft();
		InitSequenceBranches(lastSeqIndex, sequenceBranches, dictionary);
	}

	private void InterruptStrong(IEvent evt)
	{
		if (CurrentSeqIndex == ultraSeqInex && actor.monsterInfo.currentEnergy < actor.monsterInfo.maxEnergy)
		{
			SetCurrentSequenceIndex(lastBranchIndex);
			SwitchSequence(lastSeqIndex, initialIndex: false);
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
			if (actor.monsterInfo.currentEnergy >= actor.monsterInfo.maxEnergy)
			{
				SwitchSequence(ultraSeqInex);
			}
			else if (curSeqIndex == ultraSeqInex)
			{
				SetCurrentSequenceIndex(lastBranchIndex);
				SwitchSequence(lastSeqIndex, initialIndex: false);
			}
			else
			{
				lastSeqIndex = RandomIndexFromLeft();
				SwitchSequence(lastSeqIndex);
			}
		}
		else if (actor.monsterInfo.currentEnergy >= actor.monsterInfo.maxEnergy)
		{
			SwitchSequence(ultraSeqInex);
		}
	}

	private int RandomIndexFromLeft()
	{
		int index = TSRandom.Range(0, seqList.Count);
		int result = seqList.get_Item(index);
		seqList.RemoveAt(index);
		if (seqList.Count == 0)
		{
			for (int i = 0; i < seqCount; i++)
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
		yield return WaitTime(2);
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
		SetLogicTagListLongValue(_actor, "MonsterSpawnList", moveSummonIds.ConvertAll((Converter<int, long>)((int id) => id)));
	}
}
