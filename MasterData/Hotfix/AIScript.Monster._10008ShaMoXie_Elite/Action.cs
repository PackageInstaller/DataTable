using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10008ShaMoXie_Elite;

public class Action : MonsterActionBase
{
	private readonly int SkillId_NormalAttack = 1000805;

	private readonly int SkillId_PoisonBall = 1000803;

	private readonly int SkillId_TailSlash = 1000804;

	private readonly int SkillId_Chase = 9999970;

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
		FP cd = 8;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Condition01;
		OperateDelegate operateIEnumerator = Skill_PoisonBall;
		list2.Add(new PoolBranchInfo(actor, 1, 90, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 8;
		FP initCd2 = 0;
		operationConditionFunc = Condition02;
		operateIEnumerator = Skill_TailSlash;
		list2.Add(new PoolBranchInfo(actor2, 2, 80, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0;
		FP initCd3 = 0;
		operationConditionFunc = Condition03;
		operateIEnumerator = Skill_NormalAttack;
		list2.Add(new PoolBranchInfo(actor3, 3, 70, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 0;
		FP initCd4 = 0;
		operateIEnumerator = Skill_Chase;
		list2.Add(new PoolBranchInfo(actor4, 4, 60, cd4, initCd4, active: true, default, default, default, null, null, operateIEnumerator));
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
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 5 && GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 10)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 5)
		{
			return true;
		}
		return false;
	}

	private bool Condition03()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < 3)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Skill_NormalAttack()
	{
		GotoCastSkill(SkillId_NormalAttack);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_PoisonBall()
	{
		GotoCastSkill(SkillId_PoisonBall);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_TailSlash()
	{
		GotoCastSkill(SkillId_TailSlash);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_Chase()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		GotoCastSkill(SkillId_Chase);
		yield return WaitSkillFinish();
	}
}
