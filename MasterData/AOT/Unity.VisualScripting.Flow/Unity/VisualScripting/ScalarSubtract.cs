namespace Unity.VisualScripting;

[UnitCategory("Math/Scalar")]
[UnitTitle("Subtract")]
public sealed class ScalarSubtract : Subtract<float>
{
	protected override float defaultMinuend => 1f;

	protected override float defaultSubtrahend => 1f;

	public override float Operation(float a, float b)
	{
		return a - b;
	}
}
