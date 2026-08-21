using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Utility")]
[Description("Send a Local Event to specified graph")]
public class SendEvent : CallableActionNode<GraphOwner, string>
{
	public override void Invoke(GraphOwner target, string eventName)
	{
		target.SendEvent(new EventData(eventName), base.parentNode);
	}
}
[Category("Utility")]
[Description("Send a Local Event with 1 argument to specified graph")]
[ExposeAsDefinition]
public class SendEvent<T> : CallableActionNode<GraphOwner, string, T>
{
	public override void Invoke(GraphOwner target, string eventName, T eventValue)
	{
		target.SendEvent(new EventData<T>(eventName, eventValue), base.parentNode);
	}
}
