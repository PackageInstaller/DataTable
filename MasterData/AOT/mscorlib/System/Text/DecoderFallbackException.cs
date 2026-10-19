using System.Runtime.Serialization;

namespace System.Text;

[Serializable]
public sealed class DecoderFallbackException : ArgumentException
{
	private byte[] _bytesUnknown;

	private int _index;

	public byte[] BytesUnknown => _bytesUnknown;

	public int Index => _index;

	public DecoderFallbackException()
		: base("Value does not fall within the expected range.")
	{
		HResult = -2147024809;
	}

	public DecoderFallbackException(string message)
		: base(message)
	{
		HResult = -2147024809;
	}

	public DecoderFallbackException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2147024809;
	}

	public DecoderFallbackException(string message, byte[] bytesUnknown, int index)
		: base(message)
	{
		_bytesUnknown = bytesUnknown;
		_index = index;
	}

	private DecoderFallbackException(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
	}
}
