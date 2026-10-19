namespace Unity.VisualScripting;

[UnitOrder(601)]
public abstract class PerSecond<T> : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		input = ValueInput<T>("input", default);
		output = ValueOutput("output", Operation);
		Requirement(input, output);
	}

	public abstract T Operation(T input);

	public T Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(input));
	}
}
