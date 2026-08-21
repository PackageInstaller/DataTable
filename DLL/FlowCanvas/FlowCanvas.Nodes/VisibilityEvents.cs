using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Visibility", 0)]
[Category("Events/Object")]
[Description("Calls events based on object's render visibility")]
public class VisibilityEvents : MessageEventNode<Transform>
{
	private FlowOutput onVisible;

	private FlowOutput onInvisible;

	private GameObject receiver;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[2] { "OnBecameVisible", "OnBecameInvisible" };
	}

	protected override void RegisterPorts()
	{
		onVisible = AddFlowOutput("Became Visible");
		onInvisible = AddFlowOutput("Became Invisible");
		AddValueOutput("Receiver", () => receiver);
	}

	private void OnBecameVisible(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		onVisible.Call(default(Flow));
	}

	private void OnBecameInvisible(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		onInvisible.Call(default(Flow));
	}
}
