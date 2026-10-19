using System.Runtime.Serialization;

namespace System;

[Serializable]
public class InvalidCastException : SystemException
{
	public InvalidCastException()
		: base("Specified cast is not valid.")
	{
		HResult = -2147467262;
	}

	public InvalidCastException(string message)
		: base(message)
	{
		HResult = -2147467262;
	}

	public InvalidCastException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2147467262;
	}

	protected InvalidCastException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
