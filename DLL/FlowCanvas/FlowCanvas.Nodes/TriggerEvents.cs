using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Trigger", 0)]
[Category("Events/Object")]
[Description("Called when Trigger based event happen on target")]
public class TriggerEvents : MessageEventNode<Collider>
{
	private FlowOutput onEnter;

	private FlowOutput onStay;

	private FlowOutput onExit;

	private Collider receiver;

	private GameObject other;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[3] { "OnTriggerEnter", "OnTriggerStay", "OnTriggerExit" };
	}

	protected override void RegisterPorts()
	{
		onEnter = AddFlowOutput("Enter");
		onStay = AddFlowOutput("Stay");
		onExit = AddFlowOutput("Exit");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Other", () => other);
	}

	private void OnTriggerEnter(MessageRouter.MessageData<Collider> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		other = msg.value.gameObject;
		onEnter.Call(default(Flow));
	}

	private void OnTriggerStay(MessageRouter.MessageData<Collider> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		other = msg.value.gameObject;
		onStay.Call(default(Flow));
	}

	private void OnTriggerExit(MessageRouter.MessageData<Collider> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		other = msg.value.gameObject;
		onExit.Call(default(Flow));
	}
}
