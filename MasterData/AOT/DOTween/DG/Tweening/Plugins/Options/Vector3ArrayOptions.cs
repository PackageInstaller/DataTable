namespace DG.Tweening.Plugins.Options;

public struct Vector3ArrayOptions : IPlugOptions
{
	public AxisConstraint axisConstraint;

	public bool snapping;

	internal float[] durations;

	public void Reset()
	{
		axisConstraint = AxisConstraint.None;
		snapping = false;
		durations = null;
	}
}
