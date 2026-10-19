using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 3")]
[UnitTitle("Average")]
public sealed class Vector3Average : Average<Vector3>
{
	public override Vector3 Operation(Vector3 a, Vector3 b)
	{
		return (a + b) / 2f;
	}

	public override Vector3 Operation(IEnumerable<Vector3> values)
	{
		Vector3 zero = Vector3.zero;
		int num = 0;
		foreach (Vector3 value in values)
		{
			zero += value;
			num++;
		}
		return zero / num;
	}
}
