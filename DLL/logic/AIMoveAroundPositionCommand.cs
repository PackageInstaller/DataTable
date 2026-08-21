using Config;

public class AIMoveAroundPositionCommand : AICommand
{
	public Int3 mCenter;

	public int mRadius;

	public int mDirection;

	public int mSpeed;

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
		RoleConfig roleConfig = entity.entityConfig.mConfig as RoleConfig;
		int num = ((mSpeed > 0) ? mSpeed : roleConfig.Speed);
		Int3 mPosition = entity.entityPositon.mPosition;
		int floorInt = (IntMath.asin(num / 2, mRadius) * IntMath.Rad2Deg).floorInt;
		floorInt = ((floorInt <= 0) ? 1 : floorInt);
		floorInt *= ((mDirection >= 0) ? 1 : (-1));
		Int3 targetPosition = mCenter + (mPosition - mCenter).RotateY(floorInt, mRadius);
		AIProcessor.MoveAIDirection(entity.creationIndex, targetPosition, VFactor.one);
		mStatus = AIProcessor.AICommandStatus.Running;
		return mStatus;
	}
}
