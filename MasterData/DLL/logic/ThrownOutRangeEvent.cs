public sealed class ThrownOutRangeEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mThrownID;

	public Int3 mBorderPosition;

	public ThrownOutRangeEvent(int thrownID, Int3 borderPosition)
	{
		mThrownID = thrownID;
		mBorderPosition = borderPosition;
	}

	public ThrownOutRangeEvent()
	{
	}

	public static ThrownOutRangeEvent Claim(int thrownID, Int3 borderPosition)
	{
		ThrownOutRangeEvent thrownOutRangeEvent = FrameObjectPool<ThrownOutRangeEvent>.Claim();
		thrownOutRangeEvent.mThrownID = thrownID;
		thrownOutRangeEvent.mBorderPosition = borderPosition;
		return thrownOutRangeEvent;
	}

	public override void OnEnterPool()
	{
		mThrownID = 0;
		mBorderPosition = Int3.zero;
	}

	public override void Release()
	{
		FrameObjectPool<ThrownOutRangeEvent>.Release(this);
	}
}
