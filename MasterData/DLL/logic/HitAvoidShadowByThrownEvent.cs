public sealed class HitAvoidShadowByThrownEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mThrownID;

	public int mTargetID;

	public int mTimelineID;

	public int mHitIndex;

	public Int3 mPosition;

	public HitAvoidShadowByThrownEvent()
	{
	}

	public HitAvoidShadowByThrownEvent(int thrownID, int targetID, int timelineID, int hitIndex, Int3 position)
	{
		mThrownID = thrownID;
		mTargetID = targetID;
		mTimelineID = timelineID;
		mHitIndex = hitIndex;
		mPosition = position;
	}

	public static HitAvoidShadowByThrownEvent Claim(int thrownID, int targetID, int timelineID, int hitIndex, Int3 position)
	{
		HitAvoidShadowByThrownEvent hitAvoidShadowByThrownEvent = FrameObjectPool<HitAvoidShadowByThrownEvent>.Claim();
		hitAvoidShadowByThrownEvent.mThrownID = thrownID;
		hitAvoidShadowByThrownEvent.mTargetID = targetID;
		hitAvoidShadowByThrownEvent.mTimelineID = timelineID;
		hitAvoidShadowByThrownEvent.mHitIndex = hitIndex;
		hitAvoidShadowByThrownEvent.mPosition = position;
		return hitAvoidShadowByThrownEvent;
	}

	public override void OnEnterPool()
	{
		mThrownID = 0;
		mTargetID = 0;
		mTimelineID = 0;
		mHitIndex = 0;
	}

	public override void Release()
	{
		FrameObjectPool<HitAvoidShadowByThrownEvent>.Release(this);
	}
}
