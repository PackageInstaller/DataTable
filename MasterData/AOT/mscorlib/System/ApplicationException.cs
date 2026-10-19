using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ApplicationException : Exception
{
	public ApplicationException()
		: base("Error in the application.")
	{
		HResult = -2146232832;
	}

	public ApplicationException(string message)
		: base(message)
	{
		HResult = -2146232832;
	}

	public ApplicationException(string message, Exception innerException)
		: base(message, innerException)
	{
		HResult = -2146232832;
	}

	protected ApplicationException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
