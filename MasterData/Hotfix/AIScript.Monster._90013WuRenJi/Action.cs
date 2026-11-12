using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._90013WuRenJi;

public class Action : MonsterActionBase
{
	private const int Skill_Boom = 9001301;

	private static readonly FP LifeTime = 8;

	private static readonly FP NearDistance = 2;

	private const int BoomBranchId = 1001;

	private static readonly FP BoomRecoverCd = 1;

	private bool _boomTriggered;

	protected override void OnActionEnable()
	{
		_boomTriggered = false;
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
		FP boomRecoverCd = BoomRecoverCd;
		FP lifeTime = LifeTime;
		Func<bool> operationConditionFunc = Check_Boom;
		OperateDelegate operateIEnumerator = DoCast_Boom;
		list2.Add(new PoolBranchInfo(actor, 1001, 999, boomRecoverCd, lifeTime, active: true, default, default, default, operationConditionFunc, null, operateIEnumerator));
		AdventureActor actor2 = _actor;
		FP cd = 0;
		FP initCd = 0;
		FP nearDistance = NearDistance;
		operateIEnumerator = DoChase;
		list2.Add(new PoolBranchInfo(actor2, 1002, 1, cd, initCd, active: true, nearDistance, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private bool Check_Boom()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < NearDistance)
		{
			return !_boomTriggered;
		}
		return false;
	}

	private IEnumerator DoCast_Boom()
	{
		_boomTriggered = true;
		InterruptSkill();
		CastSkill(9001301);
		yield return WaitSkillFinish();
	}

	private IEnumerator DoChase()
	{
		yield return null;
		if (Check_Boom() && GetPoolBranchCD(1001) > BoomRecoverCd)
		{
			SetPoolBranchCD(1001, BoomRecoverCd);
		}
	}
}
