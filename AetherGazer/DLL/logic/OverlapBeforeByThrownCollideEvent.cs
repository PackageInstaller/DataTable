public sealed class OverlapBeforeByThrownCollideEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mCreationIndex;

	public int mAbilityID;

	public int mCollideIndex;

	public OverlapBeforeByThrownCollideEvent(int creationIndex, int abilityID, int collideIndex)
	{
		mCreationIndex = creationIndex;
		mAbilityID = abilityID;
		mCollideIndex = collideIndex;
	}

	public OverlapBeforeByThrownCollideEvent()
	{
	}

	public static OverlapBeforeByThrownCollideEvent Claim(int creationIndex, int abilityID, int collideIndex)
	{
		OverlapBeforeByThrownCollideEvent overlapBeforeByThrownCollideEvent = FrameObjectPool<OverlapBeforeByThrownCollideEvent>.Claim();
		overlapBeforeByThrownCollideEvent.mCreationIndex = creationIndex;
		overlapBeforeByThrownCollideEvent.mAbilityID = abilityID;
		overlapBeforeByThrownCollideEvent.mCollideIndex = collideIndex;
		return overlapBeforeByThrownCollideEvent;
	}

	public override void OnEnterPool()
	{
		mCreationIndex = 0;
		mAbilityID = 0;
		mCollideIndex = -1;
	}

	public override void Release()
	{
		FrameObjectPool<OverlapBeforeByThrownCollideEvent>.Release(this);
	}
}
