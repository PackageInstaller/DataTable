using UnityEngine;

namespace Unity.VisualScripting;

[UnitOrder(99)]
[UnitCategory("Logic")]
[UnitTitle("Comparison")]
[UnitShortTitle("Comparison")]
public sealed class Comparison : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[Inspectable]
	[Serialize]
	public bool numeric { get; set; } = true;

	[PortLabel("A < B")]
	[DoNotSerialize]
	public ValueOutput aLessThanB { get; private set; }

	[PortLabel("A ≤ B")]
	[DoNotSerialize]
	public ValueOutput aLessThanOrEqualToB { get; private set; }

	[DoNotSerialize]
	[PortLabel("A = B")]
	public ValueOutput aEqualToB { get; private set; }

	[PortLabel("A ≠ B")]
	[DoNotSerialize]
	public ValueOutput aNotEqualToB { get; private set; }

	[PortLabel("A ≥ B")]
	[DoNotSerialize]
	public ValueOutput aGreaterThanOrEqualToB { get; private set; }

	[DoNotSerialize]
	[PortLabel("A > B")]
	public ValueOutput aGreatherThanB { get; private set; }

	protected override void Definition()
	{
		if (numeric)
		{
			a = ValueInput<float>("a");
			b = ValueInput("b", 0f);
			aLessThanB = ValueOutput("aLessThanB", (Flow flow) => NumericLess(flow.GetValue<float>(a), flow.GetValue<float>(b))).Predictable();
			aLessThanOrEqualToB = ValueOutput("aLessThanOrEqualToB", (Flow flow) => NumericLessOrEqual(flow.GetValue<float>(a), flow.GetValue<float>(b))).Predictable();
			aEqualToB = ValueOutput("aEqualToB", (Flow flow) => NumericEqual(flow.GetValue<float>(a), flow.GetValue<float>(b))).Predictable();
			aNotEqualToB = ValueOutput("aNotEqualToB", (Flow flow) => NumericNotEqual(flow.GetValue<float>(a), flow.GetValue<float>(b))).Predictable();
			aGreaterThanOrEqualToB = ValueOutput("aGreaterThanOrEqualToB", (Flow flow) => NumericGreaterOrEqual(flow.GetValue<float>(a), flow.GetValue<float>(b))).Predictable();
			aGreatherThanB = ValueOutput("aGreatherThanB", (Flow flow) => NumericGreater(flow.GetValue<float>(a), flow.GetValue<float>(b))).Predictable();
		}
		else
		{
			a = ValueInput<object>("a").AllowsNull();
			b = ValueInput<object>("b").AllowsNull();
			aLessThanB = ValueOutput("aLessThanB", (Flow flow) => GenericLess(flow.GetValue(a), flow.GetValue(b)));
			aLessThanOrEqualToB = ValueOutput("aLessThanOrEqualToB", (Flow flow) => GenericLessOrEqual(flow.GetValue(a), flow.GetValue(b)));
			aEqualToB = ValueOutput("aEqualToB", (Flow flow) => GenericEqual(flow.GetValue(a), flow.GetValue(b)));
			aNotEqualToB = ValueOutput("aNotEqualToB", (Flow flow) => GenericNotEqual(flow.GetValue(a), flow.GetValue(b)));
			aGreaterThanOrEqualToB = ValueOutput("aGreaterThanOrEqualToB", (Flow flow) => GenericGreaterOrEqual(flow.GetValue(a), flow.GetValue(b)));
			aGreatherThanB = ValueOutput("aGreatherThanB", (Flow flow) => GenericGreater(flow.GetValue(a), flow.GetValue(b)));
		}
		Requirement(a, aLessThanB);
		Requirement(b, aLessThanB);
		Requirement(a, aLessThanOrEqualToB);
		Requirement(b, aLessThanOrEqualToB);
		Requirement(a, aEqualToB);
		Requirement(b, aEqualToB);
		Requirement(a, aNotEqualToB);
		Requirement(b, aNotEqualToB);
		Requirement(a, aGreaterThanOrEqualToB);
		Requirement(b, aGreaterThanOrEqualToB);
		Requirement(a, aGreatherThanB);
		Requirement(b, aGreatherThanB);
	}

	private bool NumericLess(float a, float b)
	{
		return a < b;
	}

	private bool NumericLessOrEqual(float a, float b)
	{
		if (!(a < b))
		{
			return Mathf.Approximately(a, b);
		}
		return true;
	}

	private bool NumericEqual(float a, float b)
	{
		return Mathf.Approximately(a, b);
	}

	private bool NumericNotEqual(float a, float b)
	{
		return !Mathf.Approximately(a, b);
	}

	private bool NumericGreaterOrEqual(float a, float b)
	{
		if (!(a > b))
		{
			return Mathf.Approximately(a, b);
		}
		return true;
	}

	private bool NumericGreater(float a, float b)
	{
		return a > b;
	}

	private bool GenericLess(object a, object b)
	{
		return OperatorUtility.LessThan(a, b);
	}

	private bool GenericLessOrEqual(object a, object b)
	{
		return OperatorUtility.LessThanOrEqual(a, b);
	}

	private bool GenericEqual(object a, object b)
	{
		return OperatorUtility.Equal(a, b);
	}

	private bool GenericNotEqual(object a, object b)
	{
		return OperatorUtility.NotEqual(a, b);
	}

	private bool GenericGreaterOrEqual(object a, object b)
	{
		return OperatorUtility.GreaterThanOrEqual(a, b);
	}

	private bool GenericGreater(object a, object b)
	{
		return OperatorUtility.GreaterThan(a, b);
	}
}
