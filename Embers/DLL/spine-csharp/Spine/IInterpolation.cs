namespace Spine;

public abstract class IInterpolation
{
	public static IInterpolation Pow2 = new Pow(2f);

	public static IInterpolation Pow2Out = new PowOut(2f);

	protected abstract float Apply(float a);

	public float Apply(float start, float end, float a)
	{
		return start + (end - start) * Apply(a);
	}
}
