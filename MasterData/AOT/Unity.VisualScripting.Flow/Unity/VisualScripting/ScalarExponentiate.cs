using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Scalar")]
[UnitOrder(105)]
[UnitTitle("Exponentiate")]
public sealed class ScalarExponentiate : Unit
{
	[DoNotSerialize]
	[PortLabel("x")]
	public ValueInput @base { get; private set; }

	[PortLabel("n")]
	[DoNotSerialize]
	public ValueInput exponent { get; private set; }

	[DoNotSerialize]
	[PortLabel("xⁿ")]
	public ValueOutput power { get; private set; }

	protected override void Definition()
	{
		@base = ValueInput("base", 1f);
		exponent = ValueInput("exponent", 2f);
		power = ValueOutput("power", Exponentiate);
		Requirement(@base, power);
		Requirement(exponent, power);
	}

	public float Exponentiate(Flow flow)
	{
		return Mathf.Pow(flow.GetValue<float>(@base), flow.GetValue<float>(exponent));
	}
}
