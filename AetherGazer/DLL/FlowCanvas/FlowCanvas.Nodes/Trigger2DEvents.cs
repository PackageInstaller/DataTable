using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Trigger2D", 0)]
[Category("Events/Object")]
[Description("Called when 2D Trigger based event happen on target")]
public class Trigger2DEvents : MessageEventNode<Collider2D>
{
	private FlowOutput onEnter;

	private FlowOutput onStay;

	private FlowOutput onExit;

	private Collider2D receiver;

	private GameObject other;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[3] { "OnTriggerEnter2D", "OnTriggerStay2D", "OnTriggerExit2D" };
	}

	protected override void RegisterPorts()
	{
		onEnter = AddFlowOutput("Enter");
		onStay = AddFlowOutput("Stay");
		onExit = AddFlowOutput("Exit");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Other", () => other);
	}

	private void OnTriggerEnter2D(MessageRouter.MessageData<Collider2D> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		other = msg.value.gameObject;
		onEnter.Call(default(Flow));
	}

	private void OnTriggerStay2D(MessageRouter.MessageData<Collider2D> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		other = msg.value.gameObject;
		onStay.Call(default(Flow));
	}

	private void OnTriggerExit2D(MessageRouter.MessageData<Collider2D> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		other = msg.value.gameObject;
		onExit.Call(default(Flow));
	}
}
