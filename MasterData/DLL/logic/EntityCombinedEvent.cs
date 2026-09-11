public sealed class EntityCombinedEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public CombinedStep mCombinedStep;

	public int mPendantEntityID;

	public int mBedEntityID;

	public EntityCombinedEvent(CombinedStep pCombinedStep, int pPendantEntityID, int pBaseEntityID)
	{
		mCombinedStep = pCombinedStep;
		mPendantEntityID = pPendantEntityID;
		mBedEntityID = pBaseEntityID;
	}

	public EntityCombinedEvent()
	{
	}

	public static EntityCombinedEvent Claim(CombinedStep pCombinedStep, int pPendantEntityID, int pBaseEntityID)
	{
		EntityCombinedEvent entityCombinedEvent = FrameObjectPool<EntityCombinedEvent>.Claim();
		entityCombinedEvent.mCombinedStep = pCombinedStep;
		entityCombinedEvent.mPendantEntityID = pPendantEntityID;
		entityCombinedEvent.mBedEntityID = pBaseEntityID;
		return entityCombinedEvent;
	}

	public override void OnEnterPool()
	{
		mCombinedStep = CombinedStep.None;
		mPendantEntityID = 0;
		mBedEntityID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<EntityCombinedEvent>.Release(this);
	}
}
