using Unity.VisualScripting;

[UnitCategory("Community\\Utility\\string")]
[UnitTitle("Size")]
[TypeIcon(typeof(string))]
public class SizeString : Unit
{
	[Inspectable]
	[UnitHeaderInspectable("Size")]
	public int size;

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
		object value = flow.GetValue(Value);
		return $"<size={size}>" + value?.ToString() + "</size>";
	}
}
