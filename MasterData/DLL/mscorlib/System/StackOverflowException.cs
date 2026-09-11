using System.Runtime.Serialization;

namespace System;

[Serializable]
public sealed class StackOverflowException : SystemException
{
	public StackOverflowException()
		: base("Operation caused a stack overflow.")
	{
		base.HResult = -2147023895;
	}

	public StackOverflowException(string message)
		: base(message)
	{
		base.HResult = -2147023895;
	}

	internal StackOverflowException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
