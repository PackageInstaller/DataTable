using System;
using UnityEngine;

namespace Unity.VisualScripting;

[Obsolete("Use the Equal node with Numeric enabled instead.")]
[UnitSubtitle("(Approximately)")]
[UnitCategory("Logic")]
[UnitOrder(7)]
[UnitShortTitle("Equal")]
public sealed class ApproximatelyEqual : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[PortLabel("A ≈ B")]
	[DoNotSerialize]
	public ValueOutput equal { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<float>("a");
		b = ValueInput("b", 0f);
		equal = ValueOutput("equal", Comparison).Predictable();
		Requirement(a, equal);
		Requirement(b, equal);
	}

	public bool Comparison(Flow flow)
	{
		return Mathf.Approximately(flow.GetValue<float>(a), flow.GetValue<float>(b));
	}
}
