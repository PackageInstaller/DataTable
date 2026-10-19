namespace Unity.VisualScripting;

[UnitOrder(101)]
public abstract class Add<T> : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[DoNotSerialize]
	[PortLabel("A + B")]
	public ValueOutput sum { get; private set; }

	[DoNotSerialize]
	protected virtual T defaultB => default;

	protected override void Definition()
	{
		a = ValueInput<T>("a");
		b = ValueInput("b", defaultB);
		sum = ValueOutput("sum", Operation).Predictable();
		Requirement(a, sum);
		Requirement(b, sum);
	}

	private T Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(a), flow.GetValue<T>(b));
	}

	public abstract T Operation(T a, T b);
}
