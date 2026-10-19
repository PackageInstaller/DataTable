using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 2")]
[UnitTitle("Maximum")]
public sealed class Vector2Maximum : Maximum<Vector2>
{
	public override Vector2 Operation(Vector2 a, Vector2 b)
	{
		return Vector2.Max(a, b);
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
				vector = Vector2.Max(vector, value);
			}
		}
		return vector;
	}
}
