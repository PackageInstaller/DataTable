namespace Unity.VisualScripting.Community;

[UnitCategory("Events/Community/Returns")]
[UnitShortTitle("Return")]
[RenamedFrom("Bolt.Addons.Community.ReturnEvents.EventReturn")]
[RenamedFrom("Lasm.UAlive.EventReturn")]
[UnitSubtitle("Return Event")]
[RenamedFrom("Lasm.BoltExtensions.EventReturn")]
public sealed class EventReturn : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput value;

	[DoNotSerialize]
	public ValueInput data;

	private GraphReference triggerReference;

	private ScriptMachine machine;

	protected override void Definition()
	{
		enter = ControlInput("enter", Enter);
		data = ValueInput<ReturnEventData>("data");
		value = ValueInput<object>("value");
	}

	public ControlOutput Enter(Flow flow)
	{
		ReturnEventData returnEventData = flow.GetValue<ReturnEventData>(data);
		object obj = flow.GetValue(value);
		if (returnEventData.args.trigger != null)
		{
			returnEventData.args.trigger.storingValue = obj;
		}
		if (returnEventData.args.isCallback)
		{
			returnEventData.args.callback?.DynamicInvoke(obj);
		}
		else
		{
			TriggerReturnEvent.Trigger(returnEventData.args);
		}
		return null;
	}
}
