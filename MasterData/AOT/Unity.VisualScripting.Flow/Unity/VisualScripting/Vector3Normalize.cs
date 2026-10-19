using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 3")]
[UnitTitle("Normalize")]
public sealed class Vector3Normalize : Normalize<Vector3>
{
	public override Vector3 Operation(Vector3 input)
	{
		return Vector3.Normalize(input);
	}
}
