using System.Runtime.Serialization;

namespace System.Threading;

[Serializable]
public class LockRecursionException : Exception
{
	public LockRecursionException()
	{
	}

	public LockRecursionException(string message)
		: base(message)
	{
	}

	protected LockRecursionException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
