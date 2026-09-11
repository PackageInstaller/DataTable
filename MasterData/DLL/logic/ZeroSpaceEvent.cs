public sealed class ZeroSpaceEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public EnZeroSpaceStep mEnZeroSpaceStep;

	public int mAvoiderID;

	public int mAttackerID;

	public int mParam;

	public ZeroSpaceEvent(EnZeroSpaceStep enZeroSpaceStep, int avoiderID, int attackerID, int param)
	{
		mEnZeroSpaceStep = enZeroSpaceStep;
		mAvoiderID = avoiderID;
		mAttackerID = attackerID;
		mParam = param;
	}

	public ZeroSpaceEvent()
	{
	}

	public static ZeroSpaceEvent Claim(EnZeroSpaceStep enZeroSpaceStep, int avoiderID, int attackerID, int param)
	{
		ZeroSpaceEvent zeroSpaceEvent = FrameObjectPool<ZeroSpaceEvent>.Claim();
		zeroSpaceEvent.mEnZeroSpaceStep = enZeroSpaceStep;
		zeroSpaceEvent.mAvoiderID = avoiderID;
		zeroSpaceEvent.mAttackerID = attackerID;
		zeroSpaceEvent.mParam = param;
		return zeroSpaceEvent;
	}

	public override void OnEnterPool()
	{
		mEnZeroSpaceStep = EnZeroSpaceStep.None;
		mAvoiderID = 0;
		mAttackerID = 0;
		mParam = 0;
	}

	public override void Release()
	{
		FrameObjectPool<ZeroSpaceEvent>.Release(this);
	}
}
