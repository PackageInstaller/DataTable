using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 2")]
[UnitTitle("Per Second")]
public sealed class Vector2PerSecond : PerSecond<Vector2>
{
	public override Vector2 Operation(Vector2 input)
	{
		return input * Time.deltaTime;
	}
}
