namespace Unity.VisualScripting.Community;

[UnitCategory("Community\\Logic")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Latch")]
[RenamedFrom("Bolt.Addons.Community.Logic.Units.Latch")]
public sealed class Latch : Unit
{
	private bool _isSet;

	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	public ValueInput set { get; private set; }

	[DoNotSerialize]
	public ValueInput reset { get; private set; }

	[DoNotSerialize]
	[PortLabel("Reset Dominant")]
	public ValueInput resetDominant { get; private set; }

	[DoNotSerialize]
	[PortLabel("Exit")]
	public ControlOutput exit { get; private set; }

	[DoNotSerialize]
	public ValueOutput value { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		set = ValueInput("set", @default: false);
		reset = ValueInput("reset", @default: false);
		resetDominant = ValueInput("resetDominant", @default: false);
		exit = ControlOutput("exit");
		value = ValueOutput("value", (Flow x) => _isSet);
		Succession(enter, exit);
		Requirement(set, enter);
		Requirement(reset, enter);
		Requirement(resetDominant, enter);
		Requirement(set, value);
		Requirement(reset, value);
		Requirement(resetDominant, value);
	}

	public ControlOutput Enter(Flow flow)
	{
		if (flow.GetValue<bool>(set))
		{
			if (flow.GetValue<bool>(reset))
			{
				if (flow.GetValue<bool>(resetDominant))
				{
					_isSet = false;
				}
				else
				{
					_isSet = true;
				}
			}
			else
			{
				_isSet = true;
			}
		}
		else if (flow.GetValue<bool>(reset))
		{
			_isSet = false;
		}
		return exit;
	}
}
