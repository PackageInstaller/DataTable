using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Mouse Pick", 0)]
[Category("Events/Input")]
[Description("Called when any collider is clicked with the specified mouse button. PickInfo contains the information of the raycast event")]
public class MousePickEvent : EventNode, IUpdatable
{
	public enum ButtonKeys
	{
		Left,
		Right,
		Middle
	}

	public BBParameter<ButtonKeys> buttonKey;

	public BBParameter<LayerMask> mask = new BBParameter<LayerMask>(-1);

	private FlowOutput o;

	private RaycastHit hit;

	public override string name => $"{base.name} [{buttonKey}]";

	protected override void RegisterPorts()
	{
		o = AddFlowOutput("Object Picked");
		AddValueOutput("Pick Info", () => hit);
	}

	public void Update()
	{
		if (Input.GetMouseButtonDown((int)buttonKey.value) && Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), out hit, float.PositiveInfinity, mask.value))
		{
			o.Call(default(Flow));
		}
	}
}
