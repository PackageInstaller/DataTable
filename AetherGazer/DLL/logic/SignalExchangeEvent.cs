public class SignalExchangeEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int entityID;

	public int contentID;

	public static SignalExchangeEvent Claim(int entityID, int contentID)
	{
		SignalExchangeEvent signalExchangeEvent = FrameObjectPool<SignalExchangeEvent>.Claim();
		signalExchangeEvent.entityID = entityID;
		signalExchangeEvent.contentID = contentID;
		return signalExchangeEvent;
	}

	public override void Release()
	{
		FrameObjectPool<SignalExchangeEvent>.Release(this);
	}

	public override void OnEnterPool()
	{
		entityID = 0;
		contentID = 0;
	}
}
