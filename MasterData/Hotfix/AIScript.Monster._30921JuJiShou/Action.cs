using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30921JuJiShou;

public class Action : MonsterActionBase
{
	private readonly int SkillId_Snipe = 3092101;

	private readonly int SkillId_FlashBomb = 3092102;

	private readonly int SkillId_Wander = 9999971;

	private readonly int testSkillId;

	private readonly FP AttackDistance = 20;

	private readonly FP EscapeDistance = 6;

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
		FP cd = 999;
		FP initCd = 3;
		Func<bool> operationConditionFunc = Condition02;
		OperateDelegate operateIEnumerator = Skill_FlashBomb;
		list2.Add(new PoolBranchInfo(actor, 1, 90, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 0;
		FP initCd2 = 0;
		operationConditionFunc = Condition01;
		operateIEnumerator = Skill_Snipe;
		list2.Add(new PoolBranchInfo(actor2, 2, 80, cd2, initCd2, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0;
		FP initCd3 = 0;
		operationConditionFunc = Condition03;
		operateIEnumerator = Skill_Wander;
		list2.Add(new PoolBranchInfo(actor3, 3, 70, cd3, initCd3, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		SetLogicTagToggleValue(_actor, "FlashBomb", value: false);
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
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= AttackDistance)
		{
			return true;
		}
		return false;
	}

	private bool Condition02()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= EscapeDistance)
		{
			return true;
		}
		return false;
	}

	private bool Condition03()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > AttackDistance)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Skill_Snipe()
	{
		GotoCastSkill(SkillId_Snipe);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_FlashBomb()
	{
		GotoCastSkill(SkillId_FlashBomb);
		SetLogicTagToggleValue(_actor, "FlashBomb", value: true);
		yield return WaitSkillFinish();
	}

	private IEnumerator Skill_Wander()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		GotoCastSkill(SkillId_Wander);
		yield return WaitSkillFinish();
	}
}
