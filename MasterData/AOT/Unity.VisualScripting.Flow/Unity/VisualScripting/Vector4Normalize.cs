using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Normalize")]
[UnitCategory("Math/Vector 4")]
public sealed class Vector4Normalize : Normalize<Vector4>
{
	public override Vector4 Operation(Vector4 input)
	{
		return Vector4.Normalize(input);
	}
}
