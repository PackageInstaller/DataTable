using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Collision2D", 0)]
[Category("Events/Object")]
[Description("Called when 2D Collision based events happen on target and expose collision information")]
public class Collision2DEvents : MessageEventNode<Collider2D>
{
	private FlowOutput onEnter;

	private FlowOutput onStay;

	private FlowOutput onExit;

	private Collider2D receiver;

	private Collision2D collision;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[3] { "OnCollisionEnter2D", "OnCollisionStay2D", "OnCollisionExit2D" };
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

	private void OnCollisionEnter2D(MessageRouter.MessageData<Collision2D> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		collision = msg.value;
		onEnter.Call(default(Flow));
	}

	private void OnCollisionStay2D(MessageRouter.MessageData<Collision2D> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		collision = msg.value;
		onStay.Call(default(Flow));
	}

	private void OnCollisionExit2D(MessageRouter.MessageData<Collision2D> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		collision = msg.value;
		onExit.Call(default(Flow));
	}
}
