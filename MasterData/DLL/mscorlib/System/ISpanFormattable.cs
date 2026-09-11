namespace System;

internal interface ISpanFormattable
{
	bool TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format, IFormatProvider provider);
}
