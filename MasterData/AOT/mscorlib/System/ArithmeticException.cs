using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ArithmeticException : SystemException
{
	public ArithmeticException()
		: base("Overflow or underflow in the arithmetic operation.")
	{
		HResult = -2147024362;
	}

	public ArithmeticException(string message)
		: base(message)
	{
		HResult = -2147024362;
	}

	public ArithmeticException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2147024362;
	}

	protected ArithmeticException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
