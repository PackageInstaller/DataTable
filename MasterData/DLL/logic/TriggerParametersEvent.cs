public class TriggerParametersEvent : NEventBase, IPostToSimulation, IPostToPreliminaryPresentation
{
	public int triggerID;

	public int param1;

	public int param2;

	public int param3;

	public int param4;

	public TriggerParametersEvent()
	{
	}

	public TriggerParametersEvent(int id, int param1, int param2, int param3, int param4)
	{
		triggerID = id;
		this.param1 = param1;
		this.param2 = param2;
		this.param3 = param3;
		this.param4 = param4;
	}

	public override void OnEnterPool()
	{
		triggerID = 0;
		param1 = 0;
		param2 = 0;
		param3 = 0;
		param4 = 0;
	}

	public static TriggerParametersEvent Claim(int id, int param1, int param2, int param3, int param4)
	{
		TriggerParametersEvent triggerParametersEvent = FrameObjectPool<TriggerParametersEvent>.Claim();
		triggerParametersEvent.triggerID = id;
		triggerParametersEvent.param1 = param1;
		triggerParametersEvent.param2 = param2;
		triggerParametersEvent.param3 = param3;
		triggerParametersEvent.param4 = param4;
		return triggerParametersEvent;
	}

	public override void Release()
	{
		FrameObjectPool<TriggerParametersEvent>.Release(this);
	}
}
