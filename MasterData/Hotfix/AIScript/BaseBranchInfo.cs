using System;
using TrueSync;

namespace AIScript;

public class BaseBranchInfo
{
	public int id;

	public FP releaseDistance;

	public FP releaseAngle;

	public FP traceDuration;

	public Func<bool> finishTraceConditionFunc;

	public MonsterActionBase.OperateDelegate operateIEnumerator;

	public Action operateCompleteCallback;

	public Action operateInterruptCallback;

	public BaseBranchInfo(int id, FP releaseDistance = default(FP), FP releaseAngle = default(FP), FP traceDuration = default(FP), Func<bool> finishTraceConditionFunc = null, MonsterActionBase.OperateDelegate operateIEnumerator = null, Action operateCompleteCallback = null, Action operateInterruptCallback = null)
	{
		this.id = id;
		this.releaseDistance = ((releaseDistance == default(FP)) ? ((FP)999) : releaseDistance);
		this.releaseAngle = ((releaseAngle == default(FP)) ? ((FP)360) : releaseAngle);
		this.traceDuration = ((traceDuration == default(FP)) ? ((FP)5) : traceDuration);
		this.finishTraceConditionFunc = finishTraceConditionFunc;
		this.operateIEnumerator = operateIEnumerator;
		this.operateCompleteCallback = operateCompleteCallback;
		this.operateInterruptCallback = operateInterruptCallback;
	}
}
