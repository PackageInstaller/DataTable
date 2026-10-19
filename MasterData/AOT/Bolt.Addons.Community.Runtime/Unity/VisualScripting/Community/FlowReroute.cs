using UnityEngine;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Utility.FlowReroute")]
[RenamedFrom("Lasm.BoltExtensions.FlowReroute")]
[RenamedFrom("Lasm.UAlive.FlowReroute")]
[UnitCategory("Community/Utility")]
public sealed class FlowReroute : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput input;

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput output;

	[Inspectable]
	public Color InputColor = Color.white;

	[Inspectable]
	public Color OutputColor = Color.white;

	[Inspectable]
	public bool SnapToGrid;

	[Inspectable]
	public bool InputVisible = true;

	[Inspectable]
	public bool OutputVisible = true;

	[Inspectable]
	public bool showFlowOnHover = true;

	protected override void Definition()
	{
		input = ControlInput("in", (Flow flow) => output);
		output = ControlOutput("out");
		Succession(input, output);
	}
}
