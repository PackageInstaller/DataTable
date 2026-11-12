using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu.MageGhost;

public class Action_Ranged : Action
{
	protected override void SetConfig()
	{
		_hasFastExplodeTag = HasFastExplodeTag();
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 0;
		FP lifeTime = Action.LifeTime;
		Func<bool> operationConditionFunc = Check_DeathWord;
		OperateDelegate operateIEnumerator = DoCast_DeathWord;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, cd, lifeTime, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 6;
		FP initCd = 3;
		FP releaseDistance = 12;
		FP releaseAngle = 15;
		operationConditionFunc = Check_MagicBullet;
		operateIEnumerator = DoCast_MagicBullet;
		list2.Add(new PoolBranchInfo(actor2, 1002, 100, cd2, initCd, active: true, releaseDistance, releaseAngle, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 0;
		FP initCd2 = 0;
		operateIEnumerator = DoWander;
		list2.Add(new PoolBranchInfo(actor3, 1003, 1, cd3, initCd2, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}
}
