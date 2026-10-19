using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Absolute")]
[UnitCategory("Math/Vector 3")]
public sealed class Vector3Absolute : Absolute<Vector3>
{
	protected override Vector3 Operation(Vector3 input)
	{
		return new Vector3(Mathf.Abs(input.x), Mathf.Abs(input.y), Mathf.Abs(input.z));
	}
}
