namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.MachineIsUnit")]
[UnitCategory("Community/Graphs")]
[TypeIcon(typeof(ScriptMachine))]
[UnitTitle("Machine Is")]
public sealed class MachineIsNode : Unit
{
	[DoNotSerialize]
	[NullMeansSelf]
	[PortLabelHidden]
	public ValueInput target;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput asset;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput result;

	protected override void Definition()
	{
		target = ValueInput<ScriptMachine>("target", null);
		target.NullMeansSelf();
		asset = ValueInput<ScriptGraphAsset>("asset", null);
		result = ValueOutput("machine", (Flow flow) =>
		{
			ScriptGraphAsset scriptGraphAsset = flow.GetValue<ScriptMachine>(target)?.nest.macro;
			return scriptGraphAsset != null && scriptGraphAsset == flow.GetValue<ScriptGraphAsset>(asset);
		});
	}
}
