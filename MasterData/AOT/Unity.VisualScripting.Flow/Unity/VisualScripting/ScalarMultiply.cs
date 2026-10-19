namespace Unity.VisualScripting;

[UnitCategory("Math/Scalar")]
[UnitTitle("Multiply")]
public sealed class ScalarMultiply : Multiply<float>
{
	protected override float defaultB => 1f;

	public override float Operation(float a, float b)
	{
		return a * b;
	}
}
