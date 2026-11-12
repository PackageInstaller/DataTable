using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Action_ShuFuXianJing : MonsterActionBase
{
	private const int skill_Lifecycle = 7201307;

	private bool _checkLifecycle;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_checkLifecycle = true;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_checkLifecycle = false;
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
		Func<bool> operationConditionFunc = Check_Lifecycle;
		OperateDelegate operateIEnumerator = DoCast_Lifecycle;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		InitPoolBranches(1, list);
	}

	private bool Check_Lifecycle()
	{
		return _checkLifecycle;
	}

	private IEnumerator DoCast_Lifecycle()
	{
		_checkLifecycle = false;
		CastSkill(7201307);
		yield return WaitSkillFinish();
		_actor.DestroySelf();
	}
}
