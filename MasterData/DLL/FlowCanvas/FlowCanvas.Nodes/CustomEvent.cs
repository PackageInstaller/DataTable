using System;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Services;

namespace FlowCanvas.Nodes;

[Name("Custom Event", 100)]
[Description("Called when a custom event is received on target(s).\n- Receiver, is the object which received the event.\n- Sender, is the object which invoked the event.\n\n- To send an event from a graph use the SendEvent node.\n- To send an event from code use: 'FlowScriptController.SendEvent(string)'")]
[Category("Events/Custom")]
public class CustomEvent : MessageEventNode<GraphOwner>
{
	[RequiredField]
	[DelayedField]
	public BBParameter<string> eventName = new BBParameter<string>("EventName");

	private FlowOutput onReceived;

	private GraphOwner sender;

	private GraphOwner receiver;

	public override string name => base.name + $" [ <color=#DDDDDD>{eventName}</color> ]";

	protected override string[] GetTargetMessageEvents()
	{
		return new string[1] { "OnCustomEvent" };
	}

	protected override void RegisterPorts()
	{
		onReceived = AddFlowOutput("Received");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Sender", () => sender);
	}

	public void OnCustomEvent(MessageRouter.MessageData<EventData> msg)
	{
		if (msg.value.name.ToUpper() == eventName.value.ToUpper())
		{
			Graph elementGraph = Graph.GetElementGraph(msg.sender);
			sender = ((elementGraph != null) ? (elementGraph.agent as GraphOwner) : null);
			receiver = ResolveReceiver(msg.receiver);
			onReceived.Call(default(Flow));
		}
	}
}
[Name("Custom Event", 100)]
[Description("Called when a custom event is received on target(s).\n- Receiver, is the object which received the event.\n- Sender, is the object which invoked the event.\n\n- To send an event from a graph use the SendEvent(T) node.\n- To send an event from code use: 'FlowScriptController.SendEvent(string, T)'")]
[Category("Events/Custom")]
[ContextDefinedOutputs(new Type[] { typeof(Wild) })]
public class CustomEvent<T> : MessageEventNode<GraphOwner>
{
	[RequiredField]
	public BBParameter<string> eventName = new BBParameter<string>("EventName");

	private FlowOutput onReceived;

	private GraphOwner sender;

	private GraphOwner receiver;

	private T receivedValue;

	public override string name => base.name + $" [ <color=#DDDDDD>{eventName}</color> ]";

	protected override string[] GetTargetMessageEvents()
	{
		return new string[1] { "OnCustomEvent" };
	}

	protected override void RegisterPorts()
	{
		onReceived = AddFlowOutput("Received");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Sender", () => sender);
		AddValueOutput("Event Value", () => receivedValue);
	}

	public void OnCustomEvent(MessageRouter.MessageData<EventData> msg)
	{
		if (!(msg.value.name.ToUpper() == eventName.value.ToUpper()))
		{
			return;
		}
		Graph elementGraph = Graph.GetElementGraph(msg.sender);
		sender = ((elementGraph != null) ? (elementGraph.agent as GraphOwner) : null);
		receiver = ResolveReceiver(msg.receiver);
		Type type = msg.value.GetType();
		if (type.RTIsGenericType())
		{
			Type other = type.RTGetGenericArguments().FirstOrDefault();
			if (typeof(T).RTIsAssignableFrom(other))
			{
				receivedValue = (T)msg.value.value;
			}
		}
		onReceived.Call(default(Flow));
	}
}
