using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 3")]
[UnitTitle("Cross Product")]
public sealed class Vector3CrossProduct : CrossProduct<Vector3>
{
	public override Vector3 Operation(Vector3 a, Vector3 b)
	{
		return Vector3.Cross(a, b);
	}
}
