using System;
using UnityEngine;

namespace Unity.VisualScripting;

[RenamedFrom("Unity.VisualScripting.Vector3Add")]
[UnitTitle("Add")]
[UnitCategory("Math/Vector 3")]
[Obsolete("Use the new \"Add (Math/Vector 3)\" instead.")]
[RenamedFrom("Bolt.Vector3Add")]
public sealed class DeprecatedVector3Add : Add<Vector3>
{
	protected override Vector3 defaultB => Vector3.zero;

	public override Vector3 Operation(Vector3 a, Vector3 b)
	{
		return a + b;
	}
}
