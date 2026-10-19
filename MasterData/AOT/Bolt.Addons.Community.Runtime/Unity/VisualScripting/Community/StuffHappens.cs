namespace Unity.VisualScripting.Community;

[UnitCategory("Community\\Documentation")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Documenting.StuffHappens")]
public class StuffHappens : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput enter { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", (Flow x) => exit);
		exit = ControlOutput("exit");
		Succession(enter, exit);
	}
}
