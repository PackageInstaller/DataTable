using System.Collections.Generic;
using System.Text;

public class UnitState : SimPersistentState
{
	public int mPredictionID;

	public bool mLocalFlag;

	public int mEntityConfigID;

	public EnemyType entityType;

	public bool mIsTeleport;

	public Int3 mPostion;

	public Int mSpeed;

	public Int3 mVec;

	public List<Int3> mPath;

	public Int mRadius;

	public Int mForwardAngle;

	public Int3 mForward;

	public Int3 mSpeedDirection;

	public long mHP;

	public long mMaxHP;

	public int powerValue;

	public int maxPowerValue;

	public long mExposedValue;

	public long mMaxExposedValue;

	public int mUniqueVluae;

	public int mUniqueMaxValue;

	public Int mMaxEnduranceValue;

	public Int mCurrentEnduranceValue;

	public long mSourceSpaceDamage;

	public List<ModifyHPInfo> mModfiyInfo = new List<ModifyHPInfo>(4);

	public List<BuffState> mBuffArray = new List<BuffState>(8);

	public Dictionary<int, int> mAttrArray = new Dictionary<int, int>(new IntComparer());

	public List<AbilityStatueInfo> mAbilityState = new List<AbilityStatueInfo>();

	public List<ShapeState> mShapeStates = new List<ShapeState>(8);

	public E_IdleType mIsIdling;

	public bool mIsVisible;

	public bool mCantBeLocked;

	public int mBeLockedPriority;

	public bool mIsAlive;

	public bool mIsDeath;

	public bool mIsBorning;

	public E_HitRecover mHitRecover;

	public int mHitRecoverActionID;

	public E_HitRecoverStatus mHitRecoverStatus;

	public int mHitCount;

	public int mHitAbilityID;

	public int mAimingTarget;

	public bool mIsCaught;

	public byte mAbilityOriginalCanUse;

	public int mAbilityID;

	public bool mAbilityCanBeParry;

	public bool mHasMoveDirectionInput;

	public Int3 mMoveDirectionInputDirection;

	public EntityActionStatus mMovementStatus;

	public int mMoveID;

	public int mEntityTimeScale;

	public int mHitRecoverCaster;

	public int mSubJoystickCommandCode;

	public int mSubJoystickTimelineID;

	public int mCombatScore;

	public bool mValidQTE;

	public bool mResistanceState;

	public int mResistanceMaxValue;

	public int mResistanceCurValue;

	public uint mResistanceMaxTime;

	public uint mResistanceCurTime;

	public int mResistanceStateEle;

	public List<int> mResistanceEle = new List<int>();

	public int mNewRoleID;

	public int mAbilityTime;

	public int mMoveTime;

	public int mHitRecoverTime;

	public int mAbilityTimeStep;

	public int mHitRecoverTimeStep;

	public int mMoveTimeStep;

	public int mGrabTarget;

	public E_EntityHideType mHide;

	public int mAimingPart;

	public int mBreakValue;

	public int mMaxBreakValue;

	public BreakState mBreakState;

	public int mBreakDamageType;

	public int mEntityMasterSkillCurValue;

	public int mEntityMasterSkillMaxValue;

	public int mEntityMasterSkillCurCD;

	public int mEntityMasterSkillMaxCD;

	public int mEntityMasterSkillConsumeValue;

	public int mEntityMasterSkillConsumeCD;

	public int mEntityMasterSkillConfigID;

	public static SimPersistentState Claim()
	{
		return FrameObjectPool<UnitState>.Claim();
	}

	public override void Release()
	{
		FrameObjectPool<UnitState>.Release(this);
	}

	public override void OnEnterPool()
	{
		mPredictionID = 0;
		mLocalFlag = false;
		mEntityConfigID = 0;
		entityType = EnemyType.Other;
		mIsTeleport = false;
		mPostion = Int3.zero;
		mSpeed = 0;
		mVec = Int3.zero;
		if (mPath != null)
		{
			mPath.Clear();
		}
		mRadius = 0;
		mForwardAngle = 0;
		mForward = Int3.zero;
		mSpeedDirection = Int3.zero;
		mHP = 0L;
		mMaxHP = 0L;
		powerValue = 0;
		maxPowerValue = 0;
		mExposedValue = 0L;
		mMaxExposedValue = 0L;
		mUniqueVluae = 0;
		mUniqueMaxValue = 0;
		mMaxEnduranceValue = 0;
		mCurrentEnduranceValue = 0;
		mSourceSpaceDamage = 0L;
		if (mModfiyInfo != null)
		{
			mModfiyInfo.Clear();
		}
		if (mBuffArray != null)
		{
			mBuffArray.Clear();
		}
		if (mAttrArray != null)
		{
			mAttrArray.Clear();
		}
		if (mAbilityState != null)
		{
			mAbilityState.Clear();
		}
		mIsIdling = E_IdleType.Normal;
		mIsVisible = false;
		mCantBeLocked = false;
		mBeLockedPriority = 0;
		mIsAlive = false;
		mIsDeath = false;
		mIsBorning = false;
		mHitRecover = E_HitRecover.None;
		mHitRecoverActionID = 0;
		mHitRecoverStatus = E_HitRecoverStatus.None;
		mHitCount = 0;
		mHitAbilityID = 0;
		mHitRecoverTime = 0;
		mHitRecoverTimeStep = 0;
		mMoveTimeStep = 0;
		mMoveTime = 0;
		mAbilityTime = 0;
		mAbilityTimeStep = 0;
		mAimingTarget = 0;
		mIsCaught = false;
		mAbilityOriginalCanUse = 0;
		mAbilityID = 0;
		mAbilityCanBeParry = false;
		mHasMoveDirectionInput = false;
		mMoveDirectionInputDirection = Int3.zero;
		mMovementStatus = EntityActionStatus.None;
		mMoveID = 0;
		mEntityTimeScale = 0;
		mHitRecoverCaster = 0;
		mSubJoystickCommandCode = 0;
		mSubJoystickTimelineID = 0;
		mCombatScore = 0;
		mValidQTE = false;
		mResistanceState = false;
		mResistanceMaxValue = 0;
		mResistanceCurValue = 0;
		mResistanceMaxTime = 0u;
		mResistanceCurTime = 0u;
		mResistanceStateEle = 0;
		mResistanceEle.Clear();
		mNewRoleID = 0;
		mGrabTarget = 0;
		mHide = E_EntityHideType.None;
		if (mShapeStates != null)
		{
			mShapeStates.Clear();
		}
		mAimingPart = 0;
		mBreakValue = 0;
		mMaxBreakValue = 0;
		mBreakState = BreakState.tick;
		mEntityMasterSkillCurValue = 0;
		mEntityMasterSkillMaxValue = 0;
		mEntityMasterSkillCurCD = 0;
		mEntityMasterSkillMaxCD = 0;
		mEntityMasterSkillConsumeValue = 0;
		mEntityMasterSkillConsumeCD = 0;
		mEntityMasterSkillConfigID = 0;
	}

	public void GetCheckSum(Checksum cs)
	{
		cs.Add(mPredictionID);
		cs.Add(mLocalFlag);
		cs.Add(mEntityConfigID);
		cs.Add((int)entityType);
		cs.Add(mIsTeleport);
		cs.Add(mPostion);
		cs.Add(mSpeed.i);
		cs.Add(mVec);
		cs.Add(mRadius.i);
		cs.Add(mForwardAngle.i);
		cs.Add(mForward);
		cs.Add(mSpeedDirection);
		cs.Add(mHP);
		cs.Add(mMaxHP);
		cs.Add(powerValue);
		cs.Add(maxPowerValue);
		cs.Add(mExposedValue);
		cs.Add(mMaxExposedValue);
		cs.Add(mUniqueVluae);
		cs.Add(mUniqueMaxValue);
		cs.Add(mMaxEnduranceValue.i);
		cs.Add(mCurrentEnduranceValue.i);
		cs.Add(mSourceSpaceDamage);
		for (int i = 0; i < mModfiyInfo.Count; i++)
		{
			cs.Add((int)mModfiyInfo[i].mDamageType);
			cs.Add(mModfiyInfo[i].mAmount);
			cs.Add(mModfiyInfo[i].mDamgeFlyDir);
			cs.Add(mModfiyInfo[i].mDelay);
			cs.Add(mModfiyInfo[i].mActionID);
			cs.Add(mModfiyInfo[i].mCasterID);
			cs.Add(mModfiyInfo[i].mThrownID);
			cs.Add(mModfiyInfo[i].mRealDamage);
		}
		for (int j = 0; j < mBuffArray.Count; j++)
		{
			cs.Add(mBuffArray[j].mBuffID);
			cs.Add(mBuffArray[j].mBuffOwnerID);
			cs.Add(mBuffArray[j].mBuffCasterID);
			cs.Add(mBuffArray[j].mBuffClassID);
			cs.Add(mBuffArray[j].mBuffConfigID);
			cs.Add(mBuffArray[j].mDuring);
			cs.Add(mBuffArray[j].mBuffRuntime);
			cs.Add(mBuffArray[j].mTick);
			cs.Add(mBuffArray[j].mFloor);
			cs.Add((int)mBuffArray[j].mBindLife);
			cs.Add(mBuffArray[j].mBuffParams.v1.int3Var.x);
			cs.Add(mBuffArray[j].mBuffParams.v1.int3Var.y);
			cs.Add(mBuffArray[j].mBuffParams.v1.int3Var.z);
			cs.Add(mBuffArray[j].mBuffParams.v2.int3Var.x);
			cs.Add(mBuffArray[j].mBuffParams.v2.int3Var.y);
			cs.Add(mBuffArray[j].mBuffParams.v2.int3Var.z);
			cs.Add(mBuffArray[j].mBuffParams.v3.int3Var.x);
			cs.Add(mBuffArray[j].mBuffParams.v3.int3Var.y);
			cs.Add(mBuffArray[j].mBuffParams.v3.int3Var.z);
			cs.Add(mBuffArray[j].mBuffParams.v4.int3Var.x);
			cs.Add(mBuffArray[j].mBuffParams.v4.int3Var.y);
			cs.Add(mBuffArray[j].mBuffParams.v4.int3Var.z);
			cs.Add(mBuffArray[j].mBuffKeepTime);
		}
		foreach (KeyValuePair<int, int> item in mAttrArray)
		{
			cs.Add(item.Key);
			cs.Add(item.Value);
		}
		for (int k = 0; k < mAbilityState.Count; k++)
		{
			cs.Add(mAbilityState[k].ID);
			cs.Add(mAbilityState[k].CD);
			cs.Add(mAbilityState[k].MaxCD);
			cs.Add(mAbilityState[k].ChargingCount);
			cs.Add(mAbilityState[k].Enable);
			cs.Add(mAbilityState[k].Consume);
		}
		cs.Add((int)mIsIdling);
		cs.Add(mIsVisible);
		cs.Add(mCantBeLocked);
		cs.Add(mBeLockedPriority);
		cs.Add(mIsAlive);
		cs.Add(mIsDeath);
		cs.Add(mIsBorning);
		cs.Add((int)mHitRecover);
		cs.Add(mHitRecoverActionID);
		cs.Add((int)mHitRecoverStatus);
		cs.Add(mHitCount);
		cs.Add(mHitAbilityID);
		cs.Add(mAimingTarget);
		cs.Add(mIsCaught);
		cs.Add(mAbilityOriginalCanUse);
		cs.Add(mAbilityID);
		cs.Add(mAbilityCanBeParry);
		cs.Add(mHasMoveDirectionInput);
		cs.Add(mMoveDirectionInputDirection);
		cs.Add((int)mMovementStatus);
		cs.Add(mMoveID);
		cs.Add(mEntityTimeScale);
		cs.Add(mHitRecoverCaster);
		cs.Add(mSubJoystickCommandCode);
		cs.Add(mSubJoystickTimelineID);
		cs.Add(mCombatScore);
		cs.Add(mValidQTE);
		cs.Add(mResistanceState);
		cs.Add(mResistanceMaxValue);
		cs.Add(mResistanceCurValue);
		cs.Add((int)mResistanceMaxTime);
		cs.Add((int)mResistanceCurTime);
		cs.Add(mNewRoleID);
		cs.Add(mAbilityTime);
		cs.Add(mMoveTime);
		cs.Add(mHitRecoverTime);
		cs.Add(mAbilityTimeStep);
		cs.Add(mHitRecoverTimeStep);
		cs.Add(mMoveTimeStep);
		cs.Add(mGrabTarget);
		for (int l = 0; l < mShapeStates.Count; l++)
		{
			cs.Add((int)mShapeStates[l].mPartType);
			cs.Add(mShapeStates[l].mWorldPos);
			cs.Add(mShapeStates[l].mAvgCollisionRadius);
		}
		cs.Add(mAimingPart);
		cs.Add((int)mBreakState);
		cs.Add(mBreakValue);
		cs.Add(mMaxBreakValue);
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine(mPredictionID.ToString());
		stringBuilder.AppendLine(mLocalFlag.ToString());
		stringBuilder.AppendLine(mEntityConfigID.ToString());
		stringBuilder.AppendLine(entityType.ToString());
		stringBuilder.AppendLine(mIsTeleport.ToString());
		stringBuilder.AppendLine(mPostion);
		stringBuilder.AppendLine(mSpeed.i.ToString());
		stringBuilder.AppendLine(mVec);
		stringBuilder.AppendLine(mRadius.i.ToString());
		stringBuilder.AppendLine(mForwardAngle.i.ToString());
		stringBuilder.AppendLine(mForward);
		stringBuilder.AppendLine(mSpeedDirection);
		stringBuilder.AppendLine(mHP.ToString());
		stringBuilder.AppendLine(mMaxHP.ToString());
		stringBuilder.AppendLine(powerValue.ToString());
		stringBuilder.AppendLine(maxPowerValue.ToString());
		stringBuilder.AppendLine(mExposedValue.ToString());
		stringBuilder.AppendLine(mMaxExposedValue.ToString());
		stringBuilder.AppendLine(mUniqueVluae.ToString());
		stringBuilder.AppendLine(mUniqueMaxValue.ToString());
		stringBuilder.AppendLine(mMaxEnduranceValue.i.ToString());
		stringBuilder.AppendLine(mCurrentEnduranceValue.i.ToString());
		stringBuilder.AppendLine(mSourceSpaceDamage.ToString());
		for (int i = 0; i < mModfiyInfo.Count; i++)
		{
			stringBuilder.AppendLine(mModfiyInfo[i].mDamageType.ToString());
			stringBuilder.AppendLine(mModfiyInfo[i].mAmount.ToString());
			stringBuilder.AppendLine(mModfiyInfo[i].mDamgeFlyDir.ToString());
			stringBuilder.AppendLine(mModfiyInfo[i].mDelay.ToString());
			stringBuilder.AppendLine(mModfiyInfo[i].mActionID.ToString());
			stringBuilder.AppendLine(mModfiyInfo[i].mCasterID.ToString());
			stringBuilder.AppendLine(mModfiyInfo[i].mThrownID.ToString());
			stringBuilder.AppendLine(mModfiyInfo[i].mRealDamage.ToString());
		}
		for (int j = 0; j < mBuffArray.Count; j++)
		{
			stringBuilder.AppendLine(mBuffArray[j].mBuffID.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mBuffOwnerID.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mBuffCasterID.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mBuffClassID.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mBuffConfigID.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mDuring.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mBuffRuntime.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mTick.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mFloor.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mBindLife.ToString());
			stringBuilder.AppendLine(mBuffArray[j].mBuffParams.v1.int3Var);
			stringBuilder.AppendLine(mBuffArray[j].mBuffParams.v2.int3Var);
			stringBuilder.AppendLine(mBuffArray[j].mBuffParams.v3.int3Var);
			stringBuilder.AppendLine(mBuffArray[j].mBuffParams.v4.int3Var);
			stringBuilder.AppendLine(mBuffArray[j].mBuffKeepTime.ToString());
		}
		foreach (KeyValuePair<int, int> item in mAttrArray)
		{
			stringBuilder.AppendLine(item.Key.ToString());
			stringBuilder.AppendLine(item.Value.ToString());
		}
		for (int k = 0; k < mAbilityState.Count; k++)
		{
			stringBuilder.AppendLine(mAbilityState[k].ID.ToString());
			stringBuilder.AppendLine(mAbilityState[k].CD.ToString());
			stringBuilder.AppendLine(mAbilityState[k].MaxCD.ToString());
			stringBuilder.AppendLine(mAbilityState[k].ChargingCount.ToString());
			stringBuilder.AppendLine(mAbilityState[k].Enable.ToString());
			stringBuilder.AppendLine(mAbilityState[k].Consume.ToString());
		}
		stringBuilder.AppendLine(mIsIdling.ToString());
		stringBuilder.AppendLine(mIsVisible.ToString());
		stringBuilder.AppendLine(mCantBeLocked.ToString());
		stringBuilder.AppendLine(mBeLockedPriority.ToString());
		stringBuilder.AppendLine(mIsAlive.ToString());
		stringBuilder.AppendLine(mIsDeath.ToString());
		stringBuilder.AppendLine(mIsBorning.ToString());
		stringBuilder.AppendLine(mHitRecover.ToString());
		stringBuilder.AppendLine(mHitRecoverActionID.ToString());
		stringBuilder.AppendLine(mHitRecoverStatus.ToString());
		stringBuilder.AppendLine(mHitCount.ToString());
		stringBuilder.AppendLine(mHitAbilityID.ToString());
		stringBuilder.AppendLine(mAimingTarget.ToString());
		stringBuilder.AppendLine(mIsCaught.ToString());
		stringBuilder.AppendLine(mAbilityOriginalCanUse.ToString());
		stringBuilder.AppendLine(mAbilityID.ToString());
		stringBuilder.AppendLine(mAbilityCanBeParry.ToString());
		stringBuilder.AppendLine(mHasMoveDirectionInput.ToString());
		stringBuilder.AppendLine(mMoveDirectionInputDirection);
		stringBuilder.AppendLine(mMovementStatus.ToString());
		stringBuilder.AppendLine(mMoveID.ToString());
		stringBuilder.AppendLine(mEntityTimeScale.ToString());
		stringBuilder.AppendLine(mHitRecoverCaster.ToString());
		stringBuilder.AppendLine(mSubJoystickCommandCode.ToString());
		stringBuilder.AppendLine(mSubJoystickTimelineID.ToString());
		stringBuilder.AppendLine(mCombatScore.ToString());
		stringBuilder.AppendLine(mValidQTE.ToString());
		stringBuilder.AppendLine(mResistanceState.ToString());
		stringBuilder.AppendLine(mResistanceMaxValue.ToString());
		stringBuilder.AppendLine(mResistanceCurValue.ToString());
		stringBuilder.AppendLine(mResistanceMaxTime.ToString());
		stringBuilder.AppendLine(mResistanceCurTime.ToString());
		stringBuilder.AppendLine(mNewRoleID.ToString());
		stringBuilder.AppendLine(mAbilityTime.ToString());
		stringBuilder.AppendLine(mMoveTime.ToString());
		stringBuilder.AppendLine(mHitRecoverTime.ToString());
		stringBuilder.AppendLine(mAbilityTimeStep.ToString());
		stringBuilder.AppendLine(mHitRecoverTimeStep.ToString());
		stringBuilder.AppendLine(mMoveTimeStep.ToString());
		stringBuilder.AppendLine(mGrabTarget.ToString());
		for (int l = 0; l < mShapeStates.Count; l++)
		{
			stringBuilder.AppendLine(mShapeStates[l].mPartType.ToString());
			stringBuilder.AppendLine(mShapeStates[l].mWorldPos.ToString());
			stringBuilder.AppendLine(mShapeStates[l].mAvgCollisionRadius.ToString());
		}
		stringBuilder.AppendLine(mAimingPart.ToString());
		stringBuilder.AppendLine(mBreakValue.ToString());
		stringBuilder.AppendLine(mBreakState.ToString());
		stringBuilder.AppendLine(mMaxBreakValue.ToString());
		return stringBuilder.ToString();
	}
}
