using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Object State", 0)]
[Category("Events/Object")]
[Description("OnEnable, OnDisable and OnDestroy callback events for target object")]
public class ObjectStateEvents : MessageEventNode<Transform>
{
	private FlowOutput onEnable;

	private FlowOutput onDisable;

	private FlowOutput onDestroy;

	private GameObject receiver;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[3] { "OnEnable", "OnDisable", "OnDestroy" };
	}

	protected override void RegisterPorts()
	{
		onEnable = AddFlowOutput("On Enable");
		onDisable = AddFlowOutput("On Disable");
		onDestroy = AddFlowOutput("On Destroy");
		AddValueOutput("Receiver", () => receiver);
	}

	private void OnEnable(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		onEnable.Call(default(Flow));
	}

	private void OnDisable(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		onDisable.Call(default(Flow));
	}

	private void OnDestroy(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		onDestroy.Call(default(Flow));
	}
}
