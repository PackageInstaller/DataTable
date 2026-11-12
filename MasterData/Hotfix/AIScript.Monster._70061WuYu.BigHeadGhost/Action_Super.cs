using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BigHeadGhost;

public class Action_Super : Action
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
		FP cd = 0;
		FP lifeTime = Action.LifeTime;
		Func<bool> operationConditionFunc = Check_DeathWord;
		OperateDelegate operateIEnumerator = DoCast_DeathWord;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, cd, lifeTime, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd2 = 4;
		FP initCd = 0;
		FP releaseDistance = 6;
		operationConditionFunc = Check_EnergyCircle;
		operateIEnumerator = DoCast_EnergyCircle;
		list2.Add(new PoolBranchInfo(actor2, 1002, 200, cd2, initCd, active: true, releaseDistance, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 5;
		FP initCd2 = 0;
		FP releaseDistance2 = 5;
		operationConditionFunc = Check_SpinSlash;
		operateIEnumerator = DoCast_SpinSlash;
		list2.Add(new PoolBranchInfo(actor3, 1003, 190, cd3, initCd2, active: true, releaseDistance2, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 2;
		FP initCd3 = 0;
		FP releaseDistance3 = 3;
		operationConditionFunc = Check_BowTie;
		operateIEnumerator = DoCast_BowTie;
		list2.Add(new PoolBranchInfo(actor4, 1004, 100, cd4, initCd3, active: true, releaseDistance3, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 3;
		FP initCd4 = 0;
		FP releaseDistance4 = 4;
		operationConditionFunc = Check_RocketHeadbutt;
		operateIEnumerator = DoCast_RocketHeadbutt;
		list2.Add(new PoolBranchInfo(actor5, 1005, 90, cd5, initCd4, active: true, releaseDistance4, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor6 = _actor;
		FP cd6 = 0;
		FP initCd5 = 0;
		operateIEnumerator = DoWander;
		list2.Add(new PoolBranchInfo(actor6, 1006, 1, cd6, initCd5, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}
}
