using System.Collections.Generic;
using Config;
using Pathfinding;

public class ThrownProcessor
{
	public static SimContext mSimContext;

	public static SEntityWorldState mWorldState;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
		mWorldState = mSimContext.sEntityWorldState;
	}

	internal static void Shutdown()
	{
		mSimContext = null;
		mWorldState = null;
	}

	public static void ProcessThrown()
	{
		List<ThrownState> mThrowns = mWorldState.status.mThrowns;
		List<int> mDestoryThrowns = mWorldState.status.mDestoryThrowns;
		for (int i = 0; i < mDestoryThrowns.Count; i++)
		{
			for (int j = 0; j < mThrowns.Count; j++)
			{
				if (mThrowns[j].mCreationIndex == mDestoryThrowns[i])
				{
					mWorldState.status.RemoveThrowIDFromEntityIDsInCurrentThrownRange(mSimContext, mDestoryThrowns[i], mThrowns[j].mAbilityID);
					FrameObjectPool<ThrownState>.Release(mThrowns[j]);
					mThrowns.RemoveAt(j);
					break;
				}
			}
			mWorldState.status.RemoveHitHistory(mDestoryThrowns[i]);
		}
		mWorldState.status.mDestoryThrowns.Clear();
		if (mWorldState.status.mFreezeThrownLogic)
		{
			return;
		}
		for (int k = 0; k < mThrowns.Count; k++)
		{
			ThrownState thrownState = mThrowns[k];
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
			if (config == null)
			{
				XLogger.Debug("Can't Find Thrown Timeline Config By " + thrownState.mAbilityID);
				continue;
			}
			if (config.IsDependCasterForThrown && (!CommonProcessor.TryGetAliveRole(mSimContext, thrownState.mCasterID, out var simEntity) || !simEntity.hasEntityActionAbility))
			{
				DestoryThrown(mSimContext, thrownState);
				continue;
			}
			CalcThrownStateTimeStep(thrownState);
			int num = thrownState.mTimeStep;
			while (num > 0)
			{
				int num2 = num;
				if (num >= CommonProcessor.GetConfigInterval())
				{
					num2 = CommonProcessor.GetConfigInterval();
				}
				thrownState.mLogicTime += num2;
				ProcessThrownItem(config, thrownState, num2);
				num -= num2;
			}
		}
	}

	public static void ProcessThrownItem(Timeline timelineConfig, ThrownState thrownState, int deltaTime)
	{
		int mLogicTime = thrownState.mLogicTime;
		if (thrownState.mFrameFreezeTime > 0)
		{
			thrownState.mFrameFreezeTime -= deltaTime;
			if (thrownState.mFrameFreezeTime <= 0)
			{
				thrownState.mFrameFreezeTime = 0;
			}
			return;
		}
		ProcessHitCheck(mSimContext, mLogicTime, timelineConfig, thrownState);
		int num = (mLogicTime - deltaTime) / CommonProcessor.GetConfigInterval();
		int num2 = mLogicTime / CommonProcessor.GetConfigInterval();
		if (num != num2 || mLogicTime - thrownState.mTimeStep == 0)
		{
			AbilitiesProcessor.PostThrownEvent(timelineConfig, mLogicTime, deltaTime, thrownState.mCasterID, thrownState.mPosition, thrownState.mForward, thrownState, thrownState.mCreationIndex, thrownState.mCreatedRootTimelineID, thrownState.mAttributeID);
		}
		ISimulatorInferface simInterface = mSimContext.GetSimInterface();
		if (simInterface != null)
		{
			ProcessThrownItemLockOn(mSimContext, thrownState, deltaTime);
			simInterface.mThrownProcessDirection?.Invoke(thrownState.mCreationIndex, thrownState.mAbilityID);
			ProcessThrownItemMovement(mSimContext, thrownState, deltaTime);
			simInterface.mThrownProcessMovement?.Invoke(thrownState.mCreationIndex, thrownState.mAbilityID);
			ProcessThrownItemCollision(mSimContext, thrownState);
			simInterface.mThrownProcessCollisionCheck?.Invoke(thrownState.mCreationIndex, thrownState.mAbilityID);
			simInterface.mThrownUpdateAbilityLogicEvent?.Invoke(thrownState.mCreationIndex, thrownState.mAbilityID, mLogicTime);
		}
	}

	private static void Rotate(ThrownLockActionInfo lockActionNode, ThrownState thrownState, int deltaTime, Int3 targetPos)
	{
		Int3 mPosition = thrownState.mPosition;
		Int3 mForward = thrownState.mForward;
		Int3 @int = (targetPos - mPosition).NormalizeTo(1000);
		if (thrownState.mLogicTime < lockActionNode.StartChangeHeightTime)
		{
			@int.y = mForward.y;
		}
		long num = Int3.Det(mForward, @int);
		int num2 = Int3.Dot(mForward, @int);
		if (num == 0L && num2 >= 0)
		{
			return;
		}
		int num3 = (thrownState.mLogicTime - lockActionNode.Start) / CommonProcessor.GetConfigInterval();
		int num4 = 0;
		if (lockActionNode.AngleSpeedCurveFrame != null)
		{
			for (int i = 0; i < lockActionNode.AngleSpeedCurveFrame.Count && lockActionNode.AngleSpeedCurveFrame.get_Item(i) <= num3; i++)
			{
				num4 = i;
			}
		}
		int num5 = lockActionNode.TurnRate / 1000;
		if (lockActionNode.AngleSpeedCurveVal != null && lockActionNode.AngleSpeedCurveVal.Count > num4)
		{
			num5 = lockActionNode.AngleSpeedCurveVal.get_Item(num4) * num5 / 1000;
		}
		if (lockActionNode.ChangeAngleSpeedAngle > 0)
		{
			VFactor vFactor = IntMath.cos(new VFactor(lockActionNode.ChangeAngleSpeedAngle, 1000L) * IntMath.Deg2Rad);
			if (vFactor * 1000L * 1000L > num2)
			{
				num5 = num5 * lockActionNode.ChangeAngleSpeedFactor / 1000;
			}
		}
		mForward = CommonProcessor.Int3Slerp(mForward, @int, new VFactor(num5 * deltaTime, 1000L));
		thrownState.mForward = mForward;
	}

	private static void ProcessThrownItemLockOn(SimContext simContext, ThrownState thrownState, int deltaTime)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
		if (config == null || config.ThrownLockActionInfoList.Count < 0 || thrownState.mCurLockIndex >= config.ThrownLockActionInfoList.Count)
		{
			return;
		}
		if (thrownState.mTargetID == 0 || (config.ThrownLockActionInfoList.get_Item(thrownState.mCurLockIndex).TargetChangeWhenDead && AIProcessor.IsAIDeath(thrownState.mTargetID)))
		{
			thrownState.mTargetID = UpdateThrownTargetAndIgnoreAllHistory(thrownState);
			if (simContext.GetSimInterface() != null && simContext.GetSimInterface().mUpdateThrownTarget != null)
			{
				simContext.GetSimInterface().mUpdateThrownTarget(thrownState.mCreationIndex);
			}
		}
		int mLogicTime = thrownState.mLogicTime;
		bool mIsInLock = false;
		ThrownLockActionInfo thrownLockActionInfo = config.ThrownLockActionInfoList.get_Item(thrownState.mCurLockIndex);
		if (mLogicTime > thrownLockActionInfo.Start)
		{
			thrownState.mTargetPosition = Int3.up;
			if (mLogicTime <= thrownLockActionInfo.Start + thrownLockActionInfo.Duration)
			{
				if (thrownLockActionInfo.LockTargetPoint)
				{
					thrownState.mTargetPosition = new Int3(thrownLockActionInfo.CenterOffset.X, thrownLockActionInfo.CenterOffset.Y, thrownLockActionInfo.CenterOffset.Z);
					Rotate(thrownLockActionInfo, thrownState, deltaTime, thrownState.mTargetPosition);
					mIsInLock = true;
				}
				else
				{
					SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(thrownState.mTargetID);
					if (AttributeProcessor.CanLockOfEntity(entityWithEntityID))
					{
						ISimShape nearestCollisionData = AIProcessor.GetNearestCollisionData(thrownState.mPosition, entityWithEntityID, RoleCampProcessor.GetInterestCamp(thrownState.mCamp), out var _);
						if (nearestCollisionData != null)
						{
							if (thrownLockActionInfo.FollowThreshold > 0)
							{
								thrownState.mTargetPosition = nearestCollisionData.WorldPos;
								thrownState.mForward = (nearestCollisionData.WorldPos - thrownState.mPosition).NormalizeTo(1000);
							}
							else
							{
								Rotate(thrownLockActionInfo, thrownState, deltaTime, nearestCollisionData.WorldPos + new Int3(0, 1500, 0));
							}
							mIsInLock = true;
						}
					}
				}
			}
			else
			{
				if (thrownLockActionInfo.LockEndOperation != 0 && (thrownLockActionInfo.LockEndOperation & 1) == 1)
				{
					SimEntity entityWithEntityID2 = simContext.GetEntityWithEntityID(thrownState.mTargetID);
					if (thrownLockActionInfo.LockTargetPoint)
					{
						thrownState.mTargetPosition = new Int3(thrownLockActionInfo.CenterOffset.X, thrownLockActionInfo.CenterOffset.Y, thrownLockActionInfo.CenterOffset.Z);
						thrownState.mForward = GetTargetDirection(thrownState, thrownState.mTargetPosition);
					}
					else if (AttributeProcessor.CanLockOfEntity(entityWithEntityID2))
					{
						ISimShape nearestCollisionData2 = AIProcessor.GetNearestCollisionData(thrownState.mPosition, entityWithEntityID2, RoleCampProcessor.GetInterestCamp(thrownState.mCamp), out var _);
						if (nearestCollisionData2 != null)
						{
							if (((thrownLockActionInfo.LockEndOperation >> 1) & 1) == 1 && thrownLockActionInfo.RandomRadius > 0)
							{
								uint newMagn = DRandom.Random((uint)thrownLockActionInfo.RandomRadius);
								uint num = DRandom.Random(360000u);
								Int3 @int = IntMath.VectorOfAngle(num);
								thrownState.mTargetPosition = nearestCollisionData2.WorldPos + @int.NormalizeTo((int)newMagn);
							}
							else
							{
								thrownState.mTargetPosition = nearestCollisionData2.WorldPos;
							}
							thrownState.mForward = GetTargetDirection(thrownState, thrownState.mTargetPosition);
						}
					}
				}
				thrownState.mCurLockIndex++;
			}
		}
		thrownState.mIsInLock = mIsInLock;
	}

	private static void ProcessThrownItemMovement(SimContext simContext, ThrownState thrownState, int deltaTime)
	{
		if (thrownState.mTargetPosition != Int3.up && (thrownState.mPosition - thrownState.mTargetPosition).sqrMagnitudeLong < 100)
		{
			ThrownArriedPositionEvent evt = ThrownArriedPositionEvent.Claim(thrownState.mCreationIndex, thrownState.mPosition);
			simContext.PostEvent(evt);
		}
		else
		{
			if (thrownState.mDontMovement)
			{
				return;
			}
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
			if (ProcessThrownItemMoveBack(config, thrownState, deltaTime))
			{
				return;
			}
			int num = thrownState.mLogicTime / CommonProcessor.GetConfigInterval();
			if (num >= config.MoveActionTimelineNode.Duration)
			{
				return;
			}
			if (thrownState.mTargetPosition != Int3.up)
			{
				Int3 @int = thrownState.mTargetPosition - thrownState.mPosition;
				if (thrownState.mIsInLock && thrownState.mCurLockIndex > 0 && thrownState.mCurLockIndex < config.ThrownLockActionInfoList.Count)
				{
					ThrownLockActionInfo thrownLockActionInfo = config.ThrownLockActionInfoList.get_Item(thrownState.mCurLockIndex);
					if (@int.sqrMagnitudeLong <= thrownLockActionInfo.FollowThreshold * thrownLockActionInfo.FollowThreshold)
					{
						return;
					}
				}
			}
			Int3 timelineDeltaMovement = MovementProcessor.GetTimelineDeltaMovement(config, thrownState.mLogicTime, deltaTime);
			if (config.IsUseConfigY)
			{
				thrownState.mHeight += timelineDeltaMovement.y;
			}
			timelineDeltaMovement.y = 0;
			Int3 int2;
			if (!config.IsUseConfigX)
			{
				timelineDeltaMovement.x = 0;
				int2 = IntMath.Transform(timelineDeltaMovement, thrownState.mForward, thrownState.mPosition);
			}
			else
			{
				int2 = IntMath.Transform(timelineDeltaMovement, thrownState.mEarliestForward, thrownState.mPosition);
			}
			Int3 int3 = int2 - thrownState.mPosition;
			if (!config.ThrownDestroyByObstacle && config != null && thrownState.mConllisionCheckIndex >= 0 && thrownState.mConllisionCheckIndex < config.ThrownCollisionCheckInfoList.Count && SimPhysics.Raycast(thrownState.mPosition, int3, 8u, out var hitEntityID, out var hitInfo))
			{
				SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(hitEntityID);
				if (entityWithEntityID.entityShape.mShape.IsEnable)
				{
					long sqrMagnitudeLong = (hitInfo.point - thrownState.mPosition).sqrMagnitudeLong;
					if (sqrMagnitudeLong < int3.sqrMagnitudeLong)
					{
						int2 = hitInfo.point;
					}
				}
			}
			if (thrownState.mTargetPosition != Int3.up && (thrownState.mTargetPosition - int2).sqrMagnitude <= int3.sqrMagnitude)
			{
				int2 = thrownState.mTargetPosition;
			}
			thrownState.mForward = ((int3 != Int3.zero) ? int3.NormalizeTo(1000) : thrownState.mForward);
			thrownState.mLastPosition = thrownState.mPosition;
			thrownState.mPosition = int2;
			if (config.ThrownCollidGraph && PathUtilities.GetGroundY(thrownState.mLastPosition, out var groundY) && groundY > thrownState.mPosition.y)
			{
				int2.y = groundY;
				thrownState.mPosition = int2;
				ThrownOutRangeEvent evt2 = ThrownOutRangeEvent.Claim(thrownState.mCreationIndex, thrownState.mPosition);
				mSimContext.PostEvent(evt2);
				DestoryThrown(mSimContext, thrownState);
			}
		}
	}

	private static bool ProcessThrownItemMoveBack(Timeline timelineConfig, ThrownState thrownState, int deltaTime)
	{
		int mLogicTime = thrownState.mLogicTime;
		if (thrownState.mBackSpeed == 0 && thrownState.mBackIndex >= 0 && timelineConfig.ThrownBackActionInfoList.Count > 0 && thrownState.mBackIndex < timelineConfig.ThrownBackActionInfoList.Count)
		{
			ThrownBackActionInfo thrownBackActionInfo = timelineConfig.ThrownBackActionInfoList.get_Item(thrownState.mBackIndex);
			if (mLogicTime >= thrownBackActionInfo.Start)
			{
				if (mLogicTime < thrownBackActionInfo.Start + thrownBackActionInfo.Duration)
				{
					thrownState.mBackSpeed = thrownBackActionInfo.Duration;
				}
				else
				{
					thrownState.mBackIndex++;
					thrownState.mBackSpeed = 0;
				}
			}
		}
		if (thrownState.mBackSpeed > 0)
		{
			if (timelineConfig.ThrownBackActionInfoList.Count <= 0 || thrownState.mBackIndex >= timelineConfig.ThrownBackActionInfoList.Count)
			{
				MoveBackAction(mSimContext, thrownState, Int3.zero, deltaTime);
			}
			else
			{
				ThrownBackActionInfo thrownBackActionInfo2 = timelineConfig.ThrownBackActionInfoList.get_Item(thrownState.mBackIndex);
				if (thrownBackActionInfo2.OnceCalc)
				{
					MoveBackAction(mSimContext, thrownState, thrownState.mEarliestPosition, deltaTime);
				}
				else
				{
					if (thrownState.mTargetID != thrownState.mCasterID)
					{
						thrownState.mTargetID = thrownState.mCasterID;
					}
					MoveBackAction(mSimContext, thrownState, Int3.zero, deltaTime);
				}
			}
			return true;
		}
		return false;
	}

	public static void MoveBackAction(SimContext simContext, ThrownState thrownState, Int3 targetPos, int delta)
	{
		if (thrownState.mBackSpeed <= 0)
		{
			return;
		}
		VFactor vFactor = new VFactor(delta, thrownState.mBackSpeed);
		thrownState.mBackSpeed -= delta;
		if (targetPos == Int3.zero)
		{
			if (!CommonProcessor.TryGetAliveRole(simContext, thrownState.mTargetID, out var simEntity))
			{
				return;
			}
			targetPos = simEntity.entityPositon.mPosition;
		}
		Int3 @int = targetPos - thrownState.mPosition;
		Int3 int2 = @int * vFactor;
		thrownState.mForward = @int.NormalizeTo(1000);
		thrownState.mLastPosition = thrownState.mPosition;
		thrownState.mPosition += int2;
	}

	private static void ProcessThrownItemCollision(SimContext simContext, ThrownState thrownState)
	{
		if (thrownState.mDontCollisionCheck || thrownState.mHeight > 5000)
		{
			return;
		}
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
		if (config == null)
		{
			return;
		}
		int mConllisionCheckIndex = thrownState.mConllisionCheckIndex;
		if (mConllisionCheckIndex < 0 || mConllisionCheckIndex >= config.ThrownCollisionCheckInfoList.Count)
		{
			return;
		}
		ThrownCollisionCheckInfo thrownCollisionCheckInfo = config.ThrownCollisionCheckInfoList.get_Item(mConllisionCheckIndex);
		int mLogicTime = thrownState.mLogicTime;
		if (mLogicTime <= thrownCollisionCheckInfo.Start)
		{
			return;
		}
		if (mLogicTime >= thrownCollisionCheckInfo.Start + thrownCollisionCheckInfo.Duration)
		{
			thrownState.mConllisionCheckIndex++;
			RemoveThrownHitHistory(simContext, thrownState.mCreationIndex);
			List<int> listFromEntityIDsInCurrentThrownRange = mWorldState.status.GetListFromEntityIDsInCurrentThrownRange(thrownState.mCreationIndex);
			if (listFromEntityIDsInCurrentThrownRange != null)
			{
				for (int i = 0; i < listFromEntityIDsInCurrentThrownRange.Count; i++)
				{
					mSimContext.PostEvent(ThrownOverlapEvent.Claim(thrownState.mCreationIndex, listFromEntityIDsInCurrentThrownRange[i], thrownState.mAbilityID, mConllisionCheckIndex, 0, -1, ThrownOverlapEventState.leave));
				}
				listFromEntityIDsInCurrentThrownRange.Clear();
			}
			return;
		}
		List<int> list = FrameListPool<int>.Claim();
		List<int> list2 = FrameListPool<int>.Claim();
		int num = 0;
		uint targetLayerMask;
		if (thrownCollisionCheckInfo.TargetCampType == TargetCampType.Oneself)
		{
			if (CommonProcessor.TryGetAliveRole(simContext, thrownState.mCasterID, out var simEntity))
			{
				int num2 = 0;
				int num3 = 0;
				if (thrownCollisionCheckInfo.RangeType == RangeType.Roundness)
				{
					num2 = thrownCollisionCheckInfo.Radius;
					num3 = thrownCollisionCheckInfo.Radius;
				}
				else if (thrownCollisionCheckInfo.RangeType == RangeType.Rectangle)
				{
					num2 = IntMath.CeilPowerOfTwo(thrownCollisionCheckInfo.Width);
					num3 = IntMath.CeilPowerOfTwo(thrownCollisionCheckInfo.Length);
				}
				VFactor vFactor = new VFactor(num2, 1000L);
				Int3 @int = IntMath.Transform(-Int3.right * vFactor, thrownState.mForward, thrownState.mLastPosition);
				Int3 int2 = IntMath.Transform(Int3.right * vFactor, thrownState.mForward, thrownState.mLastPosition);
				Int3 int3 = int2 - @int;
				VFactor vFactor2 = new VFactor(num3, 1000L);
				Int3 int4 = thrownState.mLastPosition - thrownState.mForward * vFactor2;
				Int3 int5 = thrownState.mPosition + thrownState.mForward * vFactor2;
				Int3 int6 = int5 - int4;
				Int3 mPosition = simEntity.entityPositon.mPosition;
				Int3 lhs = mPosition - @int;
				Int3 lhs2 = mPosition - int4;
				int num4 = Int3.Dot(int6, int6);
				int num5 = Int3.Dot(lhs2, int6);
				int num6 = Int3.Dot(int3, int3);
				int num7 = Int3.Dot(lhs, int3);
				if (num4 >= num5 && num5 >= 0 && num6 >= num7 && num7 >= 0)
				{
					list.Add(thrownState.mCasterID);
					list2.Add(thrownState.mCasterID);
				}
			}
		}
		else if (CommonProcessor.TryGetTargetLayerMask(thrownState.mCamp, thrownCollisionCheckInfo.TargetCampType, out targetLayerMask))
		{
			Int3 size = (thrownCollisionCheckInfo.UnuseDeltaPosition ? CreateOverlapBoxOfThrown(thrownCollisionCheckInfo.RangeType, thrownCollisionCheckInfo.Radius, thrownCollisionCheckInfo.Width, thrownCollisionCheckInfo.Height * 2, thrownCollisionCheckInfo.Length) : CreateOverlapBoxOfThrown(thrownState.mPosition, thrownState.mLastPosition, thrownCollisionCheckInfo.RangeType, thrownCollisionCheckInfo.Radius, thrownCollisionCheckInfo.Width, thrownCollisionCheckInfo.Height * 2, thrownCollisionCheckInfo.Length));
			mSimContext.PostEvent(OverlapBeforeByThrownCollideEvent.Claim(thrownState.mCreationIndex, thrownState.mAbilityID, thrownState.mConllisionCheckIndex));
			bool flag = false;
			if (config.ThrownDestroyByObstacle && SimPhysics.Raycast(thrownState.mLastPosition + thrownState.mForward, thrownState.mForward * new VFactor(size.z, 1000L), 8u, out var _, out var hitInfo))
			{
				long sqrMagnitudeLong = (hitInfo.point - thrownState.mPosition).sqrMagnitudeLong;
				if (sqrMagnitudeLong < size.z * size.z)
				{
					flag = true;
				}
			}
			List<int> list3 = FrameListPool<int>.Claim();
			RangeType rangeType = RangeType.Rectangle;
			if (thrownState.mPosition == thrownState.mLastPosition)
			{
				rangeType = thrownCollisionCheckInfo.RangeType;
			}
			if (CommonProcessor.TryGetCollisions(mSimContext, rangeType, (!thrownCollisionCheckInfo.UnuseDeltaPosition) ? ((thrownState.mPosition + thrownState.mLastPosition) / 2f) : thrownState.mPosition, thrownState.mForward, new Int3(thrownCollisionCheckInfo.CenterOffset.X, thrownCollisionCheckInfo.CenterOffset.Y, thrownCollisionCheckInfo.CenterOffset.Z), thrownCollisionCheckInfo.Radius, 0, size, list3, targetLayerMask))
			{
				List<int> list4 = FrameListPool<int>.Claim();
				CommonProcessor.SortCollisionsByDistance(simContext, thrownState.mLastPosition, list3, list4, onlySort: true);
				List<int> histotryList = null;
				if (thrownCollisionCheckInfo.IgnoreHitHistory)
				{
					TryGetThrownHitHistory(simContext, thrownState.mCreationIndex, out histotryList);
				}
				bool flag2 = IsOnlyReduceHP(config, thrownCollisionCheckInfo, mConllisionCheckIndex);
				for (int j = 0; j < list4.Count; j++)
				{
					SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(list4[j]);
					if (entityWithEntityID.hasEntityShape && entityWithEntityID.entityShape.mShape.IsEnable && entityWithEntityID.entityShape.mShape.Layer == RoleType.Bunker)
					{
						if (flag)
						{
							num = list4[j];
							break;
						}
						continue;
					}
					SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID.creationIndex);
					if (CommonProcessor.ParryingCheck(simContext, thrownState.mCasterID, simEntityByMultiColliders.creationIndex, thrownState.mAbilityID, mConllisionCheckIndex, entityWithEntityID.entityShape.mShape.WorldPos, thrownState.mForward, thrownState.mCanBeParry, thrownState.mCreationIndex, !flag2))
					{
						continue;
					}
					if (CommonProcessor.IsInUltimateAvoidOfTarget(simContext, thrownState.mCasterID, entityWithEntityID.creationIndex, thrownState.mAbilityID, mConllisionCheckIndex, entityWithEntityID.entityShape.mShape.WorldPos, out var parentTargetID, thrownState.mCreationIndex, !flag2))
					{
						if (histotryList != null && !histotryList.Contains(parentTargetID))
						{
							histotryList.Add(parentTargetID);
						}
					}
					else
					{
						if (!CommonProcessor.IsAliveRole(entityWithEntityID) || !simEntityByMultiColliders.hasEntityRemotePlayer || !simEntityByMultiColliders.hasEntityConfig)
						{
							continue;
						}
						if (!list2.Contains(simEntityByMultiColliders.creationIndex))
						{
							list2.Add(simEntityByMultiColliders.creationIndex);
						}
						if (CommonProcessor.HasSameShapeCollect(list, entityWithEntityID) || (histotryList != null && CommonProcessor.HasSameShapeCollect(histotryList, entityWithEntityID)))
						{
							continue;
						}
						HitHeight curHitHeight = ConfigProcessor.GetCurHitHeight(simEntityByMultiColliders);
						HitHeight validHitHeight = (HitHeight)thrownCollisionCheckInfo.ValidHitHeight;
						if (curHitHeight == HitHeight.None || validHitHeight.HasFlag(curHitHeight))
						{
							list.Add(entityWithEntityID.creationIndex);
							if ((thrownCollisionCheckInfo.ThrownBehaviourOnCollision & 1) == 1 || ((thrownCollisionCheckInfo.ThrownBehaviourOnCollision >> 3) & 1) == 1)
							{
								break;
							}
						}
					}
				}
				FrameListPool<int>.Release(list4);
			}
			FrameListPool<int>.Release(list3);
		}
		if (list.Count > 0)
		{
			ProcessColliding(mSimContext, thrownState, thrownCollisionCheckInfo, list, config);
			for (int k = 0; k < list.Count; k++)
			{
				SimEntity simEntityByMultiColliders2 = CommonProcessor.GetSimEntityByMultiColliders(list[k]);
				if (simEntityByMultiColliders2 != null)
				{
					mSimContext.PostEvent(ThrownCollidedEvent.Claim(thrownState.mCreationIndex, simEntityByMultiColliders2.creationIndex, thrownState.mAbilityID, mConllisionCheckIndex, list.Count, k, list[k]));
				}
			}
			AddThrownHitHistory(simContext, thrownState.mCreationIndex, list);
		}
		for (int l = 0; l < list2.Count; l++)
		{
			if (mWorldState.status.EntityIDsInCurrentThrownRangeContainsEntityID(thrownState.mCreationIndex, list2[l]))
			{
				mSimContext.PostEvent(ThrownOverlapEvent.Claim(thrownState.mCreationIndex, list2[l], thrownState.mAbilityID, mConllisionCheckIndex, list.Count, l, ThrownOverlapEventState.tick));
				continue;
			}
			mWorldState.status.AddEntityIDToEntityIDsInCurrentThrownRange(thrownState.mCreationIndex, list2[l]);
			mSimContext.PostEvent(ThrownOverlapEvent.Claim(thrownState.mCreationIndex, list2[l], thrownState.mAbilityID, mConllisionCheckIndex, list.Count, l, ThrownOverlapEventState.enter));
		}
		List<int> listFromEntityIDsInCurrentThrownRange2 = mWorldState.status.GetListFromEntityIDsInCurrentThrownRange(thrownState.mCreationIndex);
		if (listFromEntityIDsInCurrentThrownRange2 != null)
		{
			for (int num8 = listFromEntityIDsInCurrentThrownRange2.Count - 1; num8 >= 0; num8--)
			{
				if (!list2.Contains(listFromEntityIDsInCurrentThrownRange2[num8]))
				{
					mSimContext.PostEvent(ThrownOverlapEvent.Claim(thrownState.mCreationIndex, listFromEntityIDsInCurrentThrownRange2[num8], thrownState.mAbilityID, mConllisionCheckIndex, list.Count, -1, ThrownOverlapEventState.leave));
					listFromEntityIDsInCurrentThrownRange2.RemoveAt(num8);
				}
			}
		}
		if (num != 0)
		{
			ThrownOutRangeEvent evt = ThrownOutRangeEvent.Claim(thrownState.mCreationIndex, thrownState.mPosition);
			mSimContext.PostEvent(evt);
			DestoryThrown(mSimContext, thrownState);
		}
		FrameListPool<int>.Release(list);
		FrameListPool<int>.Release(list2);
	}

	private static void ProcessColliding(SimContext simContext, ThrownState thrownState, ThrownCollisionCheckInfo thrownCollisionCheckInfo, List<int> exportCollisionList, Timeline thrownTimeline)
	{
		int thrownBehaviourOnCollision = thrownCollisionCheckInfo.ThrownBehaviourOnCollision;
		bool flag = (thrownBehaviourOnCollision & 1) == 1;
		bool flag2 = ((thrownBehaviourOnCollision >> 1) & 1) == 1;
		bool flag3 = ((thrownBehaviourOnCollision >> 3) & 1) == 1;
		bool flag4 = ((thrownBehaviourOnCollision >> 4) & 1) == 1;
		if (flag)
		{
			DestoryThrown(simContext, thrownState);
		}
		if (flag2 && thrownCollisionCheckInfo.SpawnThrownTimelineID != -1)
		{
			int spawnThrownTimelineID = thrownCollisionCheckInfo.SpawnThrownTimelineID;
			Int3 srcPos = thrownState.mPosition;
			Int3 @int = thrownState.mForward;
			@int.y = 0;
			bool flag5 = ((thrownBehaviourOnCollision >> 2) & 1) == 1;
			for (int i = 0; i < exportCollisionList.Count; i++)
			{
				if (flag5)
				{
					SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(exportCollisionList[i]);
					SimEntity simEntity = entityWithEntityID;
					if (simEntity.mTag == SimEntity.Tag.MultiColliders)
					{
						simEntity = simEntity.mParent;
					}
					if (simEntity != null && !simEntity.hasEntityActionDeath && entityWithEntityID.hasEntityShape)
					{
						srcPos = simEntity.entityShape.mShape.WorldPos;
						@int = thrownState.mForward;
						if (@int == Int3.zero)
						{
							@int = Int3.forward;
						}
					}
				}
				SpawnThrown(simContext, thrownState.mCasterID, 0, 0, srcPos, @int, spawnThrownTimelineID, useCommon: true, thrownState.mCreationIndex, thrownState.mCreatedRootTimelineID, thrownState.mAttributeID, out var _);
			}
		}
		if (flag3 && thrownCollisionCheckInfo.ChangeTargetCountLimit > 0)
		{
			int changeTargetCountLimit = thrownCollisionCheckInfo.ChangeTargetCountLimit;
			SimEntity entityWithEntityID2 = simContext.GetEntityWithEntityID(exportCollisionList[0]);
			if (entityWithEntityID2 != null && entityWithEntityID2.hasEntityShape && !entityWithEntityID2.hasEntityActionDeath)
			{
				thrownState.mPosition = entityWithEntityID2.entityShape.mShape.WorldPos;
			}
			List<int> histotryList = null;
			TryGetThrownHitHistory(simContext, thrownState.mCreationIndex, out histotryList);
			if (histotryList != null && histotryList.Count + 1 > changeTargetCountLimit)
			{
				thrownState.mCurLockIndex = thrownTimeline.ThrownLockActionInfoList.Count;
				thrownState.mDontMovement = true;
				thrownState.mDontCollisionCheck = true;
			}
			else
			{
				thrownState.mTargetID = UpdateThrownTargetAndIgnoreAllHistory(thrownState);
				if (thrownState.mTargetID == 0)
				{
					thrownState.mCurLockIndex = thrownTimeline.ThrownLockActionInfoList.Count;
					thrownState.mDontMovement = true;
					thrownState.mDontCollisionCheck = true;
				}
			}
		}
		if (!flag4)
		{
			return;
		}
		int mConllisionCheckIndex = thrownState.mConllisionCheckIndex;
		if (thrownTimeline != null && thrownTimeline.HitTimeList.Count > 0 && mConllisionCheckIndex < thrownTimeline.HitTimeList.Count)
		{
			HitCheckInfo hitCheckInfo = thrownTimeline.HitTimeList.get_Item(mConllisionCheckIndex);
			for (int j = 0; j < exportCollisionList.Count; j++)
			{
				SimEntity simEntity2 = null;
				if (CommonProcessor.TryGetAliveRole(simContext, exportCollisionList[j], out simEntity2) && (!simEntity2.hasEntityShape || !simEntity2.entityShape.mShape.IgnoreHit))
				{
					SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(simEntity2);
					if (!AttributeProcessor.IsIgnoreHit(simEntityByMultiColliders))
					{
						AbilitiesProcessor.ProcessHitting(thrownState.mCasterID, thrownState.mCreationIndex, thrownState.mAbilityID, 0, thrownState.mAttributeID, mConllisionCheckIndex, hitCheckInfo, thrownState.mLastPosition, thrownState.mForward, thrownState.mForward, simEntityByMultiColliders, simEntity2);
					}
				}
			}
		}
		ISimulatorInferface simInterface = simContext.GetSimInterface();
		simInterface.mHitCheckEvent?.Invoke(thrownState.mCreationIndex, thrownState.mAbilityID, mConllisionCheckIndex, exportCollisionList.Count);
	}

	private static bool IsOnlyReduceHP(Timeline timelineConfig, ThrownCollisionCheckInfo thrownCollisionCheckInfo, int index)
	{
		if (((thrownCollisionCheckInfo.ThrownBehaviourOnCollision >> 4) & 1) != 1)
		{
			return false;
		}
		if (index < 0 || index > timelineConfig.HitTimeList.Count)
		{
			return false;
		}
		HitCheckInfo hitCheckInfo = timelineConfig.HitTimeList.get_Item(index);
		return hitCheckInfo.IsOnlyReduceHP;
	}

	public static Int3 CreateOverlapBoxOfThrown(Int3 curPosition, Int3 lastPosition, RangeType RangeType, int Radius, int Width, int Height, int Length)
	{
		Int intMagnitude = (curPosition - lastPosition).IntMagnitude;
		Int3 result = new Int3(2000, 1000, (int)(long)intMagnitude + 2000);
		switch (RangeType)
		{
		case RangeType.Roundness:
			result = new Int3(Radius * 2, Radius * 2, (int)(long)intMagnitude + Radius * 2);
			break;
		case RangeType.Rectangle:
			result = new Int3(Width, Height, (int)(long)intMagnitude + Length);
			break;
		}
		return result;
	}

	public static Int3 CreateOverlapBoxOfThrown(RangeType RangeType, int Radius, int Width, int Height, int Length)
	{
		Int3 result = new Int3(2000, 1000, 2000);
		switch (RangeType)
		{
		case RangeType.Roundness:
			result = new Int3(Radius * 2, Radius * 2, Radius * 2);
			break;
		case RangeType.Rectangle:
			result = new Int3(Width, Height, Length);
			break;
		}
		return result;
	}

	private static void ProcessHitCheck(SimContext simContext, int logicTime, Timeline timelineConfig, ThrownState thrownState)
	{
		if (AbilitiesProcessor.IsHitFrame(timelineConfig, logicTime, thrownState.mHitIndex, thrownState.mTimeStep, out var hitCheckInfo) && hitCheckInfo.RangeType != RangeType.None)
		{
			uint interestCamp = RoleCampProcessor.GetInterestCamp(thrownState.mCamp);
			AbilitiesProcessor.HitCheck(thrownState.mCasterID, logicTime, thrownState.mAbilityID, 0, hitCheckInfo, interestCamp, thrownState.mPosition, thrownState.mForward, thrownState.mForward, ref thrownState.mHitIndex, out var kurtunTime, thrownState.mAttributeID, thrownState.mCanBeParry, thrownState.mCreationIndex);
			UpdateThrownFrameFreezeTime(simContext, thrownState.mCreationIndex, kurtunTime);
		}
		thrownState.mHitIndex = AbilitiesProcessor.UpdateHitIndex(thrownState.mCreationIndex, logicTime, timelineConfig, thrownState.mHitIndex);
	}

	public static void UpdateThrownFrameFreezeTime(SimContext simContext, int thrownID, int frameFreezeTime)
	{
		if (frameFreezeTime > 0 && TryGetThrown(simContext, thrownID, out var thrownState) && frameFreezeTime > thrownState.mFrameFreezeTime)
		{
			thrownState.mFrameFreezeTime = frameFreezeTime;
			if (thrownState.mProducerID <= 0)
			{
				UpdateThrownFrameFreezeTime(simContext, thrownState.mProducerID, frameFreezeTime);
			}
		}
	}

	public static int SpawnThrown(SimContext simContext, int casterID, int srcTimelineID, int indexOnSrcTimeline, Int3 srcPos, Int3 srcForward, int thrownTimelineID, bool useCommon, int producerID, int createdRootTimelineID, int attributeID, out ThrownState thrownState)
	{
		thrownState = null;
		SimEntity entityWithEntityID = simContext.GetEntityWithEntityID(casterID);
		if (entityWithEntityID == null || entityWithEntityID.hasEntityActionDeath || !entityWithEntityID.hasEntityCamp)
		{
			return 0;
		}
		uint num = ((entityWithEntityID != null && entityWithEntityID.hasEntityShape) ? entityWithEntityID.entityShape.mLayer : uint.MaxValue);
		num = (entityWithEntityID.hasEntityCamp ? entityWithEntityID.entityCamp.mRoleTypeCamp : num);
		int num2 = 0;
		if (num2 == 0 && entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
		{
			num2 = entityWithEntityID.entityActionAbility.mTargetID;
		}
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			SimEntity entityWithEntityID2 = mSimContext.GetEntityWithEntityID(entityWithEntityID.entityBlackboard.var.mAimTarget);
			if (entityWithEntityID2 != null)
			{
				num2 = entityWithEntityID2.creationIndex;
			}
		}
		SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(num2);
		if (simEntityByMultiColliders != null)
		{
			num2 = simEntityByMultiColliders.creationIndex;
		}
		Int3 @int = srcPos;
		Int3 int2 = srcForward;
		thrownState = FrameObjectPool<ThrownState>.Claim();
		thrownState.mCreationIndex = mWorldState.status.mThrownCreationIndex--;
		bool flag = ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(thrownTimelineID, out var config);
		if (flag)
		{
			flag = config.CanBeParry;
		}
		if (!useCommon)
		{
			InitThrownState(simContext, ref thrownState, casterID, num, num2, srcTimelineID, indexOnSrcTimeline, @int, int2, thrownTimelineID, producerID, createdRootTimelineID, attributeID, flag);
			mSimContext.GetSimInterface().mThrownProcessCustomSpawn?.Invoke(thrownState.mCreationIndex);
			mSimContext.PostEvent(ThrownSpawnedEvent.Claim(thrownState.mCreationIndex, thrownState.mAbilityID, @int, int2, casterID));
			return thrownState.mCreationIndex;
		}
		if (thrownTimelineID != 0)
		{
			InitThrownState(simContext, ref thrownState, casterID, num, num2, srcTimelineID, indexOnSrcTimeline, @int, int2, thrownTimelineID, producerID, createdRootTimelineID, attributeID, flag);
			mSimContext.PostEvent(ThrownSpawnedEvent.Claim(thrownState.mCreationIndex, thrownState.mAbilityID, @int, int2, casterID));
			return thrownState.mCreationIndex;
		}
		Timeline config2 = ConfigHelper.GetInstance().GetConfig<Timeline>(srcTimelineID);
		if (config2 == null)
		{
			return 0;
		}
		PostSpwanThrownEventInfo postSpwanThrownEventInfo = config2.PostSpwanThrownEvents.get_Item(indexOnSrcTimeline);
		@int = IntMath.Transform(new Int3(postSpwanThrownEventInfo.CenterOffset.X, postSpwanThrownEventInfo.CenterOffset.Y, postSpwanThrownEventInfo.CenterOffset.Z), srcForward, srcPos);
		if (postSpwanThrownEventInfo.SpawnForward != null)
		{
			Int3 int3 = IntMath.Transform(new Int3(postSpwanThrownEventInfo.SpawnForward.X, postSpwanThrownEventInfo.SpawnForward.Y, postSpwanThrownEventInfo.SpawnForward.Z), srcForward, @int);
			int2 = (int3 - @int).NormalizeTo(1000);
		}
		flag = ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(postSpwanThrownEventInfo.ID, out config);
		if (flag)
		{
			flag = config.CanBeParry;
		}
		InitThrownState(simContext, ref thrownState, casterID, num, num2, srcTimelineID, indexOnSrcTimeline, @int, int2, postSpwanThrownEventInfo.ID, producerID, createdRootTimelineID, attributeID, flag);
		mSimContext.PostEvent(ThrownSpawnedEvent.Claim(thrownState.mCreationIndex, thrownState.mAbilityID, @int, int2, casterID));
		return thrownState.mCreationIndex;
	}

	private static void InitThrownState(SimContext simContext, ref ThrownState thrownState, int casterID, uint camp, int targetID, int srcTimelineID, int indexOnSrcTimeline, Int3 srcPos, Int3 srcForward, int thrownTimelineID, int producerID, int createdRootTimelineID, int attributeID, bool canBeParry)
	{
		thrownState.mAbilityID = thrownTimelineID;
		thrownState.mAttributeID = attributeID;
		thrownState.mCasterID = casterID;
		thrownState.mEarliestPosition = srcPos;
		thrownState.mLastPosition = srcPos;
		thrownState.mPosition = srcPos;
		thrownState.mEarliestForward = srcForward;
		thrownState.mForward = srcForward;
		thrownState.mCamp = camp;
		thrownState.mCurFrame = 0u;
		thrownState.mHitIndex = 0;
		thrownState.mTargetID = targetID;
		thrownState.mConllisionCheckIndex = 0;
		thrownState.mTargetPosition = Int3.up;
		thrownState.mBackTargetPosition = Int3.up;
		thrownState.mCreatedRootTimelineID = createdRootTimelineID;
		thrownState.mFrameFreezeTime = 0;
		thrownState.mProducerID = producerID;
		thrownState.mProduceTimelineID = srcTimelineID;
		thrownState.mProduceIndexOfTimeline = indexOnSrcTimeline;
		thrownState.mTimeScale = 100;
		thrownState.mCanBeParry = canBeParry;
		mWorldState.status.mThrowns.Add(thrownState);
	}

	public static void DestoryThrown(SimContext simContext, ThrownState thrownState)
	{
		if (thrownState != null)
		{
			mWorldState.status.mDestoryThrowns.Add(thrownState.mCreationIndex);
			simContext.PostEvent(DespawnThrownEntityEvent.Claim(thrownState.mCasterID, thrownState.mAbilityID, thrownState.mCreationIndex));
			thrownState.mDontCollisionCheck = true;
		}
	}

	public static bool TryGetThrown(SimContext simContext, int thrownID, out ThrownState thrownState)
	{
		List<ThrownState> mThrowns = mWorldState.status.mThrowns;
		for (int i = 0; i < mThrowns.Count; i++)
		{
			ThrownState thrownState2 = mThrowns[i];
			if (thrownState2.mCreationIndex == thrownID)
			{
				thrownState = thrownState2;
				return true;
			}
		}
		thrownState = null;
		return false;
	}

	public static int UpdateThrownTargetAndIgnoreAllHistory(ThrownState thrownState)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
		if (config == null)
		{
			return 0;
		}
		if (config.ThrownLockActionInfoList.Count <= 0)
		{
			return 0;
		}
		if (thrownState.mCurLockIndex >= config.ThrownLockActionInfoList.Count)
		{
			return 0;
		}
		ThrownLockActionInfo thrownLockActionInfo = config.ThrownLockActionInfoList.get_Item(thrownState.mCurLockIndex);
		if (thrownLockActionInfo == null)
		{
			return 0;
		}
		if (thrownLockActionInfo.LockTargetPoint)
		{
			return 0;
		}
		TargetCampType targetCampType = ((thrownLockActionInfo.TargetCampType == TargetCampType.None) ? TargetCampType.Enemy : thrownLockActionInfo.TargetCampType);
		TargetSelectType targetSelectType = ((targetCampType != TargetCampType.We) ? TargetSelectType.Nearest : TargetSelectType.WithoutSelf);
		List<int> history = null;
		mWorldState.status.TryGetHitHistroy(thrownState.mCreationIndex, out history);
		List<int> list = FrameListPool<int>.Claim();
		if (!CommonProcessor.TryGetTargets(mSimContext, list, history, thrownState.mCreationIndex, targetCampType, thrownLockActionInfo.RangeType, new Int3(thrownLockActionInfo.CenterOffset.X, thrownLockActionInfo.CenterOffset.Y, thrownLockActionInfo.CenterOffset.Z), thrownLockActionInfo.Radius, thrownLockActionInfo.Angle, thrownLockActionInfo.Width, thrownLockActionInfo.Height, thrownLockActionInfo.Length, targetSelectType, 1))
		{
			FrameListPool<int>.Release(list);
			return 0;
		}
		if (list.Count > 0)
		{
			thrownState.mTargetID = 0;
			for (int i = 0; i < list.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(list[i]);
				if (simEntityByMultiColliders != null)
				{
					thrownState.mTargetID = simEntityByMultiColliders.creationIndex;
					break;
				}
			}
		}
		else
		{
			thrownState.mTargetID = 0;
		}
		FrameListPool<int>.Release(list);
		return thrownState.mTargetID;
	}

	public static Int3 GetTargetDirection(ThrownState thrownState, int ID)
	{
		Int3 mForward = thrownState.mForward;
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(ID);
		if (entityWithEntityID != null)
		{
			return GetTargetDirection(thrownState, entityWithEntityID.entityPositon.mPosition);
		}
		return mForward;
	}

	public static Int3 GetTargetDirection(ThrownState thrownState, Int3 targetPosition)
	{
		Int3 result = thrownState.mForward;
		Int3 @int = targetPosition - thrownState.mPosition;
		if (@int.sqrMagnitudeLong2D > 1000000)
		{
			result = @int.NormalizeTo(1000);
		}
		return result;
	}

	public static bool TryGetThrownHitHistory(SimContext simContext, int thrownID, out List<int> histotryList)
	{
		return mWorldState.status.TryGetHitHistroy(thrownID, out histotryList);
	}

	public static void AddThrownHitHistory(SimContext simContext, int thrownID, List<int> hitList)
	{
		mWorldState.status.AddHitHistory(thrownID, hitList);
	}

	public static void RemoveThrownHitHistory(SimContext simContext, int thrownID)
	{
		mWorldState.status.RemoveHitHistory(thrownID);
	}

	public static void CalcThrownStateTimeStep(ThrownState thrownState)
	{
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(thrownState.mAbilityID);
		if (config == null)
		{
			XLogger.Debug("找不到抛掷物的逻辑层 Timeline 数据:" + thrownState.mAbilityID);
			return;
		}
		int logicConstTick = CommonProcessor.GetLogicConstTick();
		if (thrownState.mFrameFreezeTime > 0)
		{
			thrownState.mFrameFreezeTime -= logicConstTick;
			thrownState.mTimeStep = 0;
			return;
		}
		int num = 0;
		if (config.IsDependCasterForThrown)
		{
			if (!CommonProcessor.TryGetAliveRole(mSimContext, thrownState.mCasterID, out var simEntity) || !simEntity.hasEntityActionAbility)
			{
				return;
			}
			num = (int)IntMath.Divide((long)logicConstTick * (long)simEntity.entityActionAbility.mAbilitySpeed * simEntity.entityBlackboard.var.mEntityTimeScale * thrownState.mTimeScale, 1000000L);
		}
		else
		{
			num = (int)IntMath.Divide((long)logicConstTick * (long)thrownState.mTimeScale, 100L);
		}
		SimWorldState worldState = CommonProcessor.GetWorldState();
		num = num * worldState.commonWorldTimeScaleValue / worldState.commonWorldTimeScaleBaseValue;
		thrownState.mTimeStep = num;
	}
}
