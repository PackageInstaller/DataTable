using System.Runtime.Serialization;

namespace System;

[Serializable]
public class SystemException : Exception
{
	public SystemException()
		: base("System error.")
	{
		base.HResult = -2146233087;
	}

	public SystemException(string message)
		: base(message)
	{
		base.HResult = -2146233087;
	}

	public SystemException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2146233087;
	}

	protected SystemException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
