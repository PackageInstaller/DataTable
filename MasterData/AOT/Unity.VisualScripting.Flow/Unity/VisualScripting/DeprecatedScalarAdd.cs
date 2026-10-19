using System;

namespace Unity.VisualScripting;

[UnitCategory("Math/Scalar")]
[UnitTitle("Add")]
[RenamedFrom("Unity.VisualScripting.ScalarAdd")]
[RenamedFrom("Bolt.ScalarAdd")]
[Obsolete("Use the new \"Add (Math/Scalar)\" node instead.")]
public sealed class DeprecatedScalarAdd : Add<float>
{
	protected override float defaultB => 1f;

	public override float Operation(float a, float b)
	{
		return a + b;
	}
}
