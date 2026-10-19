using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ArgumentNullException : ArgumentException
{
	public ArgumentNullException()
		: base("Value cannot be null.")
	{
		HResult = -2147467261;
	}

	public ArgumentNullException(string paramName)
		: base("Value cannot be null.", paramName)
	{
		HResult = -2147467261;
	}

	public ArgumentNullException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2147467261;
	}

	public ArgumentNullException(string paramName, string message)
		: base(message, paramName)
	{
		HResult = -2147467261;
	}

	protected ArgumentNullException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
