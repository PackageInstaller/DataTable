using System.Collections.Generic;
using Config;
using Entitas;

internal class UnitStatesSampler
{
	public static void SampleServerEntity(SimContext simContext, SimStateFrame frame)
	{
		IGroup<SimEntity> obj = simContext.GetGroup(SimMatcher.EntityRemotePlayer);
		HashSet<SimEntity>.Enumerator enumerator = obj.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (!enumerator.Current.hasEntityRecastCut && !enumerator.Current.hasEntityTrigger)
			{
				Sample(enumerator.Current, frame, isPrediction: false);
			}
		}
	}

	public static void SampleLocalEntity(SimContext simContext, SimStateFrame frame)
	{
		IGroup<SimEntity> obj = simContext.GetGroup(SimMatcher.EntityLocalPlayer);
		HashSet<SimEntity>.Enumerator enumerator = obj.GetEnumerator();
		while (enumerator.MoveNext())
		{
			Sample(enumerator.Current, frame, isPrediction: true);
		}
	}

	private static void Sample(SimEntity entity, SimStateFrame frame, bool isPrediction)
	{
		int num = entity.creationIndex;
		if (isPrediction)
		{
			num = entity.entityLocalPlayer.mRemoteEntityID;
		}
		UnitState unitState = UnitState.Claim() as UnitState;
		if (entity.hasEntityRemotePlayer && entity.entityRemotePlayer.mLocalEntityID > 0)
		{
			unitState.mLocalFlag = true;
		}
		if (entity.hasEntityHide)
		{
			unitState.mHide = entity.entityHide.mHide;
		}
		else
		{
			unitState.mHide = E_EntityHideType.None;
		}
		if (entity.hasEntityActionAbility)
		{
			unitState.mAbilityID = entity.entityActionAbility.mAbilityID;
			unitState.mAbilityCanBeParry = entity.entityActionAbility.mCanBeParry;
			unitState.mAbilityTime = entity.entityActionAbility.mLogicTime;
			unitState.mAbilityTimeStep = ((!entity.hasEntityHide) ? entity.entityActionAbility.mTimeStep : 0);
		}
		if (entity.hasEntityPositon)
		{
			unitState.mIsTeleport = entity.entityPositon.IsTeleport;
			unitState.EntityID = num;
			unitState.mPostion = entity.entityPositon.mPosition;
			unitState.mForward = entity.entityPositon.mForward;
			unitState.mForwardAngle = entity.entityPositon.mForwardAngle;
		}
		if (entity.hasEntityActionMoveDirection)
		{
			unitState.mMoveID = entity.entityActionMoveDirection.mMoveID;
			unitState.mMoveTime = entity.entityActionMoveDirection.mLogicTime;
			unitState.mMoveTimeStep = ((!entity.hasEntityHide) ? entity.entityActionMoveDirection.mTimeStep : 0);
		}
		if (entity.hasEntityEndurance)
		{
			unitState.mMaxEnduranceValue = entity.entityEndurance.maxValue;
			unitState.mCurrentEnduranceValue = entity.entityEndurance.currentValue;
		}
		if (entity.hasEntityLocalPlayer)
		{
			unitState.mPredictionID = entity.entityLocalPlayer.mRemoteEntityID;
		}
		if (entity.hasEntityConfig)
		{
			unitState.mEntityConfigID = entity.entityConfig.mId;
		}
		if (entity.hasEntityBuff)
		{
			for (int i = 0; i < entity.entityBuff.mBuffID.Count; i++)
			{
				BuffState item = new BuffState
				{
					mBuffID = entity.entityBuff.mBuffID[i],
					mBuffOwnerID = num,
					mBuffCasterID = entity.entityBuff.mBuffCasterArray[i],
					mBuffClassID = entity.entityBuff.mBuffClassIDArray[i],
					mDuring = entity.entityBuff.mDuringArray[i],
					mBuffRuntime = entity.entityBuff.mBuffRuntime[i],
					mFloor = entity.entityBuff.mBuffFloor[i],
					mTick = entity.entityBuff.mTickArray[i],
					mBuffParams = entity.entityBuff.mBuffParamsArray[i],
					mBuffConfigID = entity.entityBuff.mBuffConfigID[i],
					mBuffKeepTime = entity.entityBuff.mBuffKeepTimeArray[i],
					mBindLife = entity.entityBuff.mBuffParamsArray[i].mBindLife
				};
				unitState.mBuffArray.Add(item);
			}
		}
		if (entity.hasEntityActionMove && entity.entityActionMove.mPath != null)
		{
			if (unitState.mPath == null)
			{
				unitState.mPath = new List<Int3>();
			}
			unitState.mPath.AddRange(entity.entityActionMove.mPath.int3Path);
		}
		unitState.mSpeed = (entity.hasEntityBlackboard ? entity.entityBlackboard.var.mCalculatedSpeed : ((Int)0));
		unitState.mVec = (entity.hasEntityBlackboard ? entity.entityBlackboard.var.mCalculatedVec : Int3.zero);
		unitState.mEntityTimeScale = (entity.hasEntityBlackboard ? entity.entityBlackboard.var.mEntityTimeScale : 100);
		unitState.mHasMoveDirectionInput = entity.hasEntityActionMoveDirection;
		unitState.mMoveDirectionInputDirection = (entity.hasEntityActionMoveDirection ? entity.entityActionMoveDirection.mDirection : Int3.zero);
		unitState.mSpeedDirection = (entity.hasEntityActionMoveDirection ? entity.entityActionMoveDirection.mSpeedDirection : Int3.zero);
		unitState.mMovementStatus = (entity.hasEntityActionMoveDirection ? entity.entityActionMoveDirection.mStatus : EntityActionStatus.None);
		unitState.mIsCaught = entity.hasEntityBlackboard && entity.entityBlackboard.var.mIsCaught;
		unitState.mHitRecover = ((entity.hasEntityHitRecover && !entity.hasEntityActionDeath) ? entity.entityHitRecover.mHitRecover : E_HitRecover.OnLeave);
		unitState.mHitRecoverStatus = ((E_HitRecover.OnLeave != unitState.mHitRecover) ? entity.entityHitRecover.mHitRecoverStatus : E_HitRecoverStatus.None);
		unitState.mHitRecoverTime = (entity.hasEntityHitRecover ? entity.entityHitRecover.mHitRecoverTime : 0);
		unitState.mHitRecoverTimeStep = ((entity.hasEntityHitRecover && !entity.hasEntityHide) ? entity.entityHitRecover.mTimeStep : 0);
		unitState.mHitRecoverCaster = (entity.hasEntityHitRecover ? entity.entityHitRecover.mCasterID : 0);
		unitState.mHitCount = (entity.hasEntityBlackboard ? entity.entityBlackboard.var.mBeHitIndex : 0);
		unitState.mHitAbilityID = (entity.hasEntityBlackboard ? entity.entityBlackboard.var.mBeHitAbilitiID : (-1));
		unitState.mHitRecoverActionID = (entity.hasEntityHitRecover ? entity.entityHitRecover.mHitRecoverActionID : 0);
		if (entity.hasEntityActionModifyHP)
		{
			int num2 = ((entity.entityActionModifyHP.mModifyInfoList != null) ? entity.entityActionModifyHP.mModifyInfoList.Count : 0);
			if (num2 > 0)
			{
				for (int j = 0; j < num2; j++)
				{
					unitState.mModfiyInfo.Add(entity.entityActionModifyHP.mModifyInfoList[j]);
				}
			}
		}
		if (entity.hasEntityBlackboard)
		{
			unitState.mHP = entity.entityBlackboard.var.mHP;
			unitState.mMaxHP = entity.entityBlackboard.var.mMaxHP;
			unitState.mIsIdling = entity.entityBlackboard.var.IdleState;
		}
		if (entity.hasEntityBlackboard)
		{
			unitState.mIsDeath = entity.entityBlackboard.var.mHP <= 0;
		}
		if (entity.hasEntityBlackboard)
		{
			unitState.entityType = entity.entityBlackboard.var.enemyType;
			unitState.powerValue = AttributeProcessor.GetPowerValue(num);
			AttributeProcessor.TryGetEnergyMaxValue(entity, out var maxValue);
			unitState.maxPowerValue = maxValue;
		}
		if (entity.hasEntityExposedValue)
		{
			unitState.mExposedValue = entity.entityExposedValue.mValue;
			unitState.mMaxExposedValue = entity.entityExposedValue.mMaxValue;
		}
		if (entity.hasEntityBlackboard)
		{
			unitState.mAbilityOriginalCanUse = entity.entityBlackboard.var.mAbilityOriginalCanUse;
		}
		if (entity.hasEntityActionSubJoystick)
		{
			unitState.mSubJoystickCommandCode = entity.entityActionSubJoystick.CommandCode;
			unitState.mSubJoystickTimelineID = entity.entityActionSubJoystick.TimelineID;
		}
		if (entity.hasEntityBlackboard)
		{
			unitState.mCombatScore = entity.entityBlackboard.var.mCombatScore;
		}
		if (entity.hasEntityUniqueSkillEnergy)
		{
			EntityUniqueSkillEnergy entityUniqueSkillEnergy = entity.entityUniqueSkillEnergy;
			unitState.mUniqueVluae = ((entityUniqueSkillEnergy.mValue <= entityUniqueSkillEnergy.mMaxValue) ? entityUniqueSkillEnergy.mValue : entityUniqueSkillEnergy.mMaxValue);
			unitState.mUniqueMaxValue = entityUniqueSkillEnergy.mMaxValue;
		}
		if (ConfigHelper.GetInstance().TryGetConfig<UniqueSkill>(entity.entityConfig.mId, out var config) && entity.hasEntityBlackboard && AttributeProcessor.IsEnableAbility(entity, config.AbilityId.get_Item(0)) && ((entity.entityBlackboard.var.mAbilityOriginalCanUse >> 3) & 1) == 1)
		{
			unitState.mValidQTE = unitState.mUniqueVluae >= unitState.mUniqueMaxValue;
		}
		else
		{
			unitState.mValidQTE = false;
		}
		if (entity.hasEntityExposedValueBreak)
		{
			unitState.mSourceSpaceDamage = entity.entityExposedValueBreak.Damage;
		}
		if (entity.hasEntityBlackboard && entity.hasEntityCD && entity.hasEntityCamp && (entity.entityCamp.mRoleTypeCamp == 1 || entity.entityCamp.mRoleTypeCamp == 2048 || entity.entityCamp.mRoleTypeCamp == 4096))
		{
			for (int k = 0; k <= 2; k++)
			{
				AbilityStatueInfo abilityStatueInfo = AbilitiesProcessor.GetAbilityStatueInfo(entity, (ButtonType)k);
				if (abilityStatueInfo.ID != 0)
				{
					unitState.mAbilityState.Add(abilityStatueInfo);
				}
			}
			AbilityStatueInfo abilityStatueInfo2 = AbilitiesProcessor.GetAbilityStatueInfo(entity, ButtonType.QTE);
			if (abilityStatueInfo2.ID != 0)
			{
				unitState.mAbilityState.Add(abilityStatueInfo2);
			}
			AbilityStatueInfo abilityStatueInfo3 = AbilitiesProcessor.GetAbilityStatueInfo(entity, ButtonType.AVOID);
			if (abilityStatueInfo3.ID != 0)
			{
				unitState.mAbilityState.Add(abilityStatueInfo3);
			}
			AbilityStatueInfo abilityStatueInfo4 = AbilitiesProcessor.GetAbilityStatueInfo(entity, ButtonType.MELEE);
			if (abilityStatueInfo4.ID != 0)
			{
				unitState.mAbilityState.Add(abilityStatueInfo4);
			}
			for (int l = 16; l <= 23; l++)
			{
				AbilityStatueInfo abilityStatueInfo5 = AbilitiesProcessor.GetAbilityStatueInfo(entity, (ButtonType)l);
				if (abilityStatueInfo5.ID != 0)
				{
					unitState.mAbilityState.Add(abilityStatueInfo5);
				}
			}
		}
		if (entity.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2171, out var baseValue, out var plusValue, out var tempPlusValue);
			unitState.mCantBeLocked = baseValue != 0;
			AttributeProcessor.GetAttributeWithIntName(entity.entityBlackboard.var.mAttributeID, 2172, out var baseValue2, out plusValue, out tempPlusValue);
			unitState.mBeLockedPriority = (int)baseValue2;
			unitState.mGrabTarget = entity.entityBlackboard.var.mGrabTarget;
		}
		if (entity.hasEntityResistance)
		{
			EntityResistance entityResistance = entity.entityResistance;
			unitState.mResistanceState = entityResistance.reState;
			unitState.mResistanceMaxValue = entityResistance.maxValue;
			unitState.mResistanceCurValue = entityResistance.curValue;
			unitState.mResistanceMaxTime = entityResistance.maxTime;
			unitState.mResistanceCurTime = entityResistance.curTime;
			unitState.mResistanceStateEle = entityResistance.reStateEle;
			if (entityResistance.element != null)
			{
				for (int m = 0; m < entityResistance.element.Count; m++)
				{
					unitState.mResistanceEle.Add(entityResistance.element[m]);
				}
			}
		}
		if (entity.hasEntityActionTransfiguration)
		{
			unitState.mNewRoleID = entity.entityActionTransfiguration.mRoleID;
		}
		else
		{
			unitState.mNewRoleID = 0;
		}
		if (entity.hasEntityShape)
		{
			unitState.mRadius = entity.entityShape.mShape.AvgCollisionRadius;
		}
		if (entity.hasEntityShape && entity.entityShape.mShape.IsEnable)
		{
			ShapeState item2 = new ShapeState
			{
				mPartType = entity.entityShape.mPartType,
				mAvgCollisionRadius = entity.entityShape.mShape.AvgCollisionRadius,
				mWorldPos = entity.entityShape.mShape.WorldPos,
				mShapeEntityID = entity.entityShape.mShape.OwnerID,
				mdestroyValChangeRule = entity.entityShape.mShapePartInfo.destroyValChangeRule,
				mDestroyVal = entity.entityShape.mShapePartInfo.destroyVal,
				mDestroyValLimit = entity.entityShape.mShapePartInfo.destroyValLimit
			};
			unitState.mShapeStates.Add(item2);
		}
		if (entity.FindChildrenTag(SimEntity.Tag.MultiColliders, out var children))
		{
			for (int n = 0; n < children.Count; n++)
			{
				if (children[n].hasEntityShape && children[n].entityShape.mShape.IsEnable && children[n].entityShape.GetLayer() == entity.entityShape.GetLayer())
				{
					ShapeState item3 = new ShapeState
					{
						mPartType = children[n].entityShape.mPartType,
						mAvgCollisionRadius = children[n].entityShape.mShape.AvgCollisionRadius,
						mWorldPos = children[n].entityShape.mShape.WorldPos,
						mShapeEntityID = children[n].entityShape.mShape.OwnerID,
						mdestroyValChangeRule = children[n].entityShape.mShapePartInfo.destroyValChangeRule,
						mDestroyVal = children[n].entityShape.mShapePartInfo.destroyVal,
						mDestroyValLimit = children[n].entityShape.mShapePartInfo.destroyValLimit
					};
					unitState.mShapeStates.Add(item3);
				}
			}
		}
		if (entity.hasEntityBlackboard)
		{
			SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(entity.entityBlackboard.var.mAimTarget);
			if (simEntityByMultiColliders != null)
			{
				unitState.mAimingTarget = simEntityByMultiColliders.creationIndex;
				unitState.mAimingPart = CommonProcessor.GetTargetShapePart(entity.entityBlackboard.var.mAimTarget);
			}
		}
		if (entity.hasEntityPostureValue)
		{
			unitState.mBreakState = entity.entityPostureValue.state;
			unitState.mBreakValue = entity.entityPostureValue.value;
			unitState.mMaxBreakValue = entity.entityPostureValue.maxValue;
			unitState.mBreakDamageType = entity.entityPostureValue.damageType;
		}
		if (entity.hasEntityMasterSkill)
		{
			EntityMasterSkill entityMasterSkill = entity.entityMasterSkill;
			unitState.mEntityMasterSkillCurValue = entityMasterSkill.mValue;
			unitState.mEntityMasterSkillMaxValue = entityMasterSkill.mMaxValue;
			unitState.mEntityMasterSkillCurCD = entityMasterSkill.mCD;
			unitState.mEntityMasterSkillMaxCD = entityMasterSkill.mMaxCD;
			unitState.mEntityMasterSkillConsumeValue = entityMasterSkill.mConsumeValue;
			unitState.mEntityMasterSkillConsumeCD = entityMasterSkill.mConsumeCD;
			unitState.mEntityMasterSkillConfigID = entityMasterSkill.mConfigID;
		}
		else
		{
			unitState.mEntityMasterSkillCurValue = 0;
			unitState.mEntityMasterSkillMaxValue = 0;
			unitState.mEntityMasterSkillCurCD = 0;
			unitState.mEntityMasterSkillMaxCD = 0;
			unitState.mEntityMasterSkillConsumeValue = 0;
			unitState.mEntityMasterSkillConsumeCD = 0;
			unitState.mEntityMasterSkillConfigID = 0;
		}
		frame.AllEntityStates.Add(unitState);
	}
}
