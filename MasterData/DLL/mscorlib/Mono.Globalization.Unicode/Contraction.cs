namespace Mono.Globalization.Unicode;

internal class Contraction
{
	public int Index;

	public readonly char[] Source;

	public readonly string Replacement;

	public readonly byte[] SortKey;

	public Contraction(int index, char[] source, string replacement, byte[] sortkey)
	{
		Index = index;
		Source = source;
		Replacement = replacement;
		SortKey = sortkey;
	}
}
