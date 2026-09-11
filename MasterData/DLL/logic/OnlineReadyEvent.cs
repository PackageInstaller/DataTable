public class OnlineReadyEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int entityID;

	public bool isReady;

	public static OnlineReadyEvent Claim(int entityID, bool isReady)
	{
		OnlineReadyEvent onlineReadyEvent = FrameObjectPool<OnlineReadyEvent>.Claim();
		onlineReadyEvent.entityID = entityID;
		onlineReadyEvent.isReady = isReady;
		return onlineReadyEvent;
	}

	public override void Release()
	{
		FrameObjectPool<OnlineReadyEvent>.Release(this);
	}

	public override void OnEnterPool()
	{
		entityID = 0;
		isReady = false;
	}
}
