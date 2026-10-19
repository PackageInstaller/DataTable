using System.Runtime.Serialization;

namespace System;

[Serializable]
public class FormatException : SystemException
{
	public FormatException()
		: base("One of the identified items was in an invalid format.")
	{
		HResult = -2146233033;
	}

	public FormatException(string message)
		: base(message)
	{
		HResult = -2146233033;
	}

	public FormatException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2146233033;
	}

	protected FormatException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
