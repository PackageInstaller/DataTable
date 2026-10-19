namespace Unity.VisualScripting;

[UnitOrder(103)]
public abstract class Multiply<T> : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[DoNotSerialize]
	[PortLabel("A × B")]
	public ValueOutput product { get; private set; }

	[DoNotSerialize]
	protected virtual T defaultB => default;

	protected override void Definition()
	{
		a = ValueInput<T>("a");
		b = ValueInput("b", defaultB);
		product = ValueOutput("product", Operation).Predictable();
		Requirement(a, product);
		Requirement(b, product);
	}

	private T Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(a), flow.GetValue<T>(b));
	}

	public abstract T Operation(T a, T b);
}
