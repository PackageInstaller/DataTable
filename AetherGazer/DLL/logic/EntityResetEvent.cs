public class EntityResetEvent : NEventBase, IPostToPresentation, IPostToSimulation
{
	public EntityResetReason reason;

	public int entityID;

	protected EntityResetEvent(EntityResetReason reason, int entityID)
	{
		this.reason = reason;
		this.entityID = entityID;
	}

	public EntityResetEvent()
	{
	}

	public static EntityResetEvent Claim(EntityResetReason reason, int entityID)
	{
		EntityResetEvent entityResetEvent = FrameObjectPool<EntityResetEvent>.Claim();
		entityResetEvent.reason = reason;
		entityResetEvent.entityID = entityID;
		return entityResetEvent;
	}

	public override void OnEnterPool()
	{
		reason = EntityResetReason.None;
		entityID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<EntityResetEvent>.Release(this);
	}
}
