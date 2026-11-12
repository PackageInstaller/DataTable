using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Action_GuangXianPatrol : MonsterActionBase
{
	private const int skill_Patrol = 7201312;

	private bool _checkPatrol;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_checkPatrol = true;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_checkPatrol = false;
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
		FP cd = 0;
		FP initCd = 0;
		Func<bool> operationConditionFunc = Check_Patrol;
		OperateDelegate operateIEnumerator = DoCast_Patrol;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		InitPoolBranches(1, list);
	}

	private bool Check_Patrol()
	{
		return _checkPatrol;
	}

	private IEnumerator DoCast_Patrol()
	{
		_checkPatrol = false;
		CastSkill(7201312);
		yield return WaitSkillFinish();
	}
}
