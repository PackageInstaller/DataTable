public sealed class BuffItemCloseToEntityEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mThrownID;

	public int mTargetID;

	public BuffItemCloseToEntityEvent(int thrownID, int targetID)
	{
		mThrownID = thrownID;
		mTargetID = targetID;
	}

	public BuffItemCloseToEntityEvent()
	{
	}

	public static BuffItemCloseToEntityEvent Claim(int thrownID, int targetID)
	{
		BuffItemCloseToEntityEvent buffItemCloseToEntityEvent = FrameObjectPool<BuffItemCloseToEntityEvent>.Claim();
		buffItemCloseToEntityEvent.mThrownID = thrownID;
		buffItemCloseToEntityEvent.mTargetID = targetID;
		return buffItemCloseToEntityEvent;
	}

	public override void OnEnterPool()
	{
		mThrownID = 0;
		mTargetID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<BuffItemCloseToEntityEvent>.Release(this);
	}
}
