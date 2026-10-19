using System.Runtime.Serialization;

namespace System;

[Serializable]
public class SystemException : Exception
{
	public SystemException()
		: base("System error.")
	{
		HResult = -2146233087;
	}

	public SystemException(string message)
		: base(message)
	{
		HResult = -2146233087;
	}

	public SystemException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2146233087;
	}

	protected SystemException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
