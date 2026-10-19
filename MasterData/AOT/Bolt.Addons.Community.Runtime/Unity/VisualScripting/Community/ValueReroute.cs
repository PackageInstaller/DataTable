using System;

namespace Unity.VisualScripting.Community;

[UnitCategory("Community/Utility")]
[RenamedFrom("Lasm.UAlive.ValueReroute")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Utility.ValueReroute")]
[RenamedFrom("Lasm.BoltExtensions.ValueReroute")]
public sealed class ValueReroute : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput output;

	[Serialize]
	public Type portType = typeof(object);

	[Inspectable]
	public bool SnapToGrid;

	[Inspectable]
	public bool inputVisible = true;

	[Inspectable]
	public bool outputVisible = true;

	[Inspectable]
	public bool showFlowOnHover = true;

	protected override void Definition()
	{
		input = ValueInput(portType, "in");
		output = ValueOutput(portType, "out", (Flow flow) => flow.GetValue(input));
		Requirement(input, output);
	}
}
