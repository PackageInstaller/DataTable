using System;

namespace Unity.VisualScripting.Community.Deprecated;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.DoOnce")]
[UnitCategory("Community\\Control")]
[UnitTitle("Do Once")]
[TypeIcon(typeof(ISelectUnit))]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.DoOnce")]
[Obsolete]
public sealed class DoOnce : Unit
{
	private bool _isOpen = true;

	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ControlInput reset { get; private set; }

	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		reset = ControlInput("reset", Reset);
		exit = ControlOutput("exit");
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
}
