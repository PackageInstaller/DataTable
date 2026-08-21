namespace DG.Tweening.Plugins.Options;

public struct StringOptions : IPlugOptions
{
	public bool richTextEnabled;

	public ScrambleMode scrambleMode;

	public char[] scrambledChars;

	internal int startValueStrippedLength;

	internal int changeValueStrippedLength;

	public void Reset()
	{
		richTextEnabled = false;
		scrambleMode = ScrambleMode.None;
		scrambledChars = null;
		startValueStrippedLength = (changeValueStrippedLength = 0);
	}
}
