namespace Unity.VisualScripting.Community;

[UnitTitle("Set Machine Variable")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.SetMachineVariableUnit")]
public sealed class SetMachineVariableNode : MachineVariableNode
{
	[DoNotSerialize]
	public ControlInput enter;

	[DoNotSerialize]
	public ControlOutput exit;

	[DoNotSerialize]
	public ValueInput value;

	protected override void Definition()
	{
		base.Definition();
		enter = ControlInput("enter", (Flow flow) =>
		{
			Variables.Graph(flow.GetValue<ScriptMachine>(target).GetReference()).Set(flow.GetValue<string>(name), flow.GetValue(value));
			return exit;
		});
		exit = ControlOutput("exit");
		value = ValueInput<object>("value");
	}
}
