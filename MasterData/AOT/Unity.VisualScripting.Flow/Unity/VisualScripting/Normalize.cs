namespace Unity.VisualScripting;

[UnitOrder(401)]
public abstract class Normalize<T> : Unit
{
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput input { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		input = ValueInput<T>("input");
		output = ValueOutput("output", Operation).Predictable();
		Requirement(input, output);
	}

	private T Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(input));
	}

	public abstract T Operation(T input);
}
