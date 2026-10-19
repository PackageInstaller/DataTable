namespace Unity.VisualScripting.Community;

[TypeIcon(typeof(string))]
[UnitTitle("Multiline String")]
[UnitCategory("Community\\Utility\\string")]
[RenamedFrom("Bolt.Addons.Community.Fundamentals.Units.Utility.MultilineStringUnit")]
public class MultilineStringNode : Unit
{
	[Inspectable]
	[UnitHeaderInspectable]
	[InspectorTextArea]
	public string stringLiteral;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		output = ValueOutput("output", (Flow flow) => stringLiteral);
	}
}
