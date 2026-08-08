public class EntityTimerEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public EntityTimerStruct timerStruct;

	public EBuffLife life;

	public int entityID;

	public bool isTimeoutLeft;

	public override void OnEnterPool()
	{
		life = EBuffLife.None;
		entityID = 0;
	}

	public static EntityTimerEvent Claim(EntityTimerStruct timerStruct, EBuffLife life, int entityID, bool isTimeout = false)
	{
		EntityTimerEvent entityTimerEvent = FrameObjectPool<EntityTimerEvent>.Claim();
		entityTimerEvent.life = life;
		entityTimerEvent.timerStruct = timerStruct;
		entityTimerEvent.entityID = entityID;
		entityTimerEvent.isTimeoutLeft = isTimeout;
		return entityTimerEvent;
	}

	public override void Release()
	{
		FrameObjectPool<EntityTimerEvent>.Release(this);
	}
}
