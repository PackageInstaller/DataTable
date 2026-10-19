using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Input")]
public sealed class OnMouseInput : MachineEventUnit<EmptyEventArgs>, IMouseEventUnit
{
	protected override string hookName => "Update";

	[DoNotSerialize]
	public ValueInput button { get; private set; }

	[DoNotSerialize]
	public ValueInput action { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		button = ValueInput("button", MouseButton.Left);
		action = ValueInput("action", PressState.Down);
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		int value = (int)flow.GetValue<MouseButton>(button);
		PressState value2 = flow.GetValue<PressState>(action);
		return value2 switch
		{
			PressState.Down => Input.GetMouseButtonDown(value), 
			PressState.Up => Input.GetMouseButtonUp(value), 
			PressState.Hold => Input.GetMouseButton(value), 
			_ => throw new UnexpectedEnumValueException<PressState>(value2), 
		};
	}
}
