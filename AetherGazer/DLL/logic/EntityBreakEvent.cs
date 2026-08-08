public sealed class EntityBreakEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int entityID;

	public BreakState state;

	public override void OnEnterPool()
	{
		entityID = 0;
		state = BreakState.tick;
	}

	public static EntityBreakEvent Claim(int entityID, BreakState state)
	{
		EntityBreakEvent entityBreakEvent = new EntityBreakEvent();
		entityBreakEvent.entityID = entityID;
		entityBreakEvent.state = state;
		return entityBreakEvent;
	}

	public override void Release()
	{
		FrameObjectPool<EntityBreakEvent>.Release(this);
	}
}
