using System.Runtime.Serialization;

namespace System;

[Serializable]
public class NotImplementedException : SystemException
{
	public NotImplementedException()
		: base("The method or operation is not implemented.")
	{
		HResult = -2147467263;
	}

	public NotImplementedException(string message)
		: base(message)
	{
		HResult = -2147467263;
	}

	public NotImplementedException(string message, Exception inner)
		: base(message, inner)
	{
		HResult = -2147467263;
	}

	protected NotImplementedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
