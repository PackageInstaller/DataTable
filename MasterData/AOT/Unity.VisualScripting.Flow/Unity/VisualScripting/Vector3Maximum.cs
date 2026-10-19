using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 3")]
[UnitTitle("Maximum")]
public sealed class Vector3Maximum : Maximum<Vector3>
{
	public override Vector3 Operation(Vector3 a, Vector3 b)
	{
		return Vector3.Max(a, b);
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
				vector = Vector3.Max(vector, value);
			}
		}
		return vector;
	}
}
