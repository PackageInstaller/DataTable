using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Move Towards")]
[UnitCategory("Math/Scalar")]
public sealed class ScalarMoveTowards : MoveTowards<float>
{
	protected override float defaultCurrent => 0f;

	protected override float defaultTarget => 1f;

	public override float Operation(float current, float target, float maxDelta)
	{
		return Mathf.MoveTowards(current, target, maxDelta);
	}
}
