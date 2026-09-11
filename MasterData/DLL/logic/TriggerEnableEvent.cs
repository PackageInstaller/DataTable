public class TriggerEnableEvent : NEventBase, IPostToSimulation, IPostToPreliminaryPresentation
{
	public int id;

	public bool enable;

	public TriggerEnableEvent()
	{
	}

	public TriggerEnableEvent(int id, bool enable)
	{
		this.id = id;
		this.enable = enable;
	}

	public override void OnEnterPool()
	{
		id = 0;
		enable = false;
	}

	public static TriggerEnableEvent Claim(int id, bool enable)
	{
		TriggerEnableEvent triggerEnableEvent = FrameObjectPool<TriggerEnableEvent>.Claim();
		triggerEnableEvent.id = id;
		triggerEnableEvent.enable = enable;
		return triggerEnableEvent;
	}

	public override void Release()
	{
		FrameObjectPool<TriggerEnableEvent>.Release(this);
	}
}
