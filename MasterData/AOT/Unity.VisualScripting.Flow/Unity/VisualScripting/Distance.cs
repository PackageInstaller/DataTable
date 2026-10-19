namespace Unity.VisualScripting;

[UnitOrder(402)]
public abstract class Distance<T> : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput distance { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<T>("a");
		b = ValueInput<T>("b");
		distance = ValueOutput("distance", Operation).Predictable();
		Requirement(a, distance);
		Requirement(b, distance);
	}

	private float Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(a), flow.GetValue<T>(b));
	}

	public abstract float Operation(T a, T b);
}
