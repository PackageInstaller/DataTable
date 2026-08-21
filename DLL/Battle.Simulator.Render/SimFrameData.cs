using System.Collections.Generic;
using UnityEngine;

public class SimFrameData
{
	public int ID;

	public float EntityTimeScale = 1f;

	public bool IsHurt;

	public bool IsAlive;

	public bool HitRecoverIsEffectScale = true;

	public int HitRecoverCasterID;

	public E_HitRecoverStatus HitRecoverStatus;

	public int HitAbilityID;

	public int HitCount;

	public float Speed;

	public bool IsBorning;

	public bool IsCaught;

	public bool IsReloading;

	public long MaxHP;

	public long HP;

	public bool IsTeleport;

	public Vector3 Position;

	public Vector3 FaceDirection;

	public List<ModifyHPInfo> ModifyHpArray;

	public int EntityID;

	public List<BuffState> BuffStateArray;

	public Dictionary<int, AbilityStatueInfo> AbilityStateDict;

	public int mAimingTarget;

	public bool mIsAimingTool;

	public int mEntityConfigID;

	public EnemyType mEntityType;

	public long mExposedValue;

	public long mMaxExposedValue;

	public int mPowerValue;

	public int mMaxPowerValue;

	public int mUniqueValue;

	public int mUniqueMaxValue;

	public Vector3 SpeedDirection;

	public byte mAbilityOriginalCanUse;

	public int mEnduranceValue;

	public int mMaxEnduranceValue;

	public int mSubJoystickCommandCode;

	public int mSubJoysitckTimelineID;

	public int mCombatScore;

	public bool ValidQTE;

	public bool HasTriggerQTE;

	public long mSourceSpaceDamage;

	public bool mCantBeLocked;

	public E_IdleType mIdleState;

	public int mBeLockedPriority;

	public E_EntityHideType mIsHide;

	public int MoveID;

	public EntityActionStatus mMovementStatus;

	public int mAbilityID;

	internal int mHitRecoverActionID;

	public E_HitRecover IsHitRecovering;

	public float CONST_TICK = 1000 / BattleSimulatorSystem.sTargetLogicFrameRate;

	public int HitRecoverTime;

	public int AbilityTime;

	public int MovementTime;

	public int MovementTimeStep;

	public int AbilityTimeStep;

	public int HitRecoverTimeStep;

	public bool mResistanceState;

	public int mResistanceMaxValue;

	public int mResistanceCurValue;

	public uint mResistanceMaxTime;

	public uint mResistanceCurTime;

	public int mResistanceStateEle;

	public List<int> mResistanceEle = new List<int>();

	public int GrabTarget;

	public int mNewRoleID;

	public int mAimTargetPart;

	public List<ShapeState> mShapeStates;

	public int mBreakValue;

	public int mMaxBreakValue;

	public BreakState mBreakState;

	public int mBreakDamageType;

	public bool mAbilityCanBeParry;

	public int mEntityMasterSkillCurValue;

	public int mEntityMasterSkillMaxValue;

	public int mEntityMasterSkillCurCD;

	public int mEntityMasterSkillMaxCD;

	public int mEntityMasterSkillConsumeValue;

	public int mEntityMasterSkillConsumeCD;

	public int mEntityMasterSkillConfigID;

	public int HitRecoverFrame
	{
		get
		{
			int num = HitRecoverTime / (int)CONST_TICK - 1;
			return (num >= 0) ? num : 0;
		}
	}

	public int AbilityFrame => AbilityTime / (int)CONST_TICK;

	public int MovementFrame => MovementTime / (int)CONST_TICK;

	public float HitRecoverTimeScale => (float)HitRecoverTimeStep / CONST_TICK;

	public float AbilityTimeScale => (float)AbilityTimeStep / CONST_TICK;

	public float MovementTimeScale => (float)MovementTimeStep / CONST_TICK;

	public bool IsIdle
	{
		get
		{
			if (MoveID == 0 && mAbilityID == 0)
			{
				return mHitRecoverActionID == 0;
			}
			return false;
		}
	}

	public void Decode(SimPersistentState frameState, Vector3 deltaPos, bool overridePos, Vector3 deltaFwd, bool overrideFwd)
	{
		EntityID = frameState.EntityID;
		if (!(frameState is UnitState) || !(frameState is UnitState unitState))
		{
			return;
		}
		MovementTimeStep = unitState.mMoveTimeStep;
		HitRecoverTimeStep = unitState.mHitRecoverTimeStep;
		AbilityTimeStep = unitState.mAbilityTimeStep;
		HitRecoverTime = unitState.mHitRecoverTime;
		AbilityTime = unitState.mAbilityTime;
		MovementTime = unitState.mMoveTime;
		IsTeleport = unitState.mIsTeleport;
		Speed = (float)unitState.mSpeed;
		EntityTimeScale = (float)unitState.mEntityTimeScale / 100f;
		IsAlive = !unitState.mIsDeath;
		IsBorning = unitState.mIsBorning;
		IsCaught = unitState.mIsCaught;
		HP = unitState.mHP;
		MaxHP = unitState.mMaxHP;
		ModifyHpArray = unitState.mModfiyInfo;
		bool flag = (unitState.mHide & E_EntityHideType.Render) == E_EntityHideType.Render;
		IsHurt = ModifyHpArray != null && ModifyHpArray.Count > 0 && !flag;
		HitRecoverCasterID = unitState.mHitRecoverCaster;
		mHitRecoverActionID = unitState.mHitRecoverActionID;
		IsHitRecovering = unitState.mHitRecover;
		HitRecoverStatus = unitState.mHitRecoverStatus;
		HitAbilityID = unitState.mHitAbilityID;
		HitCount = unitState.mHitCount;
		Position = (overridePos ? deltaPos : ((Vector3)unitState.mPostion + deltaPos));
		FaceDirection = (overrideFwd ? (Quaternion.Euler(deltaFwd) * Vector3.forward) : (Quaternion.Euler(deltaFwd) * (Vector3)unitState.mForward));
		BuffStateArray = unitState.mBuffArray;
		if (AbilityStateDict == null)
		{
			AbilityStateDict = new Dictionary<int, AbilityStatueInfo>(new IntComparer());
		}
		else
		{
			AbilityStateDict.Clear();
		}
		foreach (AbilityStatueInfo item in unitState.mAbilityState)
		{
			AbilityStateDict[(int)item.ButtonType] = item;
		}
		mAimingTarget = unitState.mAimingTarget;
		mAbilityID = unitState.mAbilityID;
		mEntityConfigID = unitState.mEntityConfigID;
		mMovementStatus = unitState.mMovementStatus;
		mEntityType = unitState.entityType;
		mExposedValue = unitState.mExposedValue;
		mMaxExposedValue = unitState.mMaxExposedValue;
		mPowerValue = unitState.powerValue;
		mMaxPowerValue = unitState.maxPowerValue;
		mUniqueValue = unitState.mUniqueVluae;
		mUniqueMaxValue = unitState.mUniqueMaxValue;
		MoveID = unitState.mMoveID;
		SpeedDirection = (Vector3)unitState.mSpeedDirection;
		mAbilityOriginalCanUse = unitState.mAbilityOriginalCanUse;
		mEnduranceValue = unitState.mCurrentEnduranceValue.i;
		mMaxEnduranceValue = unitState.mMaxEnduranceValue.i;
		mSubJoystickCommandCode = unitState.mSubJoystickCommandCode;
		mSubJoysitckTimelineID = unitState.mSubJoystickTimelineID;
		mCombatScore = unitState.mCombatScore;
		ValidQTE = unitState.mValidQTE;
		mSourceSpaceDamage = unitState.mSourceSpaceDamage;
		mCantBeLocked = unitState.mCantBeLocked;
		mIdleState = unitState.mIsIdling;
		mBeLockedPriority = unitState.mBeLockedPriority;
		mResistanceState = unitState.mResistanceState;
		mResistanceMaxValue = unitState.mResistanceMaxValue;
		mResistanceCurValue = unitState.mResistanceCurValue;
		mResistanceMaxTime = unitState.mResistanceMaxTime;
		mResistanceCurTime = unitState.mResistanceCurTime;
		mResistanceStateEle = unitState.mResistanceStateEle;
		mResistanceEle = unitState.mResistanceEle;
		GrabTarget = unitState.mGrabTarget;
		mIsHide = unitState.mHide;
		mNewRoleID = unitState.mNewRoleID;
		mAimTargetPart = unitState.mAimingPart;
		mShapeStates = unitState.mShapeStates;
		mBreakValue = unitState.mBreakValue;
		mMaxBreakValue = unitState.mMaxBreakValue;
		mBreakState = unitState.mBreakState;
		mBreakDamageType = unitState.mBreakDamageType;
		mAbilityCanBeParry = unitState.mAbilityCanBeParry;
		mEntityMasterSkillCurValue = unitState.mEntityMasterSkillCurValue;
		mEntityMasterSkillMaxValue = unitState.mEntityMasterSkillMaxValue;
		mEntityMasterSkillCurCD = unitState.mEntityMasterSkillCurCD;
		mEntityMasterSkillMaxCD = unitState.mEntityMasterSkillMaxCD;
		mEntityMasterSkillConsumeValue = unitState.mEntityMasterSkillConsumeValue;
		mEntityMasterSkillConsumeCD = unitState.mEntityMasterSkillConsumeCD;
		mEntityMasterSkillConfigID = unitState.mEntityMasterSkillConfigID;
	}

	public override string ToString()
	{
		return JsonUtility.ToJson(this);
	}

	public MeleeAttackStatus GetActionStatus(int status, MeleeStatusMask mask)
	{
		return (MeleeAttackStatus)(status & (int)(~mask));
	}
}
