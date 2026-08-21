using System.Runtime.Serialization;

namespace System.Threading;

[Serializable]
public class ThreadStateException : SystemException
{
	public ThreadStateException()
		: base("Thread was in an invalid state for the operation being executed.")
	{
		base.HResult = -2146233056;
	}

	public ThreadStateException(string message)
		: base(message)
	{
		base.HResult = -2146233056;
	}

	protected ThreadStateException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
