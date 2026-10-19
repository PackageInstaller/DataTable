using Unity.VisualScripting;

[TypeIcon(typeof(string))]
[UnitTitle("Strikethrough")]
[UnitCategory("Community\\Utility\\string")]
public class StrikethroughString : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput Value;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput Result;

	protected override void Definition()
	{
		Value = ValueInput<string>("Value", null);
		Result = ValueOutput("Result", Enter_);
	}

	public string Enter_(Flow flow)
	{
		return "<s>" + flow.GetValue(Value)?.ToString() + "</s>";
	}
}
