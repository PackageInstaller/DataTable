public sealed class EntityParrySucceededEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mAttackerID;

	public int mTargetID;

	public int mTimelineID;

	public int mHitIndex;

	public Int3 mPosition;

	public Int3 mDirection;

	public int mDelayTime;

	public int mThrownID;

	public EntityParrySucceededEvent()
	{
	}

	public EntityParrySucceededEvent(int attackerID, int targetID, int timelineID, int hitIndex, Int3 position, Int3 direction, int delayTime, int thrownID)
	{
		mAttackerID = attackerID;
		mTargetID = targetID;
		mTimelineID = timelineID;
		mHitIndex = hitIndex;
		mPosition = position;
		mDirection = direction;
		mDelayTime = delayTime;
		mThrownID = thrownID;
	}

	public static EntityParrySucceededEvent Claim(int attackerID, int targetID, int timelineID, int hitIndex, Int3 position, Int3 direction, int delayTime, int thrownID)
	{
		EntityParrySucceededEvent entityParrySucceededEvent = FrameObjectPool<EntityParrySucceededEvent>.Claim();
		entityParrySucceededEvent.mAttackerID = attackerID;
		entityParrySucceededEvent.mTargetID = targetID;
		entityParrySucceededEvent.mTimelineID = timelineID;
		entityParrySucceededEvent.mHitIndex = hitIndex;
		entityParrySucceededEvent.mPosition = position;
		entityParrySucceededEvent.mDirection = direction;
		entityParrySucceededEvent.mDelayTime = delayTime;
		entityParrySucceededEvent.mThrownID = thrownID;
		return entityParrySucceededEvent;
	}

	public override void OnEnterPool()
	{
		mAttackerID = 0;
		mTargetID = 0;
		mTimelineID = 0;
		mHitIndex = 0;
		mPosition = Int3.zero;
		mDirection = Int3.forward;
		mDelayTime = 0;
		mThrownID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<EntityParrySucceededEvent>.Release(this);
	}
}
