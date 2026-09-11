namespace System.Threading;

internal class LockQueue
{
	private ReaderWriterLock rwlock;

	private int lockCount;

	public bool IsEmpty
	{
		get
		{
			lock (this)
			{
				return lockCount == 0;
			}
		}
	}

	public LockQueue(ReaderWriterLock rwlock)
	{
		this.rwlock = rwlock;
	}

	public bool Wait(int timeout)
	{
		bool flag = false;
		try
		{
			lock (this)
			{
				lockCount++;
				Monitor.Exit(rwlock);
				flag = true;
				return Monitor.Wait(this, timeout);
			}
		}
		finally
		{
			if (flag)
			{
				Monitor.Enter(rwlock);
				lockCount--;
			}
		}
	}

	public void Pulse()
	{
		lock (this)
		{
			Monitor.Pulse(this);
		}
	}
}
