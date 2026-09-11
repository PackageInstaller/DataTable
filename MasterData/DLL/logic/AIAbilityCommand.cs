using Config;
using UnityEngine;

public class AIAbilityCommand : AICommand
{
	public int mBeginFrame;

	public int mEndFrame;

	public int mRange;

	public bool mDisableApproach;

	public int mApproachSpeed;

	public int mLoop = 1;

	public int mLastAction;

	public bool mUseEdgeDistance;

	public int mCurrentLoop;

	internal bool mAbilityStart;

	internal VFactor mMovementFactor;

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
		mAbilityStart = false;
		mMovementFactor = new VFactor(mApproachSpeed, 100L);
		RoleConfig roleConfig = entity.entityConfig.mConfig as RoleConfig;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(roleConfig.ID * 1000 + mID);
		if (mEndFrame == 0)
		{
			mEndFrame = config.Duration;
		}
		if (mRange != 0 || mDisableApproach)
		{
			return;
		}
		if (config.HitTimeList.Count <= 0)
		{
			Debug.LogError((object)("timeline: " + roleConfig.ID + " 's " + mID + " 命中没有配置" + mDisableApproach));
			return;
		}
		HitCheckInfo hitCheckInfo = config.HitTimeList.get_Item(0);
		switch (hitCheckInfo.RangeType)
		{
		case RangeType.Sector:
		case RangeType.Roundness:
		case RangeType.Annulus:
		case RangeType.AnnularSector:
			mRange = hitCheckInfo.Radius;
			break;
		case RangeType.Rectangle:
			mRange = hitCheckInfo.Length;
			break;
		case RangeType.MultiDirection:
			break;
		}
	}

	public override void OnExit(SimContext simContext, SimEntity entity)
	{
	}

	public override AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity)
	{
		if (entity.entityBlackboard.var.mAimTarget > 0)
		{
			if (mRange == 0 || mDisableApproach)
			{
				if (!mAbilityStart)
				{
					AIProcessor.AIStartAbility(entity.creationIndex, this);
					return mStatus;
				}
			}
			else
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entity.entityBlackboard.var.mAimTarget);
				if (!mAbilityStart)
				{
					if (simEntityByMultiColliders == null || !simEntityByMultiColliders.hasEntityPositon)
					{
						mStatus = AIProcessor.AICommandStatus.Failed;
						return mStatus;
					}
					Int3 @int = simEntityByMultiColliders.entityPositon.mPosition;
					ISimShape nearestCollisionData = AIProcessor.GetNearestCollisionData(entity, simEntityByMultiColliders, simEntityByMultiColliders.entityCamp.mRoleTypeCamp, out var minDistance);
					bool flag;
					if (mUseEdgeDistance && nearestCollisionData != null)
					{
						@int = nearestCollisionData.WorldPos;
						flag = minDistance < mRange;
					}
					else
					{
						long sqrMagnitudeLong = (@int - entity.entityPositon.mPosition).sqrMagnitudeLong;
						flag = sqrMagnitudeLong < mRange * mRange;
					}
					if (flag)
					{
						AIProcessor.AIStartAbility(entity.creationIndex, this);
						return mStatus;
					}
					AIProcessor.MoveAIDirection(entity.creationIndex, @int, mMovementFactor);
				}
			}
			if (mAbilityStart)
			{
				if (entity.hasEntityActionAbility)
				{
					if (entity.entityActionAbility.mAbilityID % 1000 != mID)
					{
						mStatus = AIProcessor.AICommandStatus.Failed;
						Debug.LogWarning((object)(Time.frameCount + " AI技能不一致，AI期望和执行冲突, 正在执行" + entity.entityActionAbility.mAbilityID + ",期望：" + mID + " " + entity.ENTITY_CONFIG_ID.ToString()));
					}
					else if (entity.entityActionAbility.mLogicTime >= (mEndFrame - 1) * CommonProcessor.GetConfigInterval())
					{
						mCurrentLoop++;
						if (mCurrentLoop >= mLoop)
						{
							mStatus = AIProcessor.AICommandStatus.Success;
						}
						else
						{
							mExcutingTime = 0;
							Int3 targetPostion = entity.entityPositon.mPosition + entity.entityPositon.mForward;
							AIProcessor.AIReplaceAbility(entity.creationIndex, targetPostion, this);
						}
					}
				}
				else
				{
					mStatus = AIProcessor.AICommandStatus.Success;
				}
			}
			return mStatus;
		}
		mStatus = AIProcessor.AICommandStatus.Failed;
		return mStatus;
	}

	protected override bool IsTimeout()
	{
		if (mAbilityStart)
		{
			return false;
		}
		return base.IsTimeout();
	}

	internal override void Reset()
	{
		base.Reset();
		mCurrentLoop = 0;
		mAbilityStart = false;
	}
}
