using UnityEngine;

namespace Unity.VisualScripting;

[UnitCategory("Math/Scalar")]
[UnitTitle("Normalize")]
public sealed class ScalarNormalize : Normalize<float>
{
	public override float Operation(float input)
	{
		if (input == 0f)
		{
			return 0f;
		}
		return input / Mathf.Abs(input);
	}
}
