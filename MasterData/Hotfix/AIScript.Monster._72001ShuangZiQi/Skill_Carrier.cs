using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Carrier : SkillSimpleBase
{
	private int summonCount;

	private int SummonIndex;

	private int SummonAmount;

	private bool isRed;

	private bool isAtk;

	private int phase;

	private int lv;

	private FP AttackDelayTime;

	private int SummonMonsterID;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonMonsterSpawn);
		summonCount = 0;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		AttackDelayTime = 0;
		SummonIndex = 0;
		SummonMonsterID = GetTeammateIdByIndex(3);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonMonsterSpawn);
		SetLogicTagToggleValue(_actor, Config.Skill_Carrier_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SummonCarrier", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SummonStart");
		SummonAmount = CalSummonCount();
		summonCount = SummonAmount;
		AttackDelayTime = TSMath.Min(1, Config.AttackTotalTime / SummonAmount);
		List<long> logicTagListLongValue = GetLogicTagListLongValue(_actor, "MapGrids_Color");
		GridColor gridColor = (isRed ? GridColor.Red : GridColor.Green);
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		List<int> collection = (isRed ? new List<int> { 1, 5, 11, 15, 21 } : new List<int> { 23, 19, 13, 9, 3 });
		List<int> banList = Config.BanList;
		for (int i = 0; i < logicTagListLongValue.Count; i++)
		{
			if (!banList.Contains(i))
			{
				if (logicTagListLongValue.get_Item(i) == (long)gridColor)
				{
					list.Add(i);
				}
				else
				{
					list2.Add(i);
				}
			}
		}
		List<int> list3 = new List<int>();
		if (lv >= 3 && (phase == 1 || phase == 2))
		{
			list3.AddRange(collection);
			SummonAmount -= 5;
		}
		list3.AddRange(GetRandomPos(list, list2, SummonAmount));
		for (int j = 0; j < list3.Count; j++)
		{
			TSVector2 cellPosByIndex = Config.GetCellPosByIndex(list3.get_Item(j));
			TSVector2 tSVector = ((cellPosByIndex.x >= GetEntityPosition(GetCurrentPlayer()).x) ? TSVector2.left : TSVector2.right);
			TSVector2 pos = TransLocalPosToWorldPos(cellPosByIndex, tSVector, new TSVector2(0, -2.5));
			ILRuntimeAPI.SummonMonster(_actor, 0, SummonMonsterID, pos, tSVector, null, null, (MonsterAdventureActor monster) =>
			{
				SetLogicTagToggleValue(monster, "Attack", isAtk);
				SetLogicTagToggleValue(monster, "Red", isRed);
				SetLogicTagFpValue(monster, "Phase", phase);
				SetLogicTagFpValue(monster, "Level", lv);
			});
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (phase == 2)
		{
			yield return WaitTime(2);
			yield break;
		}
		yield return WaitUntil(() => summonCount <= 0);
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.dataID == SummonMonsterID)
		{
			summonCount--;
		}
	}

	private int CalSummonCount()
	{
		if (lv <= 2)
		{
			switch (phase)
			{
			case 1:
				return 3;
			case 2:
			case 3:
				return 5;
			default:
				return 5;
			}
		}
		List<long> logicTagListLongValue = GetLogicTagListLongValue(_actor, "MapGrids_Color");
		GridColor gridColor = (isRed ? GridColor.Red : GridColor.Green);
		int num = 0;
		for (int i = 0; i < logicTagListLongValue.Count; i++)
		{
			if (logicTagListLongValue.get_Item(i) == (long)gridColor)
			{
				num++;
			}
		}
		int num2 = phase;
		if ((uint)(num2 - 1) <= 2u)
		{
			return Mathf.Max(num / 3, 5);
		}
		return 5;
	}

	public List<int> GetRandomPos(List<int> selfCells, List<int> otherList, int m)
	{
		TSRandom random = TSRandom.instance;
		Shuffle(selfCells);
		Shuffle(otherList);
		List<int> list = new List<int>(m);
		int num = Mathf.Min(m, selfCells.Count);
		for (int i = 0; i < num; i++)
		{
			list.Add(selfCells.get_Item(i));
		}
		int num2 = m - num;
		for (int j = 0; j < num2 && j < otherList.Count; j++)
		{
			list.Add(otherList.get_Item(j));
		}
		return list;
		void Shuffle(List<int> list2)
		{
			for (int num3 = list2.Count - 1; num3 > 0; num3--)
			{
				int num4 = random.Next(0, num3 + 1);
				int index = num3;
				int index2 = num4;
				int num5 = list2.get_Item(num4);
				int num6 = list2.get_Item(num3);
				int num7;
				list2.set_Item(index, num7 = num5);
				list2.set_Item(index2, num7 = num6);
			}
		}
	}

	protected void OnSummonMonsterSpawn(IEvent evt)
	{
		AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent = evt as AdventureMonsterSummonerSpawnedEvent;
		if (adventureMonsterSummonerSpawnedEvent.summonerId == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(adventureMonsterSummonerSpawnedEvent.id) as MonsterAdventureActor;
			if (monsterAdventureActor != null && monsterAdventureActor.dataID == SummonMonsterID)
			{
				SetLogicTagFpValue(monsterAdventureActor, "AttackDelayTime", SummonIndex * AttackDelayTime);
				SummonIndex++;
			}
		}
	}
}
