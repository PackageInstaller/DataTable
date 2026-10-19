using System;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 4")]
[UnitTitle("Add")]
[Obsolete("Use the new \"Add (Math/Vector 4)\" instead.")]
[RenamedFrom("Unity.VisualScripting.Vector4Add")]
[RenamedFrom("Bolt.Vector4Add")]
public sealed class DeprecatedVector4Add : Add<Vector4>
{
	protected override Vector4 defaultB => Vector4.zero;

	public override Vector4 Operation(Vector4 a, Vector4 b)
	{
		return a + b;
	}
}
