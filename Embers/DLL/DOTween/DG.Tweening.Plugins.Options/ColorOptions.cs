namespace DG.Tweening.Plugins.Options;

public struct ColorOptions : IPlugOptions
{
	public bool alphaOnly;

	public void Reset()
	{
		alphaOnly = false;
	}
}
