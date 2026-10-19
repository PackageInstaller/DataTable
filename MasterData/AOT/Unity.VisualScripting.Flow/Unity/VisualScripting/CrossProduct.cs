namespace Unity.VisualScripting;

[UnitOrder(405)]
[TypeIcon(typeof(Multiply<>))]
public abstract class CrossProduct<T> : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[PortLabel("A × B")]
	[DoNotSerialize]
	public ValueOutput crossProduct { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<T>("a");
		b = ValueInput<T>("b");
		crossProduct = ValueOutput("crossProduct", Operation).Predictable();
		Requirement(a, crossProduct);
		Requirement(b, crossProduct);
	}

	private T Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(a), flow.GetValue<T>(b));
	}

	public abstract T Operation(T a, T b);
}
