using System.Collections.Generic;
using System.Linq;

namespace Unity.VisualScripting;

[UnitTitle("Add")]
[UnitCategory("Math/Scalar")]
public sealed class ScalarSum : Sum<float>, IDefaultValue<float>
{
	[DoNotSerialize]
	public float defaultValue => 1f;

	public override float Operation(float a, float b)
	{
		return a + b;
	}

	public override float Operation(IEnumerable<float> values)
	{
		return values.Sum();
	}
}
