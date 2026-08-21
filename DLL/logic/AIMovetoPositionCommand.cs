public class AIMovetoPositionCommand : AICommand
{
	public bool mLookat;

	public int mSpeedFactor;

	public Int3 mPosition;

	public int mArriveDistance;

	public bool mStopWhenFinished;

	protected override void OnTimeout()
	{
		base.OnTimeout();
		mStatus = AIProcessor.AICommandStatus.Success;
	}

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
	}

	public override void OnExit(SimContext simContext, SimEntity entity)
	{
		if (mStopWhenFinished)
		{
			AIProcessor.StopAIMovement(entity.creationIndex);
		}
	}

	public override AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity)
	{
		if ((entity.entityPositon.mPosition - mPosition).sqrMagnitudeLong <= mArriveDistance * mArriveDistance)
		{
			mStatus = AIProcessor.AICommandStatus.Success;
		}
		else
		{
			entity.entityBlackboard.var.mIsLookatAimTarget = mLookat;
			AIProcessor.MoveAIDirection(entity.creationIndex, mPosition, new VFactor(mSpeedFactor, 100L));
			mStatus = AIProcessor.AICommandStatus.Running;
		}
		return mStatus;
	}
}
