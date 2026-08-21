using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Mouse Button", 0)]
[Category("Events/Input")]
[Description("Called when the specified mouse button is clicked down, held or released")]
public class MouseEvents : EventNode, IUpdatable
{
	public enum ButtonKeys
	{
		Left,
		Right,
		Middle
	}

	public BBParameter<ButtonKeys> buttonKey;

	private FlowOutput down;

	private FlowOutput pressed;

	private FlowOutput up;

	public override string name => $"{base.name} [{buttonKey}]";

	protected override void RegisterPorts()
	{
		down = AddFlowOutput("Down");
		pressed = AddFlowOutput("Pressed");
		up = AddFlowOutput("Up");
	}

	public void Update()
	{
		ButtonKeys value = buttonKey.value;
		if (Input.GetMouseButtonDown((int)value))
		{
			down.Call(default(Flow));
		}
		if (Input.GetMouseButton((int)value))
		{
			pressed.Call(default(Flow));
		}
		if (Input.GetMouseButtonUp((int)value))
		{
			up.Call(default(Flow));
		}
	}
}
