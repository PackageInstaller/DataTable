namespace Unity.VisualScripting;

[UnitOrder(501)]
public abstract class Lerp<T> : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[DoNotSerialize]
	public ValueInput t { get; private set; }

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput interpolation { get; private set; }

	[DoNotSerialize]
	protected virtual T defaultA => default;

	[DoNotSerialize]
	protected virtual T defaultB => default;

	protected override void Definition()
	{
		a = ValueInput("a", defaultA);
		b = ValueInput("b", defaultB);
		t = ValueInput("t", 0f);
		interpolation = ValueOutput("interpolation", Operation).Predictable();
		Requirement(a, interpolation);
		Requirement(b, interpolation);
		Requirement(t, interpolation);
	}

	private T Operation(Flow flow)
	{
		return Operation(flow.GetValue<T>(a), flow.GetValue<T>(b), flow.GetValue<float>(t));
	}

	public abstract T Operation(T a, T b, float t);
}
