using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Project")]
[UnitCategory("Math/Vector 2")]
public sealed class Vector2Project : Project<Vector2>
{
	public override Vector2 Operation(Vector2 a, Vector2 b)
	{
		return Vector2.Dot(a, b) * b.normalized;
	}
}
