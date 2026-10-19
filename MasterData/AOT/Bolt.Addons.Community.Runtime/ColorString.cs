using Unity.VisualScripting;

[UnitTitle("Color")]
[TypeIcon(typeof(string))]
[UnitCategory("Community\\Utility\\string")]
public class ColorString : Unit
{
	[Inspectable]
	[UnitHeaderInspectable("Color")]
	public TextColor color;

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
		string text = color.ToString();
		object value = flow.GetValue(Value);
		return "<color=" + text + ">" + value?.ToString() + "</color>";
	}
}
