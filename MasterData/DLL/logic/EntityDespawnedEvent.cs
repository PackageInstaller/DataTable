public class EntityDespawnedEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int DestroyedEntity;

	public bool IsByCommanderEliminated;

	public CommanderID KillingCommanderID;

	public int KillingEntity;

	public UnitRemoveReason RemoveReason;

	public bool SkipDeathSequence;

	public uint mAgentCamp;

	public int mAbilityID;

	public uint mDespawnedFrame;

	public EntityDespawnedEvent()
	{
	}

	protected EntityDespawnedEvent(CommanderID killingCommanderID, int killingEntity, int destroyedEntity, bool skipDeathSequence, uint destroyedUnitClass, UnitRemoveReason removeReason, bool isByCommanderEliminated, int abilityID, uint mLastFrame)
	{
		DestroyedEntity = destroyedEntity;
		SkipDeathSequence = skipDeathSequence;
		KillingCommanderID = killingCommanderID;
		KillingEntity = killingEntity;
		RemoveReason = removeReason;
		IsByCommanderEliminated = isByCommanderEliminated;
		mAgentCamp = destroyedUnitClass;
		mAbilityID = abilityID;
		mDespawnedFrame = mLastFrame;
	}

	public static EntityDespawnedEvent Claim(CommanderID killingCommanderID, int killingEntity, int destroyedEntity, bool skipDeathSequence, uint destroyedUnitClass, UnitRemoveReason removeReason, bool isByCommanderEliminated, int abilityID, uint mLastFrame)
	{
		EntityDespawnedEvent entityDespawnedEvent = FrameObjectPool<EntityDespawnedEvent>.Claim();
		entityDespawnedEvent.SkipDeathSequence = skipDeathSequence;
		entityDespawnedEvent.KillingCommanderID = killingCommanderID;
		entityDespawnedEvent.KillingEntity = killingEntity;
		entityDespawnedEvent.RemoveReason = removeReason;
		entityDespawnedEvent.IsByCommanderEliminated = isByCommanderEliminated;
		entityDespawnedEvent.mAgentCamp = destroyedUnitClass;
		entityDespawnedEvent.mAbilityID = abilityID;
		entityDespawnedEvent.mDespawnedFrame = mLastFrame;
		entityDespawnedEvent.DestroyedEntity = destroyedEntity;
		return entityDespawnedEvent;
	}

	public override void OnEnterPool()
	{
	}

	public override void Release()
	{
		FrameObjectPool<EntityDespawnedEvent>.Release(this);
	}
}
