using System.Runtime.Serialization;

namespace System;

[Serializable]
public class InvalidCastException : SystemException
{
	public InvalidCastException()
		: base("Specified cast is not valid.")
	{
		base.HResult = -2147467262;
	}

	public InvalidCastException(string message)
		: base(message)
	{
		base.HResult = -2147467262;
	}

	public InvalidCastException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2147467262;
	}

	public InvalidCastException(string message, int errorCode)
		: base(message)
	{
		base.HResult = errorCode;
	}

	protected InvalidCastException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
