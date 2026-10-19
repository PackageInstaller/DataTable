namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.MachineVariableUnit")]
[TypeIcon(typeof(ScriptMachine))]
[UnitCategory("Community/Graphs")]
public abstract class MachineVariableNode : Unit
{
	[Inspectable]
	[UnitHeaderInspectable]
	[Serialize]
	public ScriptGraphAsset asset;

	[Serialize]
	public string defaultName = string.Empty;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput name;

	[DoNotSerialize]
	[NullMeansSelf]
	[PortLabelHidden]
	public ValueInput target;

	protected override void Definition()
	{
		target = ValueInput<ScriptMachine>("target", null);
		target.NullMeansSelf();
		name = ValueInput("name", defaultName);
	}
}
