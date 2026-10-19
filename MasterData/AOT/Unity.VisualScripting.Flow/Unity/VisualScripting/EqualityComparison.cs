using System;

namespace Unity.VisualScripting;

[UnitTitle("Equality Comparison")]
[UnitSurtitle("Equality")]
[UnitOrder(4)]
[UnitCategory("Logic")]
[UnitShortTitle("Comparison")]
[Obsolete("Use the Comparison node instead.")]
public sealed class EqualityComparison : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[PortLabel("A = B")]
	[DoNotSerialize]
	public ValueOutput equal { get; private set; }

	[DoNotSerialize]
	[PortLabel("A ≠ B")]
	public ValueOutput notEqual { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<object>("a").AllowsNull();
		b = ValueInput<object>("b").AllowsNull();
		equal = ValueOutput("equal", Equal).Predictable();
		notEqual = ValueOutput("notEqual", NotEqual).Predictable();
		Requirement(a, equal);
		Requirement(b, equal);
		Requirement(a, notEqual);
		Requirement(b, notEqual);
	}

	private bool Equal(Flow flow)
	{
		return OperatorUtility.Equal(flow.GetValue(a), flow.GetValue(b));
	}

	private bool NotEqual(Flow flow)
	{
		return OperatorUtility.NotEqual(flow.GetValue(a), flow.GetValue(b));
	}
}
