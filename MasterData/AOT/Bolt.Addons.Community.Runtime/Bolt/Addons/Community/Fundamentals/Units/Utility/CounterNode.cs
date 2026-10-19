using Unity.VisualScripting;

namespace Bolt.Addons.Community.Fundamentals.Units.Utility;

[UnitCategory("Community\\Utility")]
[TypeIcon(typeof(Add<object>))]
[UnitTitle("Counter")]
public class CounterNode : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter;

	[DoNotSerialize]
	public ControlInput reset;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit;

	[DoNotSerialize]
	public ValueOutput timesTriggered;

	private int counter;

	protected override void Definition()
	{
		enter = ControlInput("enter", OnEnter);
		reset = ControlInput("reset", OnReset);
		exit = ControlOutput("exit");
		timesTriggered = ValueOutput<int>("timesTriggered");
		Succession(enter, exit);
		Succession(reset, exit);
	}

	public ControlOutput OnEnter(Flow flow)
	{
		counter++;
		flow.SetValue(timesTriggered, counter);
		return exit;
	}

	public ControlOutput OnReset(Flow flow)
	{
		counter = 0;
		flow.SetValue(timesTriggered, counter);
		return null;
	}
}
