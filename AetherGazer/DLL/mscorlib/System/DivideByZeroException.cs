using System.Runtime.Serialization;

namespace System;

[Serializable]
public class DivideByZeroException : ArithmeticException
{
	public DivideByZeroException()
		: base("Attempted to divide by zero.")
	{
		base.HResult = -2147352558;
	}

	public DivideByZeroException(string message)
		: base(message)
	{
		base.HResult = -2147352558;
	}

	protected DivideByZeroException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
