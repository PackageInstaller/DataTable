namespace Ase;

public class NpcNodeEventTrigger : BaseEventTriggerNode
{
	public MapItemEventType messageType;

	public NPCNode eventNpcNode;

	public override string TriggerName => "NPC事件触发器";

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		eventNpcNode.RegisterSubscription(this);
	}

	public void OnMessage(NPCNode NpcNode, MapItemEventType message)
	{
		if (message == messageType)
		{
			Execute();
		}
	}

	public override void OnDisposed()
	{
		eventNpcNode.UnRegisterSubscription(this);
	}
}
