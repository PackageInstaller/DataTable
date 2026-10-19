using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 2")]
[UnitTitle("Distance")]
public sealed class Vector2Distance : Distance<Vector2>
{
	public override float Operation(Vector2 a, Vector2 b)
	{
		return Vector2.Distance(a, b);
	}
}
