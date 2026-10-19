using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Logic")]
[UnitOrder(6)]
public sealed class NotEqual : BinaryComparisonUnit
{
	protected override string outputKey => "notEqual";

	[PortKey("notEqual")]
	[DoNotSerialize]
	[PortLabel("A ≠ B")]
	public override ValueOutput comparison => base.comparison;

	public NotEqual()
	{
		numeric = false;
	}

	protected override bool NumericComparison(float a, float b)
	{
		return !Mathf.Approximately(a, b);
	}

	protected override bool GenericComparison(object a, object b)
	{
		return OperatorUtility.NotEqual(a, b);
	}
}
