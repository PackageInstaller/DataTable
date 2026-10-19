namespace DG.Tweening.Plugins.Options;

public struct RectOptions : IPlugOptions
{
	public bool snapping;

	public void Reset()
	{
		snapping = false;
	}
}
