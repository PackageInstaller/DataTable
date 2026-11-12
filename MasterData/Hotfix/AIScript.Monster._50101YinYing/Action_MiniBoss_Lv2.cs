using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50101YinYing;

public class Action_MiniBoss_Lv2 : MonsterActionBase
{
	private static readonly int Skill_DarkWave_Fan = 5010104;

	private static readonly int Skill_DarkWave_Ring = 5010103;

	private static readonly int Skill_SummonAct = 5010111;

	private static readonly int testSkillId = 0;

	private static readonly int FirstGroupIndex = 5;

	private static readonly FP SkillCD = 4;

	private static readonly int MonsterCost_Melee_Normal_1 = 1;

	private static readonly int MonsterCost_Melee_Normal_2 = 4;

	private static readonly int MonsterCost_Range_Normal_1 = 2;

	private static readonly int MonsterCost_Range_Normal_2 = 2;

	private static readonly int MonsterCost_Melee_Plus_1 = 2;

	private static readonly int MonsterCost_Melee_Plus_2 = 4;

	private static readonly int MonsterCost_Range_Plus_1 = 3;

	private static readonly int MonsterCost_Range_Plus_2 = 3;

	private static readonly int MonsterCost_Melee_Ultra_1 = 4;

	private static readonly int MonsterCost_Melee_Ultra_2 = 6;

	private static readonly int MonsterCost_Range_Ultra_1 = 4;

	private static readonly int MonsterCost_Range_Ultra_2 = 3;

	private static readonly FP MonsterSummonDistance_Melee = 10;

	private static readonly FP MonsterSummonDistance_Range = 12.5;

	private int[] MaxCostInBattle;

	private int GroupIndex;

	private int GroupId_Normal;

	private int GroupId_Plus;

	private int GroupId_Ultra;

	private int SkillTimes;

	private int SummonTryIndex;

	private bool HaveToSummon;

	private FP TotalCost;

	private Dictionary<int, FP> MonsterCostDic;

	private Dictionary<int, FP> MonsterDistanceDic;

	private Dictionary<int, Dictionary<int, int>> MonsterSummonDic;

	private TSVector2 CenterPosition;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP skillCD = SkillCD;
		FP initCd = 1;
		OperateDelegate operateIEnumerator = Cast;
		list2.Add(new PoolBranchInfo(actor, 1001, 60, skillCD, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		ShowCenterHpBar();
		CenterPosition = GetPosition();
		SkillTimes = 0;
		SummonTryIndex = 0;
		HaveToSummon = false;
		MaxCostInBattle = new int[12]
		{
			1935879787, 16777216, 1090519040, 1936933212, 1551070309, 1600352851, 1718906696, 1415346281, 1550868850, 808661041,
			1852397617, 1550153049
		};
		GroupIndex = FirstGroupIndex;
		GroupId_Normal = _actor.dataID * 10;
		GroupId_Plus = _actor.dataID * 10 + 1;
		GroupId_Ultra = _actor.dataID * 10 + 2;
		CommonHelper.GetMonsterTeammateId(GroupId_Normal, 1);
		CommonHelper.GetMonsterTeammateId(GroupId_Normal, 2);
		CommonHelper.GetMonsterTeammateId(GroupId_Normal, 3);
		int monsterTeammateId = CommonHelper.GetMonsterTeammateId(GroupId_Plus, 1);
		int monsterTeammateId2 = CommonHelper.GetMonsterTeammateId(GroupId_Plus, 2);
		int monsterTeammateId3 = CommonHelper.GetMonsterTeammateId(GroupId_Plus, 3);
		int monsterTeammateId4 = CommonHelper.GetMonsterTeammateId(GroupId_Ultra, 1);
		int monsterTeammateId5 = CommonHelper.GetMonsterTeammateId(GroupId_Ultra, 2);
		int monsterTeammateId6 = CommonHelper.GetMonsterTeammateId(GroupId_Ultra, 3);
		MonsterCostDic = new Dictionary<int, FP>
		{
			{ monsterTeammateId, MonsterCost_Melee_Plus_1 },
			{ monsterTeammateId2, MonsterCost_Melee_Plus_2 },
			{ monsterTeammateId3, MonsterCost_Range_Plus_1 },
			{ monsterTeammateId4, MonsterCost_Melee_Ultra_1 },
			{ monsterTeammateId5, MonsterCost_Melee_Ultra_2 },
			{ monsterTeammateId6, MonsterCost_Range_Ultra_1 }
		};
		MonsterSummonDic = new Dictionary<int, Dictionary<int, int>>
		{
			{
				5,
				new Dictionary<int, int> { { monsterTeammateId, 8 } }
			},
			{
				6,
				new Dictionary<int, int>
				{
					{ monsterTeammateId2, 3 },
					{ monsterTeammateId3, 2 }
				}
			},
			{
				7,
				new Dictionary<int, int> { { monsterTeammateId, 6 } }
			},
			{
				8,
				new Dictionary<int, int> { { monsterTeammateId3, 3 } }
			},
			{
				9,
				new Dictionary<int, int> { { monsterTeammateId4, 3 } }
			},
			{
				10,
				new Dictionary<int, int>
				{
					{ monsterTeammateId5, 2 },
					{ monsterTeammateId6, 2 }
				}
			},
			{
				11,
				new Dictionary<int, int> { { monsterTeammateId4, 3 } }
			},
			{
				12,
				new Dictionary<int, int> { { monsterTeammateId6, 2 } }
			}
		};
		MonsterDistanceDic = new Dictionary<int, FP>
		{
			{ monsterTeammateId, MonsterSummonDistance_Melee },
			{ monsterTeammateId2, MonsterSummonDistance_Melee },
			{ monsterTeammateId3, MonsterSummonDistance_Range },
			{ monsterTeammateId4, MonsterSummonDistance_Melee },
			{ monsterTeammateId5, MonsterSummonDistance_Melee },
			{ monsterTeammateId6, MonsterSummonDistance_Range }
		};
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator Cast()
	{
		if (CheckMonsterCost())
		{
			GotoCastSkill(Skill_SummonAct);
			if (GroupIndex < 12)
			{
				GroupIndex++;
			}
			else
			{
				GroupIndex = 9;
			}
			yield return WaitTime(1);
			WaveActivate();
		}
		else if (SkillTimes % 2 == 0)
		{
			GotoCastSkill(Skill_DarkWave_Ring);
			SkillTimes++;
		}
		else
		{
			GotoCastSkill(Skill_DarkWave_Fan);
			SkillTimes++;
		}
		yield return WaitSkillFinish();
	}

	private bool CheckMonsterCost()
	{
		TotalCost = 0;
		foreach (LogicEntity item in GetTargetsByFaction(isFriend: true))
		{
			int dataID = (item as AdventureActor).dataID;
			if (MonsterCostDic.ContainsKey(dataID))
			{
				TotalCost += MonsterCostDic.get_Item(dataID);
			}
		}
		if (SummonTryIndex <= 0)
		{
			HaveToSummon = true;
		}
		SummonTryIndex--;
		if (TotalCost <= MaxCostInBattle[GroupIndex - 1] && HaveToSummon)
		{
			HaveToSummon = false;
			SummonTryIndex = 3;
			return true;
		}
		return false;
	}

	private void WaveActivate()
	{
		foreach (KeyValuePair<int, int> item in MonsterSummonDic.get_Item(GroupIndex - 1))
		{
			GoToSummonMonsters(item.Key, item.Value);
		}
	}

	private void GoToSummonMonsters(int MonsterID, int MonsterAmount)
	{
		int i = 0;
		TSVector2 zero = TSVector2.zero;
		FP randomValue = GetRandomValue(0, 180);
		for (; i < MonsterAmount; i++)
		{
			zero = TransLocalPosToWorldPos(CenterPosition, RotateTo(RotateTo(TSVector2.up, randomValue), i * 360 / MonsterAmount + GetRandomValue(-15, 15)), new TSVector2(0, GetRandomValue(-2.5, 2.5) + MonsterDistanceDic.get_Item(MonsterID)));
			SummonMonster(MonsterID, 0, zero, CenterPosition - zero);
		}
	}
}
