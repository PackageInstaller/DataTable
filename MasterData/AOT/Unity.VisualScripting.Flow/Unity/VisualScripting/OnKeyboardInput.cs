using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Events/Input")]
public sealed class OnKeyboardInput : MachineEventUnit<EmptyEventArgs>
{
	protected override string hookName => "Update";

	[DoNotSerialize]
	public ValueInput key { get; private set; }

	[DoNotSerialize]
	public ValueInput action { get; private set; }

	protected override void Definition()
	{
		base.Definition();
		key = ValueInput("key", KeyCode.Space);
		action = ValueInput("action", PressState.Down);
	}

	protected override bool ShouldTrigger(Flow flow, EmptyEventArgs args)
	{
		KeyCode value = flow.GetValue<KeyCode>(key);
		PressState value2 = flow.GetValue<PressState>(action);
		return value2 switch
		{
			PressState.Down => Input.GetKeyDown(value), 
			PressState.Up => Input.GetKeyUp(value), 
			PressState.Hold => Input.GetKey(value), 
			_ => throw new UnexpectedEnumValueException<PressState>(value2), 
		};
	}
}
