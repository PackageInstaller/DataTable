public sealed class EntityParryFailedEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mAttackerID;

	public int mTargetID;

	public int mTimelineID;

	public int mHitIndex;

	public Int3 mPosition;

	public Int3 mDirection;

	public int mThrownID;

	public EntityParryFailedEvent()
	{
	}

	public EntityParryFailedEvent(int attackerID, int targetID, int timelineID, int hitIndex, Int3 position, Int3 direction, int thrownID)
	{
		mAttackerID = attackerID;
		mTargetID = targetID;
		mTimelineID = timelineID;
		mHitIndex = hitIndex;
		mPosition = position;
		mDirection = direction;
		mThrownID = thrownID;
	}

	public static EntityParryFailedEvent Claim(int attackerID, int targetID, int timelineID, int hitIndex, Int3 position, Int3 direction, int thrownID)
	{
		EntityParryFailedEvent entityParryFailedEvent = FrameObjectPool<EntityParryFailedEvent>.Claim();
		entityParryFailedEvent.mAttackerID = attackerID;
		entityParryFailedEvent.mTargetID = targetID;
		entityParryFailedEvent.mTimelineID = timelineID;
		entityParryFailedEvent.mHitIndex = hitIndex;
		entityParryFailedEvent.mPosition = position;
		entityParryFailedEvent.mDirection = direction;
		entityParryFailedEvent.mThrownID = thrownID;
		return entityParryFailedEvent;
	}

	public override void OnEnterPool()
	{
		mAttackerID = 0;
		mTargetID = 0;
		mTimelineID = 0;
		mHitIndex = 0;
		mPosition = Int3.zero;
		mDirection = Int3.forward;
		mThrownID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<EntityParryFailedEvent>.Release(this);
	}
}
