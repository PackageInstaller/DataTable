using System.Runtime.Serialization;

namespace System;

[Serializable]
public class NotSupportedException : SystemException
{
	public NotSupportedException()
		: base("Specified method is not supported.")
	{
		base.HResult = -2146233067;
	}

	public NotSupportedException(string message)
		: base(message)
	{
		base.HResult = -2146233067;
	}

	public NotSupportedException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2146233067;
	}

	protected NotSupportedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
