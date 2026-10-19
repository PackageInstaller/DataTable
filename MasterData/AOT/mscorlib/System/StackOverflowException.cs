using System.Runtime.Serialization;

namespace System;

[Serializable]
public sealed class StackOverflowException : SystemException
{
	public StackOverflowException()
		: base("Operation caused a stack overflow.")
	{
		HResult = -2147023895;
	}

	public StackOverflowException(string message)
		: base(message)
	{
		HResult = -2147023895;
	}

	public StackOverflowException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2147023895;
	}

	internal StackOverflowException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
