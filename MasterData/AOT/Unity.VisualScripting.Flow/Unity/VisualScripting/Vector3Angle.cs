using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 3")]
[UnitTitle("Angle")]
public sealed class Vector3Angle : Angle<Vector3>
{
	public override float Operation(Vector3 a, Vector3 b)
	{
		return Vector3.Angle(a, b);
	}
}
