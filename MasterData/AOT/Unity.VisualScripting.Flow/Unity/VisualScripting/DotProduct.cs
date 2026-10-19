namespace Unity.VisualScripting;

[UnitOrder(404)]
public abstract class DotProduct<T> : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[PortLabel("A∙B")]
	[DoNotSerialize]
	public ValueOutput dotProduct { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<T>("a");
		b = ValueInput<T>("b");
		dotProduct = ValueOutput("dotProduct", Operation).Predictable();
		Requirement(a, dotProduct);
		Requirement(b, dotProduct);
	}

	private float Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(a), flow.GetValue<T>(b));
	}

	public abstract float Operation(T a, T b);
}
