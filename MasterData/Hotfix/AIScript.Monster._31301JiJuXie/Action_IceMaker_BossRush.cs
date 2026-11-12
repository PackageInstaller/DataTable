using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Action_IceMaker_BossRush : MonsterActionBase
{
	private bool check_Attack;

	private int skill_Active = 3130140;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		check_Attack = true;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		check_Attack = false;
	}

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
		FP cd = 60;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Check_Attack;
		OperateDelegate operateIEnumerator = DoCast_Attack;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private bool Check_Attack()
	{
		return check_Attack;
	}

	private IEnumerator DoCast_Attack()
	{
		check_Attack = false;
		CastSkill(skill_Active);
		yield return WaitSkillFinish();
	}
}
