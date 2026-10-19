using UnityEngine;

namespace Unity.VisualScripting;

[UnitOrder(10)]
[UnitCategory("Logic")]
public sealed class LessOrEqual : BinaryComparisonUnit
{
	[PortLabel("A ≤ B")]
	public override ValueOutput comparison => base.comparison;

	protected override bool NumericComparison(float a, float b)
	{
		if (!(a < b))
		{
			return Mathf.Approximately(a, b);
		}
		return true;
	}

	protected override bool GenericComparison(object a, object b)
	{
		return OperatorUtility.LessThanOrEqual(a, b);
	}
}
