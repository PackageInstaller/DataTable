using System.Runtime.Serialization;

namespace System.Threading;

[Serializable]
public class AbandonedMutexException : SystemException
{
	private int _mutexIndex = -1;

	private Mutex _mutex;

	public AbandonedMutexException()
		: base("The wait completed due to an abandoned mutex.")
	{
		base.HResult = -2146233043;
	}

	public AbandonedMutexException(int location, WaitHandle handle)
		: base("The wait completed due to an abandoned mutex.")
	{
		base.HResult = -2146233043;
		SetupException(location, handle);
	}

	protected AbandonedMutexException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}

	private void SetupException(int location, WaitHandle handle)
	{
		_mutexIndex = location;
		if (handle != null)
		{
			_mutex = handle as Mutex;
		}
	}
}
