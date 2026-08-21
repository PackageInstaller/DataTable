using System.Runtime.Serialization;

namespace System;

[Serializable]
public class InvalidOperationException : SystemException
{
	public InvalidOperationException()
		: base("Operation is not valid due to the current state of the object.")
	{
		base.HResult = -2146233079;
	}

	public InvalidOperationException(string message)
		: base(message)
	{
		base.HResult = -2146233079;
	}

	public InvalidOperationException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2146233079;
	}

	protected InvalidOperationException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
