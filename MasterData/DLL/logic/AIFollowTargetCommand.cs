using System.Collections.Generic;
using UnityEngine;

public class AIFollowTargetCommand : AICommand
{
	public int mDisanceBase;

	public int mDistanceRandomOffset;

	public int mLerpMinDistance;

	public int mLerpMaxDistance;

	public int mSpeedFactorMini;

	public int mSpeedFactorMaxi;

	public int mFollowOffsetAngleInput;

	public int mFollowOffsetDistanceInput;

	public int mStartMoveDistanceInput;

	public override void OnEnter(SimContext simContext, SimEntity entity)
	{
	}

	public override void OnExit(SimContext simContext, SimEntity entity)
	{
	}

	public static int GetRandomValue(int basePart, int randomPart)
	{
		return basePart + (int)DRandom.Random((uint)randomPart);
	}

	public override AIProcessor.AICommandStatus Running(SimContext simContext, SimEntity entity)
	{
		AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2202, out var baseValue, out var _, out var _);
		if (baseValue == 0L)
		{
			baseValue = GetRandomValue(mDisanceBase, mDistanceRandomOffset);
		}
		int mLocalPlayerID = simContext.sEntityWorldState.status.mLocalPlayerID;
		int creationIndex = entity.creationIndex;
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(mLocalPlayerID);
		entityWithEntityID = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID);
		if (entity == null || entityWithEntityID == null)
		{
			Debug.LogWarning((object)("队友跟随玩家 节点 其中一个实体为空， " + entity.creationIndex + ", " + mLocalPlayerID));
			mStatus = AIProcessor.AICommandStatus.Failed;
		}
		else
		{
			AIProcessor.GetNearestCollisionData(entity, entityWithEntityID, entityWithEntityID.entityCamp.mRoleTypeCamp, out var minDistance);
			long num = minDistance;
			minDistance = num;
			minDistance = IntMath.Clamp(minDistance, mLerpMinDistance, mLerpMaxDistance);
			int num2 = IntMath.Lerp(mSpeedFactorMini, mSpeedFactorMaxi, (int)(minDistance - mLerpMinDistance), mLerpMaxDistance - mLerpMinDistance);
			int num3 = -1;
			int num4 = -1;
			Dictionary<MemberPosition, RemoteMember> mRoomMembers = simContext.sEntityWorldState.status.mRoomMembers;
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
			int num5 = -1;
			while (enumerator.MoveNext())
			{
				int mEntityID = enumerator.Current.Value.mEntityID;
				SimEntity entityWithEntityID2 = simContext.GetEntityWithEntityID(mEntityID);
				if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityCamp && RoleCampProcessor.IsPlayer(entityWithEntityID2.entityCamp.mRoleTypeCamp))
				{
					num5++;
					if (mEntityID == mLocalPlayerID)
					{
						num3 = num5;
					}
					if (mEntityID == creationIndex)
					{
						num4 = num5;
					}
				}
			}
			int num6 = num4 - num3;
			SimEntity entityWithEntityID3 = simContext.GetEntityWithEntityID(mLocalPlayerID);
			Int3 mPosition = entityWithEntityID3.entityPositon.mPosition;
			Int3 mForward = entityWithEntityID3.entityPositon.mForward;
			Int3 @int = -mForward;
			switch (num6)
			{
			case -2:
			case 1:
				@int = mForward.RotateY(-mFollowOffsetAngleInput, mFollowOffsetDistanceInput);
				break;
			case -1:
			case 2:
				@int = mForward.RotateY(mFollowOffsetAngleInput, mFollowOffsetDistanceInput);
				break;
			}
			mPosition += @int;
			int range = mStartMoveDistanceInput;
			bool flag = false;
			if (entity.hasEntityActionMoveDirection ? AIProcessor.IsAITargetInRange(creationIndex, mPosition, (int)baseValue) : AIProcessor.IsAITargetInRange(creationIndex, mPosition, range))
			{
				AIProcessor.DoStopAbility(entity);
				AttributeProcessor.SetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2202, GetRandomValue(mDisanceBase, mDistanceRandomOffset), 0L, 0L);
			}
			else
			{
				AIProcessor.MoveAIDirection(creationIndex, mPosition, new VFactor(num2, 100L));
			}
		}
		return mStatus;
	}
}
