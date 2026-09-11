using System.Diagnostics;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;

namespace System.Threading;

[DebuggerDisplay("IsHeld = {IsHeld}")]
[DebuggerTypeProxy(typeof(SystemThreading_SpinLockDebugView))]
[ComVisible(false)]
public struct SpinLock
{
	internal class SystemThreading_SpinLockDebugView
	{
	}

	private volatile int m_owner = 0;

	private const int SPINNING_FACTOR = 100;

	private const int SLEEP_ONE_FREQUENCY = 40;

	private const int SLEEP_ZERO_FREQUENCY = 10;

	private const int TIMEOUT_CHECK_FREQUENCY = 10;

	private const int LOCK_ID_DISABLE_MASK = int.MinValue;

	private const int LOCK_ANONYMOUS_OWNED = 1;

	private const int WAITERS_MASK = 2147483646;

	private const int ID_DISABLED_AND_ANONYMOUS_OWNED = -2147483647;

	private const int LOCK_UNOWNED = 0;

	private static int MAXIMUM_WAITERS = 2147483646;

	public bool IsHeldByCurrentThread
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			if (!IsThreadOwnerTrackingEnabled)
			{
				throw new InvalidOperationException(Environment.GetResourceString("Thread tracking is disabled."));
			}
			return (m_owner & 0x7FFFFFFF) == Thread.CurrentThread.ManagedThreadId;
		}
	}

	public bool IsThreadOwnerTrackingEnabled
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			return (m_owner & int.MinValue) == 0;
		}
	}

	public SpinLock(bool enableThreadOwnerTracking)
	{
		if (!enableThreadOwnerTracking)
		{
			m_owner |= int.MinValue;
		}
	}

	public void Enter(ref bool lockTaken)
	{
		Thread.BeginCriticalRegion();
		int owner = m_owner;
		if (lockTaken || (owner & -2147483647) != int.MinValue || Interlocked.CompareExchange(ref m_owner, owner | 1, owner, ref lockTaken) != owner)
		{
			ContinueTryEnter(-1, ref lockTaken);
		}
	}

	public void TryEnter(int millisecondsTimeout, ref bool lockTaken)
	{
		Thread.BeginCriticalRegion();
		int owner = m_owner;
		if (((millisecondsTimeout < -1) | lockTaken) || (owner & -2147483647) != int.MinValue || Interlocked.CompareExchange(ref m_owner, owner | 1, owner, ref lockTaken) != owner)
		{
			ContinueTryEnter(millisecondsTimeout, ref lockTaken);
		}
	}

	private void ContinueTryEnter(int millisecondsTimeout, ref bool lockTaken)
	{
		Thread.EndCriticalRegion();
		if (lockTaken)
		{
			lockTaken = false;
			throw new ArgumentException(Environment.GetResourceString("The tookLock argument must be set to false before calling this method."));
		}
		if (millisecondsTimeout < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout", millisecondsTimeout, Environment.GetResourceString("The timeout must be a value between -1 and Int32.MaxValue, inclusive."));
		}
		uint startTime = 0u;
		if (millisecondsTimeout != -1 && millisecondsTimeout != 0)
		{
			startTime = TimeoutHelper.GetTime();
		}
		if (IsThreadOwnerTrackingEnabled)
		{
			ContinueTryEnterWithThreadTracking(millisecondsTimeout, startTime, ref lockTaken);
			return;
		}
		int num = int.MaxValue;
		int owner = m_owner;
		if ((owner & 1) == 0)
		{
			Thread.BeginCriticalRegion();
			if (Interlocked.CompareExchange(ref m_owner, owner | 1, owner, ref lockTaken) == owner)
			{
				return;
			}
			Thread.EndCriticalRegion();
		}
		else if ((owner & 0x7FFFFFFE) != MAXIMUM_WAITERS)
		{
			num = (Interlocked.Add(ref m_owner, 2) & 0x7FFFFFFE) >> 1;
		}
		if (millisecondsTimeout == 0 || (millisecondsTimeout != -1 && TimeoutHelper.UpdateTimeOut(startTime, millisecondsTimeout) <= 0))
		{
			DecrementWaiters();
			return;
		}
		int processorCount = PlatformHelper.ProcessorCount;
		if (num < processorCount)
		{
			int num2 = 1;
			for (int i = 1; i <= num * 100; i++)
			{
				Thread.SpinWait((num + i) * 100 * num2);
				if (num2 < processorCount)
				{
					num2++;
				}
				owner = m_owner;
				if ((owner & 1) == 0)
				{
					Thread.BeginCriticalRegion();
					int value = (((owner & 0x7FFFFFFE) == 0) ? (owner | 1) : ((owner - 2) | 1));
					if (Interlocked.CompareExchange(ref m_owner, value, owner, ref lockTaken) == owner)
					{
						return;
					}
					Thread.EndCriticalRegion();
				}
			}
		}
		if (millisecondsTimeout != -1 && TimeoutHelper.UpdateTimeOut(startTime, millisecondsTimeout) <= 0)
		{
			DecrementWaiters();
			return;
		}
		int num3 = 0;
		while (true)
		{
			owner = m_owner;
			if ((owner & 1) == 0)
			{
				Thread.BeginCriticalRegion();
				int value2 = (((owner & 0x7FFFFFFE) == 0) ? (owner | 1) : ((owner - 2) | 1));
				if (Interlocked.CompareExchange(ref m_owner, value2, owner, ref lockTaken) == owner)
				{
					return;
				}
				Thread.EndCriticalRegion();
			}
			if (num3 % 40 == 0)
			{
				Thread.Sleep(1);
			}
			else if (num3 % 10 == 0)
			{
				Thread.Sleep(0);
			}
			else
			{
				Thread.Yield();
			}
			if (num3 % 10 == 0 && millisecondsTimeout != -1 && TimeoutHelper.UpdateTimeOut(startTime, millisecondsTimeout) <= 0)
			{
				break;
			}
			num3++;
		}
		DecrementWaiters();
	}

	private void DecrementWaiters()
	{
		SpinWait spinWait = default(SpinWait);
		while (true)
		{
			int owner = m_owner;
			if ((owner & 0x7FFFFFFE) != 0 && Interlocked.CompareExchange(ref m_owner, owner - 2, owner) != owner)
			{
				spinWait.SpinOnce();
				continue;
			}
			break;
		}
	}

	private void ContinueTryEnterWithThreadTracking(int millisecondsTimeout, uint startTime, ref bool lockTaken)
	{
		int num = 0;
		int managedThreadId = Thread.CurrentThread.ManagedThreadId;
		if (m_owner == managedThreadId)
		{
			throw new LockRecursionException(Environment.GetResourceString("The calling thread already holds the lock."));
		}
		SpinWait spinWait = default(SpinWait);
		while (true)
		{
			spinWait.SpinOnce();
			if (m_owner == num)
			{
				Thread.BeginCriticalRegion();
				if (Interlocked.CompareExchange(ref m_owner, managedThreadId, num, ref lockTaken) == num)
				{
					break;
				}
				Thread.EndCriticalRegion();
			}
			switch (millisecondsTimeout)
			{
			case -1:
				continue;
			case 0:
				return;
			}
			if (spinWait.NextSpinWillYield && TimeoutHelper.UpdateTimeOut(startTime, millisecondsTimeout) <= 0)
			{
				return;
			}
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public void Exit(bool useMemoryBarrier)
	{
		if ((m_owner & int.MinValue) != 0 && !useMemoryBarrier)
		{
			int owner = m_owner;
			m_owner = owner & -2;
		}
		else
		{
			ExitSlowPath(useMemoryBarrier);
		}
		Thread.EndCriticalRegion();
	}

	private void ExitSlowPath(bool useMemoryBarrier)
	{
		bool flag = (m_owner & int.MinValue) == 0;
		if (flag && !IsHeldByCurrentThread)
		{
			throw new SynchronizationLockException(Environment.GetResourceString("The calling thread does not hold the lock."));
		}
		if (useMemoryBarrier)
		{
			if (flag)
			{
				Interlocked.Exchange(ref m_owner, 0);
			}
			else
			{
				Interlocked.Decrement(ref m_owner);
			}
		}
		else if (flag)
		{
			m_owner = 0;
		}
		else
		{
			int owner = m_owner;
			m_owner = owner & -2;
		}
	}
}
