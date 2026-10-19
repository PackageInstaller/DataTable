using System;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Logic")]
[UnitShortTitle("Not Equal")]
[UnitSubtitle("(Approximately)")]
[UnitOrder(8)]
[Obsolete("Use the Not Equal node with Numeric enabled instead.")]
public sealed class NotApproximatelyEqual : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[PortLabel("A ≉ B")]
	[DoNotSerialize]
	public ValueOutput notEqual { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<float>("a");
		b = ValueInput("b", 0f);
		notEqual = ValueOutput("notEqual", Comparison).Predictable();
		Requirement(a, notEqual);
		Requirement(b, notEqual);
	}

	public bool Comparison(Flow flow)
	{
		return !Mathf.Approximately(flow.GetValue<float>(a), flow.GetValue<float>(b));
	}
}
