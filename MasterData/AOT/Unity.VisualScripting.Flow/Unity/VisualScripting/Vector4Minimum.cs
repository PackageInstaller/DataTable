using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 4")]
[UnitTitle("Minimum")]
public sealed class Vector4Minimum : Minimum<Vector4>
{
	public override Vector4 Operation(Vector4 a, Vector4 b)
	{
		return Vector4.Min(a, b);
	}

	public override Vector4 Operation(IEnumerable<Vector4> values)
	{
		bool flag = false;
		Vector4 vector = Vector4.zero;
		foreach (Vector4 value in values)
		{
			if (!flag)
			{
				vector = value;
				flag = true;
			}
			else
			{
				vector = Vector4.Min(vector, value);
			}
		}
		return vector;
	}
}
