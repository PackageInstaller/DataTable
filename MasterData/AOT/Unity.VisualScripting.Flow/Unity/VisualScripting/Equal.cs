using UnityEngine;

namespace Unity.VisualScripting;

[UnitOrder(5)]
[UnitCategory("Logic")]
public sealed class Equal : BinaryComparisonUnit
{
	protected override string outputKey => "equal";

	[PortLabel("A = B")]
	[PortKey("equal")]
	[DoNotSerialize]
	public override ValueOutput comparison => base.comparison;

	public Equal()
	{
		numeric = false;
	}

	protected override bool NumericComparison(float a, float b)
	{
		return Mathf.Approximately(a, b);
	}

	protected override bool GenericComparison(object a, object b)
	{
		return OperatorUtility.Equal(a, b);
	}
}
