namespace Unity.VisualScripting;

[UnitCategory("Logic")]
[UnitOrder(2)]
public sealed class ExclusiveOr : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[PortLabel("A ⊕ B")]
	[DoNotSerialize]
	public ValueOutput result { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<bool>("a");
		b = ValueInput<bool>("b");
		result = ValueOutput("result", Operation).Predictable();
		Requirement(a, result);
		Requirement(b, result);
	}

	public bool Operation(Flow flow)
	{
		return flow.GetValue<bool>(a) ^ flow.GetValue<bool>(b);
	}
}
