public sealed class MapInitFinishedTriggerEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int triggerEntityID;

	public override void OnEnterPool()
	{
		triggerEntityID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<MapInitFinishedTriggerEvent>.Release(this);
	}
}
