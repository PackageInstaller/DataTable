using System;

namespace Unity.VisualScripting.Community.Deprecated;

[TypeIcon(typeof(ISelectUnit))]
[UnitCategory("Community\\Control")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.DoOnceV2")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.DoOnceV2")]
[UnitTitle("Do Once")]
[Obsolete("Use the build in Once Unit!")]
public sealed class DoOnceV2 : Unit
{
	private bool _isOpen = true;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[PortLabel("Reset")]
	[DoNotSerialize]
	public ControlInput resetFlow { get; private set; }

	[PortLabel("Test Reset")]
	[DoNotSerialize]
	public ControlInput testReset { get; private set; }

	[PortLabel("Reset")]
	[DoNotSerialize]
	public ValueInput resetBool { get; private set; }

	[InspectorToggleLeft]
	[Inspectable]
	[Serialize]
	public bool boolean { get; set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		if (!boolean)
		{
			enter = ControlInput("enter", Enter);
			resetFlow = ControlInput("resetFlow", Reset);
			exit = ControlOutput("exit");
		}
		else
		{
			enter = ControlInput("enter", Enter);
			testReset = ControlInput("testReset", TestReset);
			resetBool = ValueInput("resetBool", @default: false);
			exit = ControlOutput("exit");
			Requirement(resetBool, enter);
			Requirement(resetBool, testReset);
		}
		Succession(enter, exit);
	}

	public ControlOutput Enter(Flow flow)
	{
		if (_isOpen)
		{
			_isOpen = false;
			return exit;
		}
		return null;
	}

	private ControlOutput Reset(Flow obj)
	{
		_isOpen = true;
		return null;
	}

	public ControlOutput TestReset(Flow flow)
	{
		if (flow.GetValue<bool>(resetBool))
		{
			_isOpen = true;
		}
		return null;
	}
}
