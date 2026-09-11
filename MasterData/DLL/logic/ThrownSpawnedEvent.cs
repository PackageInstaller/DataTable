public sealed class ThrownSpawnedEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mThrownID;

	public int mTimelineID;

	public Int3 mSpawnPosition = Int3.zero;

	public Int3 mSpawnForward = Int3.zero;

	public int mCasterID;

	public ThrownSpawnedEvent()
	{
	}

	public ThrownSpawnedEvent(int thrownID, int timelineID, Int3 spawnPosition, Int3 spawnForward, int casterID)
	{
		mThrownID = thrownID;
		mTimelineID = timelineID;
		mSpawnPosition = spawnPosition;
		mSpawnForward = spawnForward;
		mCasterID = casterID;
	}

	public static ThrownSpawnedEvent Claim(int thrownID, int timelineID, Int3 spawnPosition, Int3 spawnForward, int casterID)
	{
		ThrownSpawnedEvent thrownSpawnedEvent = FrameObjectPool<ThrownSpawnedEvent>.Claim();
		thrownSpawnedEvent.mThrownID = thrownID;
		thrownSpawnedEvent.mTimelineID = timelineID;
		thrownSpawnedEvent.mSpawnPosition = spawnPosition;
		thrownSpawnedEvent.mSpawnForward = spawnForward;
		thrownSpawnedEvent.mCasterID = casterID;
		return thrownSpawnedEvent;
	}

	public override void OnEnterPool()
	{
		mThrownID = 0;
		mTimelineID = 0;
		mCasterID = 0;
		mSpawnPosition = Int3.zero;
		mSpawnForward = Int3.zero;
	}

	public override void Release()
	{
		FrameObjectPool<ThrownSpawnedEvent>.Release(this);
	}
}
