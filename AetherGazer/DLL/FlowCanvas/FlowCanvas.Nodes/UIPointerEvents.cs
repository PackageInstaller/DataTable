using System.Collections;
using ParadoxNotion.Design;
using ParadoxNotion.Services;
using UnityEngine;
using UnityEngine.EventSystems;

namespace FlowCanvas.Nodes;

[Name("UI Pointer", 0)]
[Category("Events/Object/UI")]
[Description("Calls UI Pointer based events on target. The Unity Event system has to be set through 'GameObject/UI/Event System'")]
public class UIPointerEvents : MessageEventNode<Transform>
{
	private FlowOutput onPointerDown;

	private FlowOutput onPointerPressed;

	private FlowOutput onPointerUp;

	private FlowOutput onPointerEnter;

	private FlowOutput onPointerExit;

	private FlowOutput onPointerClick;

	private GameObject receiver;

	private PointerEventData eventData;

	private bool updatePressed;

	protected override string[] GetTargetMessageEvents()
	{
		return new string[5] { "OnPointerEnter", "OnPointerExit", "OnPointerDown", "OnPointerUp", "OnPointerClick" };
	}

	protected override void RegisterPorts()
	{
		onPointerClick = AddFlowOutput("Click");
		onPointerDown = AddFlowOutput("Down");
		onPointerPressed = AddFlowOutput("Pressed");
		onPointerUp = AddFlowOutput("Up");
		onPointerEnter = AddFlowOutput("Enter");
		onPointerExit = AddFlowOutput("Exit");
		AddValueOutput("Receiver", () => receiver);
		AddValueOutput("Event Data", () => eventData);
	}

	private void OnPointerDown(MessageRouter.MessageData<PointerEventData> msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		eventData = msg.value;
		onPointerDown.Call(default(Flow));
		updatePressed = true;
		StartCoroutine(UpdatePressed());
	}

	private void OnPointerUp(MessageRouter.MessageData<PointerEventData> msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		eventData = msg.value;
		onPointerUp.Call(default(Flow));
		updatePressed = false;
	}

	private IEnumerator UpdatePressed()
	{
		while (updatePressed)
		{
			onPointerPressed.Call(default(Flow));
			yield return null;
		}
	}

	private void OnPointerEnter(MessageRouter.MessageData<PointerEventData> msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		eventData = msg.value;
		onPointerEnter.Call(default(Flow));
	}

	private void OnPointerExit(MessageRouter.MessageData<PointerEventData> msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		eventData = msg.value;
		onPointerExit.Call(default(Flow));
	}

	private void OnPointerClick(MessageRouter.MessageData<PointerEventData> msg)
	{
		receiver = ResolveReceiver(msg.receiver).gameObject;
		eventData = msg.value;
		onPointerClick.Call(default(Flow));
	}
}
