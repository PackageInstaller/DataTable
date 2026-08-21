using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
public class TargetException : ApplicationException
{
	public TargetException()
		: this(null)
	{
	}

	public TargetException(string message)
		: this(message, null)
	{
	}

	public TargetException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2146232829;
	}

	protected TargetException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
