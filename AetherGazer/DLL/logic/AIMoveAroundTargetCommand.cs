public class AIMoveAroundTargetCommand : AICommand
{
	public int mTargetID;

	public int mApproachSpeed;

	public bool mStopWhenFinished;

	private AIProcessor.E_Direction mDesiredDirection;

	internal VFactor mSpeedFactor;

	protected override void OnTimeout()
	{
		base.OnTimeout();
		mStatus = AIProcessor.AICommandStatus.Success;
	}

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
		mSpeedFactor = new VFactor(mApproachSpeed, 100L);
		mDesiredDirection = AIProcessor.GetRandomLeftOrRight();
		SimEntity nearestAliveEntity = AIProcessor.GetNearestAliveEntity(entity.entityPositon.mPosition, 4000, entity, entity.entityCamp.mRoleTypeCamp);
		if (nearestAliveEntity == null)
		{
			return;
		}
		Int3 mPosition = nearestAliveEntity.entityPositon.mPosition;
		Int3 rhs = mPosition - entity.entityPositon.mPosition;
		if (mDesiredDirection == AIProcessor.E_Direction.Left)
		{
			if (Int3.Det(entity.entityPositon.mForward, rhs) > 0)
			{
				mDesiredDirection = AIProcessor.E_Direction.Right;
			}
		}
		else if (Int3.Det(entity.entityPositon.mForward, rhs) < 0)
		{
			mDesiredDirection = AIProcessor.E_Direction.Left;
		}
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
		Int3 targetPos = AIProcessor.GetTargetPos(entity, mDesiredDirection);
		AIProcessor.MoveAIDirection(entity.creationIndex, targetPos, mSpeedFactor);
		mStatus = AIProcessor.AICommandStatus.Running;
		return mStatus;
	}
}
