using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Mouse2D", 0)]
[Category("Events/Object")]
[Description("Called when mouse based operations happen on target 2D collider")]
public class MouseAgent2DEvents : MessageEventNode<Collider2D>
{
	private FlowOutput onEnter;

	private FlowOutput onOver;

	private FlowOutput onExit;

	private FlowOutput onDown;

	private FlowOutput onUp;

	private FlowOutput onDrag;

	private Collider2D receiver;

	private RaycastHit2D hit;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[6] { "OnMouseEnter", "OnMouseOver", "OnMouseExit", "OnMouseDown", "OnMouseUp", "OnMouseDrag" };
	}

	protected override void RegisterPorts()
	{
		onDown = AddFlowOutput("Down");
		onUp = AddFlowOutput("Up");
		onEnter = AddFlowOutput("Enter");
		onOver = AddFlowOutput("Over");
		onExit = AddFlowOutput("Exit");
		onDrag = AddFlowOutput("Drag");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Info", () => hit);
	}

	private void OnMouseEnter(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		StoreHit();
		onEnter.Call(default(Flow));
	}

	private void OnMouseOver(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		StoreHit();
		onOver.Call(default(Flow));
	}

	private void OnMouseExit(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		StoreHit();
		onExit.Call(default(Flow));
	}

	private void OnMouseDown(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		StoreHit();
		onDown.Call(default(Flow));
	}

	private void OnMouseUp(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		StoreHit();
		onUp.Call(default(Flow));
	}

	private void OnMouseDrag(MessageRouter.MessageData msg)
	{
		receiver = ResolveReceiver(msg.receiver);
		StoreHit();
		onDrag.Call(default(Flow));
	}

	private void StoreHit()
	{
		if (Camera.main != null)
		{
			Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
			hit = Physics2D.Raycast(ray.origin, ray.direction, float.PositiveInfinity);
		}
	}
}
