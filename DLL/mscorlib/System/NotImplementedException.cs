using System.Runtime.Serialization;

namespace System;

[Serializable]
public class NotImplementedException : SystemException
{
	public NotImplementedException()
		: base("The method or operation is not implemented.")
	{
		base.HResult = -2147467263;
	}

	public NotImplementedException(string message)
		: base(message)
	{
		base.HResult = -2147467263;
	}

	public NotImplementedException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2147467263;
	}

	protected NotImplementedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
