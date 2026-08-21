public class AIMovetoTargetCommand : AICommand
{
	public int mTargetID;

	public long mArriveDistance;

	public bool mLookat;

	public int mSpeedFactor = 100;

	public AIProcessor.E_Direction mDirection;

	public bool mStopWhenFinished;

	public bool mUseEdgeDistance;

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
		int entityID = ((mTargetID == 0) ? entity.entityBlackboard.var.mAimTarget : mTargetID);
		SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityID);
		if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityPositon)
		{
			Int3 @int = Int3.zero;
			if (mDirection == AIProcessor.E_Direction.Backward)
			{
				@int = (entity.entityPositon.mPosition - simEntityByMultiColliders.entityPositon.mPosition).NormalizeTo(1000);
			}
			else if (mDirection == AIProcessor.E_Direction.Forward)
			{
				if (mUseEdgeDistance)
				{
					ISimShape nearestCollisionData = AIProcessor.GetNearestCollisionData(entity, simEntityByMultiColliders, simEntityByMultiColliders.entityCamp.mRoleTypeCamp, out var minDistance);
					if (nearestCollisionData != null)
					{
						@int = nearestCollisionData.WorldPos - entity.entityPositon.mPosition;
						if (minDistance <= mArriveDistance)
						{
							mStatus = AIProcessor.AICommandStatus.Success;
						}
					}
					else
					{
						mStatus = AIProcessor.AICommandStatus.Failed;
					}
				}
				else
				{
					@int = simEntityByMultiColliders.entityPositon.mPosition - entity.entityPositon.mPosition;
					if (@int.sqrMagnitudeLong <= mArriveDistance * mArriveDistance)
					{
						mStatus = AIProcessor.AICommandStatus.Success;
					}
				}
			}
			else
			{
				mStatus = AIProcessor.AICommandStatus.Failed;
			}
			if (mStatus == AIProcessor.AICommandStatus.Running)
			{
				Int3 targetPosition = entity.entityPositon.mPosition + @int;
				entity.entityBlackboard.var.mIsLookatAimTarget = mLookat;
				AIProcessor.MoveAIDirection(entity.creationIndex, targetPosition, new VFactor(mSpeedFactor, 100L));
			}
		}
		else
		{
			mStatus = AIProcessor.AICommandStatus.Failed;
		}
		return mStatus;
	}

	internal override void Reset()
	{
		base.Reset();
		mTargetID = 0;
	}
}
