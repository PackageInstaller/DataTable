using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public sealed class InvalidDataException : SystemException
{
	private const int Result = -2146233085;

	public InvalidDataException()
		: base(Locale.GetText("Invalid data format."))
	{
		HResult = -2146233085;
	}

	public InvalidDataException(string message)
		: base(message)
	{
		HResult = -2146233085;
	}

	public InvalidDataException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2146233085;
	}

	private InvalidDataException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
