using System.Runtime.Serialization;

namespace System;

[Serializable]
public class OutOfMemoryException : SystemException
{
	public OutOfMemoryException()
		: base("Insufficient memory to continue the execution of the program.")
	{
		HResult = -2147024882;
	}

	public OutOfMemoryException(string message)
		: base(message)
	{
		HResult = -2147024882;
	}

	protected OutOfMemoryException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
