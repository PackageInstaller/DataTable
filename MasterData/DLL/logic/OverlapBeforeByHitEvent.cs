public sealed class OverlapBeforeByHitEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mCreationIndex;

	public int mAbilityID;

	public int mHitIndex;

	public Int3 mPosition;

	public Int3 mForward;

	public Int3 mAimDirection;

	public OverlapBeforeByHitEvent(int creationIndex, int abilityID, int hitIndex, Int3 position, Int3 forward, Int3 aimDirection)
	{
		mCreationIndex = creationIndex;
		mAbilityID = abilityID;
		mHitIndex = hitIndex;
		mPosition = position;
		mForward = forward;
		mAimDirection = aimDirection;
	}

	public OverlapBeforeByHitEvent()
	{
	}

	public static OverlapBeforeByHitEvent Claim(int creationIndex, int abilityID, int hitIndex, Int3 position, Int3 forward, Int3 aimDirection)
	{
		OverlapBeforeByHitEvent overlapBeforeByHitEvent = FrameObjectPool<OverlapBeforeByHitEvent>.Claim();
		overlapBeforeByHitEvent.mCreationIndex = creationIndex;
		overlapBeforeByHitEvent.mAbilityID = abilityID;
		overlapBeforeByHitEvent.mHitIndex = hitIndex;
		overlapBeforeByHitEvent.mPosition = position;
		overlapBeforeByHitEvent.mForward = forward;
		overlapBeforeByHitEvent.mAimDirection = aimDirection;
		return overlapBeforeByHitEvent;
	}

	public override void OnEnterPool()
	{
		mCreationIndex = 0;
		mAbilityID = 0;
		mHitIndex = -1;
		mPosition = Int3.zero;
		mForward = Int3.forward;
		mAimDirection = Int3.zero;
	}

	public override void Release()
	{
		FrameObjectPool<OverlapBeforeByHitEvent>.Release(this);
	}
}
