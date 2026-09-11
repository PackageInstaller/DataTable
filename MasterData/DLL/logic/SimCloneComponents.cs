using System.Collections.Generic;
using Entitas;

internal static class SimCloneComponents
{
	public static void Clone(this EntityMasterSkill sourceComponent, Entity target)
	{
		EntityMasterSkill entityMasterSkill = target.CreateComponent(43, typeof(EntityMasterSkill)) as EntityMasterSkill;
		entityMasterSkill.mState = sourceComponent.mState;
		entityMasterSkill.mValue = sourceComponent.mValue;
		entityMasterSkill.mMaxValue = sourceComponent.mMaxValue;
		entityMasterSkill.mCD = sourceComponent.mCD;
		entityMasterSkill.mMaxCD = sourceComponent.mMaxCD;
		entityMasterSkill.mConsumeValue = sourceComponent.mConsumeValue;
		entityMasterSkill.mConsumeCD = sourceComponent.mConsumeCD;
		entityMasterSkill.mConfigID = sourceComponent.mConfigID;
		if (target.HasComponent(43))
		{
			target.ReplaceComponent(43, entityMasterSkill);
		}
		else
		{
			target.AddComponent(43, entityMasterSkill);
		}
	}

	public static void Clone(this EntityMoveClamp sourceComponent, Entity target)
	{
		EntityMoveClamp entityMoveClamp = target.CreateComponent(44, typeof(EntityMoveClamp)) as EntityMoveClamp;
		entityMoveClamp.isCircle = sourceComponent.isCircle;
		entityMoveClamp.mCenter = sourceComponent.mCenter;
		entityMoveClamp.mZLength = sourceComponent.mZLength;
		entityMoveClamp.mXLength = sourceComponent.mXLength;
		entityMoveClamp.mRange = sourceComponent.mRange;
		if (target.HasComponent(44))
		{
			target.ReplaceComponent(44, entityMoveClamp);
		}
		else
		{
			target.AddComponent(44, entityMoveClamp);
		}
	}

	public static void Clone(this EntityActionParrying sourceComponent, Entity target)
	{
		EntityActionParrying entityActionParrying = target.CreateComponent(17, typeof(EntityActionParrying)) as EntityActionParrying;
		entityActionParrying.mAngle = sourceComponent.mAngle;
		entityActionParrying.mEnableFlag = sourceComponent.mEnableFlag;
		entityActionParrying.mEnableCount = sourceComponent.mEnableCount;
		if (target.HasComponent(17))
		{
			target.ReplaceComponent(17, entityActionParrying);
		}
		else
		{
			target.AddComponent(17, entityActionParrying);
		}
	}

	public static void Clone(this EntityResistance sourceComponent, Entity target)
	{
		EntityResistance entityResistance = target.CreateComponent(53, typeof(EntityResistance)) as EntityResistance;
		entityResistance.maxValue = sourceComponent.maxValue;
		entityResistance.curValue = sourceComponent.curValue;
		entityResistance.maxTime = sourceComponent.maxTime;
		entityResistance.curTime = sourceComponent.curTime;
		entityResistance.reState = sourceComponent.reState;
		entityResistance.reStateEle = sourceComponent.reStateEle;
		entityResistance.enterReason = sourceComponent.enterReason;
		entityResistance.exitReason = sourceComponent.exitReason;
		if (entityResistance.element == null)
		{
			entityResistance.element = new List<int>();
		}
		entityResistance.element.Clear();
		entityResistance.element.AddRange(sourceComponent.element);
		if (target.HasComponent(53))
		{
			target.ReplaceComponent(53, entityResistance);
		}
		else
		{
			target.AddComponent(53, entityResistance);
		}
	}

	public static void Clone(this EntityUniqueSkillEnergy sourceComponent, Entity target)
	{
		EntityUniqueSkillEnergy entityUniqueSkillEnergy = target.CreateComponent(62, typeof(EntityUniqueSkillEnergy)) as EntityUniqueSkillEnergy;
		entityUniqueSkillEnergy.mState = sourceComponent.mState;
		entityUniqueSkillEnergy.mValue = sourceComponent.mValue;
		entityUniqueSkillEnergy.mMaxValue = sourceComponent.mMaxValue;
		entityUniqueSkillEnergy.mAddValue = sourceComponent.mAddValue;
		entityUniqueSkillEnergy.mTick = sourceComponent.mTick;
		entityUniqueSkillEnergy.mRuntime = sourceComponent.mRuntime;
		if (target.HasComponent(62))
		{
			target.ReplaceComponent(62, entityUniqueSkillEnergy);
		}
		else
		{
			target.AddComponent(62, entityUniqueSkillEnergy);
		}
	}

	public static void Clone(this EntityActionManualAIInput sourceComponent, Entity target)
	{
		EntityActionManualAIInput entityActionManualAIInput = target.CreateComponent(10, typeof(EntityActionManualAIInput)) as EntityActionManualAIInput;
		entityActionManualAIInput.mStatus = sourceComponent.mStatus;
		entityActionManualAIInput.mInputKey = sourceComponent.mInputKey;
		entityActionManualAIInput.mCanDestroy = sourceComponent.mCanDestroy;
		entityActionManualAIInput.mIsPressing = sourceComponent.mIsPressing;
		if (target.HasComponent(10))
		{
			target.ReplaceComponent(10, entityActionManualAIInput);
		}
		else
		{
			target.AddComponent(10, entityActionManualAIInput);
		}
	}

	public static void Clone(this EntityActionModifyCombatScore sourceComponent, Entity target)
	{
		EntityActionModifyCombatScore entityActionModifyCombatScore = target.CreateComponent(13, typeof(EntityActionModifyCombatScore)) as EntityActionModifyCombatScore;
		entityActionModifyCombatScore.mStatus = sourceComponent.mStatus;
		if (entityActionModifyCombatScore.mModifyInfoList == null)
		{
			entityActionModifyCombatScore.mModifyInfoList = new List<ModifyCombatScoreInfo>();
		}
		entityActionModifyCombatScore.mModifyInfoList.Clear();
		entityActionModifyCombatScore.mModifyInfoList.AddRange(sourceComponent.mModifyInfoList);
		if (target.HasComponent(13))
		{
			target.ReplaceComponent(13, entityActionModifyCombatScore);
		}
		else
		{
			target.AddComponent(13, entityActionModifyCombatScore);
		}
	}

	public static void Clone(this EntityUltimateAvoidCD sourceComponent, Entity target)
	{
		EntityUltimateAvoidCD entityUltimateAvoidCD = target.CreateComponent(61, typeof(EntityUltimateAvoidCD)) as EntityUltimateAvoidCD;
		entityUltimateAvoidCD.mRuntime = sourceComponent.mRuntime;
		entityUltimateAvoidCD.mLeftUseCount = sourceComponent.mLeftUseCount;
		if (target.HasComponent(61))
		{
			target.ReplaceComponent(61, entityUltimateAvoidCD);
		}
		else
		{
			target.AddComponent(61, entityUltimateAvoidCD);
		}
	}

	public static void Clone(this EntityQTE sourceComponent, Entity target)
	{
		EntityQTE entityQTE = target.CreateComponent(50, typeof(EntityQTE)) as EntityQTE;
		entityQTE.mStatus = sourceComponent.mStatus;
		entityQTE.mID = sourceComponent.mID;
		entityQTE.mTime = sourceComponent.mTime;
		entityQTE.mTotalTime = sourceComponent.mTotalTime;
		if (target.HasComponent(50))
		{
			target.ReplaceComponent(50, entityQTE);
		}
		else
		{
			target.AddComponent(50, entityQTE);
		}
	}

	public static void Clone(this EntityActionAbilityLogicInput sourceComponent, Entity target)
	{
		EntityActionAbilityLogicInput entityActionAbilityLogicInput = target.CreateComponent(3, typeof(EntityActionAbilityLogicInput)) as EntityActionAbilityLogicInput;
		entityActionAbilityLogicInput.mBrokenAbilityID = sourceComponent.mBrokenAbilityID;
		entityActionAbilityLogicInput.mForceBroken = sourceComponent.mForceBroken;
		if (target.HasComponent(3))
		{
			target.ReplaceComponent(3, entityActionAbilityLogicInput);
		}
		else
		{
			target.AddComponent(3, entityActionAbilityLogicInput);
		}
	}

	public static void Clone(this EntityActionAvoidShadow sourceComponent, Entity target)
	{
		EntityActionAvoidShadow entityActionAvoidShadow = target.CreateComponent(5, typeof(EntityActionAvoidShadow)) as EntityActionAvoidShadow;
		entityActionAvoidShadow.EarliestPosition = sourceComponent.EarliestPosition;
		entityActionAvoidShadow.Posted = sourceComponent.Posted;
		entityActionAvoidShadow.leftTime = sourceComponent.leftTime;
		if (target.HasComponent(5))
		{
			target.ReplaceComponent(5, entityActionAvoidShadow);
		}
		else
		{
			target.AddComponent(5, entityActionAvoidShadow);
		}
	}

	public static void Clone(this EntityActionSubJoystick sourceComponent, Entity target)
	{
		EntityActionSubJoystick entityActionSubJoystick = target.CreateComponent(18, typeof(EntityActionSubJoystick)) as EntityActionSubJoystick;
		entityActionSubJoystick.CommandCode = sourceComponent.CommandCode;
		entityActionSubJoystick.TimelineID = sourceComponent.TimelineID;
		if (target.HasComponent(18))
		{
			target.ReplaceComponent(18, entityActionSubJoystick);
		}
		else
		{
			target.AddComponent(18, entityActionSubJoystick);
		}
	}

	public static void Clone(this EntityEndurance sourceComponent, Entity target)
	{
		EntityEndurance entityEndurance = target.CreateComponent(34, typeof(EntityEndurance)) as EntityEndurance;
		entityEndurance.maxValue = sourceComponent.maxValue;
		entityEndurance.currentValue = sourceComponent.currentValue;
		entityEndurance.resumeSpeed = sourceComponent.resumeSpeed;
		entityEndurance.consumeValue = sourceComponent.consumeValue;
		entityEndurance.state = sourceComponent.state;
		if (target.HasComponent(34))
		{
			target.ReplaceComponent(34, entityEndurance);
		}
		else
		{
			target.AddComponent(34, entityEndurance);
		}
	}

	public static void Clone(this EntityPuppet sourceComponent, Entity target)
	{
		EntityPuppet entityPuppet = target.CreateComponent(48, typeof(EntityPuppet)) as EntityPuppet;
		entityPuppet.mParent = sourceComponent.mParent;
		entityPuppet.mThinkTime = sourceComponent.mThinkTime;
		entityPuppet.mIsClose = sourceComponent.mIsClose;
		if (target.HasComponent(48))
		{
			target.ReplaceComponent(48, entityPuppet);
		}
		else
		{
			target.AddComponent(48, entityPuppet);
		}
	}

	public static void Clone(this EntityPuppetHost sourceComponent, Entity target)
	{
		EntityPuppetHost entityPuppetHost = target.CreateComponent(49, typeof(EntityPuppetHost)) as EntityPuppetHost;
		if (entityPuppetHost.mPuppets == null)
		{
			entityPuppetHost.mPuppets = new List<int>();
		}
		entityPuppetHost.mPuppets.Clear();
		entityPuppetHost.mPuppets.AddRange(sourceComponent.mPuppets);
		if (target.HasComponent(49))
		{
			target.ReplaceComponent(49, entityPuppetHost);
		}
		else
		{
			target.AddComponent(49, entityPuppetHost);
		}
	}

	public static void Clone(this EntityActionTransfiguration sourceComponent, Entity target)
	{
		EntityActionTransfiguration entityActionTransfiguration = target.CreateComponent(19, typeof(EntityActionTransfiguration)) as EntityActionTransfiguration;
		entityActionTransfiguration.mRoleID = sourceComponent.mRoleID;
		entityActionTransfiguration.mAppearID = sourceComponent.mAppearID;
		if (target.HasComponent(19))
		{
			target.ReplaceComponent(19, entityActionTransfiguration);
		}
		else
		{
			target.AddComponent(19, entityActionTransfiguration);
		}
	}

	public static void Clone(this EntityCD sourceComponent, Entity target)
	{
		EntityCD entityCD = target.CreateComponent(28, typeof(EntityCD)) as EntityCD;
		if (entityCD.mAward == null)
		{
			entityCD.mAward = new HashSet<int>(new IntComparer());
		}
		entityCD.mAward.Clear();
		foreach (int item in sourceComponent.mAward)
		{
			entityCD.mAward.Add(item);
		}
		if (entityCD.mIgnore == null)
		{
			entityCD.mIgnore = new HashSet<int>(new IntComparer());
		}
		entityCD.mIgnore.Clear();
		foreach (int item2 in sourceComponent.mIgnore)
		{
			entityCD.mIgnore.Add(item2);
		}
		if (entityCD.mAbilityMaxCD == null)
		{
			entityCD.mAbilityMaxCD = new Dictionary<int, AbilityMaxCDInfo>(new IntComparer());
		}
		entityCD.mAbilityMaxCD.Clear();
		foreach (KeyValuePair<int, AbilityMaxCDInfo> item3 in sourceComponent.mAbilityMaxCD)
		{
			entityCD.mAbilityMaxCD[item3.Key] = item3.Value;
		}
		if (entityCD.mAbilityMaxUse == null)
		{
			entityCD.mAbilityMaxUse = new Dictionary<int, int>(new IntComparer());
		}
		entityCD.mAbilityMaxUse.Clear();
		foreach (KeyValuePair<int, int> item4 in sourceComponent.mAbilityMaxUse)
		{
			entityCD.mAbilityMaxUse[item4.Key] = item4.Value;
		}
		if (entityCD.mAbilityCD == null)
		{
			entityCD.mAbilityCD = new List<AbilityCD>();
		}
		entityCD.mAbilityCD.Clear();
		entityCD.mAbilityCD.AddRange(sourceComponent.mAbilityCD);
		if (target.HasComponent(28))
		{
			target.ReplaceComponent(28, entityCD);
		}
		else
		{
			target.AddComponent(28, entityCD);
		}
	}

	public static void Clone(this EntityComboNumber sourceComponent, Entity target)
	{
		EntityComboNumber entityComboNumber = target.CreateComponent(30, typeof(EntityComboNumber)) as EntityComboNumber;
		entityComboNumber.comboCount = sourceComponent.comboCount;
		entityComboNumber.runningTime = sourceComponent.runningTime;
		if (target.HasComponent(30))
		{
			target.ReplaceComponent(30, entityComboNumber);
		}
		else
		{
			target.AddComponent(30, entityComboNumber);
		}
	}

	public static void Clone(this EntityTimer sourceComponent, Entity target)
	{
		EntityTimer entityTimer = target.CreateComponent(59, typeof(EntityTimer)) as EntityTimer;
		if (entityTimer.entityTimers == null)
		{
			entityTimer.entityTimers = new List<EntityTimerStruct>();
		}
		entityTimer.entityTimers.Clear();
		entityTimer.entityTimers.AddRange(sourceComponent.entityTimers);
		if (target.HasComponent(59))
		{
			target.ReplaceComponent(59, entityTimer);
		}
		else
		{
			target.AddComponent(59, entityTimer);
		}
	}

	public static void Clone(this EntityCameraView sourceComponent, Entity target)
	{
		EntityCameraView entityCameraView = target.CreateComponent(26, typeof(EntityCameraView)) as EntityCameraView;
		entityCameraView.mViewPosition = sourceComponent.mViewPosition;
		entityCameraView.mViewDirection = sourceComponent.mViewDirection;
		entityCameraView.mFOV = sourceComponent.mFOV;
		entityCameraView.mLimitDegree = sourceComponent.mLimitDegree;
		entityCameraView.mViewDistance = sourceComponent.mViewDistance;
		entityCameraView.mIsColinear = sourceComponent.mIsColinear;
		entityCameraView.mViewLerpTime = sourceComponent.mViewLerpTime;
		if (target.HasComponent(26))
		{
			target.ReplaceComponent(26, entityCameraView);
		}
		else
		{
			target.AddComponent(26, entityCameraView);
		}
	}

	public static void Clone(this EntityActionAbility sourceComponent, Entity target)
	{
		EntityActionAbility entityActionAbility = target.CreateComponent(1, typeof(EntityActionAbility)) as EntityActionAbility;
		entityActionAbility.mStatus = sourceComponent.mStatus;
		entityActionAbility.mAbilityID = sourceComponent.mAbilityID;
		entityActionAbility.mHitIndex = sourceComponent.mHitIndex;
		entityActionAbility.mOffsetIndex = sourceComponent.mOffsetIndex;
		entityActionAbility.mTargetID = sourceComponent.mTargetID;
		entityActionAbility.mKartunTime = sourceComponent.mKartunTime;
		entityActionAbility.mIsPressing = sourceComponent.mIsPressing;
		entityActionAbility.mCurLockIndex = sourceComponent.mCurLockIndex;
		entityActionAbility.mCasterID = sourceComponent.mCasterID;
		entityActionAbility.mEnableAbilityMovement = sourceComponent.mEnableAbilityMovement;
		entityActionAbility.mAbilitySpeed = sourceComponent.mAbilitySpeed;
		entityActionAbility.mLogicTime = sourceComponent.mLogicTime;
		entityActionAbility.mCurrentStateIndex = sourceComponent.mCurrentStateIndex;
		entityActionAbility.mCurTurnIndex = sourceComponent.mCurTurnIndex;
		entityActionAbility.mInUltimateAvoidFrame = sourceComponent.mInUltimateAvoidFrame;
		entityActionAbility.mTimeStep = sourceComponent.mTimeStep;
		entityActionAbility.mCanBeParry = sourceComponent.mCanBeParry;
		entityActionAbility.MAttackApproachSpeed = sourceComponent.MAttackApproachSpeed;
		if (target.HasComponent(1))
		{
			target.ReplaceComponent(1, entityActionAbility);
		}
		else
		{
			target.AddComponent(1, entityActionAbility);
		}
	}

	public static void Clone(this EntityHide sourceComponent, Entity target)
	{
		EntityHide entityHide = target.CreateComponent(39, typeof(EntityHide)) as EntityHide;
		entityHide.mHide = sourceComponent.mHide;
		if (target.HasComponent(39))
		{
			target.ReplaceComponent(39, entityHide);
		}
		else
		{
			target.AddComponent(39, entityHide);
		}
	}

	public static void Clone(this EntityPredicationPlayer sourceComponent, Entity target)
	{
		EntityPredicationPlayer entityPredicationPlayer = target.CreateComponent(47, typeof(EntityPredicationPlayer)) as EntityPredicationPlayer;
		entityPredicationPlayer.mOwnerID = sourceComponent.mOwnerID;
		if (target.HasComponent(47))
		{
			target.ReplaceComponent(47, entityPredicationPlayer);
		}
		else
		{
			target.AddComponent(47, entityPredicationPlayer);
		}
	}

	public static void Clone(this EntityRemotePlayer sourceComponent, Entity target)
	{
		EntityRemotePlayer entityRemotePlayer = target.CreateComponent(52, typeof(EntityRemotePlayer)) as EntityRemotePlayer;
		entityRemotePlayer.mNetID = sourceComponent.mNetID;
		entityRemotePlayer.mLocalEntityID = sourceComponent.mLocalEntityID;
		entityRemotePlayer.mIsLocalPlayer = sourceComponent.mIsLocalPlayer;
		if (target.HasComponent(52))
		{
			target.ReplaceComponent(52, entityRemotePlayer);
		}
		else
		{
			target.AddComponent(52, entityRemotePlayer);
		}
	}

	public static void Clone(this EntityActionManualInput sourceComponent, Entity target)
	{
		EntityActionManualInput entityActionManualInput = target.CreateComponent(11, typeof(EntityActionManualInput)) as EntityActionManualInput;
		entityActionManualInput.mStatus = sourceComponent.mStatus;
		entityActionManualInput.mInputKey = sourceComponent.mInputKey;
		entityActionManualInput.mInputStamp = sourceComponent.mInputStamp;
		entityActionManualInput.mCanDestroy = sourceComponent.mCanDestroy;
		entityActionManualInput.mIsPressing = sourceComponent.mIsPressing;
		if (target.HasComponent(11))
		{
			target.ReplaceComponent(11, entityActionManualInput);
		}
		else
		{
			target.AddComponent(11, entityActionManualInput);
		}
	}

	public static void Clone(this EntityActionMoveDirection sourceComponent, Entity target)
	{
		EntityActionMoveDirection entityActionMoveDirection = target.CreateComponent(16, typeof(EntityActionMoveDirection)) as EntityActionMoveDirection;
		entityActionMoveDirection.mStatus = sourceComponent.mStatus;
		entityActionMoveDirection.mDirection = sourceComponent.mDirection;
		entityActionMoveDirection.mLastDirection = sourceComponent.mLastDirection;
		entityActionMoveDirection.mIsTurn = sourceComponent.mIsTurn;
		entityActionMoveDirection.mLogicTime = sourceComponent.mLogicTime;
		entityActionMoveDirection.mSpeedDirection = sourceComponent.mSpeedDirection;
		entityActionMoveDirection.mMoveID = sourceComponent.mMoveID;
		entityActionMoveDirection.mTimeStep = sourceComponent.mTimeStep;
		entityActionMoveDirection.mMovementDirection = sourceComponent.mMovementDirection;
		entityActionMoveDirection.mMoveMode = sourceComponent.mMoveMode;
		if (target.HasComponent(16))
		{
			target.ReplaceComponent(16, entityActionMoveDirection);
		}
		else
		{
			target.AddComponent(16, entityActionMoveDirection);
		}
	}

	public static void Clone(this EntityTestGoogle sourceComponent, Entity target)
	{
		EntityTestGoogle entityTestGoogle = target.CreateComponent(58, typeof(EntityTestGoogle)) as EntityTestGoogle;
		entityTestGoogle.mRecvCache = sourceComponent.mRecvCache;
		if (target.HasComponent(58))
		{
			target.ReplaceComponent(58, entityTestGoogle);
		}
		else
		{
			target.AddComponent(58, entityTestGoogle);
		}
	}

	public static void Clone(this EntityLocalPlayer sourceComponent, Entity target)
	{
		EntityLocalPlayer entityLocalPlayer = target.CreateComponent(42, typeof(EntityLocalPlayer)) as EntityLocalPlayer;
		entityLocalPlayer.mNetID = sourceComponent.mNetID;
		entityLocalPlayer.mRemoteEntityID = sourceComponent.mRemoteEntityID;
		if (target.HasComponent(42))
		{
			target.ReplaceComponent(42, entityLocalPlayer);
		}
		else
		{
			target.AddComponent(42, entityLocalPlayer);
		}
	}

	public static void Clone(this EntitySkillEffect sourceComponent, Entity target)
	{
		EntitySkillEffect entitySkillEffect = target.CreateComponent(56, typeof(EntitySkillEffect)) as EntitySkillEffect;
		entitySkillEffect.mSkillEffectCreator = sourceComponent.mSkillEffectCreator;
		entitySkillEffect.mSkillConfigID = sourceComponent.mSkillConfigID;
		entitySkillEffect.mSkillCastCount = sourceComponent.mSkillCastCount;
		entitySkillEffect.mSkillSingleTargetID = sourceComponent.mSkillSingleTargetID;
		entitySkillEffect.mEffectStartPosition = sourceComponent.mEffectStartPosition;
		entitySkillEffect.mEffectPosition = sourceComponent.mEffectPosition;
		entitySkillEffect.mEffectReadyTime = sourceComponent.mEffectReadyTime;
		entitySkillEffect.mEffectDuring = sourceComponent.mEffectDuring;
		entitySkillEffect.mEffectTick = sourceComponent.mEffectTick;
		if (target.HasComponent(56))
		{
			target.ReplaceComponent(56, entitySkillEffect);
		}
		else
		{
			target.AddComponent(56, entitySkillEffect);
		}
	}

	public static void Clone(this EntityActionJump sourceComponent, Entity target)
	{
		EntityActionJump entityActionJump = target.CreateComponent(9, typeof(EntityActionJump)) as EntityActionJump;
		entityActionJump.mTargetPos = sourceComponent.mTargetPos;
		entityActionJump.mMaxHeight = sourceComponent.mMaxHeight;
		entityActionJump.mStartActionReadyTime = sourceComponent.mStartActionReadyTime;
		entityActionJump.mG = sourceComponent.mG;
		entityActionJump.mStatus = sourceComponent.mStatus;
		entityActionJump.mHSpeed = sourceComponent.mHSpeed;
		entityActionJump.mVSpeed = sourceComponent.mVSpeed;
		entityActionJump.mUseTartgetPos = sourceComponent.mUseTartgetPos;
		if (target.HasComponent(9))
		{
			target.ReplaceComponent(9, entityActionJump);
		}
		else
		{
			target.AddComponent(9, entityActionJump);
		}
	}

	public static void Clone(this EntityActionIdle sourceComponent, Entity target)
	{
		EntityActionIdle entityActionIdle = target.CreateComponent(8, typeof(EntityActionIdle)) as EntityActionIdle;
		entityActionIdle.mStatus = sourceComponent.mStatus;
		if (target.HasComponent(8))
		{
			target.ReplaceComponent(8, entityActionIdle);
		}
		else
		{
			target.AddComponent(8, entityActionIdle);
		}
	}

	public static void Clone(this EntityConfig sourceComponent, Entity target)
	{
		EntityConfig entityConfig = target.CreateComponent(32, typeof(EntityConfig)) as EntityConfig;
		entityConfig.mConfig = sourceComponent.mConfig;
		entityConfig.mId = sourceComponent.mId;
		if (target.HasComponent(32))
		{
			target.ReplaceComponent(32, entityConfig);
		}
		else
		{
			target.AddComponent(32, entityConfig);
		}
	}

	public static void Clone(this EntityHitRecover sourceComponent, Entity target)
	{
		EntityHitRecover entityHitRecover = target.CreateComponent(40, typeof(EntityHitRecover)) as EntityHitRecover;
		entityHitRecover.mHitRecover = sourceComponent.mHitRecover;
		entityHitRecover.mHitRecoverTime = sourceComponent.mHitRecoverTime;
		entityHitRecover.mHitRecoverActionID = sourceComponent.mHitRecoverActionID;
		entityHitRecover.mLookAtDirection = sourceComponent.mLookAtDirection;
		entityHitRecover.mHitDirection = sourceComponent.mHitDirection;
		entityHitRecover.mHitSpeed = sourceComponent.mHitSpeed;
		entityHitRecover.mHitAcceleration = sourceComponent.mHitAcceleration;
		entityHitRecover.mHitInfo = sourceComponent.mHitInfo;
		entityHitRecover.mHitUpSpeed = sourceComponent.mHitUpSpeed;
		entityHitRecover.mEnableMovement = sourceComponent.mEnableMovement;
		entityHitRecover.mHitOffsetTime = sourceComponent.mHitOffsetTime;
		entityHitRecover.mHitRecoverStatus = sourceComponent.mHitRecoverStatus;
		entityHitRecover.mCanProcessVerticalTime = sourceComponent.mCanProcessVerticalTime;
		entityHitRecover.mHitAbilityID = sourceComponent.mHitAbilityID;
		entityHitRecover.mHitCount = sourceComponent.mHitCount;
		entityHitRecover.mHitHorizontalSpeedOnFloat = sourceComponent.mHitHorizontalSpeedOnFloat;
		entityHitRecover.mCurrentStateIndex = sourceComponent.mCurrentStateIndex;
		entityHitRecover.mTimeScale = sourceComponent.mTimeScale;
		entityHitRecover.mLoop = sourceComponent.mLoop;
		entityHitRecover.mTimeStep = sourceComponent.mTimeStep;
		entityHitRecover.mCasterID = sourceComponent.mCasterID;
		entityHitRecover.mLastOffsetMove = sourceComponent.mLastOffsetMove;
		if (target.HasComponent(40))
		{
			target.ReplaceComponent(40, entityHitRecover);
		}
		else
		{
			target.AddComponent(40, entityHitRecover);
		}
	}

	public static void Clone(this EntityActionBorn sourceComponent, Entity target)
	{
		EntityActionBorn entityActionBorn = target.CreateComponent(6, typeof(EntityActionBorn)) as EntityActionBorn;
		entityActionBorn.mStatus = sourceComponent.mStatus;
		entityActionBorn.mBornDuring = sourceComponent.mBornDuring;
		if (target.HasComponent(6))
		{
			target.ReplaceComponent(6, entityActionBorn);
		}
		else
		{
			target.AddComponent(6, entityActionBorn);
		}
	}

	public static void Clone(this EntityActionMelee sourceComponent, Entity target)
	{
		EntityActionMelee entityActionMelee = target.CreateComponent(12, typeof(EntityActionMelee)) as EntityActionMelee;
		entityActionMelee.mStatus = sourceComponent.mStatus;
		entityActionMelee.mAttackID = sourceComponent.mAttackID;
		entityActionMelee.mIsReady = sourceComponent.mIsReady;
		entityActionMelee.mAttackTime = sourceComponent.mAttackTime;
		entityActionMelee.mAttackDirection = sourceComponent.mAttackDirection;
		entityActionMelee.mAttackStatus = sourceComponent.mAttackStatus;
		entityActionMelee.mCurOffsetCount = sourceComponent.mCurOffsetCount;
		entityActionMelee.mCurHitCount = sourceComponent.mCurHitCount;
		entityActionMelee.mNextAttackTime = sourceComponent.mNextAttackTime;
		entityActionMelee.mAttackOnceDuring = sourceComponent.mAttackOnceDuring;
		entityActionMelee.mHitDuring = sourceComponent.mHitDuring;
		entityActionMelee.mHitCheckCount = sourceComponent.mHitCheckCount;
		if (target.HasComponent(12))
		{
			target.ReplaceComponent(12, entityActionMelee);
		}
		else
		{
			target.AddComponent(12, entityActionMelee);
		}
	}

	public static void Clone(this EntityActionDeath sourceComponent, Entity target)
	{
		EntityActionDeath entityActionDeath = target.CreateComponent(7, typeof(EntityActionDeath)) as EntityActionDeath;
		entityActionDeath.mKiller = sourceComponent.mKiller;
		entityActionDeath.mAbilityID = sourceComponent.mAbilityID;
		entityActionDeath.mDeathDuring = sourceComponent.mDeathDuring;
		if (target.HasComponent(7))
		{
			target.ReplaceComponent(7, entityActionDeath);
		}
		else
		{
			target.AddComponent(7, entityActionDeath);
		}
	}

	public static void Clone(this EntityActionModifyHP sourceComponent, Entity target)
	{
		EntityActionModifyHP entityActionModifyHP = target.CreateComponent(14, typeof(EntityActionModifyHP)) as EntityActionModifyHP;
		entityActionModifyHP.mStatus = sourceComponent.mStatus;
		if (entityActionModifyHP.mModifyInfoList == null)
		{
			entityActionModifyHP.mModifyInfoList = new List<ModifyHPInfo>();
		}
		entityActionModifyHP.mModifyInfoList.Clear();
		entityActionModifyHP.mModifyInfoList.AddRange(sourceComponent.mModifyInfoList);
		if (target.HasComponent(14))
		{
			target.ReplaceComponent(14, entityActionModifyHP);
		}
		else
		{
			target.AddComponent(14, entityActionModifyHP);
		}
	}

	public static void Clone(this EntityActionAttack sourceComponent, Entity target)
	{
		EntityActionAttack entityActionAttack = target.CreateComponent(4, typeof(EntityActionAttack)) as EntityActionAttack;
		entityActionAttack.mStatus = sourceComponent.mStatus;
		entityActionAttack.mIsReady = sourceComponent.mIsReady;
		entityActionAttack.mAimDuring = sourceComponent.mAimDuring;
		entityActionAttack.mHitDuring = sourceComponent.mHitDuring;
		entityActionAttack.mHitCheckCount = sourceComponent.mHitCheckCount;
		entityActionAttack.mAttackTime = sourceComponent.mAttackTime;
		entityActionAttack.mAttackOnceDuring = sourceComponent.mAttackOnceDuring;
		entityActionAttack.mNextAttackTime = sourceComponent.mNextAttackTime;
		entityActionAttack.mIsCD = sourceComponent.mIsCD;
		entityActionAttack.mAttackDirection = sourceComponent.mAttackDirection;
		if (target.HasComponent(4))
		{
			target.ReplaceComponent(4, entityActionAttack);
		}
		else
		{
			target.AddComponent(4, entityActionAttack);
		}
	}

	public static void Clone(this EntityActionMove sourceComponent, Entity target)
	{
		EntityActionMove entityActionMove = target.CreateComponent(15, typeof(EntityActionMove)) as EntityActionMove;
		entityActionMove.mStatus = sourceComponent.mStatus;
		entityActionMove.mTargetPos = sourceComponent.mTargetPos;
		entityActionMove.mCurrentWaypointIndex = sourceComponent.mCurrentWaypointIndex;
		entityActionMove.mPath = sourceComponent.mPath;
		entityActionMove.mHasCaculated = sourceComponent.mHasCaculated;
		entityActionMove.mNeedAutoPath = sourceComponent.mNeedAutoPath;
		if (target.HasComponent(15))
		{
			target.ReplaceComponent(15, entityActionMove);
		}
		else
		{
			target.AddComponent(15, entityActionMove);
		}
	}

	public static void Clone(this EntityActionWeaponEquip sourceComponent, Entity target)
	{
		EntityActionWeaponEquip entityActionWeaponEquip = target.CreateComponent(20, typeof(EntityActionWeaponEquip)) as EntityActionWeaponEquip;
		entityActionWeaponEquip.mStatus = sourceComponent.mStatus;
		entityActionWeaponEquip.mWantEquipWeaponID = sourceComponent.mWantEquipWeaponID;
		entityActionWeaponEquip.mEquipDuring = sourceComponent.mEquipDuring;
		if (target.HasComponent(20))
		{
			target.ReplaceComponent(20, entityActionWeaponEquip);
		}
		else
		{
			target.AddComponent(20, entityActionWeaponEquip);
		}
	}

	public static void Clone(this EntityActionAbilityDirection sourceComponent, Entity target)
	{
		EntityActionAbilityDirection entityActionAbilityDirection = target.CreateComponent(2, typeof(EntityActionAbilityDirection)) as EntityActionAbilityDirection;
		entityActionAbilityDirection.mStatus = sourceComponent.mStatus;
		entityActionAbilityDirection.mDirection = sourceComponent.mDirection;
		if (target.HasComponent(2))
		{
			target.ReplaceComponent(2, entityActionAbilityDirection);
		}
		else
		{
			target.AddComponent(2, entityActionAbilityDirection);
		}
	}

	public static void Clone(this EntityBlackboard sourceComponent, Entity target)
	{
		EntityBlackboard entityBlackboard = target.CreateComponent(23, typeof(EntityBlackboard)) as EntityBlackboard;
		if (entityBlackboard.var == null)
		{
			entityBlackboard.var = new SimBlackboard();
		}
		else
		{
			entityBlackboard.var.Reset();
		}
		entityBlackboard.var.initFinished = sourceComponent.var.initFinished;
		entityBlackboard.var.sendDeathEvent = sourceComponent.var.sendDeathEvent;
		entityBlackboard.var.mEntityID = sourceComponent.var.mEntityID;
		entityBlackboard.var.mAttributeID = sourceComponent.var.mAttributeID;
		entityBlackboard.var.mHpStripCount = sourceComponent.var.mHpStripCount;
		entityBlackboard.var.mMaxHP = sourceComponent.var.mMaxHP;
		entityBlackboard.var.mMaxSpeed = sourceComponent.var.mMaxSpeed;
		entityBlackboard.var.mUseRunMoveCurve = sourceComponent.var.mUseRunMoveCurve;
		entityBlackboard.var.mSpeedFactor = sourceComponent.var.mSpeedFactor;
		entityBlackboard.var.mEntityTimeScale = sourceComponent.var.mEntityTimeScale;
		entityBlackboard.var.mHide = sourceComponent.var.mHide;
		entityBlackboard.var.mAIID = sourceComponent.var.mAIID;
		entityBlackboard.var.mRolePostion = sourceComponent.var.mRolePostion;
		entityBlackboard.var.creator = sourceComponent.var.creator;
		entityBlackboard.var.mRobotType = sourceComponent.var.mRobotType;
		entityBlackboard.var.mActionBusy = sourceComponent.var.mActionBusy;
		entityBlackboard.var.mIsCaught = sourceComponent.var.mIsCaught;
		entityBlackboard.var.mDeltaRotationSpeed = sourceComponent.var.mDeltaRotationSpeed;
		entityBlackboard.var.mTargetPos = sourceComponent.var.mTargetPos;
		entityBlackboard.var.mAimTarget = sourceComponent.var.mAimTarget;
		entityBlackboard.var.mLastTarget = sourceComponent.var.mLastTarget;
		entityBlackboard.var.mTriggerTarget = sourceComponent.var.mTriggerTarget;
		entityBlackboard.var.mIsLookatAimTarget = sourceComponent.var.mIsLookatAimTarget;
		entityBlackboard.var.mIsMoveLock = sourceComponent.var.mIsMoveLock;
		entityBlackboard.var.mDesiredVelocity = sourceComponent.var.mDesiredVelocity;
		entityBlackboard.var.mDesiredPos = sourceComponent.var.mDesiredPos;
		entityBlackboard.var.mDesiredSpeed = sourceComponent.var.mDesiredSpeed;
		entityBlackboard.var.mCalculatedSpeed = sourceComponent.var.mCalculatedSpeed;
		entityBlackboard.var.mCalculatedPos = sourceComponent.var.mCalculatedPos;
		entityBlackboard.var.mCalculatedVec = sourceComponent.var.mCalculatedVec;
		entityBlackboard.var.mDesiredMoveID = sourceComponent.var.mDesiredMoveID;
		entityBlackboard.var.mPickNextWaypointDist = sourceComponent.var.mPickNextWaypointDist;
		entityBlackboard.var.mSlowdownDistance = sourceComponent.var.mSlowdownDistance;
		entityBlackboard.var.mMinMoveScale = sourceComponent.var.mMinMoveScale;
		entityBlackboard.var.mForwardLook = sourceComponent.var.mForwardLook;
		entityBlackboard.var.mLastDamageAmount = sourceComponent.var.mLastDamageAmount;
		entityBlackboard.var.mBeHitAbilitiID = sourceComponent.var.mBeHitAbilitiID;
		entityBlackboard.var.mBeHitIndex = sourceComponent.var.mBeHitIndex;
		entityBlackboard.var.mIsHitByThump = sourceComponent.var.mIsHitByThump;
		entityBlackboard.var.mKillerID = sourceComponent.var.mKillerID;
		entityBlackboard.var.mLastHitAbilityID = sourceComponent.var.mLastHitAbilityID;
		entityBlackboard.var.mKillDamageType = sourceComponent.var.mKillDamageType;
		entityBlackboard.var.mIsBeInterrupt = sourceComponent.var.mIsBeInterrupt;
		entityBlackboard.var.mKillThrownID = sourceComponent.var.mKillThrownID;
		entityBlackboard.var.mLastAbilityID = sourceComponent.var.mLastAbilityID;
		entityBlackboard.var.mNewAbilityStartFrame = sourceComponent.var.mNewAbilityStartFrame;
		entityBlackboard.var.mCameraAngle = sourceComponent.var.mCameraAngle;
		entityBlackboard.var.hasManualLock = sourceComponent.var.hasManualLock;
		entityBlackboard.var.lockType = sourceComponent.var.lockType;
		entityBlackboard.var.TriggeredQTE = sourceComponent.var.TriggeredQTE;
		entityBlackboard.var.mBeaconPosition = sourceComponent.var.mBeaconPosition;
		entityBlackboard.var.mBeaconForward = sourceComponent.var.mBeaconForward;
		entityBlackboard.var.mTestSkill = sourceComponent.var.mTestSkill;
		entityBlackboard.var.meleeIndex = sourceComponent.var.meleeIndex;
		entityBlackboard.var.mAttackCount = sourceComponent.var.mAttackCount;
		entityBlackboard.var.mOnPressDownBtnIDMask = sourceComponent.var.mOnPressDownBtnIDMask;
		entityBlackboard.var.mIsBanMelee = sourceComponent.var.mIsBanMelee;
		entityBlackboard.var.mAbilityEnable = sourceComponent.var.mAbilityEnable;
		entityBlackboard.var.mAbilityDisableFlag = sourceComponent.var.mAbilityDisableFlag;
		entityBlackboard.var.abilityLevel = sourceComponent.var.abilityLevel;
		entityBlackboard.var.mLockMovementCount = sourceComponent.var.mLockMovementCount;
		entityBlackboard.var.mRunStartSlot = sourceComponent.var.mRunStartSlot;
		entityBlackboard.var.mNearStopSlot = sourceComponent.var.mNearStopSlot;
		entityBlackboard.var.mRushIDSlot = sourceComponent.var.mRushIDSlot;
		entityBlackboard.var.mRushStopIDSlot = sourceComponent.var.mRushStopIDSlot;
		entityBlackboard.var.mRunSlot = sourceComponent.var.mRunSlot;
		entityBlackboard.var.mMovementStopSlot = sourceComponent.var.mMovementStopSlot;
		entityBlackboard.var.mBattleIldeRecoverSlot = sourceComponent.var.mBattleIldeRecoverSlot;
		entityBlackboard.var.mRunLeftIDSlot = sourceComponent.var.mRunLeftIDSlot;
		entityBlackboard.var.mRunRightIDSlot = sourceComponent.var.mRunRightIDSlot;
		entityBlackboard.var.mDeathTimeType = sourceComponent.var.mDeathTimeType;
		entityBlackboard.var.mDeathSlot = sourceComponent.var.mDeathSlot;
		entityBlackboard.var.mAirDeathSlot = sourceComponent.var.mAirDeathSlot;
		entityBlackboard.var.mNoAnimationDeathSlot = sourceComponent.var.mNoAnimationDeathSlot;
		entityBlackboard.var.mFallDownDeathSlot = sourceComponent.var.mFallDownDeathSlot;
		entityBlackboard.var.mJumpStartSlot = sourceComponent.var.mJumpStartSlot;
		entityBlackboard.var.mJumpUpLoopSlot = sourceComponent.var.mJumpUpLoopSlot;
		entityBlackboard.var.mJumpAirSlot = sourceComponent.var.mJumpAirSlot;
		entityBlackboard.var.mJumpDownLoopSlot = sourceComponent.var.mJumpDownLoopSlot;
		entityBlackboard.var.mJumpLandSlot = sourceComponent.var.mJumpLandSlot;
		entityBlackboard.var.mHitRecoverSlot = sourceComponent.var.mHitRecoverSlot;
		entityBlackboard.var.mHitRecoverIndex = sourceComponent.var.mHitRecoverIndex;
		entityBlackboard.var.mHitRecoverSlots = sourceComponent.var.mHitRecoverSlots;
		entityBlackboard.var.mHitAirSlot = sourceComponent.var.mHitAirSlot;
		entityBlackboard.var.mHitUpSlot = sourceComponent.var.mHitUpSlot;
		entityBlackboard.var.mHitDownSlot = sourceComponent.var.mHitDownSlot;
		entityBlackboard.var.mHitFloorSlot = sourceComponent.var.mHitFloorSlot;
		entityBlackboard.var.mGetUpSlot = sourceComponent.var.mGetUpSlot;
		entityBlackboard.var.mAvoidForwardSlots = sourceComponent.var.mAvoidForwardSlots;
		entityBlackboard.var.mAvoidBackSlots = sourceComponent.var.mAvoidBackSlots;
		entityBlackboard.var.mMeleesSlots = sourceComponent.var.mMeleesSlots;
		entityBlackboard.var.mAbilitySlots = sourceComponent.var.mAbilitySlots;
		entityBlackboard.var.mIsStoic = sourceComponent.var.mIsStoic;
		entityBlackboard.var.mAbilityOriginalCanUse = sourceComponent.var.mAbilityOriginalCanUse;
		entityBlackboard.var.mEnergyType = sourceComponent.var.mEnergyType;
		entityBlackboard.var.mPublicSkillEntityChange = sourceComponent.var.mPublicSkillEntityChange;
		entityBlackboard.var.mCharacterParamUltimateAvoidCD = sourceComponent.var.mCharacterParamUltimateAvoidCD;
		entityBlackboard.var.mUltimateAvoidMaxUseCount = sourceComponent.var.mUltimateAvoidMaxUseCount;
		entityBlackboard.var.mCharacterParamItemPickUpRadius = sourceComponent.var.mCharacterParamItemPickUpRadius;
		entityBlackboard.var.mCombatScore = sourceComponent.var.mCombatScore;
		entityBlackboard.var.BattleIdleTime = sourceComponent.var.BattleIdleTime;
		entityBlackboard.var.IdleState = sourceComponent.var.IdleState;
		entityBlackboard.var.LocalPositionOfCombination = sourceComponent.var.LocalPositionOfCombination;
		entityBlackboard.var.timer = sourceComponent.var.timer;
		entityBlackboard.var.mDropItems = sourceComponent.var.mDropItems;
		entityBlackboard.var.commonDamageReductions = sourceComponent.var.commonDamageReductions;
		entityBlackboard.var.mTempCanBeGrab = sourceComponent.var.mTempCanBeGrab;
		entityBlackboard.var.mGrabTarget = sourceComponent.var.mGrabTarget;
		entityBlackboard.var.mHasTurnMoveID = sourceComponent.var.mHasTurnMoveID;
		entityBlackboard.var.mTurnLeftMoveID = sourceComponent.var.mTurnLeftMoveID;
		entityBlackboard.var.mTurnRightMoveID = sourceComponent.var.mTurnRightMoveID;
		entityBlackboard.var.mTurnLimitAngle = sourceComponent.var.mTurnLimitAngle;
		entityBlackboard.var.mTurnRotationSpeed = sourceComponent.var.mTurnRotationSpeed;
		entityBlackboard.var.mTempCanBeTransfer = sourceComponent.var.mTempCanBeTransfer;
		entityBlackboard.var.mEquipLv = sourceComponent.var.mEquipLv;
		entityBlackboard.var.mAbilityStartFroward = sourceComponent.var.mAbilityStartFroward;
		entityBlackboard.var.mConfigID = sourceComponent.var.mConfigID;
		entityBlackboard.var.mFightLevel = sourceComponent.var.mFightLevel;
		entityBlackboard.var.mHP = sourceComponent.var.mHP;
		entityBlackboard.var.mRaceID = sourceComponent.var.mRaceID;
		entityBlackboard.var.enemyType = sourceComponent.var.enemyType;
		if (target.HasComponent(23))
		{
			target.ReplaceComponent(23, entityBlackboard);
		}
		else
		{
			target.AddComponent(23, entityBlackboard);
		}
	}

	public static void Clone(this EntityCamp sourceComponent, Entity target)
	{
		EntityCamp entityCamp = target.CreateComponent(27, typeof(EntityCamp)) as EntityCamp;
		entityCamp.mRoleTypeCamp = sourceComponent.mRoleTypeCamp;
		if (target.HasComponent(27))
		{
			target.ReplaceComponent(27, entityCamp);
		}
		else
		{
			target.AddComponent(27, entityCamp);
		}
	}

	public static void Clone(this EntityCollisionInfo sourceComponent, Entity target)
	{
		EntityCollisionInfo entityCollisionInfo = target.CreateComponent(29, typeof(EntityCollisionInfo)) as EntityCollisionInfo;
		entityCollisionInfo.contactEntity = sourceComponent.contactEntity;
		entityCollisionInfo.collisionStatus = sourceComponent.collisionStatus;
		if (target.HasComponent(29))
		{
			target.ReplaceComponent(29, entityCollisionInfo);
		}
		else
		{
			target.AddComponent(29, entityCollisionInfo);
		}
	}

	public static void Clone(this EntityShape sourceComponent, Entity target)
	{
		EntityShape entityShape = target.CreateComponent(55, typeof(EntityShape)) as EntityShape;
		entityShape.mOffset = sourceComponent.mOffset;
		entityShape.mPartType = sourceComponent.mPartType;
		entityShape.mShape = sourceComponent.mShape;
		entityShape.mLayer = sourceComponent.mLayer;
		entityShape.mWeight = sourceComponent.mWeight;
		entityShape.mShapePartInfo = sourceComponent.mShapePartInfo;
		if (target.HasComponent(55))
		{
			target.ReplaceComponent(55, entityShape);
		}
		else
		{
			target.AddComponent(55, entityShape);
		}
	}

	public static void Clone(this Unit sourceComponent, Entity target)
	{
		Unit unit = target.CreateComponent(74, typeof(Unit)) as Unit;
		unit.mUnitClass = sourceComponent.mUnitClass;
		if (target.HasComponent(74))
		{
			target.ReplaceComponent(74, unit);
		}
		else
		{
			target.AddComponent(74, unit);
		}
	}

	public static void Clone(this EntityRVO sourceComponent, Entity target)
	{
		EntityRVO entityRVO = target.CreateComponent(54, typeof(EntityRVO)) as EntityRVO;
		entityRVO.agent = sourceComponent.agent;
		entityRVO.bugPrevAvoided = sourceComponent.bugPrevAvoided;
		entityRVO.bugDirection = sourceComponent.bugDirection;
		entityRVO.bugTimer = sourceComponent.bugTimer;
		entityRVO.mAgentTimeHorizon = sourceComponent.mAgentTimeHorizon;
		entityRVO.mObstacleTimeHorizon = sourceComponent.mObstacleTimeHorizon;
		entityRVO.mlockWhenNotMoving = sourceComponent.mlockWhenNotMoving;
		entityRVO.mMaxNeighbours = sourceComponent.mMaxNeighbours;
		entityRVO.mLayer = sourceComponent.mLayer;
		entityRVO.mColliderWith = sourceComponent.mColliderWith;
		entityRVO.mPriority = sourceComponent.mPriority;
		if (target.HasComponent(54))
		{
			target.ReplaceComponent(54, entityRVO);
		}
		else
		{
			target.AddComponent(54, entityRVO);
		}
	}

	public static void Clone(this SimTransform sourceComponent, Entity target)
	{
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		SimTransform simTransform = target.CreateComponent(72, typeof(SimTransform)) as SimTransform;
		simTransform.position = sourceComponent.position;
		simTransform.forward = sourceComponent.forward;
		simTransform.rotation = sourceComponent.rotation;
		simTransform.inverseRotation = sourceComponent.inverseRotation;
		simTransform.localRotation = sourceComponent.localRotation;
		simTransform.localScale = sourceComponent.localScale;
		simTransform.inverseMatrix = sourceComponent.inverseMatrix;
		simTransform.identity = sourceComponent.identity;
		simTransform.onlyTranslational = sourceComponent.onlyTranslational;
		simTransform.speed = sourceComponent.speed;
		simTransform.Matrix = sourceComponent.Matrix;
		if (target.HasComponent(72))
		{
			target.ReplaceComponent(72, simTransform);
		}
		else
		{
			target.AddComponent(72, simTransform);
		}
	}

	public static void Clone(this Projectile sourceComponent, Entity target)
	{
		Projectile component = target.CreateComponent(65, typeof(Projectile)) as Projectile;
		if (target.HasComponent(65))
		{
			target.ReplaceComponent(65, component);
		}
		else
		{
			target.AddComponent(65, component);
		}
	}

	public static void Clone(this EntityDetectable sourceComponent, Entity target)
	{
		EntityDetectable component = target.CreateComponent(33, typeof(EntityDetectable)) as EntityDetectable;
		if (target.HasComponent(33))
		{
			target.ReplaceComponent(33, component);
		}
		else
		{
			target.AddComponent(33, component);
		}
	}

	public static void Clone(this EntityHealth sourceComponent, Entity target)
	{
		EntityHealth entityHealth = target.CreateComponent(38, typeof(EntityHealth)) as EntityHealth;
		entityHealth.MaxHealth = sourceComponent.MaxHealth;
		entityHealth.mCurrentHealth = sourceComponent.mCurrentHealth;
		entityHealth.mLastDamagedAtFrame = sourceComponent.mLastDamagedAtFrame;
		if (target.HasComponent(38))
		{
			target.ReplaceComponent(38, entityHealth);
		}
		else
		{
			target.AddComponent(38, entityHealth);
		}
	}

	public static void Clone(this EntityPositon sourceComponent, Entity target)
	{
		EntityPositon entityPositon = target.CreateComponent(45, typeof(EntityPositon)) as EntityPositon;
		entityPositon.mPosition = sourceComponent.mPosition;
		entityPositon.mForward = sourceComponent.mForward;
		entityPositon.mForwardAngle = sourceComponent.mForwardAngle;
		entityPositon.mUp = sourceComponent.mUp;
		entityPositon.IsTeleport = sourceComponent.IsTeleport;
		if (target.HasComponent(45))
		{
			target.ReplaceComponent(45, entityPositon);
		}
		else
		{
			target.AddComponent(45, entityPositon);
		}
	}

	public static void Clone(this EntityBuff sourceComponent, Entity target)
	{
		EntityBuff entityBuff = target.CreateComponent(25, typeof(EntityBuff)) as EntityBuff;
		sourceComponent.CopyBuffTo(entityBuff);
		if (target.HasComponent(25))
		{
			target.ReplaceComponent(25, entityBuff);
		}
		else
		{
			target.AddComponent(25, entityBuff);
		}
	}

	public static void CloneTo(this IEntity entity, Entity target, int index)
	{
		if (index == 43)
		{
			EntityMasterSkill sourceComponent = entity.GetComponent(index) as EntityMasterSkill;
			sourceComponent.Clone(target);
		}
		if (index == 44)
		{
			EntityMoveClamp sourceComponent2 = entity.GetComponent(index) as EntityMoveClamp;
			sourceComponent2.Clone(target);
		}
		if (index == 17)
		{
			EntityActionParrying sourceComponent3 = entity.GetComponent(index) as EntityActionParrying;
			sourceComponent3.Clone(target);
		}
		if (index == 53)
		{
			EntityResistance sourceComponent4 = entity.GetComponent(index) as EntityResistance;
			sourceComponent4.Clone(target);
		}
		if (index == 62)
		{
			EntityUniqueSkillEnergy sourceComponent5 = entity.GetComponent(index) as EntityUniqueSkillEnergy;
			sourceComponent5.Clone(target);
		}
		if (index == 10)
		{
			EntityActionManualAIInput sourceComponent6 = entity.GetComponent(index) as EntityActionManualAIInput;
			sourceComponent6.Clone(target);
		}
		if (index == 13)
		{
			EntityActionModifyCombatScore sourceComponent7 = entity.GetComponent(index) as EntityActionModifyCombatScore;
			sourceComponent7.Clone(target);
		}
		if (index == 61)
		{
			EntityUltimateAvoidCD sourceComponent8 = entity.GetComponent(index) as EntityUltimateAvoidCD;
			sourceComponent8.Clone(target);
		}
		if (index == 50)
		{
			EntityQTE sourceComponent9 = entity.GetComponent(index) as EntityQTE;
			sourceComponent9.Clone(target);
		}
		if (index == 3)
		{
			EntityActionAbilityLogicInput sourceComponent10 = entity.GetComponent(index) as EntityActionAbilityLogicInput;
			sourceComponent10.Clone(target);
		}
		if (index == 5)
		{
			EntityActionAvoidShadow sourceComponent11 = entity.GetComponent(index) as EntityActionAvoidShadow;
			sourceComponent11.Clone(target);
		}
		if (index == 18)
		{
			EntityActionSubJoystick sourceComponent12 = entity.GetComponent(index) as EntityActionSubJoystick;
			sourceComponent12.Clone(target);
		}
		if (index == 34)
		{
			EntityEndurance sourceComponent13 = entity.GetComponent(index) as EntityEndurance;
			sourceComponent13.Clone(target);
		}
		if (index == 48)
		{
			EntityPuppet sourceComponent14 = entity.GetComponent(index) as EntityPuppet;
			sourceComponent14.Clone(target);
		}
		if (index == 49)
		{
			EntityPuppetHost sourceComponent15 = entity.GetComponent(index) as EntityPuppetHost;
			sourceComponent15.Clone(target);
		}
		if (index == 19)
		{
			EntityActionTransfiguration sourceComponent16 = entity.GetComponent(index) as EntityActionTransfiguration;
			sourceComponent16.Clone(target);
		}
		if (index == 28)
		{
			EntityCD sourceComponent17 = entity.GetComponent(index) as EntityCD;
			sourceComponent17.Clone(target);
		}
		if (index == 30)
		{
			EntityComboNumber sourceComponent18 = entity.GetComponent(index) as EntityComboNumber;
			sourceComponent18.Clone(target);
		}
		if (index == 59)
		{
			EntityTimer sourceComponent19 = entity.GetComponent(index) as EntityTimer;
			sourceComponent19.Clone(target);
		}
		if (index == 26)
		{
			EntityCameraView sourceComponent20 = entity.GetComponent(index) as EntityCameraView;
			sourceComponent20.Clone(target);
		}
		if (index == 1)
		{
			EntityActionAbility sourceComponent21 = entity.GetComponent(index) as EntityActionAbility;
			sourceComponent21.Clone(target);
		}
		if (index == 39)
		{
			EntityHide sourceComponent22 = entity.GetComponent(index) as EntityHide;
			sourceComponent22.Clone(target);
		}
		if (index == 47)
		{
			EntityPredicationPlayer sourceComponent23 = entity.GetComponent(index) as EntityPredicationPlayer;
			sourceComponent23.Clone(target);
		}
		if (index == 52)
		{
			EntityRemotePlayer sourceComponent24 = entity.GetComponent(index) as EntityRemotePlayer;
			sourceComponent24.Clone(target);
		}
		if (index == 11)
		{
			EntityActionManualInput sourceComponent25 = entity.GetComponent(index) as EntityActionManualInput;
			sourceComponent25.Clone(target);
		}
		if (index == 16)
		{
			EntityActionMoveDirection sourceComponent26 = entity.GetComponent(index) as EntityActionMoveDirection;
			sourceComponent26.Clone(target);
		}
		if (index == 58)
		{
			EntityTestGoogle sourceComponent27 = entity.GetComponent(index) as EntityTestGoogle;
			sourceComponent27.Clone(target);
		}
		if (index == 42)
		{
			EntityLocalPlayer sourceComponent28 = entity.GetComponent(index) as EntityLocalPlayer;
			sourceComponent28.Clone(target);
		}
		if (index == 56)
		{
			EntitySkillEffect sourceComponent29 = entity.GetComponent(index) as EntitySkillEffect;
			sourceComponent29.Clone(target);
		}
		if (index == 9)
		{
			EntityActionJump sourceComponent30 = entity.GetComponent(index) as EntityActionJump;
			sourceComponent30.Clone(target);
		}
		if (index == 8)
		{
			EntityActionIdle sourceComponent31 = entity.GetComponent(index) as EntityActionIdle;
			sourceComponent31.Clone(target);
		}
		if (index == 32)
		{
			EntityConfig sourceComponent32 = entity.GetComponent(index) as EntityConfig;
			sourceComponent32.Clone(target);
		}
		if (index == 40)
		{
			EntityHitRecover sourceComponent33 = entity.GetComponent(index) as EntityHitRecover;
			sourceComponent33.Clone(target);
		}
		if (index == 6)
		{
			EntityActionBorn sourceComponent34 = entity.GetComponent(index) as EntityActionBorn;
			sourceComponent34.Clone(target);
		}
		if (index == 12)
		{
			EntityActionMelee sourceComponent35 = entity.GetComponent(index) as EntityActionMelee;
			sourceComponent35.Clone(target);
		}
		if (index == 7)
		{
			EntityActionDeath sourceComponent36 = entity.GetComponent(index) as EntityActionDeath;
			sourceComponent36.Clone(target);
		}
		if (index == 14)
		{
			EntityActionModifyHP sourceComponent37 = entity.GetComponent(index) as EntityActionModifyHP;
			sourceComponent37.Clone(target);
		}
		if (index == 4)
		{
			EntityActionAttack sourceComponent38 = entity.GetComponent(index) as EntityActionAttack;
			sourceComponent38.Clone(target);
		}
		if (index == 15)
		{
			EntityActionMove sourceComponent39 = entity.GetComponent(index) as EntityActionMove;
			sourceComponent39.Clone(target);
		}
		if (index == 20)
		{
			EntityActionWeaponEquip sourceComponent40 = entity.GetComponent(index) as EntityActionWeaponEquip;
			sourceComponent40.Clone(target);
		}
		if (index == 2)
		{
			EntityActionAbilityDirection sourceComponent41 = entity.GetComponent(index) as EntityActionAbilityDirection;
			sourceComponent41.Clone(target);
		}
		if (index == 23)
		{
			EntityBlackboard sourceComponent42 = entity.GetComponent(index) as EntityBlackboard;
			sourceComponent42.Clone(target);
		}
		if (index == 27)
		{
			EntityCamp sourceComponent43 = entity.GetComponent(index) as EntityCamp;
			sourceComponent43.Clone(target);
		}
		if (index == 29)
		{
			EntityCollisionInfo sourceComponent44 = entity.GetComponent(index) as EntityCollisionInfo;
			sourceComponent44.Clone(target);
		}
		if (index == 55)
		{
			EntityShape sourceComponent45 = entity.GetComponent(index) as EntityShape;
			sourceComponent45.Clone(target);
		}
		if (index == 74)
		{
			Unit sourceComponent46 = entity.GetComponent(index) as Unit;
			sourceComponent46.Clone(target);
		}
		if (index == 54)
		{
			EntityRVO sourceComponent47 = entity.GetComponent(index) as EntityRVO;
			sourceComponent47.Clone(target);
		}
		if (index == 72)
		{
			SimTransform sourceComponent48 = entity.GetComponent(index) as SimTransform;
			sourceComponent48.Clone(target);
		}
		if (index == 65)
		{
			Projectile sourceComponent49 = entity.GetComponent(index) as Projectile;
			sourceComponent49.Clone(target);
		}
		if (index == 33)
		{
			EntityDetectable sourceComponent50 = entity.GetComponent(index) as EntityDetectable;
			sourceComponent50.Clone(target);
		}
		if (index == 38)
		{
			EntityHealth sourceComponent51 = entity.GetComponent(index) as EntityHealth;
			sourceComponent51.Clone(target);
		}
		if (index == 45)
		{
			EntityPositon sourceComponent52 = entity.GetComponent(index) as EntityPositon;
			sourceComponent52.Clone(target);
		}
		if (index == 25)
		{
			EntityBuff sourceComponent53 = entity.GetComponent(index) as EntityBuff;
			sourceComponent53.Clone(target);
		}
	}
}
