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
