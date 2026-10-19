using System;
using UnityEngine;

namespace Unity.VisualScripting;

[Obsolete("Use the Comparison node with Numeric enabled instead.")]
[UnitCategory("Logic")]
[UnitTitle("Numeric Comparison")]
[UnitSurtitle("Numeric")]
[UnitShortTitle("Comparison")]
[UnitOrder(99)]
public sealed class NumericComparison : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[DoNotSerialize]
	[PortLabel("A < B")]
	public ValueOutput aLessThanB { get; private set; }

	[DoNotSerialize]
	[PortLabel("A ≤ B")]
	public ValueOutput aLessThanOrEqualToB { get; private set; }

	[DoNotSerialize]
	[PortLabel("A = B")]
	public ValueOutput aEqualToB { get; private set; }

	[PortLabel("A ≥ B")]
	[DoNotSerialize]
	public ValueOutput aGreaterThanOrEqualToB { get; private set; }

	[PortLabel("A > B")]
	[DoNotSerialize]
	public ValueOutput aGreatherThanB { get; private set; }

	protected override void Definition()
	{
		a = ValueInput<float>("a");
		b = ValueInput("b", 0f);
		aLessThanB = ValueOutput("aLessThanB", Less).Predictable();
		aLessThanOrEqualToB = ValueOutput("aLessThanOrEqualToB", LessOrEqual).Predictable();
		aEqualToB = ValueOutput("aEqualToB", Equal).Predictable();
		aGreaterThanOrEqualToB = ValueOutput("aGreaterThanOrEqualToB", GreaterOrEqual).Predictable();
		aGreatherThanB = ValueOutput("aGreatherThanB", Greater).Predictable();
		Requirement(a, aLessThanB);
		Requirement(b, aLessThanB);
		Requirement(a, aLessThanOrEqualToB);
		Requirement(b, aLessThanOrEqualToB);
		Requirement(a, aEqualToB);
		Requirement(b, aEqualToB);
		Requirement(a, aGreaterThanOrEqualToB);
		Requirement(b, aGreaterThanOrEqualToB);
		Requirement(a, aGreatherThanB);
		Requirement(b, aGreatherThanB);
	}

	private bool Less(Flow flow)
	{
		return flow.GetValue<float>(a) < flow.GetValue<float>(b);
	}

	private bool LessOrEqual(Flow flow)
	{
		float value = flow.GetValue<float>(a);
		float value2 = flow.GetValue<float>(b);
		if (!(value < value2))
		{
			return Mathf.Approximately(value, value2);
		}
		return true;
	}

	private bool Equal(Flow flow)
	{
		return Mathf.Approximately(flow.GetValue<float>(a), flow.GetValue<float>(b));
	}

	private bool GreaterOrEqual(Flow flow)
	{
		float value = flow.GetValue<float>(a);
		float value2 = flow.GetValue<float>(b);
		if (!(value > value2))
		{
			return Mathf.Approximately(value, value2);
		}
		return true;
	}

	private bool Greater(Flow flow)
	{
		return flow.GetValue<float>(a) < flow.GetValue<float>(b);
	}
}
