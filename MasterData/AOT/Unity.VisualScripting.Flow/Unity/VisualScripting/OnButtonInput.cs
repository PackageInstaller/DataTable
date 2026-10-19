using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Input")]
public sealed class OnButtonInput : MachineEventUnit<EmptyEventArgs>
{
	protected override string hookName => "Update";

	[DoNotSerialize]
	[PortLabel("Name")]
	public ValueInput buttonName { get; private set; }

	[DoNotSerialize]
	public ValueInput action { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		buttonName = ValueInput("buttonName", string.Empty);
		action = ValueInput("action", PressState.Down);
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		string value = flow.GetValue<string>(buttonName);
		PressState value2 = flow.GetValue<PressState>(action);
		return value2 switch
		{
			PressState.Down => Input.GetButtonDown(value), 
			PressState.Up => Input.GetButtonUp(value), 
			PressState.Hold => Input.GetButton(value), 
			_ => throw new UnexpectedEnumValueException<PressState>(value2), 
		};
	}
}
