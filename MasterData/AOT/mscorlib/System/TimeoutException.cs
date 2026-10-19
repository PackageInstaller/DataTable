using System.Runtime.Serialization;

namespace System;

[Serializable]
public class TimeoutException : SystemException
{
	public TimeoutException()
		: base("The operation has timed out.")
	{
		HResult = -2146233083;
	}

	public TimeoutException(string message)
		: base(message)
	{
		HResult = -2146233083;
	}

	public TimeoutException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2146233083;
	}

	protected TimeoutException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
