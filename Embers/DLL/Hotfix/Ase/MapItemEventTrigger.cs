using UnityEngine.Serialization;

namespace Ase;

public class MapItemEventTrigger : BaseEventTriggerNode
{
	public MapItemEventType messageType;

	[FormerlySerializedAs("eventMapItem")]
	public MapItemNode eventMapItemNode;

	public override string TriggerName => "交互物事件触发器";

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		eventMapItemNode.RegisterSubscription(this);
	}

	public void OnMessage(MapItemNode mapItemNode, MapItemEventType message)
	{
		if (message == messageType)
		{
			Execute();
		}
	}

	public override void OnDisposed()
	{
		eventMapItemNode.UnRegisterSubscription(this);
	}
}
