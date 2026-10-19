using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 2")]
[UnitTitle("Dot Product")]
public sealed class Vector2DotProduct : DotProduct<Vector2>
{
	public override float Operation(Vector2 a, Vector2 b)
	{
		return Vector2.Dot(a, b);
	}
}
