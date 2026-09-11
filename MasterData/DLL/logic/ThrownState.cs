public class ThrownState : IFramePooledObject
{
	public int mCreationIndex;

	public int mAbilityID;

	public uint mCurFrame;

	public int mLogicTime;

	public int mHitIndex;

	public uint mCamp;

	public int mCasterID;

	public int mCreatedRootTimelineID;

	public int mProducerID;

	public int mProduceTimelineID;

	public int mProduceIndexOfTimeline;

	public int mAttributeID;

	public Int3 mEarliestForward;

	public Int3 mEarliestPosition;

	public Int3 mLastPosition;

	public Int3 mPosition;

	public bool mDontMovement;

	public int mBackIndex;

	public int mBackSpeed;

	public Int3 mBackTargetPosition;

	public Int3 mForward;

	public int mConllisionCheckIndex;

	public bool mDontCollisionCheck;

	public int mTargetID;

	public int mCurLockIndex;

	public bool mIsInLock;

	public int mLastHeight;

	public int mHeight;

	public Int3 mTargetPosition;

	public int mFrameFreezeTime;

	public int mTimeScale;

	public int mTimeStep;

	public int mBuffItemID;

	public bool mCanBeParry;

	public void OnEnterPool()
	{
		mCreationIndex = 0;
		mAbilityID = 0;
		mCurFrame = 0u;
		mLogicTime = 0;
		mHitIndex = 0;
		mCamp = 0u;
		mCasterID = 0;
		mCreatedRootTimelineID = 0;
		mProducerID = 0;
		mProduceTimelineID = 0;
		mProduceIndexOfTimeline = 0;
		mEarliestForward = Int3.forward;
		mEarliestPosition = Int3.zero;
		mLastPosition = Int3.zero;
		mPosition = Int3.zero;
		mDontMovement = false;
		mBackIndex = 0;
		mBackSpeed = 0;
		mBackTargetPosition = Int3.zero;
		mForward = Int3.forward;
		mConllisionCheckIndex = 0;
		mDontCollisionCheck = false;
		mTargetID = 0;
		mCurLockIndex = 0;
		mIsInLock = false;
		mLastHeight = 0;
		mHeight = 0;
		mTargetPosition = Int3.zero;
		mFrameFreezeTime = 0;
		mTimeScale = 100;
		mTimeStep = 0;
		mBuffItemID = 0;
		mCanBeParry = false;
	}
}
