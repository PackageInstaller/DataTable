using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ArithmeticException : SystemException
{
	public ArithmeticException()
		: base("Overflow or underflow in the arithmetic operation.")
	{
		base.HResult = -2147024362;
	}

	public ArithmeticException(string message)
		: base(message)
	{
		base.HResult = -2147024362;
	}

	public ArithmeticException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2147024362;
	}

	protected ArithmeticException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
