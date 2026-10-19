namespace Unity.VisualScripting;

[UnitOrder(403)]
public abstract class Angle<T> : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput angle { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<T>("a");
		b = ValueInput<T>("b");
		angle = ValueOutput("angle", Operation).Predictable();
		Requirement(a, angle);
		Requirement(b, angle);
	}

	private float Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(a), flow.GetValue<T>(b));
	}

	public abstract float Operation(T a, T b);
}
