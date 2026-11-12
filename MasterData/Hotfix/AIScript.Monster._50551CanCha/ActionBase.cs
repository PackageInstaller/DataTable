#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class ActionBase : MonsterActionBase
{
	protected static List<BaseBranchInfo> sequenceBranchesList;

	protected static readonly int wait1 = 1001;

	protected static readonly int wait2 = 1002;

	protected static readonly int wait3 = 1003;

	protected static readonly int wanderActionBranchID = 1004;

	private static readonly int wanderActionSkillID = 5055120;

	protected static readonly int to1 = 1011;

	protected static readonly int to2 = 1012;

	protected static readonly int to3 = 1013;

	protected static readonly int to4 = 1014;

	private static readonly int chargeAttackBranchID = 2001;

	private static readonly int chargeAttackSkillID = 5055111;

	private static readonly int ultimateShootBranchID = 2002;

	private static readonly int ultimateShootSkillID = 5055112;

	protected static readonly int nearAttackBranchID = 2003;

	private static readonly int nearAttackSkillID = 5055113;

	protected static readonly int teamShootingBranchID = 2004;

	private static readonly int teamShootingSkillID = 5055116;

	protected static readonly int normalAttackBranchID = 2005;

	protected static readonly int summonElfBranchID = 3001;

	private static readonly int summonElfSkillID = 5055118;

	private static readonly int ultShootConditionBranchID = 4001;

	private int count;

	protected readonly List<int> wanderlAction = new List<int> { wanderActionBranchID };

	protected readonly List<int> normalATK_1 = new List<int> { normalAttackBranchID, wait1 };

	protected readonly List<int> normalATK_2 = new List<int> { normalAttackBranchID, wait1, normalAttackBranchID, wait1 };

	protected readonly List<int> ultShoot_1 = new List<int> { ultimateShootBranchID, wait2 };

	protected readonly List<int> teamShoot_3 = new List<int> { teamShootingBranchID, wait3 };

	protected readonly List<int> elf_3 = new List<int> { summonElfBranchID, wait3 };

	protected readonly List<int> elfUltShoot_3 = new List<int> { summonElfBranchID, wait1, ultShootConditionBranchID, wait2 };

	private IEnumerator Wait1()
	{
		yield return WaitTime(1);
	}

	private IEnumerator Wait2()
	{
		yield return WaitTime(2);
	}

	private IEnumerator Wait3()
	{
		yield return WaitTime(3);
	}

	private IEnumerator WanderActionEnumerator()
	{
		CastSkill(wanderActionSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator To1()
	{
		SwitchSequence(1);
		yield break;
	}

	private IEnumerator To2()
	{
		SwitchSequence(2);
		yield break;
	}

	private IEnumerator To3()
	{
		SwitchSequence(3);
		yield break;
	}

	private IEnumerator To4()
	{
		SwitchSequence(4);
		yield break;
	}

	private IEnumerator ChargeAttackEnumerator()
	{
		CastSkill(chargeAttackSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator UltimateShootEnumerator()
	{
		CastSkill(ultimateShootSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator NearAttackEnumerator()
	{
		CastSkill(nearAttackSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator TeamShootingEnumerator()
	{
		CastSkill(teamShootingSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator NormalAttackBEnumerator()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(currentPlayer);
		TSVector2 entityPositionObsoleted2 = GetEntityPositionObsoleted(_actor);
		if (Distance(entityPositionObsoleted, entityPositionObsoleted2) < 5)
		{
			CastSkill(nearAttackSkillID);
		}
		else
		{
			CastSkill(chargeAttackSkillID);
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator SummonElfEnumerator()
	{
		CastSkill(summonElfSkillID);
		yield return WaitSkillFinish();
	}

	private IEnumerator UltShootConditionEnumerator()
	{
		count++;
		if (count % 2 == 0)
		{
			CastSkill(ultimateShootSkillID);
			yield return WaitSkillFinish();
		}
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		int id = wanderActionBranchID;
		OperateDelegate operateIEnumerator = WanderActionEnumerator;
		list.Add(new BaseBranchInfo(id, default, default, default, null, operateIEnumerator));
		int id2 = to1;
		operateIEnumerator = To1;
		list.Add(new BaseBranchInfo(id2, default, default, default, null, operateIEnumerator));
		int id3 = to2;
		operateIEnumerator = To2;
		list.Add(new BaseBranchInfo(id3, default, default, default, null, operateIEnumerator));
		int id4 = to3;
		operateIEnumerator = To3;
		list.Add(new BaseBranchInfo(id4, default, default, default, null, operateIEnumerator));
		int id5 = to4;
		operateIEnumerator = To4;
		list.Add(new BaseBranchInfo(id5, default, default, default, null, operateIEnumerator));
		int id6 = wait1;
		operateIEnumerator = Wait1;
		list.Add(new BaseBranchInfo(id6, default, default, default, null, operateIEnumerator));
		int id7 = wait2;
		operateIEnumerator = Wait2;
		list.Add(new BaseBranchInfo(id7, default, default, default, null, operateIEnumerator));
		int id8 = wait3;
		operateIEnumerator = Wait3;
		list.Add(new BaseBranchInfo(id8, default, default, default, null, operateIEnumerator));
		int id9 = chargeAttackBranchID;
		operateIEnumerator = ChargeAttackEnumerator;
		list.Add(new BaseBranchInfo(id9, default, default, default, null, operateIEnumerator));
		int id10 = ultimateShootBranchID;
		FP releaseAngle = 90;
		FP traceDuration = 3;
		operateIEnumerator = UltimateShootEnumerator;
		list.Add(new BaseBranchInfo(id10, default, releaseAngle, traceDuration, null, operateIEnumerator));
		int id11 = nearAttackBranchID;
		traceDuration = 90;
		releaseAngle = 3;
		operateIEnumerator = NearAttackEnumerator;
		list.Add(new BaseBranchInfo(id11, default, traceDuration, releaseAngle, null, operateIEnumerator));
		int id12 = teamShootingBranchID;
		operateIEnumerator = TeamShootingEnumerator;
		list.Add(new BaseBranchInfo(id12, default, default, default, null, operateIEnumerator));
		int id13 = normalAttackBranchID;
		operateIEnumerator = NormalAttackBEnumerator;
		list.Add(new BaseBranchInfo(id13, default, default, default, null, operateIEnumerator));
		int id14 = summonElfBranchID;
		operateIEnumerator = SummonElfEnumerator;
		list.Add(new BaseBranchInfo(id14, default, default, default, null, operateIEnumerator));
		int id15 = ultShootConditionBranchID;
		operateIEnumerator = UltShootConditionEnumerator;
		list.Add(new BaseBranchInfo(id15, default, default, default, null, operateIEnumerator));
		sequenceBranchesList = list;
	}

	protected override void OnActionEnable()
	{
		count = 0;
		base.OnActionEnable();
	}

	protected List<int> ToTargetKey(List<int> skillList, int targetKey)
	{
		List<int> list = new List<int>();
		list.AddRange(skillList);
		switch (targetKey)
		{
		case 1:
			list.Add(to1);
			break;
		case 2:
			list.Add(to2);
			break;
		case 3:
			list.Add(to3);
			break;
		case 4:
			list.Add(to4);
			break;
		default:
			list.Add(to1);
			NovaLogger.Debug("禁断丽容.AI脚本.ToTargetKey函数传参有误,默认1");
			break;
		}
		return list;
	}

	protected List<int> SkillListAddSkill(List<int> skillList, params int[] targetSkillBranch)
	{
		List<int> list = new List<int>();
		list.AddRange(skillList);
		foreach (int item in targetSkillBranch)
		{
			list.Add(item);
		}
		return list;
	}

	protected List<int> AssemblyList(List<int> skillGroup, params List<int>[] targetSkillBranch)
	{
		List<int> list = new List<int>();
		list.AddRange(skillGroup);
		foreach (List<int> collection in targetSkillBranch)
		{
			list.AddRange(collection);
		}
		return list;
	}
}
