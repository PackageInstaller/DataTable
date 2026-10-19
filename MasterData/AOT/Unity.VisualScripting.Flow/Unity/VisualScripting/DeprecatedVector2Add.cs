using System;
using UnityEngine;

namespace Unity.VisualScripting;

[RenamedFrom("Unity.VisualScripting.Vector2Add")]
[Obsolete("Use the new \"Add (Math/Vector 2)\" node instead.")]
[RenamedFrom("Bolt.Vector2Add")]
[UnitCategory("Math/Vector 2")]
[UnitTitle("Add")]
public sealed class DeprecatedVector2Add : Add<Vector2>
{
	protected override Vector2 defaultB => Vector2.zero;

	public override Vector2 Operation(Vector2 a, Vector2 b)
	{
		return a + b;
	}
}
