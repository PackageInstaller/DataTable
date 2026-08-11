using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
public class InvalidFilterCriteriaException : ApplicationException
{
	public InvalidFilterCriteriaException()
		: this("Specified filter criteria was invalid.")
	{
	}

	public InvalidFilterCriteriaException(string message)
		: this(message, null)
	{
	}

	public InvalidFilterCriteriaException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2146232831;
	}

	protected InvalidFilterCriteriaException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
