using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Input Button", 0)]
[Category("Events/Input")]
[Description("Calls respective outputs when the defined Button is pressed down, held down or released.\nButtons are configured in Unity Input Manager.")]
public class InputButtonEvents : EventNode, IUpdatable
{
	[RequiredField]
	public BBParameter<string> buttonName = new BBParameter<string>("Fire1");

	private FlowOutput down;

	private FlowOutput up;

	private FlowOutput pressed;

	public override string name => $"{base.name} [{buttonName}]";

	protected override void RegisterPorts()
	{
		down = AddFlowOutput("Down");
		pressed = AddFlowOutput("Pressed");
		up = AddFlowOutput("Up");
	}

	public void Update()
	{
		string value = buttonName.value;
		if (Input.GetButtonDown(value))
		{
			down.Call(default(Flow));
		}
		if (Input.GetButton(value))
		{
			pressed.Call(default(Flow));
		}
		if (Input.GetButtonUp(value))
		{
			up.Call(default(Flow));
		}
	}
}
