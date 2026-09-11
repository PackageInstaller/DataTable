using System.Runtime.Serialization;

namespace System.Text;

[Serializable]
public sealed class EncoderFallbackException : ArgumentException
{
	private char _charUnknown;

	private char _charUnknownHigh;

	private char _charUnknownLow;

	private int _index;

	public EncoderFallbackException()
		: base("Value does not fall within the expected range.")
	{
		base.HResult = -2147024809;
	}

	internal EncoderFallbackException(string message, char charUnknown, int index)
		: base(message)
	{
		_charUnknown = charUnknown;
		_index = index;
	}

	internal EncoderFallbackException(string message, char charUnknownHigh, char charUnknownLow, int index)
		: base(message)
	{
		if (!char.IsHighSurrogate(charUnknownHigh))
		{
			throw new ArgumentOutOfRangeException("charUnknownHigh", SR.Format("Valid values are between {0} and {1}, inclusive.", 55296, 56319));
		}
		if (!char.IsLowSurrogate(charUnknownLow))
		{
			throw new ArgumentOutOfRangeException("CharUnknownLow", SR.Format("Valid values are between {0} and {1}, inclusive.", 56320, 57343));
		}
		_charUnknownHigh = charUnknownHigh;
		_charUnknownLow = charUnknownLow;
		_index = index;
	}

	private EncoderFallbackException(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
	}
}
