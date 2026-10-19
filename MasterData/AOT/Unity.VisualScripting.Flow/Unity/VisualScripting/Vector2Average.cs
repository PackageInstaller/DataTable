using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 2")]
[UnitTitle("Average")]
public sealed class Vector2Average : Average<Vector2>
{
	public override Vector2 Operation(Vector2 a, Vector2 b)
	{
		return (a + b) / 2f;
	}

	public override Vector2 Operation(IEnumerable<Vector2> values)
	{
		Vector2 zero = Vector2.zero;
		int num = 0;
		foreach (Vector2 value in values)
		{
			zero += value;
			num++;
		}
		return zero / num;
	}
}
