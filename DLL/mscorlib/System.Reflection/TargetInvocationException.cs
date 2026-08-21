using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
public sealed class TargetInvocationException : ApplicationException
{
	public TargetInvocationException(Exception inner)
		: base("Exception has been thrown by the target of an invocation.", inner)
	{
		base.HResult = -2146232828;
	}

	public TargetInvocationException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2146232828;
	}

	internal TargetInvocationException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
