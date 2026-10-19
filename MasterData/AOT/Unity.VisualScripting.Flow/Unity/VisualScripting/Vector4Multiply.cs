using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Multiply")]
[UnitCategory("Math/Vector 4")]
public sealed class Vector4Multiply : Multiply<Vector4>
{
	protected override Vector4 defaultB => Vector4.zero;

	public override Vector4 Operation(Vector4 a, Vector4 b)
	{
		return new Vector4(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w);
	}
}
