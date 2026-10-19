using System.Runtime.Serialization;

namespace System;

[Serializable]
public class NullReferenceException : SystemException
{
	public NullReferenceException()
		: base("Object reference not set to an instance of an object.")
	{
		HResult = -2147467261;
	}

	public NullReferenceException(string message)
		: base(message)
	{
		HResult = -2147467261;
	}

	public NullReferenceException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2147467261;
	}

	protected NullReferenceException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
