using System.Collections.Generic;
using System.Linq;
using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Events/Object")]
[Description("Events relevant to transform changes")]
public class TransformEvents : MessageEventNode<Transform>
{
	private FlowOutput onParentChanged;

	private FlowOutput onChildrenChanged;

	private Transform receiver;

	private Transform parent;

	private IEnumerable<Transform> children;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[2] { "OnTransformParentChanged", "OnTransformChildrenChanged" };
	}

	protected override void RegisterPorts()
	{
		onParentChanged = AddFlowOutput("On Transform Parent Changed");
		onChildrenChanged = AddFlowOutput("On Transform Children Changed");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Parent", () => parent);
		AddValueOutput("Children", () => children);
	}

	private void OnTransformParentChanged(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		parent = receiver.parent;
		children = receiver.Cast<Transform>();
		onParentChanged.Call(default(Flow));
	}

	private void OnTransformChildrenChanged(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		parent = receiver.parent;
		children = receiver.Cast<Transform>();
		onChildrenChanged.Call(default(Flow));
	}
}
