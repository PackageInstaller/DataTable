using System.Runtime.Serialization;

namespace System.Threading;

[Serializable]
public class SemaphoreFullException : SystemException
{
	public SemaphoreFullException()
		: base("Adding the specified count to the semaphore would cause it to exceed its maximum count.")
	{
	}

	protected SemaphoreFullException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
