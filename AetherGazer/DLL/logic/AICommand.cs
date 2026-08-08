public abstract class AICommand
{
	public int mID;

	public AICommand mParent;

	public int mTimeout;

	public int mExcutingTime;

	public AIProcessor.AICommandStatus mStatus;

	public bool mForceInterruptAbility;

	public bool mForceInterruptSelf;

	private int mDeltaTime;

	public AIProcessor.AICommandStatus Enter(SimContext simContext, SimEntity entity)
	{
		if (simContext.GetSimInterface().mAICommandConditionEvent != null)
		{
			simContext.GetSimInterface().mAICommandConditionEvent(entity.creationIndex, this, entity.entityConfig.mId);
		}
		if (mStatus == AIProcessor.AICommandStatus.Failed || mStatus == AIProcessor.AICommandStatus.Success)
		{
			return mStatus;
		}
		mStatus = AIProcessor.AICommandStatus.Running;
		if (simContext.GetSimInterface().mAICommandBeginEvent != null)
		{
			simContext.GetSimInterface().mAICommandBeginEvent(entity.creationIndex, this, entity.entityConfig.mId);
		}
		OnEnter(simContext, entity);
		return mStatus;
	}

	public AIProcessor.AICommandStatus Run(SimContext simContext, SimEntity entity)
	{
		if (mForceInterruptSelf)
		{
			return mStatus;
		}
		if (mDeltaTime == 0)
		{
			mDeltaTime = simContext.simStatus.runtimeSetting.kSimTickPeriodMS;
		}
		if (mExcutingTime == 0)
		{
			mStatus = Enter(simContext, entity);
			if (mStatus == AIProcessor.AICommandStatus.Failed || mStatus == AIProcessor.AICommandStatus.Success)
			{
				return mStatus;
			}
		}
		if (Timeout(simContext, entity))
		{
			return mStatus;
		}
		mStatus = Running(simContext, entity);
		if (!(this is AICommandSet) && simContext.GetSimInterface().mAICommandRunEvent != null)
		{
			simContext.GetSimInterface().mAICommandRunEvent(entity.creationIndex, this, entity.entityConfig.mId);
		}
		mExcutingTime += mDeltaTime;
		return mStatus;
	}

	public AIProcessor.AICommandStatus Exit(SimContext simContext, SimEntity entity)
	{
		OnExit(simContext, entity);
		if (simContext.GetSimInterface().mAICommandEndEvent != null)
		{
			simContext.GetSimInterface().mAICommandEndEvent(entity.creationIndex, this, entity.entityConfig.mId);
		}
		return mStatus;
	}

	public bool Timeout(SimContext simContext, SimEntity entity)
	{
		bool flag = IsTimeout();
		if (flag)
		{
			mStatus = AIProcessor.AICommandStatus.Failed;
			OnTimeout();
			if (simContext.GetSimInterface().mAICommandTimeoutEvent != null)
			{
				simContext.GetSimInterface().mAICommandTimeoutEvent(entity.creationIndex, this, entity.entityConfig.mId);
			}
		}
		return flag;
	}

	protected virtual void OnTimeout()
	{
	}

	protected virtual bool IsTimeout()
	{
		if (mTimeout != 0)
		{
			return mExcutingTime >= mTimeout;
		}
		return false;
	}

	public abstract void OnEnter(SimContext simContext, SimEntity entity);

	public abstract AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity);

	public abstract void OnExit(SimContext simContext, SimEntity entity);

	internal virtual void Reset()
	{
		mExcutingTime = 0;
		mForceInterruptSelf = false;
		mStatus = AIProcessor.AICommandStatus.None;
	}
}
