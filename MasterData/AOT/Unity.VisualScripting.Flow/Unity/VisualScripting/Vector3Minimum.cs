using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Minimum")]
[UnitCategory("Math/Vector 3")]
public sealed class Vector3Minimum : Minimum<Vector3>
{
	public override Vector3 Operation(Vector3 a, Vector3 b)
	{
		return Vector3.Min(a, b);
	}

	public override Vector3 Operation(IEnumerable<Vector3> values)
	{
		bool flag = false;
		Vector3 vector = Vector3.zero;
		foreach (Vector3 value in values)
		{
			if (!flag)
			{
				vector = value;
				flag = true;
			}
			else
			{
				vector = Vector3.Min(vector, value);
			}
		}
		return vector;
	}
}
