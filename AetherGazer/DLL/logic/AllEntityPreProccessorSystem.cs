using System.Collections.Generic;
using Config;
using Entitas;
using UnityEngine;

public class AllEntityPreProccessorSystem : IExecuteSystem, ISystem, IInitializeSystem
{
	private SimContext mSimContext;

	private List<SimEntity> mEntityBuffer = new List<SimEntity>();

	private IGroup<SimEntity> mModifyHpGroup;

	private IGroup<SimEntity> mEntityWithHitRecover;

	private IGroup<SimEntity> mBlackboardGroup;

	private IGroup<SimEntity> mAbilityGroup;

	private IGroup<SimEntity> mEntityBuffGroup;

	private IGroup<SimEntity> mEnityCDGroup;

	private IGroup<SimEntity> mEntityTimerGroup;

	private IGroup<SimEntity> mEntityTransfiguration;

	private IGroup<SimEntity> mEntityUltimateAvoidCD;

	private IGroup<SimEntity> mEntityCombatScore;

	private IGroup<SimEntity> mEntityUniqueSkillEnergy;

	private IGroup<SimEntity> mEntityMasterSkill;

	private IGroup<SimEntity> mEntityWithHide;

	private IGroup<SimEntity> mEntityPosition;

	public AllEntityPreProccessorSystem(SimContext sim)
	{
		mSimContext = sim;
	}

	public void Initialize()
	{
		mEntityWithHide = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityHide));
		mEntityWithHitRecover = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityHitRecover).NoneOf(SimMatcher.EntityHide));
		mModifyHpGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionModifyHP));
		mBlackboardGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBlackboard).NoneOf(SimMatcher.EntityHide));
		mAbilityGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionAbility).NoneOf(SimMatcher.EntityHide));
		mEntityBuffGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBuff).NoneOf(SimMatcher.EntityHide));
		mEnityCDGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityCD).NoneOf(SimMatcher.EntityHide));
		mEntityTimerGroup = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityTimer).NoneOf(SimMatcher.EntityHide));
		mEntityTransfiguration = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityActionTransfiguration).NoneOf(SimMatcher.EntityHide));
		mEntityUltimateAvoidCD = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityUltimateAvoidCD).NoneOf(SimMatcher.EntityHide));
		mEntityCombatScore = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityBlackboard, SimMatcher.EntityActionModifyCombatScore).NoneOf(SimMatcher.EntityHide));
		mEntityUniqueSkillEnergy = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityUniqueSkillEnergy).NoneOf(SimMatcher.EntityHide));
		mEntityMasterSkill = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityMasterSkill).NoneOf(SimMatcher.EntityHide));
		mEntityPosition = mSimContext.GetGroup(SimMatcher.AllOf(SimMatcher.EntityRemotePlayer, SimMatcher.EntityPositon).NoneOf(SimMatcher.EntityHide));
	}

	public void Execute()
	{
		Process();
	}

	public void Process()
	{
		Process_UpdateEntityStatus();
		Process_FindDeathEnities();
		Process_FindHideEnities();
		Process_WorldState();
	}

	private void Process_UpdateEntityStatus()
	{
		mModifyHpGroup.GetEntities(mEntityBuffer);
		for (int i = 0; i < mEntityBuffer.Count; i++)
		{
			mEntityBuffer[i].RemoveEntityActionModifyHP();
		}
		mEntityTransfiguration.GetEntities(mEntityBuffer);
		for (int j = 0; j < mEntityBuffer.Count; j++)
		{
			SimEntity simEntity = mEntityBuffer[j];
			AbilitiesProcessor.AbilityTransform(simEntity, simEntity.entityActionTransfiguration.mRoleID, simEntity.entityActionTransfiguration.mAppearID);
		}
		mEntityPosition.GetEntities(mEntityBuffer);
		for (int k = 0; k < mEntityBuffer.Count; k++)
		{
			SimEntity simEntity2 = mEntityBuffer[k];
			simEntity2.entityPositon.IsTeleport = false;
		}
		mEntityBuffGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity7)
		{
			int count = simEntity7.entityBuff.mBuffID.Count;
			ConfigHelper instance = ConfigHelper.GetInstance();
			for (int l = 0; l < simEntity7.entityBuff.mDuringArray.Count; l++)
			{
				if (simEntity7.entityBuff.mDuringArray[l] <= 0 && !simEntity7.entityBuff.IsInPendingRemoveArray(simEntity7.entityBuff.mBuffID[l]) && simContext.GetSimInterface() != null)
				{
					if (simContext.GetSimInterface().mUpdateBuffLogicEvent != null)
					{
						simContext.GetSimInterface().mUpdateBuffLogicEvent(simEntity7.creationIndex, l, simEntity7.entityBuff.mBuffClassIDArray[l], EBuffLife.Leave, arg5: true);
					}
					simEntity7.entityBuff.AddPendingRemoveArray(simEntity7.entityBuff.mBuffID[l]);
				}
			}
		});
		for (int num = 0; num < mEntityBuffer.Count; num++)
		{
			if (mEntityBuffer[num].entityBuff.ReleaseBuffOnPossible())
			{
				mEntityBuffer[num].RemoveEntityBuff();
			}
		}
		mEntityTimerGroup.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity7)
		{
			for (int l = 0; l < simEntity7.entityTimer.entityTimers.Count; l++)
			{
				if (simEntity7.entityTimer.entityTimers[l].duringTime <= 0 && simContext.GetSimInterface() != null && !simEntity7.entityTimer.IsInPendingRemoveArray(simEntity7.entityTimer.entityTimers[l].id))
				{
					simContext.PostEvent(EntityTimerEvent.Claim(simEntity7.entityTimer.entityTimers[l], EBuffLife.Leave, simEntity7.creationIndex, isTimeout: true));
					simEntity7.entityTimer.AddPendingRemoveArray(simEntity7.entityTimer.entityTimers[l].id);
				}
			}
		});
		for (int num2 = 0; num2 < mEntityBuffer.Count; num2++)
		{
			if (mEntityBuffer[num2].entityTimer.ReleaseTimerIfPossible())
			{
				mEntityBuffer[num2].RemoveEntityTimer();
			}
		}
		mEntityWithHitRecover.GetEntities(mEntityBuffer);
		for (int num3 = 0; num3 < mEntityBuffer.Count; num3++)
		{
			SimEntity simEntity3 = mEntityBuffer[num3];
			if ((mEntityBuffer[num3].entityHitRecover.mHitRecoverStatus == E_HitRecoverStatus.HitReocver || E_HitRecoverStatus.GetUp == mEntityBuffer[num3].entityHitRecover.mHitRecoverStatus) && simEntity3.entityHitRecover.mHitRecoverTime >= AbilitiesProcessor.GetTimelineDuration(simEntity3, simEntity3.entityHitRecover.mHitRecoverActionID, simEntity3.entityHitRecover.mHitRecoverStatus))
			{
				simEntity3.RemoveEntityHitRecover();
			}
			if (simEntity3.hasEntityBlackboard)
			{
				simEntity3.entityBlackboard.var.meleeIndex = 0;
			}
		}
		mEnityCDGroup.GetEntities(mEntityBuffer).DoAction(delegate(SimEntity simEntity7)
		{
			CDProcessor.UpdateCD(simEntity7);
		});
		mEntityUltimateAvoidCD.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity7)
		{
			simEntity7.entityUltimateAvoidCD.mRuntime -= CommonProcessor.GetLogicConstTick();
			if (simEntity7.entityUltimateAvoidCD.mRuntime <= 0)
			{
				simEntity7.entityUltimateAvoidCD.mRuntime = simEntity7.entityBlackboard.var.mCharacterParamUltimateAvoidCD;
				simEntity7.entityUltimateAvoidCD.mLeftUseCount++;
				if (simEntity7.entityUltimateAvoidCD.mLeftUseCount >= simEntity7.entityBlackboard.var.mUltimateAvoidMaxUseCount)
				{
					simEntity7.RemoveEntityUltimateAvoidCD();
				}
			}
		});
		mAbilityGroup.GetEntities(mEntityBuffer);
		for (int num4 = 0; num4 < mEntityBuffer.Count; num4++)
		{
			SimEntity simEntity4 = mEntityBuffer[num4];
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(simEntity4.entityActionAbility.mAbilityID);
			if (config == null)
			{
				Debug.LogError((object)("无法找到 == " + simEntity4.entityActionAbility.mAbilityID));
			}
			if (simEntity4.entityActionAbility.mLogicTime >= config.Duration)
			{
				simEntity4.entityBlackboard.var.mActionBusy = false;
				MovementProcessor.EnableMovement(simEntity4, simEntity4.hasEntityActionMoveDirection);
				simEntity4.RemoveEntityActionAbility();
				simEntity4.entityBlackboard.var.meleeIndex = 0;
				if (config.IsFinalAction)
				{
					simEntity4.AddEntityActionDeath(0, 0, 0);
				}
			}
		}
		mBlackboardGroup.GetEntities(mEntityBuffer);
		for (int num5 = 0; num5 < mEntityBuffer.Count; num5++)
		{
			SimEntity simEntity5 = mEntityBuffer[num5];
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(simEntity5.entityBlackboard.var.mAimTarget);
			uint interestCamp = RoleCampProcessor.GetInterestCamp(simEntity5.entityCamp.mRoleTypeCamp);
			if (entityWithEntityID != null && (!entityWithEntityID.entityShape.mShape.IsEnable || !RoleCampProcessor.Is(interestCamp, entityWithEntityID.entityShape.GetLayer())))
			{
				ISimShape nearestCollisionData = AIProcessor.GetNearestCollisionData(simEntity5, CommonProcessor.GetSimEntityByMultiColliders(entityWithEntityID), interestCamp, out var _);
				if (nearestCollisionData != null)
				{
					entityWithEntityID = mSimContext.GetEntityWithEntityID(nearestCollisionData.OwnerID);
					simEntity5.entityBlackboard.var.mLastTarget = entityWithEntityID.creationIndex;
					simEntity5.entityBlackboard.var.mAimTarget = entityWithEntityID.creationIndex;
				}
			}
		}
		for (int num6 = 0; num6 < mEntityBuffer.Count; num6++)
		{
			SimEntity simEntity6 = mEntityBuffer[num6];
			if (!simEntity6.entityBlackboard.var.initFinished)
			{
				if (mSimContext.GetSimInterface().mInitEntityFinishedEvent != null)
				{
					mSimContext.GetSimInterface().mInitEntityFinishedEvent(simEntity6.creationIndex);
				}
				simEntity6.entityBlackboard.var.initFinished = true;
			}
		}
		if (mSimContext.hasSEntityWorldState && mSimContext.sEntityWorldState.status.m_sendOffline)
		{
			int sendOfflineMember = mSimContext.sEntityWorldState.status.m_sendOfflineMember;
			for (int num7 = 0; num7 < 32; num7++)
			{
				if (mSimContext.sEntityWorldState.status.mRoomMembers.TryGetValue((MemberPosition)num7, out var value) && (sendOfflineMember & (1 << num7)) != 0)
				{
					mSimContext.PostEvent(OnlinePlayerOfflineEvent.Claim(value.mEntityID));
				}
			}
			mSimContext.sEntityWorldState.status.m_sendOfflineMember = 0;
			mSimContext.sEntityWorldState.status.m_offlineMember = 0;
			mSimContext.sEntityWorldState.status.m_sendOffline = false;
		}
		if (mSimContext.hasEntitySourceSpace)
		{
			EntitySourceSpace entitySourceSpace = mSimContext.entitySourceSpace;
			if (entitySourceSpace.Enable)
			{
				if (entitySourceSpace.SourceSpaceDelayTime >= 0)
				{
					int arg = int.MaxValue - entitySourceSpace.SourceSpaceDelayTime;
					entitySourceSpace.SourceSpaceDelayTime -= CommonProcessor.GetLogicConstTick();
					int arg2 = int.MaxValue - entitySourceSpace.SourceSpaceDelayTime;
					mSimContext.GetSimInterface().mSourceSpaceUpdateEvent?.Invoke(SourceSpaceEvent.E_SourceSpaceState.Enter, arg, arg2);
					if (entitySourceSpace.SourceSpaceDelayTime <= 0)
					{
						mSimContext.PostEvent(SourceSpaceEvent.Claim(SourceSpaceEvent.E_SourceSpaceState.Enter, entitySourceSpace.SourceSpaceKeepTime, entitySourceSpace.SourceSpaceRaceID, entitySourceSpace.BreakEntityID));
						entitySourceSpace.SourceSpaceDelayTime = -1;
					}
				}
				else if (entitySourceSpace.SourceSpaceKeepTime >= 0)
				{
					entitySourceSpace.SourceSpaceKeepTime -= CommonProcessor.GetLogicConstTick();
					if (entitySourceSpace.SourceSpaceKeepTime <= 0)
					{
						if (mSimContext.sEntityWorldState.status.m_InQTERoleCount <= 0)
						{
							mSimContext.PostEvent(SourceSpaceEvent.Claim(SourceSpaceEvent.E_SourceSpaceState.Leavel, 0, entitySourceSpace.SourceSpaceRaceID, entitySourceSpace.BreakEntityID));
							entitySourceSpace.SourceSpaceKeepTime = -1;
						}
						else
						{
							entitySourceSpace.SourceSpaceKeepTime = 0;
						}
					}
				}
				else
				{
					int arg3 = int.MaxValue - entitySourceSpace.SourceSpaceExitTime;
					entitySourceSpace.SourceSpaceExitTime -= CommonProcessor.GetLogicConstTick();
					int arg4 = int.MaxValue - entitySourceSpace.SourceSpaceExitTime;
					mSimContext.GetSimInterface().mSourceSpaceUpdateEvent?.Invoke(SourceSpaceEvent.E_SourceSpaceState.Exit, arg3, arg4);
					if (entitySourceSpace.SourceSpaceExitTime <= 0)
					{
						mSimContext.PostEvent(SourceSpaceEvent.Claim(SourceSpaceEvent.E_SourceSpaceState.Exit, 0, entitySourceSpace.SourceSpaceRaceID, entitySourceSpace.BreakEntityID));
						entitySourceSpace.Enable = false;
						entitySourceSpace.SourceSpaceRaceID = 0;
						entitySourceSpace.SourceSpaceDelayTime = -1;
						entitySourceSpace.SourceSpaceKeepTime = -1;
						entitySourceSpace.SourceSpaceExitTime = -1;
						entitySourceSpace.BreakEntityID = 0;
					}
				}
			}
			if (entitySourceSpace.LimitDodgeCD > 0)
			{
				entitySourceSpace.LimitDodgeCD -= CommonProcessor.GetLogicConstTick();
				if (entitySourceSpace.LimitDodgeCD <= 0)
				{
					entitySourceSpace.LimitDodgeCD = 0;
				}
			}
		}
		mEntityUniqueSkillEnergy.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext pSimContext, SimEntity pSimEntity)
		{
			EntityUniqueSkillEnergy entityUniqueSkillEnergy = pSimEntity.entityUniqueSkillEnergy;
			if (entityUniqueSkillEnergy.mMaxValue != 0 && entityUniqueSkillEnergy.mState == EntityActionStatus.E_ACTIVE)
			{
				entityUniqueSkillEnergy.mRuntime -= CommonProcessor.GetLogicConstTick();
				if (entityUniqueSkillEnergy.mRuntime <= 0)
				{
					entityUniqueSkillEnergy.mValue += entityUniqueSkillEnergy.mAddValue;
					if (entityUniqueSkillEnergy.mValue >= entityUniqueSkillEnergy.mMaxValue && mSimContext.sEntityWorldState.status.m_cooperateUniqueSkillIsActive <= 0)
					{
						entityUniqueSkillEnergy.mState = EntityActionStatus.E_SUCCESS;
						pSimContext.GetSimInterface().mUniqueSkillPrepared?.Invoke(pSimEntity.creationIndex);
					}
					entityUniqueSkillEnergy.mRuntime = entityUniqueSkillEnergy.mTick;
				}
			}
		});
		mEntityMasterSkill.GetEntities(mEntityBuffer);
		for (int num8 = 0; num8 < mEntityBuffer.Count; num8++)
		{
			mSimContext.GetSimInterface().mUpdateEntityMasterSkillEvent?.Invoke(mEntityBuffer[num8].creationIndex);
		}
		mEntityCombatScore.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity7)
		{
			if (simEntity7.entityActionModifyCombatScore.mStatus == EntityActionStatus.E_SUCCESS)
			{
				List<ModifyCombatScoreInfo> mModifyInfoList = simEntity7.entityActionModifyCombatScore.mModifyInfoList;
				for (int num9 = mModifyInfoList.Count - 1; num9 >= 0; num9--)
				{
					if (mModifyInfoList[num9].mState == EntityActionStatus.E_SUCCESS)
					{
						mModifyInfoList.RemoveAt(num9);
					}
				}
			}
		});
	}

	private void Process_FindHideEnities()
	{
		mEntityWithHide.GetEntities(mEntityBuffer).DoAction(mSimContext, delegate(SimContext simContext, SimEntity simEntity)
		{
			CommonProcessor.HideEntity(simEntity, isShow: false);
		});
	}

	private void Process_FindDeathEnities()
	{
		mSimContext.GetGroup(SimMatcher.EntityActionDeath).GetEntities(mEntityBuffer);
		for (int i = 0; i < mEntityBuffer.Count; i++)
		{
			SimEntity simEntity = mEntityBuffer[i];
			int creationIndex = simEntity.creationIndex;
			SimContext simContext = mSimContext;
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(simEntity.entityBlackboard.var.mGrabTarget);
			if (entityWithEntityID != null)
			{
				entityWithEntityID.entityBlackboard.var.mIsCaught = false;
			}
			if (simEntity.hasEntityBuff)
			{
				for (int j = 0; j < simEntity.entityBuff.mBuffID.Count; j++)
				{
					BuffProcessor.RemoveBuffID(simEntity.creationIndex, simEntity.creationIndex, simEntity.entityBuff.mBuffID[j]);
				}
			}
			mSimContext.PostEvent(EntityTriggerEvent.Claim(TriggerEventType.UnitDie, 0, simEntity.creationIndex));
			if (simEntity.hasEntityBlackboard && simEntity.hasEntityCamp)
			{
				mSimContext.PostEvent(EntityDespawnedEvent.Claim(CommanderID.None, simEntity.entityBlackboard.var.mKillerID, creationIndex, skipDeathSequence: false, simEntity.entityCamp.mRoleTypeCamp, UnitRemoveReason.Despawn, isByCommanderEliminated: false, simEntity.entityActionDeath.mAbilityID, mSimContext.simStatus.mServerFrame));
			}
			simEntity.entityBlackboard.var.mKillerID = 0;
			simEntity.entityBlackboard.var.mKillThrownID = 0;
			SimEntity entityWithEntityID2 = simContext.GetEntityWithEntityID(creationIndex);
			if (entityWithEntityID2 == null)
			{
				XLogger.Debug("===========>> dont exsist: " + creationIndex);
			}
			if (simContext.sEntityWorldState.status.mEnemys != null)
			{
				simContext.sEntityWorldState.status.mEnemys.Remove(creationIndex);
			}
			SimEntity entityWithEntityID3 = simContext.GetEntityWithEntityID(creationIndex);
			entityWithEntityID3.RemoveAllComponents();
			entityWithEntityID3.Destroy();
		}
	}

	private void Process_WorldState()
	{
		SimWorldState status = mSimContext.sEntityWorldState.status;
		if (status.m_cooperateUniqueSkillIsActive <= 0 || !ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(status.m_CooperateUniqueSkillID, out var config))
		{
			return;
		}
		status.m_cooperateUniqueSkillEnergyValue = 0;
		status.m_cooperateUniqueSkillEnergyMaxValue = 0;
		status.m_cooperateUniqueSkillCD = 0;
		status.m_cooperateUniqueSkillMaxCD = 0;
		bool cooperateUniqueSkillVaild = status.m_cooperateUniqueSkillVaild;
		status.m_cooperateUniqueSkillVaild = false;
		int num = 0;
		int num2 = 0;
		List<SimEntity> list = FrameListPool<SimEntity>.Claim();
		List<int> list2 = FrameListPool<int>.Claim();
		int num3 = 0;
		Dictionary<MemberPosition, RemoteMember> mRoomMembers = status.mRoomMembers;
		Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
		while (enumerator.MoveNext())
		{
			int mEntityID = enumerator.Current.Value.mEntityID;
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mEntityID);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard || entityWithEntityID.entityBlackboard.var.mHP <= 0 || !entityWithEntityID.hasEntityUniqueSkillEnergy || !entityWithEntityID.hasEntityConfig || !config.CooperateRoleIds.Contains(entityWithEntityID.entityConfig.mId))
			{
				continue;
			}
			list.Add(entityWithEntityID);
			status.m_cooperateUniqueSkillEnergyValue += entityWithEntityID.entityUniqueSkillEnergy.mValue;
			status.m_cooperateUniqueSkillEnergyMaxValue += entityWithEntityID.entityUniqueSkillEnergy.mMaxValue;
			if (ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entityWithEntityID.entityConfig.mId, out var config2))
			{
				list2.Add(config2.AbilityId.get_Item(0));
				if (CDProcessor.GetCD(entityWithEntityID, config2.AbilityId.get_Item(0), out var abilityCD))
				{
					num += abilityCD.CD;
					num2 += abilityCD.MaxCD;
				}
				if (AttributeProcessor.IsEnableAbility(entityWithEntityID, config2.AbilityId.get_Item(0)))
				{
					num3++;
				}
			}
			else
			{
				list2.Add(0);
				XLogger.Error(entityWithEntityID.entityConfig.mId + " hasn't uniqueSkill data in Config.UniqueSkill");
			}
		}
		if (num > 0 && list.Count > 0)
		{
			status.m_cooperateUniqueSkillCD = IntMath.Max(1, IntMath.Divide(num, list.Count));
			status.m_cooperateUniqueSkillMaxCD = IntMath.Divide(num2, list.Count);
			for (int i = 0; i < list.Count; i++)
			{
				if (list2[i] == 0)
				{
					continue;
				}
				SimEntity simEntity = list[i];
				int num4 = list2[i];
				if (simEntity != null)
				{
					if (CDProcessor.GetCD(simEntity, num4, out var abilityCD2))
					{
						CDProcessor.SetCD(simEntity, num4, status.m_cooperateUniqueSkillCD, abilityCD2.UsedCount);
						continue;
					}
					CDProcessor.AddCD(simEntity, num4);
					CDProcessor.SetCD(simEntity, num4, status.m_cooperateUniqueSkillCD, 1);
				}
			}
		}
		if (status.m_cooperateUniqueSkillEnergyValue > 0)
		{
			int num5 = status.m_cooperateUniqueSkillEnergyValue;
			for (int j = 0; j < list.Count; j++)
			{
				SimEntity simEntity2 = list[j];
				if (simEntity2 != null && simEntity2.hasEntityUniqueSkillEnergy)
				{
					if (j != list.Count - 1)
					{
						simEntity2.entityUniqueSkillEnergy.mValue = (status.m_cooperateUniqueSkillEnergyValue * new VFactor(simEntity2.entityUniqueSkillEnergy.mMaxValue, status.m_cooperateUniqueSkillEnergyMaxValue)).floorInt;
						num5 -= simEntity2.entityUniqueSkillEnergy.mValue;
					}
					else
					{
						simEntity2.entityUniqueSkillEnergy.mValue = num5;
					}
				}
			}
		}
		status.m_cooperateUniqueSkillVaild = status.m_cooperateUniqueSkillDisableFlag == 0 && num3 == config.CooperateRoleIds.Count && status.m_cooperateUniqueSkillEnergyValue >= status.m_cooperateUniqueSkillEnergyMaxValue && num <= 0;
		if (!cooperateUniqueSkillVaild && cooperateUniqueSkillVaild != status.m_cooperateUniqueSkillVaild)
		{
			mSimContext.GetSimInterface().mCooperateUniqueSkillPrepared?.Invoke();
		}
		FrameListPool<int>.Release(list2);
		FrameListPool<SimEntity>.Release(list);
	}
}
