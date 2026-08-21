public sealed class ThrownCollidedEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mThrownID;

	public int mColliedID;

	public int mTimelineID;

	public int mIndex;

	public int mCurCollidedCount;

	public int mCurCollidedIndex;

	public int mTargetPartID;

	public ThrownCollidedEvent(int thrownID, int colliedID, int timelineID, int index, int curCollidedCount, int curCollidedIndex, int targetPartID)
	{
		mThrownID = thrownID;
		mColliedID = colliedID;
		mTimelineID = timelineID;
		mIndex = index;
		mCurCollidedCount = curCollidedCount;
		mCurCollidedIndex = curCollidedIndex;
		mTargetPartID = targetPartID;
	}

	public ThrownCollidedEvent()
	{
	}

	public static ThrownCollidedEvent Claim(int thrownID, int colliedID, int timelineID, int index, int curCollidedCount, int curCollidedIndex, int targetPartID)
	{
		ThrownCollidedEvent thrownCollidedEvent = FrameObjectPool<ThrownCollidedEvent>.Claim();
		thrownCollidedEvent.mThrownID = thrownID;
		thrownCollidedEvent.mColliedID = colliedID;
		thrownCollidedEvent.mTimelineID = timelineID;
		thrownCollidedEvent.mIndex = index;
		thrownCollidedEvent.mCurCollidedCount = curCollidedCount;
		thrownCollidedEvent.mCurCollidedIndex = curCollidedIndex;
		thrownCollidedEvent.mTargetPartID = targetPartID;
		return thrownCollidedEvent;
	}

	public override void OnEnterPool()
	{
		mThrownID = 0;
		mColliedID = 0;
		mTimelineID = 0;
		mIndex = 0;
		mCurCollidedCount = 0;
		mCurCollidedIndex = 0;
		mTargetPartID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<ThrownCollidedEvent>.Release(this);
	}
}
