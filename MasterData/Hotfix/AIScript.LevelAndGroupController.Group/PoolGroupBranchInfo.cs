using System;
using TrueSync;

namespace AIScript.LevelAndGroupController.Group;

public class PoolGroupBranchInfo : BaseGroupBranchInfo
{
	public int priority;

	public FP cd;

	private FP initCd;

	public bool active;

	public Func<bool> operationConditionFunc;

	public FP startCdTime;

	public FP branchCdExpireTime;

	public PoolGroupBranchInfo(int id, int priority, FP cd, FP initCd, bool active = true, Func<bool> operationConditionFunc = null, MonsterActionBase.OperateDelegate operateIEnumerator = null, Action operateCompleteCallback = null, FP startCdTime = default(FP))
		: base(id, operateIEnumerator, operateCompleteCallback)
	{
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
		branchCdExpireTime = LockStepManager.time + cd;
	}

	public void ResetBranchCdExpireTime()
	{
		branchCdExpireTime = LockStepManager.time + initCd;
	}

	public void SetBranchActive(bool active)
	{
		this.active = active;
	}
}
