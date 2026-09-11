using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Animator", 0)]
[Category("Events/Object")]
[Description("Calls Animator based events. Note that using this node will override root motion as usual, but you can call 'Apply Builtin Root Motion' to get it back.")]
public class AnimatorEvents : MessageEventNode<Animator>
{
	private FlowOutput onAnimatorMove;

	private FlowOutput onAnimatorIK;

	private Animator receiver;

	private int layerIndex;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[2] { "OnAnimatorIK", "OnAnimatorMove" };
	}

	protected override void RegisterPorts()
	{
		onAnimatorMove = AddFlowOutput("On Animator Move");
		onAnimatorIK = AddFlowOutput("On Animator IK");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Layer Index", () => layerIndex);
	}

	private void OnAnimatorMove(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		onAnimatorMove.Call(default(Flow));
	}

	private void OnAnimatorIK(MessageRouter.MessageData<int> msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		layerIndex = msg.value;
		onAnimatorIK.Call(default(Flow));
	}
}
