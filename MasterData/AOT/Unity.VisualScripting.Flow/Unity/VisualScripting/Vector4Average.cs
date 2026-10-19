using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Average")]
[UnitCategory("Math/Vector 4")]
public sealed class Vector4Average : Average<Vector4>
{
	public override Vector4 Operation(Vector4 a, Vector4 b)
	{
		return (a + b) / 2f;
	}

	public override Vector4 Operation(IEnumerable<Vector4> values)
	{
		Vector4 zero = Vector4.zero;
		int num = 0;
		foreach (Vector4 value in values)
		{
			zero += value;
			num++;
		}
		return zero / num;
	}
}
