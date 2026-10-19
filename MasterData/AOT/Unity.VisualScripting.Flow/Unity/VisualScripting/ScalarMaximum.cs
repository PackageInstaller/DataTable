using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Scalar")]
[UnitTitle("Maximum")]
public sealed class ScalarMaximum : Maximum<float>
{
	public override float Operation(float a, float b)
	{
		return Mathf.Max(a, b);
	}

	public override float Operation(IEnumerable<float> values)
	{
		return values.Max();
	}
}
