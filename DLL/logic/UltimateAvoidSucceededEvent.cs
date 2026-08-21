public sealed class UltimateAvoidSucceededEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mAvoiderID;

	public int mAttackerID;

	public UltimateAvoidSucceededEvent(int avoiderID, int attackerID)
	{
		mAvoiderID = avoiderID;
		mAttackerID = attackerID;
	}

	public UltimateAvoidSucceededEvent()
	{
	}

	public static UltimateAvoidSucceededEvent Claim(int avoiderID, int attackerID)
	{
		UltimateAvoidSucceededEvent ultimateAvoidSucceededEvent = FrameObjectPool<UltimateAvoidSucceededEvent>.Claim();
		ultimateAvoidSucceededEvent.mAvoiderID = avoiderID;
		ultimateAvoidSucceededEvent.mAttackerID = attackerID;
		return ultimateAvoidSucceededEvent;
	}

	public override void OnEnterPool()
	{
		mAvoiderID = 0;
		mAttackerID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<UltimateAvoidSucceededEvent>.Release(this);
	}
}
