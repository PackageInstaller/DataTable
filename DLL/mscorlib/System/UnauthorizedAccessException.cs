using System.Runtime.Serialization;

namespace System;

[Serializable]
public class UnauthorizedAccessException : SystemException
{
	public UnauthorizedAccessException()
		: base("Attempted to perform an unauthorized operation.")
	{
		base.HResult = -2147024891;
	}

	public UnauthorizedAccessException(string message)
		: base(message)
	{
		base.HResult = -2147024891;
	}

	public UnauthorizedAccessException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2147024891;
	}

	protected UnauthorizedAccessException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
