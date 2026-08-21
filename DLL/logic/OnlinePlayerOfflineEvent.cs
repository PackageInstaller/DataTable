public class OnlinePlayerOfflineEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int entityID;

	public static OnlinePlayerOfflineEvent Claim(int entityID)
	{
		OnlinePlayerOfflineEvent onlinePlayerOfflineEvent = FrameObjectPool<OnlinePlayerOfflineEvent>.Claim();
		onlinePlayerOfflineEvent.entityID = entityID;
		return onlinePlayerOfflineEvent;
	}

	public override void Release()
	{
		FrameObjectPool<OnlinePlayerOfflineEvent>.Release(this);
	}

	public override void OnEnterPool()
	{
		entityID = 0;
	}
}
