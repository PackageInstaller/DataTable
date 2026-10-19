using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public class EndOfStreamException : IOException
{
	public EndOfStreamException()
		: base("Attempted to read past the end of the stream.")
	{
		HResult = -2147024858;
	}

	public EndOfStreamException(string message)
		: base(message)
	{
		HResult = -2147024858;
	}

	public EndOfStreamException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2147024858;
	}

	protected EndOfStreamException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
