using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Minimum")]
[UnitCategory("Math/Vector 2")]
public sealed class Vector2Minimum : Minimum<Vector2>
{
	public override Vector2 Operation(Vector2 a, Vector2 b)
	{
		return Vector2.Min(a, b);
	}

	public override Vector2 Operation(IEnumerable<Vector2> values)
	{
		bool flag = false;
		Vector2 vector = Vector2.zero;
		foreach (Vector2 value in values)
		{
			if (!flag)
			{
				vector = value;
				flag = true;
			}
			else
			{
				vector = Vector2.Min(vector, value);
			}
		}
		return vector;
	}
}
