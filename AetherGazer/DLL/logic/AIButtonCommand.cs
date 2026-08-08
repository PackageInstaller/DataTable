public class AIButtonCommand : AICommand
{
	public ButtonType mButtonType;

	public int mDuring;

	public bool mPressing;

	public bool mIsSubStick;

	public bool mSingleClick = true;

	public int mTimelineID;

	public bool mFailedWhenNoTarget;

	public int mFinishedAbilityID;

	public int mFinishedAbilityFrame;

	private bool startSubStick;

	internal override void Reset()
	{
		base.Reset();
		startSubStick = false;
	}

	protected override void OnTimeout()
	{
		base.OnTimeout();
		mStatus = AIProcessor.AICommandStatus.Success;
	}

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
		if (mIsSubStick)
		{
			entity.entityBlackboard.var.mTargetPos = entity.entityPositon.mPosition;
			entity.entityBlackboard.var.mBeaconPosition = entity.entityPositon.mPosition;
		}
		if (mSingleClick)
		{
			if (entity.hasEntityActionManualInput)
			{
				entity.entityActionManualInput.mStatus = EntityActionStatus.E_ACTIVE;
				entity.entityActionManualInput.mIsPressing = mPressing;
				entity.entityActionManualInput.mCanDestroy = true;
				entity.entityActionManualInput.mInputKey = (int)mButtonType;
				entity.entityActionManualInput.mInputStamp = TimeHelper.Now();
			}
			else
			{
				entity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, (int)mButtonType, TimeHelper.Now(), newMCanDestroy: true, mPressing);
			}
		}
	}

	public override void OnExit(SimContext simContext, SimEntity entity)
	{
		if (entity.hasEntityActionSubJoystick)
		{
			entity.RemoveEntityActionSubJoystick();
		}
		entity.entityBlackboard.var.RemoveOnPressDownBtnID((int)mButtonType);
	}

	public override AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity)
	{
		if (!mSingleClick)
		{
			if (entity.hasEntityActionManualInput)
			{
				entity.entityActionManualInput.mStatus = EntityActionStatus.E_ACTIVE;
				entity.entityActionManualInput.mIsPressing = mPressing;
				entity.entityActionManualInput.mCanDestroy = true;
				entity.entityActionManualInput.mInputKey = (int)mButtonType;
				entity.entityActionManualInput.mInputStamp = TimeHelper.Now();
			}
			else
			{
				entity.AddEntityActionManualInput(EntityActionStatus.E_ACTIVE, (int)mButtonType, TimeHelper.Now(), newMCanDestroy: true, mPressing);
			}
		}
		if (mExcutingTime <= mDuring)
		{
			if (mPressing && mIsSubStick)
			{
				if (startSubStick)
				{
					SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(entity.entityBlackboard.var.mAimTarget);
					if (entityWithEntityID == null)
					{
						mStatus = AIProcessor.AICommandStatus.Failed;
						return mStatus;
					}
					Int3 @int = entityWithEntityID.entityShape.mShape.WorldPos - entity.entityBlackboard.var.mTargetPos;
					if (@int.sqrMagnitudeLong <= 160000)
					{
						@int = Int3.zero;
					}
					else
					{
						@int.NormalizeTo(400);
					}
					entity.entityBlackboard.var.mTargetPos += @int;
					entity.entityBlackboard.var.mBeaconPosition = entity.entityBlackboard.var.mTargetPos;
					entity.entityBlackboard.var.mBeaconForward = Int3.forward;
					int num = SubJoystickCommand.PositionToCommandCode(entity.entityPositon.mPosition, entity.entityPositon.mForward, entity.entityBlackboard.var.mTargetPos, mTimelineID);
					if (entity.hasEntityActionSubJoystick)
					{
						entity.entityActionSubJoystick.CommandCode = num;
						entity.entityActionSubJoystick.TimelineID = mTimelineID;
					}
					else
					{
						entity.AddEntityActionSubJoystick(num, mTimelineID);
					}
				}
				else if (entity.hasEntityActionAbility && entity.entityActionAbility.mAbilityID == mTimelineID)
				{
					startSubStick = true;
				}
			}
		}
		else
		{
			mStatus = AIProcessor.AICommandStatus.Failed;
		}
		if (entity.hasEntityActionAbility)
		{
			entity.entityActionAbility.mIsPressing = mPressing;
			if (mPressing)
			{
				entity.entityBlackboard.var.AddOnPressDownBtnID((int)mButtonType);
			}
			else
			{
				entity.entityBlackboard.var.RemoveOnPressDownBtnID((int)mButtonType);
			}
			if (entity.entityActionAbility.mAbilityID % 1000 == mFinishedAbilityID && entity.entityActionAbility.mLogicTime / CommonProcessor.GetConfigInterval() >= mFinishedAbilityFrame)
			{
				mStatus = AIProcessor.AICommandStatus.Success;
			}
		}
		if (!AIProcessor.AICheckTargetValid(entity.creationIndex, entity.entityBlackboard.var.mAimTarget) && mFailedWhenNoTarget)
		{
			mStatus = AIProcessor.AICommandStatus.Failed;
			return mStatus;
		}
		if (mStatus == AIProcessor.AICommandStatus.Failed && entity.hasEntityActionSubJoystick)
		{
			entity.RemoveEntityActionSubJoystick();
		}
		return mStatus;
	}
}
