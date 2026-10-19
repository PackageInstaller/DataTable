using Unity.VisualScripting;

[UnitCategory("Community\\Utility\\string")]
[UnitTitle("Reverse String")]
[TypeIcon(typeof(string))]
public class ReverseStringNode : Unit
{
	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		input = ValueInput("input", string.Empty);
		output = ValueOutput("output", (Flow flow) => flow.GetValue<string>(input).Reverse());
		Requirement(input, output);
	}
}
