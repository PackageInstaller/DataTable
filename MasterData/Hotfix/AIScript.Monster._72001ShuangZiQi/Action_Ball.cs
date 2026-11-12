using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Action_Ball : MonsterActionBase
{
	private const int Skill_Atk = 7200702;

	private const int Skill_Atk_Lv6Common = 7200704;

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
		FP cd = 2;
		FP initCd = 0;
		OperateDelegate operateIEnumerator = DoCast_Blast;
		list2.Add(new PoolBranchInfo(actor, 1001, 9, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 2;
		FP initCd2 = 0;
		Func<bool> operationConditionFunc = Check_Blast_Lv6Common;
		operateIEnumerator = DoCast_Blast_Lv6Common;
		list2.Add(new PoolBranchInfo(actor2, 1002, 99, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator DoCast_Blast()
	{
		CastSkill(7200702);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoCast_Blast_Lv6Common()
	{
		CastSkill(7200704);
		yield return WaitSkillFinish();
	}

	private bool Check_Blast_Lv6Common()
	{
		return GetLogicTagToggleValue(_actor, "Lv6Common");
	}
}
