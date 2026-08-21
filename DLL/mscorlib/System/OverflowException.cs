using System.Runtime.Serialization;

namespace System;

[Serializable]
public class OverflowException : ArithmeticException
{
	public OverflowException()
		: base("Arithmetic operation resulted in an overflow.")
	{
		base.HResult = -2146233066;
	}

	public OverflowException(string message)
		: base(message)
	{
		base.HResult = -2146233066;
	}

	public OverflowException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2146233066;
	}

	protected OverflowException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
