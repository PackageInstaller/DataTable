using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Character Controller", 0)]
[Category("Events/Object")]
[Description("Called when the Character Controller hits a collider while performing a Move")]
public class CharacterControllerEvents : MessageEventNode<CharacterController>
{
	private FlowOutput onHit;

	private CharacterController receiver;

	private ControllerColliderHit hitInfo;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[1] { "OnControllerColliderHit" };
	}

	protected override void RegisterPorts()
	{
		onHit = AddFlowOutput("Collider Hit");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Other", () => hitInfo.gameObject);
		AddValueOutput("Collision Point", () => hitInfo.point);
		AddValueOutput("Collision Info", () => hitInfo);
	}

	private void OnControllerColliderHit(MessageRouter.MessageData<ControllerColliderHit> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		hitInfo = msg.value;
		onHit.Call(default(Flow));
	}
}
