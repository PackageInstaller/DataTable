using System.Runtime.ConstrainedExecution;

namespace System.Threading;

internal sealed class ThreadPoolWorkQueue
{
	internal class SparseArray<T> where T : class
	{
		private volatile T[] m_array;

		internal T[] Current => m_array;

		internal SparseArray(int initialSize)
		{
			m_array = new T[initialSize];
		}

		internal int Add(T e)
		{
			while (true)
			{
				T[] array = m_array;
				lock (array)
				{
					for (int i = 0; i < array.Length; i++)
					{
						if (array[i] == null)
						{
							Volatile.Write(ref array[i], e);
							return i;
						}
						if (i == array.Length - 1 && array == m_array)
						{
							T[] array2 = new T[array.Length * 2];
							Array.Copy(array, array2, i + 1);
							array2[i + 1] = e;
							m_array = array2;
							return i + 1;
						}
					}
				}
			}
		}

		internal void Remove(T e)
		{
			lock (m_array)
			{
				for (int i = 0; i < m_array.Length; i++)
				{
					if (m_array[i] == e)
					{
						Volatile.Write(ref m_array[i], null);
						break;
					}
				}
			}
		}
	}

	internal class WorkStealingQueue
	{
		internal volatile IThreadPoolWorkItem[] m_array = new IThreadPoolWorkItem[32];

		private volatile int m_mask = 31;

		private volatile int m_headIndex;

		private volatile int m_tailIndex;

		private SpinLock m_foreignLock = new SpinLock(enableThreadOwnerTracking: false);

		public void LocalPush(IThreadPoolWorkItem obj)
		{
			int num = m_tailIndex;
			if (num == int.MaxValue)
			{
				bool lockTaken = false;
				try
				{
					m_foreignLock.Enter(ref lockTaken);
					if (m_tailIndex == int.MaxValue)
					{
						m_headIndex &= m_mask;
						num = (m_tailIndex &= m_mask);
					}
				}
				finally
				{
					if (lockTaken)
					{
						m_foreignLock.Exit(useMemoryBarrier: true);
					}
				}
			}
			if (num < m_headIndex + m_mask)
			{
				Volatile.Write(ref m_array[num & m_mask], obj);
				m_tailIndex = num + 1;
				return;
			}
			bool lockTaken2 = false;
			try
			{
				m_foreignLock.Enter(ref lockTaken2);
				int headIndex = m_headIndex;
				int num2 = m_tailIndex - m_headIndex;
				if (num2 >= m_mask)
				{
					IThreadPoolWorkItem[] array = new IThreadPoolWorkItem[m_array.Length << 1];
					for (int i = 0; i < m_array.Length; i++)
					{
						array[i] = m_array[(i + headIndex) & m_mask];
					}
					m_array = array;
					m_headIndex = 0;
					num = (m_tailIndex = num2);
					m_mask = (m_mask << 1) | 1;
				}
				Volatile.Write(ref m_array[num & m_mask], obj);
				m_tailIndex = num + 1;
			}
			finally
			{
				if (lockTaken2)
				{
					m_foreignLock.Exit(useMemoryBarrier: false);
				}
			}
		}

		public bool LocalFindAndPop(IThreadPoolWorkItem obj)
		{
			if (m_array[(m_tailIndex - 1) & m_mask] == obj)
			{
				if (LocalPop(out var _))
				{
					return true;
				}
				return false;
			}
			for (int num = m_tailIndex - 2; num >= m_headIndex; num--)
			{
				if (m_array[num & m_mask] == obj)
				{
					bool lockTaken = false;
					try
					{
						m_foreignLock.Enter(ref lockTaken);
						if (m_array[num & m_mask] == null)
						{
							return false;
						}
						Volatile.Write(ref m_array[num & m_mask], null);
						if (num == m_tailIndex)
						{
							m_tailIndex--;
						}
						else if (num == m_headIndex)
						{
							m_headIndex++;
						}
						return true;
					}
					finally
					{
						if (lockTaken)
						{
							m_foreignLock.Exit(useMemoryBarrier: false);
						}
					}
				}
			}
			return false;
		}

		public bool LocalPop(out IThreadPoolWorkItem obj)
		{
			int num;
			while (true)
			{
				int tailIndex = m_tailIndex;
				if (m_headIndex >= tailIndex)
				{
					obj = null;
					return false;
				}
				tailIndex--;
				Interlocked.Exchange(ref m_tailIndex, tailIndex);
				if (m_headIndex <= tailIndex)
				{
					num = tailIndex & m_mask;
					obj = Volatile.Read(ref m_array[num]);
					if (obj != null)
					{
						break;
					}
					continue;
				}
				bool lockTaken = false;
				try
				{
					m_foreignLock.Enter(ref lockTaken);
					if (m_headIndex <= tailIndex)
					{
						int num2 = tailIndex & m_mask;
						obj = Volatile.Read(ref m_array[num2]);
						if (obj != null)
						{
							m_array[num2] = null;
							return true;
						}
						continue;
					}
					m_tailIndex = tailIndex + 1;
					obj = null;
					return false;
				}
				finally
				{
					if (lockTaken)
					{
						m_foreignLock.Exit(useMemoryBarrier: false);
					}
				}
			}
			m_array[num] = null;
			return true;
		}

		public bool TrySteal(out IThreadPoolWorkItem obj, ref bool missedSteal)
		{
			return TrySteal(out obj, ref missedSteal, 0);
		}

		private bool TrySteal(out IThreadPoolWorkItem obj, ref bool missedSteal, int millisecondsTimeout)
		{
			obj = null;
			while (true)
			{
				if (m_headIndex >= m_tailIndex)
				{
					return false;
				}
				bool lockTaken = false;
				try
				{
					m_foreignLock.TryEnter(millisecondsTimeout, ref lockTaken);
					if (lockTaken)
					{
						int headIndex = m_headIndex;
						Interlocked.Exchange(ref m_headIndex, headIndex + 1);
						if (headIndex < m_tailIndex)
						{
							int num = headIndex & m_mask;
							obj = Volatile.Read(ref m_array[num]);
							if (obj == null)
							{
								continue;
							}
							m_array[num] = null;
							return true;
						}
						m_headIndex = headIndex;
						obj = null;
						missedSteal = true;
					}
					else
					{
						missedSteal = true;
					}
				}
				finally
				{
					if (lockTaken)
					{
						m_foreignLock.Exit(useMemoryBarrier: false);
					}
				}
				break;
			}
			return false;
		}
	}

	internal class QueueSegment
	{
		internal readonly IThreadPoolWorkItem[] nodes;

		private volatile int indexes;

		public volatile QueueSegment Next;

		private void GetIndexes(out int upper, out int lower)
		{
			int num = indexes;
			upper = (num >> 16) & 0xFFFF;
			lower = num & 0xFFFF;
		}

		private bool CompareExchangeIndexes(ref int prevUpper, int newUpper, ref int prevLower, int newLower)
		{
			int num = (prevUpper << 16) | (prevLower & 0xFFFF);
			int value = (newUpper << 16) | (newLower & 0xFFFF);
			int num2 = Interlocked.CompareExchange(ref indexes, value, num);
			prevUpper = (num2 >> 16) & 0xFFFF;
			prevLower = num2 & 0xFFFF;
			return num2 == num;
		}

		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
		public QueueSegment()
		{
			nodes = new IThreadPoolWorkItem[256];
		}

		public bool IsUsedUp()
		{
			GetIndexes(out var upper, out var lower);
			if (upper == nodes.Length)
			{
				return lower == nodes.Length;
			}
			return false;
		}

		public bool TryEnqueue(IThreadPoolWorkItem node)
		{
			GetIndexes(out var upper, out var lower);
			do
			{
				if (upper == nodes.Length)
				{
					return false;
				}
			}
			while (!CompareExchangeIndexes(ref upper, upper + 1, ref lower, lower));
			Volatile.Write(ref nodes[upper], node);
			return true;
		}

		public bool TryDequeue(out IThreadPoolWorkItem node)
		{
			GetIndexes(out var upper, out var lower);
			do
			{
				if (lower == upper)
				{
					node = null;
					return false;
				}
			}
			while (!CompareExchangeIndexes(ref upper, upper, ref lower, lower + 1));
			SpinWait spinWait = default(SpinWait);
			while ((node = Volatile.Read(ref nodes[lower])) == null)
			{
				spinWait.SpinOnce();
			}
			nodes[lower] = null;
			return true;
		}
	}

	internal volatile QueueSegment queueHead;

	internal volatile QueueSegment queueTail;

	internal static SparseArray<WorkStealingQueue> allThreadQueues = new SparseArray<WorkStealingQueue>(16);

	private volatile int numOutstandingThreadRequests;

	public ThreadPoolWorkQueue()
	{
		queueTail = (queueHead = new QueueSegment());
	}

	public ThreadPoolWorkQueueThreadLocals EnsureCurrentThreadHasQueue()
	{
		if (ThreadPoolWorkQueueThreadLocals.threadLocals == null)
		{
			ThreadPoolWorkQueueThreadLocals.threadLocals = new ThreadPoolWorkQueueThreadLocals(this);
		}
		return ThreadPoolWorkQueueThreadLocals.threadLocals;
	}

	internal void EnsureThreadRequested()
	{
		int num = numOutstandingThreadRequests;
		while (num < ThreadPoolGlobals.processorCount)
		{
			int num2 = Interlocked.CompareExchange(ref numOutstandingThreadRequests, num + 1, num);
			if (num2 == num)
			{
				ThreadPool.RequestWorkerThread();
				break;
			}
			num = num2;
		}
	}

	internal void MarkThreadRequestSatisfied()
	{
		int num = numOutstandingThreadRequests;
		while (num > 0)
		{
			int num2 = Interlocked.CompareExchange(ref numOutstandingThreadRequests, num - 1, num);
			if (num2 != num)
			{
				num = num2;
				continue;
			}
			break;
		}
	}

	public void Enqueue(IThreadPoolWorkItem callback, bool forceGlobal)
	{
		ThreadPoolWorkQueueThreadLocals threadPoolWorkQueueThreadLocals = null;
		if (!forceGlobal)
		{
			threadPoolWorkQueueThreadLocals = ThreadPoolWorkQueueThreadLocals.threadLocals;
		}
		if (threadPoolWorkQueueThreadLocals != null)
		{
			threadPoolWorkQueueThreadLocals.workStealingQueue.LocalPush(callback);
		}
		else
		{
			QueueSegment queueSegment = queueHead;
			while (!queueSegment.TryEnqueue(callback))
			{
				Interlocked.CompareExchange(ref queueSegment.Next, new QueueSegment(), null);
				while (queueSegment.Next != null)
				{
					Interlocked.CompareExchange(ref queueHead, queueSegment.Next, queueSegment);
					queueSegment = queueHead;
				}
			}
		}
		ThreadPool.NotifyWorkItemQueued();
		EnsureThreadRequested();
	}

	internal bool LocalFindAndPop(IThreadPoolWorkItem callback)
	{
		return ThreadPoolWorkQueueThreadLocals.threadLocals?.workStealingQueue.LocalFindAndPop(callback) ?? false;
	}

	public void Dequeue(ThreadPoolWorkQueueThreadLocals tl, out IThreadPoolWorkItem callback, out bool missedSteal)
	{
		callback = null;
		missedSteal = false;
		WorkStealingQueue workStealingQueue = tl.workStealingQueue;
		workStealingQueue.LocalPop(out callback);
		if (callback == null)
		{
			QueueSegment queueSegment = queueTail;
			while (!queueSegment.TryDequeue(out callback) && queueSegment.Next != null && queueSegment.IsUsedUp())
			{
				Interlocked.CompareExchange(ref queueTail, queueSegment.Next, queueSegment);
				queueSegment = queueTail;
			}
		}
		if (callback != null)
		{
			return;
		}
		WorkStealingQueue[] current = allThreadQueues.Current;
		int num = tl.random.Next(current.Length);
		int num2 = current.Length;
		while (num2 > 0)
		{
			WorkStealingQueue workStealingQueue2 = Volatile.Read(ref current[num % current.Length]);
			if (workStealingQueue2 == null || workStealingQueue2 == workStealingQueue || !workStealingQueue2.TrySteal(out callback, ref missedSteal))
			{
				num++;
				num2--;
				continue;
			}
			break;
		}
	}

	internal static bool Dispatch()
	{
		ThreadPoolWorkQueue workQueue = ThreadPoolGlobals.workQueue;
		int tickCount = Environment.TickCount;
		workQueue.MarkThreadRequestSatisfied();
		bool flag = true;
		IThreadPoolWorkItem callback = null;
		try
		{
			ThreadPoolWorkQueueThreadLocals tl = workQueue.EnsureCurrentThreadHasQueue();
			while ((long)(Environment.TickCount - tickCount) < 30L)
			{
				try
				{
				}
				finally
				{
					bool missedSteal = false;
					workQueue.Dequeue(tl, out callback, out missedSteal);
					if (callback == null)
					{
						flag = missedSteal;
					}
					else
					{
						workQueue.EnsureThreadRequested();
					}
				}
				if (callback == null)
				{
					return true;
				}
				if (ThreadPoolGlobals.enableWorkerTracking)
				{
					bool flag2 = false;
					try
					{
						try
						{
						}
						finally
						{
							ThreadPool.ReportThreadStatus(isWorking: true);
							flag2 = true;
						}
						callback.ExecuteWorkItem();
						callback = null;
					}
					finally
					{
						if (flag2)
						{
							ThreadPool.ReportThreadStatus(isWorking: false);
						}
					}
				}
				else
				{
					callback.ExecuteWorkItem();
					callback = null;
				}
				if (!ThreadPool.NotifyWorkItemComplete())
				{
					return false;
				}
			}
			return true;
		}
		catch (ThreadAbortException tae)
		{
			callback?.MarkAborted(tae);
			flag = false;
		}
		finally
		{
			if (flag)
			{
				workQueue.EnsureThreadRequested();
			}
		}
		return true;
	}
}
