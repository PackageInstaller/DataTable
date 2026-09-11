public sealed class ThrownCollideToAvoidShadowEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mThrownID;

	public int mColliedID;

	public int mTimelineID;

	public int mIndex;

	public Int3 mPosition;

	public ThrownCollideToAvoidShadowEvent(int thrownID, int colliedID, int timelineID, int index, Int3 position)
	{
		mThrownID = thrownID;
		mColliedID = colliedID;
		mTimelineID = timelineID;
		mIndex = index;
		mPosition = position;
	}

	public ThrownCollideToAvoidShadowEvent()
	{
	}

	public static ThrownCollideToAvoidShadowEvent Claim(int thrownID, int colliedID, int timelineID, int index, Int3 position)
	{
		ThrownCollideToAvoidShadowEvent thrownCollideToAvoidShadowEvent = FrameObjectPool<ThrownCollideToAvoidShadowEvent>.Claim();
		thrownCollideToAvoidShadowEvent.mThrownID = thrownID;
		thrownCollideToAvoidShadowEvent.mColliedID = colliedID;
		thrownCollideToAvoidShadowEvent.mTimelineID = timelineID;
		thrownCollideToAvoidShadowEvent.mIndex = index;
		thrownCollideToAvoidShadowEvent.mPosition = position;
		return thrownCollideToAvoidShadowEvent;
	}

	public override void OnEnterPool()
	{
		mThrownID = 0;
		mColliedID = 0;
		mTimelineID = 0;
		mIndex = 0;
		mPosition = Int3.zero;
	}

	public override void Release()
	{
		FrameObjectPool<ThrownCollideToAvoidShadowEvent>.Release(this);
	}
}
