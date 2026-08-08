using System.Runtime.Serialization;

namespace System;

[Serializable]
public sealed class IndexOutOfRangeException : SystemException
{
	public IndexOutOfRangeException()
		: base("Index was outside the bounds of the array.")
	{
		base.HResult = -2146233080;
	}

	public IndexOutOfRangeException(string message)
		: base(message)
	{
		base.HResult = -2146233080;
	}

	public IndexOutOfRangeException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2146233080;
	}

	internal IndexOutOfRangeException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
