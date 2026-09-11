using System.Runtime.Serialization;

namespace System.Threading;

[Serializable]
public class SynchronizationLockException : SystemException
{
	public SynchronizationLockException()
		: base("Object synchronization method was called from an unsynchronized block of code.")
	{
		base.HResult = -2146233064;
	}

	public SynchronizationLockException(string message)
		: base(message)
	{
		base.HResult = -2146233064;
	}

	protected SynchronizationLockException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
