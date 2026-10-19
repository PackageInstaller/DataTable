namespace Unity.VisualScripting;

[UnitOrder(15)]
[UnitCategory("Control")]
public sealed class Cache : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ControlInput enter { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	[PortLabel("Cached")]
	[PortLabelHidden]
	public ValueOutput output { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ControlOutput exit { get; private set; }

	protected override void Definition()
	{
		enter = ControlInput("enter", Store);
		input = ValueInput<object>("input");
		output = ValueOutput<object>("output");
		exit = ControlOutput("exit");
		Requirement(input, enter);
		Assignment(enter, output);
		Succession(enter, exit);
	}

	private ControlOutput Store(Flow flow)
	{
		flow.SetValue(output, flow.GetValue(input));
		return exit;
	}
}
