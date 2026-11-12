using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30901ChiHou;

public class Action : MonsterActionBase
{
	private readonly int SkillId_Slash = 3090101;

	private readonly int SkillId_DashAttack = 3090102;

	private readonly int SkillId_Wander = 9999970;

	private readonly int testSkillId;

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
		FP cd = 5;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Skill_DashAttack;
		list2.Add(new PoolBranchInfo(actor, 1, 90, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Skill_Slash;
		list2.Add(new PoolBranchInfo(actor2, 2, 80, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0;
		FP initCd3 = 0;
		operateIEnumerator = Skill_Wander;
		list2.Add(new PoolBranchInfo(actor3, 3, 70, cd3, initCd3, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private bool Condition01()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 5)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 3)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Skill_Slash()
	{
		GotoCastSkill(SkillId_Slash);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_DashAttack()
	{
		GotoCastSkill(SkillId_DashAttack);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_Wander()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		GotoCastSkill(SkillId_Wander);
		yield return WaitSkillFinish();
	}
}
