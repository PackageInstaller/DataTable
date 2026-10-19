using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 2")]
[UnitTitle("Normalize")]
public sealed class Vector2Normalize : Normalize<Vector2>
{
	public override Vector2 Operation(Vector2 input)
	{
		return input.normalized;
	}
}
