using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Multiply")]
[UnitCategory("Math/Vector 3")]
public sealed class Vector3Multiply : Multiply<Vector3>
{
	protected override Vector3 defaultB => Vector3.zero;

	public override Vector3 Operation(Vector3 a, Vector3 b)
	{
		return new Vector3(a.x * b.x, a.y * b.y, a.z * b.z);
	}
}
