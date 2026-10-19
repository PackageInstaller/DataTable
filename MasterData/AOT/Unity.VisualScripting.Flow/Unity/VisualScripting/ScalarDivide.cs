namespace Unity.VisualScripting;

[UnitCategory("Math/Scalar")]
[UnitTitle("Divide")]
public sealed class ScalarDivide : Divide<float>
{
	protected override float defaultDividend => 1f;

	protected override float defaultDivisor => 1f;

	public override float Operation(float a, float b)
	{
		return a / b;
	}
}
