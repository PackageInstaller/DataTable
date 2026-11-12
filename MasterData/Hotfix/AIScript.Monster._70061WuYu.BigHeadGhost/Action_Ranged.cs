using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BigHeadGhost;

public class Action_Ranged : Action
{
	private const int Skill_Wander_Ranged = 7006129;

	protected override IEnumerator DoWander()
	{
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakBranch", value: true);
		CastSkill(7006129);
		yield return WaitSkillFinish();
	}

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
		FP initCd = 0;
		FP releaseDistance = 14;
		FP releaseAngle = 30;
		operationConditionFunc = Check_EnergyCircle;
		operateIEnumerator = DoCast_EnergyCircle;
		list2.Add(new PoolBranchInfo(actor2, 1002, 200, cd2, initCd, active: true, releaseDistance, releaseAngle, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor3 = _actor;
		FP cd3 = 4;
		FP initCd2 = 0;
		FP releaseDistance2 = 3;
		FP releaseAngle2 = 10;
		operationConditionFunc = Check_BowTie;
		operateIEnumerator = DoCast_BowTie;
		list2.Add(new PoolBranchInfo(actor3, 1004, 90, cd3, initCd2, active: true, releaseDistance2, releaseAngle2, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor4 = _actor;
		FP cd4 = 10;
		FP initCd3 = 4;
		FP releaseDistance3 = 5;
		FP releaseAngle3 = 5;
		operationConditionFunc = Check_RocketHeadbutt;
		operateIEnumerator = DoCast_RocketHeadbutt;
		list2.Add(new PoolBranchInfo(actor4, 1005, 100, cd4, initCd3, active: true, releaseDistance3, releaseAngle3, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor5 = _actor;
		FP cd5 = 0;
		FP initCd4 = 0;
		operateIEnumerator = DoWander;
		list2.Add(new PoolBranchInfo(actor5, 1006, 1, cd5, initCd4, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}
}
