using System;

namespace Unity.VisualScripting;

[UnitCategory("Control")]
[UnitOrder(16)]
public sealed class Throw : Unit
{
	[InspectorToggleLeft]
	[UnitHeaderInspectable("Custom")]
	[Inspectable]
	[Serialize]
	public bool custom { get; set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ValueInput message { get; private set; }

	[DoNotSerialize]
	public ValueInput exception { get; private set; }

	protected override void Definition()
	{
		if (custom)
		{
			enter = ControlInput("enter", ThrowCustom);
			exception = ValueInput<Exception>("exception");
			Requirement(exception, enter);
		}
		else
		{
			enter = ControlInput("enter", ThrowMessage);
			message = ValueInput("message", string.Empty);
			Requirement(message, enter);
		}
	}

	private ControlOutput ThrowCustom(Flow flow)
	{
		throw flow.GetValue<Exception>(exception);
	}

	private ControlOutput ThrowMessage(Flow flow)
	{
		throw new Exception(flow.GetValue<string>(message));
	}
}
