public sealed class HitTargetEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mAttackerID;

	public int mTargetID;

	public int mAbilityID;

	public int mThrownID;

	public int mHitIndex;

	public Int3 mPosition;

	public int mTargetPartID;

	public HitTargetEvent(int attckerID, int targetID, int abilityID, int thrownID, int hitIndex, Int3 position, int targetPartID)
	{
		mAttackerID = attckerID;
		mTargetID = targetID;
		mAbilityID = abilityID;
		mThrownID = thrownID;
		mHitIndex = hitIndex;
		mPosition = position;
		mTargetPartID = targetPartID;
	}

	public HitTargetEvent()
	{
	}

	public static HitTargetEvent Claim(int attckerID, int targetID, int abilityID, int thrownID, int hitIndex, Int3 position, int targetPartID)
	{
		HitTargetEvent hitTargetEvent = FrameObjectPool<HitTargetEvent>.Claim();
		hitTargetEvent.mAttackerID = attckerID;
		hitTargetEvent.mTargetID = targetID;
		hitTargetEvent.mAbilityID = abilityID;
		hitTargetEvent.mThrownID = thrownID;
		hitTargetEvent.mHitIndex = hitIndex;
		hitTargetEvent.mPosition = position;
		hitTargetEvent.mTargetPartID = targetPartID;
		return hitTargetEvent;
	}

	public override void OnEnterPool()
	{
		mAttackerID = 0;
		mTargetID = 0;
		mAbilityID = 0;
		mThrownID = 0;
		mHitIndex = 0;
		mTargetPartID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<HitTargetEvent>.Release(this);
	}
}
