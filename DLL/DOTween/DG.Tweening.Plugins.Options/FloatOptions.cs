namespace DG.Tweening.Plugins.Options;

public struct FloatOptions : IPlugOptions
{
	public bool snapping;

	public void Reset()
	{
		snapping = false;
	}
}
