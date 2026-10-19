using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Move Towards")]
[UnitCategory("Math/Vector 2")]
public sealed class Vector2MoveTowards : MoveTowards<Vector2>
{
	protected override Vector2 defaultCurrent => Vector2.zero;

	protected override Vector2 defaultTarget => Vector2.one;

	public override Vector2 Operation(Vector2 current, Vector2 target, float maxDelta)
	{
		return Vector2.MoveTowards(current, target, maxDelta);
	}
}
