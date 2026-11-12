using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Action_10_2KeepShooting : MonsterActionBase
{
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
		FP cd = 1;
		FP initCd = 0;
		FP releaseDistance = 15;
		Func<bool> operationConditionFunc = CheckDistanceToPlayer;
		OperateDelegate operateIEnumerator = DoPuTongSheJi;
		list2.Add(new PoolBranchInfo(actor, 1004, 1, cd, initCd, active: true, releaseDistance, default, default, operationConditionFunc, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
	}

	private IEnumerator DoPuTongSheJi()
	{
		CastSkill(7201601);
		yield return WaitSkillFinish();
	}

	private bool CheckDistanceToPlayer()
	{
		return Distance(GetPosition(), GetEntityPosition(GetCurrentPlayer())) <= 15;
	}
}
