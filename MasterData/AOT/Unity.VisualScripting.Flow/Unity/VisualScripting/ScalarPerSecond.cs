using UnityEngine;

namespace Unity.VisualScripting;

[UnitTitle("Per Second")]
[UnitCategory("Math/Scalar")]
public sealed class ScalarPerSecond : PerSecond<float>
{
	public override float Operation(float input)
	{
		return input * Time.deltaTime;
	}
}
