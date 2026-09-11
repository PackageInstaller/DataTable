using System.Runtime.Serialization;

namespace System;

[Serializable]
public class NullReferenceException : SystemException
{
	public NullReferenceException()
		: base("Object reference not set to an instance of an object.")
	{
		base.HResult = -2147467261;
	}

	public NullReferenceException(string message)
		: base(message)
	{
		base.HResult = -2147467261;
	}

	public NullReferenceException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2147467261;
	}

	protected NullReferenceException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
