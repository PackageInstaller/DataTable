using Unity.VisualScripting;

namespace Bolt.Addons.Community.Fundamentals.Units.Utility;

[UnitTitle("IsEmptyOrWhitespace")]
[UnitCategory("Community\\Utility\\string")]
[TypeIcon(typeof(string))]
public class StringNullorWhiteSpace : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ControlInput Input;

	[DoNotSerialize]
	public ControlOutput True;

	[DoNotSerialize]
	public ControlOutput False;

	[PortLabelHidden]
	public ValueInput String;

	protected override void Definition()
	{
		Input = ControlInput("Input", Check);
		True = ControlOutput("True");
		False = ControlOutput("False");
		String = ValueInput<string>("String", null);
		Succession(Input, True);
		Succession(Input, False);
	}

	private ControlOutput Check(Flow flow)
	{
		string value = flow.GetValue<string>(String);
		if (string.IsNullOrEmpty(value) || string.IsNullOrWhiteSpace(value))
		{
			return True;
		}
		return False;
	}
}
