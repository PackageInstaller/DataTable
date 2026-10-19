using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 2")]
[UnitTitle("Add")]
public sealed class Vector2Sum : Sum<Vector2>, IDefaultValue<Vector2>
{
	[DoNotSerialize]
	public Vector2 defaultValue => Vector2.zero;

	public override Vector2 Operation(Vector2 a, Vector2 b)
	{
		return a + b;
	}

	public override Vector2 Operation(IEnumerable<Vector2> values)
	{
		Vector2 zero = Vector2.zero;
		foreach (Vector2 value in values)
		{
			zero += value;
		}
		return zero;
	}
}
