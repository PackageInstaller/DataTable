public sealed class HitAvoidShadowEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mAttackerID;

	public int mTargetID;

	public int mTimelineID;

	public int mHitIndex;

	public Int3 mPosition;

	public HitAvoidShadowEvent()
	{
	}

	public HitAvoidShadowEvent(int attckerID, int targetID, int timelineID, int hitIndex, Int3 position)
	{
		mAttackerID = attckerID;
		mTargetID = targetID;
		mTimelineID = timelineID;
		mHitIndex = hitIndex;
		mPosition = position;
	}

	public static HitAvoidShadowEvent Claim(int attckerID, int targetID, int timelineID, int hitIndex, Int3 position)
	{
		HitAvoidShadowEvent hitAvoidShadowEvent = FrameObjectPool<HitAvoidShadowEvent>.Claim();
		hitAvoidShadowEvent.mAttackerID = attckerID;
		hitAvoidShadowEvent.mTargetID = targetID;
		hitAvoidShadowEvent.mTimelineID = timelineID;
		hitAvoidShadowEvent.mHitIndex = hitIndex;
		hitAvoidShadowEvent.mPosition = position;
		return hitAvoidShadowEvent;
	}

	public override void OnEnterPool()
	{
		mAttackerID = 0;
		mTargetID = 0;
		mTimelineID = 0;
		mHitIndex = 0;
	}

	public override void Release()
	{
		FrameObjectPool<HitAvoidShadowEvent>.Release(this);
	}
}
