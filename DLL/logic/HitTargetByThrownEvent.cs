public sealed class HitTargetByThrownEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mThrownID;

	public int mTargetID;

	public int mAbilityID;

	public int mHitIndex;

	public int mTargetPartID;

	public HitTargetByThrownEvent(int thrownID, int targetID, int abilityID, int hitIndex, int targetPartID)
	{
		mThrownID = thrownID;
		mTargetID = targetID;
		mAbilityID = abilityID;
		mHitIndex = hitIndex;
		mTargetPartID = targetPartID;
	}

	public HitTargetByThrownEvent()
	{
	}

	public static HitTargetByThrownEvent Claim(int thrownID, int targetID, int abilityID, int hitIndex, int targetPartID)
	{
		HitTargetByThrownEvent hitTargetByThrownEvent = FrameObjectPool<HitTargetByThrownEvent>.Claim();
		hitTargetByThrownEvent.mThrownID = thrownID;
		hitTargetByThrownEvent.mTargetID = targetID;
		hitTargetByThrownEvent.mAbilityID = abilityID;
		hitTargetByThrownEvent.mHitIndex = hitIndex;
		hitTargetByThrownEvent.mTargetPartID = targetPartID;
		return hitTargetByThrownEvent;
	}

	public override void OnEnterPool()
	{
		mThrownID = 0;
		mTargetID = 0;
		mAbilityID = 0;
		mHitIndex = 0;
		mTargetPartID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<HitTargetByThrownEvent>.Release(this);
	}
}
