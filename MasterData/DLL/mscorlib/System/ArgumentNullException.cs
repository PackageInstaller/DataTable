using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ArgumentNullException : ArgumentException
{
	public ArgumentNullException()
		: base("Value cannot be null.")
	{
		base.HResult = -2147467261;
	}

	public ArgumentNullException(string paramName)
		: base("Value cannot be null.", paramName)
	{
		base.HResult = -2147467261;
	}

	public ArgumentNullException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2147467261;
	}

	public ArgumentNullException(string paramName, string message)
		: base(message, paramName)
	{
		base.HResult = -2147467261;
	}

	protected ArgumentNullException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
