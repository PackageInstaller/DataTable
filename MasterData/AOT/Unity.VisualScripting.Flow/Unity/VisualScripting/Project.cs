namespace Unity.VisualScripting;

[UnitOrder(406)]
public abstract class Project<T> : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueOutput projection { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<T>("a");
		b = ValueInput<T>("b");
		projection = ValueOutput("projection", Operation).Predictable();
		Requirement(a, projection);
		Requirement(b, projection);
	}

	private T Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(a), flow.GetValue<T>(b));
	}

	public abstract T Operation(T a, T b);
}
