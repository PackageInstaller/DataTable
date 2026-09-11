using System.Collections;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;

namespace System.Threading;

[ComVisible(true)]
public sealed class ReaderWriterLock : CriticalFinalizerObject
{
	private int seq_num = 1;

	private int state;

	private int readers;

	private int writer_lock_owner;

	private LockQueue writer_queue;

	private Hashtable reader_locks;

	public bool IsReaderLockHeld
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			lock (this)
			{
				return reader_locks.ContainsKey(Thread.CurrentThreadId);
			}
		}
	}

	public bool IsWriterLockHeld
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			lock (this)
			{
				return state < 0 && Thread.CurrentThreadId == writer_lock_owner;
			}
		}
	}

	public ReaderWriterLock()
	{
		writer_queue = new LockQueue(this);
		reader_locks = new Hashtable();
		GC.SuppressFinalize(this);
	}

	~ReaderWriterLock()
	{
	}

	public void AcquireReaderLock(int millisecondsTimeout)
	{
		AcquireReaderLock(millisecondsTimeout, 1);
	}

	private void AcquireReaderLock(int millisecondsTimeout, int initialLockCount)
	{
		lock (this)
		{
			if (HasWriterLock())
			{
				AcquireWriterLock(millisecondsTimeout, initialLockCount);
				return;
			}
			object obj = reader_locks[Thread.CurrentThreadId];
			if (obj == null)
			{
				readers++;
				try
				{
					if (state < 0 || !writer_queue.IsEmpty)
					{
						do
						{
							if (!Monitor.Wait(this, millisecondsTimeout))
							{
								throw new ApplicationException("Timeout expired");
							}
						}
						while (state < 0);
					}
				}
				finally
				{
					readers--;
				}
				reader_locks[Thread.CurrentThreadId] = initialLockCount;
				state += initialLockCount;
			}
			else
			{
				reader_locks[Thread.CurrentThreadId] = (int)obj + 1;
				state++;
			}
		}
	}

	public void AcquireWriterLock(int millisecondsTimeout)
	{
		AcquireWriterLock(millisecondsTimeout, 1);
	}

	private void AcquireWriterLock(int millisecondsTimeout, int initialLockCount)
	{
		lock (this)
		{
			if (HasWriterLock())
			{
				state--;
				return;
			}
			if (state != 0 || !writer_queue.IsEmpty)
			{
				do
				{
					if (!writer_queue.Wait(millisecondsTimeout))
					{
						throw new ApplicationException("Timeout expired");
					}
				}
				while (state != 0);
			}
			state = -initialLockCount;
			writer_lock_owner = Thread.CurrentThreadId;
			seq_num++;
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public void ReleaseReaderLock()
	{
		lock (this)
		{
			if (HasWriterLock())
			{
				ReleaseWriterLock();
				return;
			}
			if (state > 0)
			{
				object obj = reader_locks[Thread.CurrentThreadId];
				if (obj != null)
				{
					ReleaseReaderLock((int)obj, 1);
					return;
				}
			}
			throw new ApplicationException("The thread does not have any reader or writer locks.");
		}
	}

	private void ReleaseReaderLock(int currentCount, int releaseCount)
	{
		int num = currentCount - releaseCount;
		if (num == 0)
		{
			reader_locks.Remove(Thread.CurrentThreadId);
		}
		else
		{
			reader_locks[Thread.CurrentThreadId] = num;
		}
		state -= releaseCount;
		if (state == 0 && !writer_queue.IsEmpty)
		{
			writer_queue.Pulse();
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public void ReleaseWriterLock()
	{
		lock (this)
		{
			if (!HasWriterLock())
			{
				throw new ApplicationException("The thread does not have the writer lock.");
			}
			ReleaseWriterLock(1);
		}
	}

	private void ReleaseWriterLock(int releaseCount)
	{
		state += releaseCount;
		if (state == 0)
		{
			if (readers > 0)
			{
				Monitor.PulseAll(this);
			}
			else if (!writer_queue.IsEmpty)
			{
				writer_queue.Pulse();
			}
		}
	}

	private bool HasWriterLock()
	{
		if (state < 0)
		{
			return Thread.CurrentThreadId == writer_lock_owner;
		}
		return false;
	}
}
