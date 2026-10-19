using System;

namespace Unity.VisualScripting.Community.Deprecated;

[Obsolete]
[UnitTitle("Do Once")]
[UnitCategory("Community\\Control")]
[TypeIcon(typeof(ISelectUnit))]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.DoOnceValue")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.DoOnceValue")]
public sealed class DoOnceValue : Unit
{
	private bool _isOpen = true;

	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ControlInput testReset { get; private set; }

	[DoNotSerialize]
	public ValueInput reset { get; private set; }

	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		testReset = ControlInput("testReset", TestReset);
		reset = ValueInput("reset", @default: false);
		exit = ControlOutput("exit");
		Succession(enter, exit);
		Requirement(reset, enter);
		Requirement(reset, testReset);
	}

	public ControlOutput Enter(Flow flow)
	{
		if (_isOpen || flow.GetValue<bool>(reset))
		{
			_isOpen = false;
			return exit;
		}
		return null;
	}

	public ControlOutput TestReset(Flow flow)
	{
		if (flow.GetValue<bool>(reset))
		{
			_isOpen = true;
		}
		return null;
	}
}
