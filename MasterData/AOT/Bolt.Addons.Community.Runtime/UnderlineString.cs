using Unity.VisualScripting;

[UnitTitle("Underline")]
[UnitCategory("Community\\Utility\\string")]
[TypeIcon(typeof(string))]
public class UnderlineString : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput Value;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput Result;

	protected override void Definition()
	{
		Value = ValueInput<string>("Value", null);
		Result = ValueOutput("Result", Enter_);
	}

	public string Enter_(Flow flow)
	{
		return "<u>" + flow.GetValue(Value)?.ToString() + "</u>";
	}
}
