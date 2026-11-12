using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Action_Activity : MonsterActionBase
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
		FP cd = 8;
		FP initCd = 0;
		Func<bool> operationConditionFunc = CanShanShuo;
		OperateDelegate operateIEnumerator = DoShanShuo;
		list2.Add(new PoolBranchInfo(actor, 1001, 5, cd, initCd, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		list2.Add(new PoolBranchInfo(_actor, 1002, 2, 17, 5, active: true, 12, operateIEnumerator: DoXiShuaXianJing, releaseAngle: default, traceDuration: default, operationConditionFunc: () => true));
		list2.Add(new PoolBranchInfo(_actor, 1004, 1, 2, 0, active: true, 12, operateIEnumerator: DoPuTongSheJi, releaseAngle: default, traceDuration: default, operationConditionFunc: () => true));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator DoPuTongSheJi()
	{
		CastSkill(7201601);
		yield return WaitSkillFinish();
		yield return DoZhuangTian();
	}

	private IEnumerator DoXiShuaXianJing()
	{
		int skillId = ((TSRandom.Range(0, 2) == 0) ? 7201602 : 7201603);
		CastSkill(skillId);
		yield return WaitSkillFinish();
		yield return DoZhuangTian();
	}

	private CoroutineNode DoZhuangTian()
	{
		CastSkill(7201604);
		return WaitSkillFinish();
	}

	private bool CanShanShuo()
	{
		return GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 2.5;
	}

	private IEnumerator DoShanShuo()
	{
		CastSkill(7201605);
		yield return WaitSkillFinish();
	}
}
