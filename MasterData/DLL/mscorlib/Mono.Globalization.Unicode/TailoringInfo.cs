namespace Mono.Globalization.Unicode;

internal class TailoringInfo
{
	public readonly int LCID;

	public readonly int TailoringIndex;

	public readonly int TailoringCount;

	public readonly bool FrenchSort;

	public TailoringInfo(int lcid, int tailoringIndex, int tailoringCount, bool frenchSort)
	{
		LCID = lcid;
		TailoringIndex = tailoringIndex;
		TailoringCount = tailoringCount;
		FrenchSort = frenchSort;
	}
}
