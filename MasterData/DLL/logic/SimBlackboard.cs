using System.Collections.Generic;
using Config;

public class SimBlackboard
{
	public struct EntityCounterStruct
	{
		public int name;

		public int runningCount;

		public int intervalConfig;
	}

	public bool initFinished;

	public bool sendDeathEvent;

	public int mEntityID;

	public int mAttributeID;

	public const int HIT_RATE = 1000;

	public int mHpStripCount = 1;

	public long mMaxHP;

	public VFactor mMaxSpeed = new VFactor(2L, 1L);

	[VarBinding(EntityVarName.ENTITY_ATTR_MOVE_USE_CURVE, true, false, false, "位移使用曲线")]
	public bool mUseRunMoveCurve;

	public VFactor mSpeedFactor = VFactor.one;

	public int mEntityTimeScale = 100;

	public bool mHide;

	public int mAIID;

	public MemberPosition mRolePostion;

	public int creator;

	public RobotType mRobotType;

	public bool mActionBusy;

	public bool mIsCaught;

	[VarBinding(EntityVarName.ENTITY_ATTR_ROTATION_SPEED, true, false, false, "转身速度")]
	public Int mDeltaRotationSpeed = 540000;

	[VarBinding(EntityVarName.ENTITY_AI_TARGETPOS, true, false, false, "目标位置")]
	public Int3 mTargetPos;

	[VarBinding(EntityVarName.ENTITY_AI_TARGET, true, false, false, "瞄准目标")]
	public int mAimTarget;

	public int mLastTarget;

	[VarBinding(EntityVarName.ENTITY_AI_TRIGGER_TARGET, true, false, false, "触发器指定目标")]
	public int mTriggerTarget;

	public bool mIsLookatAimTarget;

	public bool mIsMoveLock;

	[VarBinding(EntityVarName.ENTITY_DESIRED_VELOCITY, false, false, false, "期待的移动方向")]
	public Int3 mDesiredVelocity;

	[VarBinding(EntityVarName.ENTITY_DESIRED_POSITION, false, false, false, "期待的移动位置")]
	public Int3 mDesiredPos;

	[VarBinding(EntityVarName.ENTITY_DESIRED_SPEED, false, false, false, "期待的移动速度")]
	public Int mDesiredSpeed;

	[VarBinding(EntityVarName.ENTITY_CALCULATED_SPEED, true, false, false, "最终的移动速度")]
	public Int mCalculatedSpeed = 0;

	[VarBinding(EntityVarName.ENTITY_CALCULATED_POSITION, true, false, false, "最终的移动位置")]
	public Int3 mCalculatedPos = Int3.zero;

	[VarBinding(EntityVarName.ENTITY_CALCULATED_VELOCITY, true, false, false, "最终的移动方向")]
	public Int3 mCalculatedVec = Int3.zero;

	public int mDesiredMoveID;

	public int mPickNextWaypointDist = 2000;

	public Int mSlowdownDistance = 1500;

	public VFactor mMinMoveScale = new VFactor(5L, 100L);

	public Int mForwardLook = 1500;

	public long mLastDamageAmount;

	public int mBeHitAbilitiID;

	public int mBeHitIndex = -1;

	public bool mIsHitByThump;

	public int mKillerID;

	public int mLastHitAbilityID;

	public int mKillDamageType;

	public bool mIsBeInterrupt;

	public int mKillThrownID;

	public bool mBeHitKeepForward;

	public int mLastAbilityID;

	public int mNewAbilityStartFrame;

	public Int mCameraAngle = 0;

	public bool hasManualLock;

	public LockType lockType;

	public bool TriggeredQTE;

	public Int3 mBeaconPosition = Int3.zero;

	public Int3 mBeaconForward = Int3.forward;

	public int mTestSkill;

	public int meleeIndex;

	public int mAttackCount;

	public int mOnPressDownBtnID = -1;

	public uint mOnPressDownBtnIDMask;

	public int mIsBanMelee;

	public Dictionary<int, int> mAbilityEnable = new Dictionary<int, int>(new IntComparer());

	public Dictionary<int, uint> mAbilityDisableFlag = new Dictionary<int, uint>(new IntComparer());

	public int[] abilityLevel = new int[5] { -9975, -9974, -9973, -9972, -9971 };

	[VarBinding(EntityVarName.ENTITY_ATTR_LOCK_MOVEMENT, true, false, false, "锁定移动次数")]
	public int mLockMovementCount;

	public int mRunStartSlot;

	public int mNearStopSlot;

	public int mRushIDSlot;

	public int mRushStopIDSlot;

	public int mRunSlot;

	public int mMovementStopSlot;

	public int mBattleIldeRecoverSlot;

	public int mRunLeftIDSlot;

	public int mRunRightIDSlot;

	public DeathTimeType mDeathTimeType;

	public int mDeathSlot;

	public int mAirDeathSlot;

	public int mNoAnimationDeathSlot;

	public int mFallDownDeathSlot;

	public int mJumpStartSlot;

	public int mJumpUpLoopSlot;

	public int mJumpAirSlot;

	public int mJumpDownLoopSlot;

	public int mJumpLandSlot;

	public int mHitRecoverSlot;

	public int mHitRecoverIndex;

	public List<int> mHitRecoverSlots = new List<int>();

	public List<int> mHitAirSlot = new List<int>();

	public int mHitUpSlot;

	public int mHitDownSlot;

	public int mHitFloorSlot;

	public int mGetUpSlot;

	public int mAvoidForwardSlots;

	public int mAvoidBackSlots;

	public List<int> mMeleesSlots = new List<int>();

	public int[] mAbilitySlots = new int[4];

	public byte mIsStoic;

	public byte mAbilityOriginalCanUse;

	public EnergyType mEnergyType;

	public Dictionary<int, AbilityConsume> mPublicSkillEntityChange = new Dictionary<int, AbilityConsume>(new IntComparer());

	public int mCharacterParamUltimateAvoidCD = 10000;

	public int mUltimateAvoidMaxUseCount = 1;

	public int mCharacterParamItemPickUpRadius = 15000;

	public int mCombatScore;

	public int BattleIdleTime;

	public E_IdleType IdleState;

	public Int3 LocalPositionOfCombination = Int3.zero;

	public Dictionary<int, EntityCounterStruct> timer = new Dictionary<int, EntityCounterStruct>(new IntComparer());

	public List<int> mDropItems = new List<int>();

	public Dictionary<int, int> commonDamageReductions = new Dictionary<int, int>(new IntComparer());

	public bool mTempCanBeGrab;

	public int mGrabTarget;

	public bool mHasTurnMoveID;

	public int mTurnLeftMoveID;

	public int mTurnRightMoveID;

	public int mTurnLimitAngle;

	public int mTurnRotationSpeed;

	public bool mTempCanBeTransfer;

	public Dictionary<int, int> mEquipLv;

	public Int3 mAbilityStartFroward = Int3.forward;

	public long mConfigID
	{
		get
		{
			AttributeProcessor.GetAttributeWithIntName(mAttributeID, 2189, out var baseValue, out var _, out var _);
			if (baseValue >= 0)
			{
				return baseValue;
			}
			return 0L;
		}
		set
		{
			AttributeProcessor.SetAttributeWithIntName(mAttributeID, 2189, value, 0L, 0L);
		}
	}

	[VarBinding(EntityVarName.ENTITY_ATTR_FIGHT_LEVEL, true, false, false, "等级")]
	public int mFightLevel
	{
		get
		{
			AttributeProcessor.GetAttributeWithIntName(mAttributeID, 2177, out var baseValue, out var _, out var _);
			if ((int)baseValue >= 1)
			{
				return (int)baseValue;
			}
			return 1;
		}
		set
		{
			AttributeProcessor.SetAttributeWithIntName(mAttributeID, 2177, value, 0L, 0L);
		}
	}

	[VarBinding(EntityVarName.ENTITY_HP, true, false, false, "生命值")]
	public long mHP
	{
		get
		{
			AttributeProcessor.GetAttributeWithIntName(mAttributeID, 2002, out var baseValue, out var _, out var _);
			if (baseValue >= 0)
			{
				return baseValue;
			}
			return 0L;
		}
		set
		{
			AttributeProcessor.SetAttributeWithIntName(mAttributeID, 2002, value, 0L, 0L);
		}
	}

	public int mRaceID
	{
		get
		{
			AttributeProcessor.GetAttributeWithIntName(mAttributeID, 2179, out var baseValue, out var _, out var _);
			return (int)baseValue;
		}
		set
		{
			AttributeProcessor.SetAttributeWithIntName(mAttributeID, 2179, value, 0L, 0L);
		}
	}

	public EnemyType enemyType
	{
		get
		{
			AttributeProcessor.GetAttributeWithIntName(mAttributeID, 2009, out var baseValue, out var _, out var _);
			return (EnemyType)baseValue;
		}
		set
		{
			AttributeProcessor.SetAttributeWithIntName(mAttributeID, 2009, (long)value, 0L, 0L);
		}
	}

	[VarBinding(EntityVarName.ENTITY_AI_HAS_ATTACK_TRAGET, true, true, true, "")]
	public bool mHasAimTarget => mAimTarget > 0;

	public void AddOnPressDownBtnID(int btnID)
	{
		mOnPressDownBtnID = btnID;
		mOnPressDownBtnIDMask |= (uint)(1 << btnID);
	}

	public void RemoveOnPressDownBtnID(int btnID)
	{
		mOnPressDownBtnID = -1;
		mOnPressDownBtnIDMask &= (uint)(~(1 << btnID));
	}

	public bool IsOnPressDownBtnID(int btnID)
	{
		return (mOnPressDownBtnIDMask & (uint)(1 << btnID)) != 0;
	}

	public void ClearOnPressDownBtnID()
	{
		mOnPressDownBtnID = -1;
		mOnPressDownBtnIDMask = 0u;
	}

	public void EnableAbility(int ability, bool isEnable)
	{
		if (!mAbilityEnable.TryGetValue(ability, out var _))
		{
			mAbilityEnable.Add(ability, 0);
		}
		mAbilityEnable[ability] += ((!isEnable) ? 1 : (-1));
	}

	public void SetAbilityEnableCount(int ability, int modify)
	{
		if (!mAbilityEnable.TryGetValue(ability, out var value))
		{
			value = 0;
		}
		value += modify;
		value = ((value > 0) ? value : 0);
		mAbilityEnable[ability] = value;
	}

	public void SetAbilityDisableFlag(int ability, int index, bool isEnable)
	{
		if (!mAbilityDisableFlag.TryGetValue(ability, out var value))
		{
			mAbilityDisableFlag.Add(ability, 0u);
		}
		if (isEnable)
		{
			mAbilityDisableFlag[ability] = (uint)(1 << index) | value;
		}
		else
		{
			mAbilityDisableFlag[ability] = (uint)(~(1 << index)) & value;
		}
	}

	public void Reset()
	{
		mTestSkill = 0;
		mAttackCount = 0;
		initFinished = false;
		sendDeathEvent = false;
		mEnergyType = EnergyType.None;
		mCharacterParamUltimateAvoidCD = 10000;
		enemyType = EnemyType.Other;
		mCombatScore = 0;
		mHpStripCount = 1;
		mDesiredMoveID = 0;
		mIsStoic = 0;
		mGrabTarget = 0;
		mRunStartSlot = 0;
		mNearStopSlot = 0;
		mRushIDSlot = 0;
		mRushStopIDSlot = 0;
		mRunSlot = 0;
		mMovementStopSlot = 0;
		mBattleIldeRecoverSlot = 0;
		mHasTurnMoveID = false;
		mTurnLeftMoveID = 0;
		mTurnRightMoveID = 0;
		mTurnLimitAngle = 0;
		mTurnRotationSpeed = 0;
		mJumpStartSlot = 0;
		mJumpUpLoopSlot = 0;
		mJumpAirSlot = 0;
		mJumpDownLoopSlot = 0;
		mJumpLandSlot = 0;
	}
}
