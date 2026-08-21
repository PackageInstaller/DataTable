public class ThrownOverlapEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mThrownID;

	public int mColliedID;

	public int mTimelineID;

	public int mIndex;

	public int mCurCollidedCount;

	public int mCurCollidedIndex;

	public ThrownOverlapEventState mState;

	public static ThrownOverlapEvent Claim(int thrownID, int colliedID, int timelineID, int index, int curCollidedCount, int curCollidedIndex, ThrownOverlapEventState state)
	{
		ThrownOverlapEvent thrownOverlapEvent = FrameObjectPool<ThrownOverlapEvent>.Claim();
		thrownOverlapEvent.mThrownID = thrownID;
		thrownOverlapEvent.mColliedID = colliedID;
		thrownOverlapEvent.mTimelineID = timelineID;
		thrownOverlapEvent.mIndex = index;
		thrownOverlapEvent.mCurCollidedCount = curCollidedCount;
		thrownOverlapEvent.mCurCollidedIndex = curCollidedIndex;
		thrownOverlapEvent.mState = state;
		return thrownOverlapEvent;
	}

	public override void OnEnterPool()
	{
		mThrownID = 0;
		mColliedID = 0;
		mTimelineID = 0;
		mIndex = 0;
		mCurCollidedCount = 0;
		mCurCollidedIndex = 0;
		mState = ThrownOverlapEventState.none;
	}

	public override void Release()
	{
		FrameObjectPool<ThrownOverlapEvent>.Release(this);
	}
}
