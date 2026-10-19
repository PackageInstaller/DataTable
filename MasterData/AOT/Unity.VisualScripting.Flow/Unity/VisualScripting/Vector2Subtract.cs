using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Subtract")]
[UnitCategory("Math/Vector 2")]
public sealed class Vector2Subtract : Subtract<Vector2>
{
	protected override Vector2 defaultMinuend => Vector2.zero;

	protected override Vector2 defaultSubtrahend => Vector2.zero;

	public override Vector2 Operation(Vector2 a, Vector2 b)
	{
		return a - b;
	}
}
