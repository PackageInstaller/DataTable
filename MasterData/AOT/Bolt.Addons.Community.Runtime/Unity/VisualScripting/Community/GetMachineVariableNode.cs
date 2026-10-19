namespace Unity.VisualScripting.Community;

[UnitTitle("Get Machine Variable")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.GetMachineVariableUnit")]
public sealed class GetMachineVariableNode : MachineVariableNode
{
	[DoNotSerialize]
	public ValueOutput value;

	protected override void Definition()
	{
		base.Definition();
		value = ValueOutput("value", (Flow flow) => Variables.Graph(flow.GetValue<ScriptMachine>(target).GetReference()).Get(flow.GetValue<string>(name)));
	}
}
