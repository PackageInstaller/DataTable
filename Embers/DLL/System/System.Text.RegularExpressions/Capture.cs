using Unity;

namespace System.Text.RegularExpressions;

public class Capture
{
	public int Index { get; private protected set; }

	public int Length { get; private protected set; }

	internal string Text { get; private protected set; }

	public string Value => Text.Substring(Index, Length);

	internal Capture(string text, int index, int length)
	{
		Text = text;
		Index = index;
		Length = length;
	}

	public override string ToString()
	{
		return Value;
	}

	internal ReadOnlySpan<char> GetLeftSubstring()
	{
		return MemoryExtensions.AsSpan(Text, 0, Index);
	}

	internal ReadOnlySpan<char> GetRightSubstring()
	{
		return MemoryExtensions.AsSpan(Text, Index + Length, Text.Length - Index - Length);
	}

	internal Capture()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
