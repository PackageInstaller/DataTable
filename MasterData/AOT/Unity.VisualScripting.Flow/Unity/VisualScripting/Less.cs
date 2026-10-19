namespace Unity.VisualScripting;

[UnitCategory("Logic")]
[UnitOrder(9)]
public sealed class Less : BinaryComparisonUnit
{
	[PortLabel("A < B")]
	public override ValueOutput comparison => base.comparison;

	protected override bool NumericComparison(float a, float b)
	{
		return a < b;
	}

	protected override bool GenericComparison(object a, object b)
	{
		return OperatorUtility.LessThan(a, b);
	}
}
