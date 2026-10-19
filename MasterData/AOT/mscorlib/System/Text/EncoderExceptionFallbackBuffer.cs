namespace System.Text;

public sealed class EncoderExceptionFallbackBuffer : EncoderFallbackBuffer
{
	public override int Remaining => 0;

	public override bool Fallback(char charUnknown, int index)
	{
		throw new EncoderFallbackException(SR.Format("Unable to translate Unicode character \\\\u{0:X4} at index {1} to specified code page.", (int)charUnknown, index), charUnknown, index);
	}

	public override bool Fallback(char charUnknownHigh, char charUnknownLow, int index)
	{
		if (!char.IsHighSurrogate(charUnknownHigh))
		{
			throw new ArgumentOutOfRangeException("charUnknownHigh", SR.Format("Valid values are between {0} and {1}, inclusive.", 55296, 56319));
		}
		if (!char.IsLowSurrogate(charUnknownLow))
		{
			throw new ArgumentOutOfRangeException("charUnknownLow", SR.Format("Valid values are between {0} and {1}, inclusive.", 56320, 57343));
		}
		int num = char.ConvertToUtf32(charUnknownHigh, charUnknownLow);
		throw new EncoderFallbackException(SR.Format("Unable to translate Unicode character \\\\u{0:X4} at index {1} to specified code page.", num, index), charUnknownHigh, charUnknownLow, index);
	}

	public override char GetNextChar()
	{
		return '\0';
	}

	public override bool MovePrevious()
	{
		return false;
	}
}
