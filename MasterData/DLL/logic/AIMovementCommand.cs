public class AIMovementCommand : AICommand
{
	public AIProcessor.E_Direction mDirection;

	public int mMaxDistance;

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
		Int3 @int = Int3.zero;
		switch (mDirection)
		{
		case AIProcessor.E_Direction.Forward:
			@int = entity.entityPositon.mForward;
			break;
		case AIProcessor.E_Direction.Backward:
			@int = -entity.entityPositon.mForward;
			break;
		case AIProcessor.E_Direction.Left:
			@int = -IntMath.GetXZRight(entity.entityPositon.mForward);
			break;
		case AIProcessor.E_Direction.Right:
			@int = IntMath.GetXZRight(entity.entityPositon.mForward);
			break;
		}
		AIProcessor.MoveAIDirection(entity.creationIndex, @int + entity.entityPositon.mPosition, VFactor.one);
		mStatus = AIProcessor.AICommandStatus.Running;
		return mStatus;
	}
}
