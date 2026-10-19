namespace DG.Tweening.Plugins.Options;

public struct UintOptions : IPlugOptions
{
	public bool isNegativeChangeValue;

	public void Reset()
	{
		isNegativeChangeValue = false;
	}
}
