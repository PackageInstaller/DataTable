using Unity.VisualScripting;

namespace Bolt.Addons.Community.Fundamentals;

[UnitCategory("Events\\Community")]
[UnitTitle("SendTaskEvent")]
[TypeIcon(typeof(EventUnit<EmptyEventArgs>))]
public class TriggerNextTask : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput inputTrigger { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput outputTrigger { get; private set; }

	protected override void Definition()
	{
		inputTrigger = ControlInput("inputTrigger", Trigger);
		outputTrigger = ControlOutput("outputTrigger");
		Succession(inputTrigger, outputTrigger);
	}

	private ControlOutput Trigger(Flow flow)
	{
		EventBus.Trigger(CommunityEvents.WaitForEvent);
		return outputTrigger;
	}
}
