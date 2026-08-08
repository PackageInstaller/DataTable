using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Collision", 0)]
[Category("Events/Object")]
[Description("Called when Collision based events happen on target and expose collision information")]
public class CollisionEvents : MessageEventNode<Collider>
{
	private FlowOutput onEnter;

	private FlowOutput onStay;

	private FlowOutput onExit;

	private Collider receiver;

	private Collision collision;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[3] { "OnCollisionEnter", "OnCollisionStay", "OnCollisionExit" };
	}

	protected override void RegisterPorts()
	{
		onEnter = AddFlowOutput("Enter");
		onStay = AddFlowOutput("Stay");
		onExit = AddFlowOutput("Exit");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Other", () => collision.gameObject);
		AddValueOutput("Contact Point", () => collision.contacts[0]);
		AddValueOutput("Collision Info", () => collision);
	}

	private void OnCollisionEnter(MessageRouter.MessageData<Collision> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		collision = msg.value;
		onEnter.Call(default(Flow));
	}

	private void OnCollisionStay(MessageRouter.MessageData<Collision> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		collision = msg.value;
		onStay.Call(default(Flow));
	}

	private void OnCollisionExit(MessageRouter.MessageData<Collision> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		collision = msg.value;
		onExit.Call(default(Flow));
	}
}
