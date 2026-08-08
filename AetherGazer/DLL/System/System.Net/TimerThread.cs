using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Threading;

namespace System.Net;

internal static class TimerThread
{
	internal abstract class Queue
	{
		private readonly int m_DurationMilliseconds;

		internal int Duration => m_DurationMilliseconds;

		internal Queue(int durationMilliseconds)
		{
			m_DurationMilliseconds = durationMilliseconds;
		}

		internal abstract Timer CreateTimer(Callback callback, object context);
	}

	internal abstract class Timer : IDisposable
	{
		private readonly int m_StartTimeMilliseconds;

		private readonly int m_DurationMilliseconds;

		internal int StartTime => m_StartTimeMilliseconds;

		internal int Expiration => m_StartTimeMilliseconds + m_DurationMilliseconds;

		internal abstract bool HasExpired { get; }

		internal Timer(int durationMilliseconds)
		{
			m_DurationMilliseconds = durationMilliseconds;
			m_StartTimeMilliseconds = Environment.TickCount;
		}

		internal abstract bool Cancel();

		public void Dispose()
		{
			Cancel();
		}
	}

	internal delegate void Callback(Timer timer, int timeNoticed, object context);

	private class TimerQueue : Queue
	{
		private IntPtr m_ThisHandle;

		private readonly TimerNode m_Timers;

		internal TimerQueue(int durationMilliseconds)
			: base(durationMilliseconds)
		{
			m_Timers = new TimerNode();
			m_Timers.Next = m_Timers;
			m_Timers.Prev = m_Timers;
		}

		internal override Timer CreateTimer(Callback callback, object context)
		{
			TimerNode timerNode = new TimerNode(callback, context, base.Duration, m_Timers);
			bool flag = false;
			lock (m_Timers)
			{
				if (m_Timers.Next == m_Timers)
				{
					if (m_ThisHandle == IntPtr.Zero)
					{
						m_ThisHandle = (IntPtr)GCHandle.Alloc(this);
					}
					flag = true;
				}
				timerNode.Next = m_Timers;
				timerNode.Prev = m_Timers.Prev;
				m_Timers.Prev.Next = timerNode;
				m_Timers.Prev = timerNode;
			}
			if (flag)
			{
				Prod();
			}
			return timerNode;
		}

		internal bool Fire(out int nextExpiration)
		{
			TimerNode next;
			do
			{
				next = m_Timers.Next;
				if (next != m_Timers)
				{
					continue;
				}
				lock (m_Timers)
				{
					next = m_Timers.Next;
					if (next == m_Timers)
					{
						if (m_ThisHandle != IntPtr.Zero)
						{
							((GCHandle)m_ThisHandle).Free();
							m_ThisHandle = IntPtr.Zero;
						}
						nextExpiration = 0;
						return false;
					}
				}
			}
			while (next.Fire());
			nextExpiration = next.Expiration;
			return true;
		}
	}

	private class InfiniteTimerQueue : Queue
	{
		internal InfiniteTimerQueue()
			: base(-1)
		{
		}

		internal override Timer CreateTimer(Callback callback, object context)
		{
			return new InfiniteTimer();
		}
	}

	private class TimerNode : Timer
	{
		private enum TimerState
		{
			Ready,
			Fired,
			Cancelled,
			Sentinel
		}

		private TimerState m_TimerState;

		private Callback m_Callback;

		private object m_Context;

		private object m_QueueLock;

		private TimerNode next;

		private TimerNode prev;

		internal override bool HasExpired => m_TimerState == TimerState.Fired;

		internal TimerNode Next
		{
			get
			{
				return next;
			}
			set
			{
				next = value;
			}
		}

		internal TimerNode Prev
		{
			get
			{
				return prev;
			}
			set
			{
				prev = value;
			}
		}

		internal TimerNode(Callback callback, object context, int durationMilliseconds, object queueLock)
			: base(durationMilliseconds)
		{
			if (callback != null)
			{
				m_Callback = callback;
				m_Context = context;
			}
			m_TimerState = TimerState.Ready;
			m_QueueLock = queueLock;
		}

		internal TimerNode()
			: base(0)
		{
			m_TimerState = TimerState.Sentinel;
		}

		internal override bool Cancel()
		{
			if (m_TimerState == TimerState.Ready)
			{
				lock (m_QueueLock)
				{
					if (m_TimerState == TimerState.Ready)
					{
						Next.Prev = Prev;
						Prev.Next = Next;
						Next = null;
						Prev = null;
						m_Callback = null;
						m_Context = null;
						m_TimerState = TimerState.Cancelled;
						return true;
					}
				}
			}
			return false;
		}

		internal bool Fire()
		{
			if (m_TimerState != TimerState.Ready)
			{
				return true;
			}
			int tickCount = Environment.TickCount;
			if (IsTickBetween(base.StartTime, base.Expiration, tickCount))
			{
				return false;
			}
			bool flag = false;
			lock (m_QueueLock)
			{
				if (m_TimerState == TimerState.Ready)
				{
					m_TimerState = TimerState.Fired;
					Next.Prev = Prev;
					Prev.Next = Next;
					Next = null;
					Prev = null;
					flag = m_Callback != null;
				}
			}
			if (flag)
			{
				try
				{
					Callback callback = m_Callback;
					object context = m_Context;
					m_Callback = null;
					m_Context = null;
					callback(this, tickCount, context);
				}
				catch (Exception exception)
				{
					if (NclUtilities.IsFatal(exception))
					{
						throw;
					}
					_ = Logging.On;
				}
			}
			return true;
		}
	}

	private class InfiniteTimer : Timer
	{
		private int cancelled;

		internal override bool HasExpired => false;

		internal InfiniteTimer()
			: base(-1)
		{
		}

		internal override bool Cancel()
		{
			return Interlocked.Exchange(ref cancelled, 1) == 0;
		}
	}

	private static LinkedList<WeakReference> s_Queues;

	private static LinkedList<WeakReference> s_NewQueues;

	private static int s_ThreadState;

	private static AutoResetEvent s_ThreadReadyEvent;

	private static ManualResetEvent s_ThreadShutdownEvent;

	private static WaitHandle[] s_ThreadEvents;

	private static int s_CacheScanIteration;

	private static Hashtable s_QueuesCache;

	static TimerThread()
	{
		s_Queues = new LinkedList<WeakReference>();
		s_NewQueues = new LinkedList<WeakReference>();
		s_ThreadState = 0;
		s_ThreadReadyEvent = new AutoResetEvent(initialState: false);
		s_ThreadShutdownEvent = new ManualResetEvent(initialState: false);
		s_QueuesCache = new Hashtable();
		s_ThreadEvents = new WaitHandle[2] { s_ThreadShutdownEvent, s_ThreadReadyEvent };
		AppDomain.CurrentDomain.DomainUnload += OnDomainUnload;
	}

	internal static Queue CreateQueue(int durationMilliseconds)
	{
		if (durationMilliseconds == -1)
		{
			return new InfiniteTimerQueue();
		}
		if (durationMilliseconds < 0)
		{
			throw new ArgumentOutOfRangeException("durationMilliseconds");
		}
		lock (s_NewQueues)
		{
			TimerQueue timerQueue = new TimerQueue(durationMilliseconds);
			WeakReference value = new WeakReference(timerQueue);
			s_NewQueues.AddLast(value);
			return timerQueue;
		}
	}

	internal static Queue GetOrCreateQueue(int durationMilliseconds)
	{
		if (durationMilliseconds == -1)
		{
			return new InfiniteTimerQueue();
		}
		if (durationMilliseconds < 0)
		{
			throw new ArgumentOutOfRangeException("durationMilliseconds");
		}
		WeakReference weakReference = (WeakReference)s_QueuesCache[durationMilliseconds];
		TimerQueue timerQueue;
		if (weakReference == null || (timerQueue = (TimerQueue)weakReference.Target) == null)
		{
			lock (s_NewQueues)
			{
				weakReference = (WeakReference)s_QueuesCache[durationMilliseconds];
				if (weakReference == null || (timerQueue = (TimerQueue)weakReference.Target) == null)
				{
					timerQueue = new TimerQueue(durationMilliseconds);
					weakReference = new WeakReference(timerQueue);
					s_NewQueues.AddLast(weakReference);
					s_QueuesCache[durationMilliseconds] = weakReference;
					if (++s_CacheScanIteration % 32 == 0)
					{
						List<int> list = new List<int>();
						foreach (DictionaryEntry item in s_QueuesCache)
						{
							if (((WeakReference)item.Value).Target == null)
							{
								list.Add((int)item.Key);
							}
						}
						for (int i = 0; i < list.Count; i++)
						{
							s_QueuesCache.Remove(list[i]);
						}
					}
				}
			}
		}
		return timerQueue;
	}

	private static void Prod()
	{
		s_ThreadReadyEvent.Set();
		if (Interlocked.CompareExchange(ref s_ThreadState, 1, 0) == 0)
		{
			new Thread(ThreadProc).Start();
		}
	}

	private static void ThreadProc()
	{
		Thread.CurrentThread.IsBackground = true;
		lock (s_Queues)
		{
			if (Interlocked.CompareExchange(ref s_ThreadState, 1, 1) != 1)
			{
				return;
			}
			bool flag = true;
			while (flag)
			{
				try
				{
					s_ThreadReadyEvent.Reset();
					while (true)
					{
						if (s_NewQueues.Count > 0)
						{
							lock (s_NewQueues)
							{
								for (LinkedListNode<WeakReference> first = s_NewQueues.First; first != null; first = s_NewQueues.First)
								{
									s_NewQueues.Remove(first);
									s_Queues.AddLast(first);
								}
							}
						}
						int tickCount = Environment.TickCount;
						int num = 0;
						bool flag2 = false;
						LinkedListNode<WeakReference> linkedListNode = s_Queues.First;
						while (linkedListNode != null)
						{
							TimerQueue timerQueue = (TimerQueue)linkedListNode.Value.Target;
							if (timerQueue == null)
							{
								LinkedListNode<WeakReference> next = linkedListNode.Next;
								s_Queues.Remove(linkedListNode);
								linkedListNode = next;
								continue;
							}
							if (timerQueue.Fire(out var nextExpiration) && (!flag2 || IsTickBetween(tickCount, num, nextExpiration)))
							{
								num = nextExpiration;
								flag2 = true;
							}
							linkedListNode = linkedListNode.Next;
						}
						int tickCount2 = Environment.TickCount;
						int millisecondsTimeout = (int)((!flag2) ? 30000 : (IsTickBetween(tickCount, num, tickCount2) ? (Math.Min((uint)(num - tickCount2), 2147483632u) + 15) : 0));
						switch (WaitHandle.WaitAny(s_ThreadEvents, millisecondsTimeout, exitContext: false))
						{
						case 0:
							flag = false;
							goto end_IL_0042;
						case 258:
							if (!flag2)
							{
								Interlocked.CompareExchange(ref s_ThreadState, 0, 1);
								if (!s_ThreadReadyEvent.WaitOne(0, exitContext: false) || Interlocked.CompareExchange(ref s_ThreadState, 1, 0) != 0)
								{
									flag = false;
									goto end_IL_0042;
								}
							}
							break;
						}
						continue;
						end_IL_0042:
						break;
					}
				}
				catch (Exception exception)
				{
					if (NclUtilities.IsFatal(exception))
					{
						throw;
					}
					_ = Logging.On;
					Thread.Sleep(1000);
				}
			}
		}
	}

	private static void StopTimerThread()
	{
		Interlocked.Exchange(ref s_ThreadState, 2);
		s_ThreadShutdownEvent.Set();
	}

	private static bool IsTickBetween(int start, int end, int comparand)
	{
		return start <= comparand == end <= comparand != start <= end;
	}

	private static void OnDomainUnload(object sender, EventArgs e)
	{
		try
		{
			StopTimerThread();
		}
		catch
		{
		}
	}
}
