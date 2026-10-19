namespace Unity.VisualScripting;

[UnitOrder(1)]
[UnitCategory("Logic")]
public sealed class Or : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[DoNotSerialize]
	[PortLabel("A | B")]
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
		if (!flow.GetValue<bool>(a))
		{
			return flow.GetValue<bool>(b);
		}
		return true;
	}
}
