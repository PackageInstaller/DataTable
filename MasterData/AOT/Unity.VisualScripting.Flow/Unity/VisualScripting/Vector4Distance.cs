using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Distance")]
[UnitCategory("Math/Vector 4")]
public sealed class Vector4Distance : Distance<Vector4>
{
	public override float Operation(Vector4 a, Vector4 b)
	{
		return Vector4.Distance(a, b);
	}
}
