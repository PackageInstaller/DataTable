namespace Cysharp.Text;

internal readonly struct Utf16FormatSegment
{
	public const int NotFormatIndex = -1;

	public readonly int Offset;

	public readonly int Count;

	public readonly int FormatIndex;

	public readonly int Alignment;

	public bool IsFormatArgument => FormatIndex != -1;

	public Utf16FormatSegment(int offset, int count, int formatIndex, int alignment)
	{
		Offset = offset;
		Count = count;
		FormatIndex = formatIndex;
		Alignment = alignment;
	}
}
