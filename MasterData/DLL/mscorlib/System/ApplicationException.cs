using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ApplicationException : Exception
{
	public ApplicationException()
		: base("Error in the application.")
	{
		base.HResult = -2146232832;
	}

	public ApplicationException(string message)
		: base(message)
	{
		base.HResult = -2146232832;
	}

	public ApplicationException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2146232832;
	}

	protected ApplicationException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
