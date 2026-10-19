using Unity.VisualScripting;

[UnitTitle("Bold")]
[TypeIcon(typeof(string))]
[UnitCategory("Community\\Utility\\string")]
public class BoldString : Unit
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
		return "<b>" + flow.GetValue(Value)?.ToString() + "</b>";
	}
}
