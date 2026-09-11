public sealed class ThrownArriedPositionEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mThrownID;

	public Int3 mArrivedPosition;

	public ThrownArriedPositionEvent(int thrownID, Int3 arrivedPosition)
	{
		mThrownID = thrownID;
		mArrivedPosition = arrivedPosition;
	}

	public ThrownArriedPositionEvent()
	{
	}

	public static ThrownArriedPositionEvent Claim(int thrownID, Int3 arrivedPosition)
	{
		ThrownArriedPositionEvent thrownArriedPositionEvent = FrameObjectPool<ThrownArriedPositionEvent>.Claim();
		thrownArriedPositionEvent.mThrownID = thrownID;
		thrownArriedPositionEvent.mArrivedPosition = arrivedPosition;
		return thrownArriedPositionEvent;
	}

	public override void OnEnterPool()
	{
		mThrownID = 0;
		mArrivedPosition = Int3.zero;
	}

	public override void Release()
	{
		FrameObjectPool<ThrownArriedPositionEvent>.Release(this);
	}
}
