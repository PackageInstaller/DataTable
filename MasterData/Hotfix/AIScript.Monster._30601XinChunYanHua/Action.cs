using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30601XinChunYanHua;

public class Action : MonsterActionBase
{
	private readonly int Fire = 3060101;

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
		FP cd = 0;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Skill_Fire;
		list2.Add(new PoolBranchInfo(actor, 1, 99, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private bool Condition01()
	{
		if (GetBuffNum(_actor, 306010001) >= 1)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Skill_Fire()
	{
		CastSkill(Fire);
		yield return WaitSkillFinish();
	}
}
