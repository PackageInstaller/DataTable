using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Vector 4")]
[UnitTitle("Add")]
public sealed class Vector4Sum : Sum<Vector4>, IDefaultValue<Vector4>
{
	[DoNotSerialize]
	public Vector4 defaultValue => Vector4.zero;

	public override Vector4 Operation(Vector4 a, Vector4 b)
	{
		return a + b;
	}

	public override Vector4 Operation(IEnumerable<Vector4> values)
	{
		Vector4 zero = Vector4.zero;
		foreach (Vector4 value in values)
		{
			zero += value;
		}
		return zero;
	}
}
