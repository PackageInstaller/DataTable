using Unity.VisualScripting;

[UnitCategory("Community\\Utility\\string")]
[UnitTitle("Italic")]
[TypeIcon(typeof(string))]
public class ItalicString : Unit
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
		return "<i>" + flow.GetValue(Value)?.ToString() + "</i>";
	}
}
