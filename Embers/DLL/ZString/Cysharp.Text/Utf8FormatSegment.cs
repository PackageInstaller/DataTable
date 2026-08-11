using System.Buffers;

namespace Cysharp.Text;

internal readonly struct Utf8FormatSegment
{
	public const int NotFormatIndex = -1;

	public readonly int Offset;

	public readonly int Count;

	public readonly int FormatIndex;

	public readonly StandardFormat StandardFormat;

	public readonly int Alignment;

	public bool IsFormatArgument => FormatIndex != -1;

	public Utf8FormatSegment(int offset, int count, int formatIndex, StandardFormat format, int alignment)
	{
		Offset = offset;
		Count = count;
		FormatIndex = formatIndex;
		StandardFormat = format;
		Alignment = alignment;
	}
}
