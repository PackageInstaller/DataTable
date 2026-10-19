using Unity.VisualScripting;

namespace Bolt.Addons.Community.Fundamentals;

[UnitCategory("Community\\Control")]
[TypeIcon(typeof(Once))]
[UnitTitle("LimitedTrigger")]
public class TriggerXTimes : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput Input;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput Exit;

	[DoNotSerialize]
	public ControlOutput After;

	[DoNotSerialize]
	public ControlInput Reset;

	[DoNotSerialize]
	public ValueInput Times;

	private int timesTriggered;

	protected override void Definition()
	{
		Input = ControlInput("Input", IncreaseTimes);
		Reset = ControlInput("Reset", ResetTimes);
		Exit = ControlOutput("Exit");
		After = ControlOutput("After");
		Times = ValueInput("Times", 1);
		Succession(Reset, Exit);
		Succession(Input, Exit);
		Succession(Input, After);
		Succession(Reset, After);
	}

	private ControlOutput IncreaseTimes(Flow flow)
	{
		timesTriggered++;
		int num = (int)flow.GetValue(Times);
		if (timesTriggered <= num)
		{
			return Exit;
		}
		return After;
	}

	private ControlOutput ResetTimes(Flow flow)
	{
		timesTriggered = 0;
		return null;
	}
}
