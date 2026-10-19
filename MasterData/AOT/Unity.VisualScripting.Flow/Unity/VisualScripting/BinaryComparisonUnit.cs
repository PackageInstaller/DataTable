namespace Unity.VisualScripting;

[UnitCategory("Logic")]
public abstract class BinaryComparisonUnit : Unit
{
	[DoNotSerialize]
	public ValueInput a { get; private set; }

	[DoNotSerialize]
	public ValueInput b { get; private set; }

	[DoNotSerialize]
	public virtual ValueOutput comparison { get; private set; }

	[InspectorToggleLeft]
	[Inspectable]
	[Serialize]
	public bool numeric { get; set; } = true;

	protected virtual string outputKey => "comparison";

	protected override void Definition()
	{
		if (numeric)
		{
			a = ValueInput<float>("a");
			b = ValueInput("b", 0f);
			comparison = ValueOutput(outputKey, NumericComparison).Predictable();
		}
		else
		{
			a = ValueInput<object>("a").AllowsNull();
			b = ValueInput<object>("b").AllowsNull();
			comparison = ValueOutput(outputKey, GenericComparison).Predictable();
		}
		Requirement(a, comparison);
		Requirement(b, comparison);
	}

	private bool NumericComparison(Flow flow)
	{
		return NumericComparison(flow.GetValue<float>(a), flow.GetValue<float>(b));
	}

	private bool GenericComparison(Flow flow)
	{
		return GenericComparison(flow.GetValue(a), flow.GetValue(b));
	}

	protected abstract bool NumericComparison(float a, float b);

	protected abstract bool GenericComparison(object a, object b);
}
