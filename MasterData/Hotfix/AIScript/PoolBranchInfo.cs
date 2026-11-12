using System;
using TrueSync;

namespace AIScript;

public class PoolBranchInfo : BaseBranchInfo
{
	public int priority;

	public FP cd;

	private FP initCd;

	public bool active;

	public Func<bool> operationConditionFunc;

	public FP startCdTime;

	public FP branchCdExpireTime;

	private AdventureActor actor;

	public PoolBranchInfo(AdventureActor actor, int id, int priority, FP cd, FP initCd, bool active = true, FP releaseDistance = default(FP), FP releaseAngle = default(FP), FP traceDuration = default(FP), Func<bool> operationConditionFunc = null, Func<bool> finishTraceConditionFunc = null, MonsterActionBase.OperateDelegate operateIEnumerator = null, Action operateCompleteCallback = null, FP startCdTime = default(FP), Action operateInterruptCallback = null)
		: base(id, releaseDistance, releaseAngle, traceDuration, finishTraceConditionFunc, operateIEnumerator, operateCompleteCallback, operateInterruptCallback)
	{
		this.actor = actor;
		this.priority = priority;
		this.cd = cd;
		this.initCd = initCd;
		this.active = active;
		this.operationConditionFunc = operationConditionFunc;
		this.startCdTime = startCdTime;
		ResetBranchCdExpireTime();
	}

	public void SetBranchCdExpireTime(FP cd)
	{
		branchCdExpireTime = actor.LogicTime + cd;
	}

	public void ResetBranchCdExpireTime()
	{
		branchCdExpireTime = actor.LogicTime + initCd;
	}

	public void SetBranchActive(bool active)
	{
		this.active = active;
	}
}
