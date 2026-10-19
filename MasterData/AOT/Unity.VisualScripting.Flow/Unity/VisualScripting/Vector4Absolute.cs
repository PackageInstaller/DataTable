using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Absolute")]
[UnitCategory("Math/Vector 4")]
public sealed class Vector4Absolute : Absolute<Vector4>
{
	protected override Vector4 Operation(Vector4 input)
	{
		return new Vector4(Mathf.Abs(input.x), Mathf.Abs(input.y), Mathf.Abs(input.z), Mathf.Abs(input.w));
	}
}
