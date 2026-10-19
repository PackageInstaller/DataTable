namespace Unity.VisualScripting;

[UnitCategory("Math/Scalar")]
[UnitTitle("Modulo")]
public sealed class ScalarModulo : Modulo<float>
{
	protected override float defaultDividend => 1f;

	protected override float defaultDivisor => 1f;

	public override float Operation(float a, float b)
	{
		return a % b;
	}
}
