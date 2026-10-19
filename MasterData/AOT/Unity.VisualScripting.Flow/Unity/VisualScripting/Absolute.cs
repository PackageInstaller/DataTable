namespace Unity.VisualScripting;

[UnitOrder(201)]
public abstract class Absolute<TInput> : Unit
{
	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput input { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput output { get; private set; }

	protected override void Definition()
	{
		input = ValueInput<TInput>("input");
		output = ValueOutput("output", Operation).Predictable();
		Requirement(input, output);
	}

	protected abstract TInput Operation(TInput input);

	public TInput Operation(Flow flow)
	{
		return Operation(flow.GetValue<TInput>(input));
	}
}
