using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;

namespace System.Threading;

public static class Monitor
{
	[MethodImpl((MethodImplOptions)4096)]
	public static extern void Enter(object obj);

	public static void Enter(object obj, ref bool lockTaken)
	{
		if (lockTaken)
		{
			ThrowLockTakenException();
		}
		ReliableEnter(obj, ref lockTaken);
	}

	private static void ThrowLockTakenException()
	{
		throw new ArgumentException(Environment.GetResourceString("Argument must be initialized to false"), "lockTaken");
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static extern void Exit(object obj);

	public static bool TryEnter(object obj)
	{
		bool lockTaken = false;
		TryEnter(obj, 0, ref lockTaken);
		return lockTaken;
	}

	public static void TryEnter(object obj, ref bool lockTaken)
	{
		if (lockTaken)
		{
			ThrowLockTakenException();
		}
		ReliableEnterTimeout(obj, 0, ref lockTaken);
	}

	public static bool TryEnter(object obj, int millisecondsTimeout)
	{
		bool lockTaken = false;
		TryEnter(obj, millisecondsTimeout, ref lockTaken);
		return lockTaken;
	}

	private static int MillisecondsTimeoutFromTimeSpan(TimeSpan timeout)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("timeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		return (int)num;
	}

	public static bool TryEnter(object obj, TimeSpan timeout)
	{
		return TryEnter(obj, MillisecondsTimeoutFromTimeSpan(timeout));
	}

	public static void TryEnter(object obj, int millisecondsTimeout, ref bool lockTaken)
	{
		if (lockTaken)
		{
			ThrowLockTakenException();
		}
		ReliableEnterTimeout(obj, millisecondsTimeout, ref lockTaken);
	}

	public static void TryEnter(object obj, TimeSpan timeout, ref bool lockTaken)
	{
		if (lockTaken)
		{
			ThrowLockTakenException();
		}
		ReliableEnterTimeout(obj, MillisecondsTimeoutFromTimeSpan(timeout), ref lockTaken);
	}

	public static bool IsEntered(object obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		return IsEnteredNative(obj);
	}

	public static bool Wait(object obj, int millisecondsTimeout, bool exitContext)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		return ObjWait(exitContext, millisecondsTimeout, obj);
	}

	public static bool Wait(object obj, TimeSpan timeout, bool exitContext)
	{
		return Wait(obj, MillisecondsTimeoutFromTimeSpan(timeout), exitContext);
	}

	public static bool Wait(object obj, int millisecondsTimeout)
	{
		return Wait(obj, millisecondsTimeout, exitContext: false);
	}

	public static bool Wait(object obj, TimeSpan timeout)
	{
		return Wait(obj, MillisecondsTimeoutFromTimeSpan(timeout), exitContext: false);
	}

	public static bool Wait(object obj)
	{
		return Wait(obj, -1, exitContext: false);
	}

	public static void Pulse(object obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		ObjPulse(obj);
	}

	public static void PulseAll(object obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		ObjPulseAll(obj);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Monitor_test_synchronised(object obj);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Monitor_pulse(object obj);

	private static void ObjPulse(object obj)
	{
		if (!Monitor_test_synchronised(obj))
		{
			throw new SynchronizationLockException("Object is not synchronized");
		}
		Monitor_pulse(obj);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Monitor_pulse_all(object obj);

	private static void ObjPulseAll(object obj)
	{
		if (!Monitor_test_synchronised(obj))
		{
			throw new SynchronizationLockException("Object is not synchronized");
		}
		Monitor_pulse_all(obj);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Monitor_wait(object obj, int ms);

	private static bool ObjWait(bool exitContext, int millisecondsTimeout, object obj)
	{
		if (millisecondsTimeout < 0 && millisecondsTimeout != -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout");
		}
		if (!Monitor_test_synchronised(obj))
		{
			throw new SynchronizationLockException("Object is not synchronized");
		}
		return Monitor_wait(obj, millisecondsTimeout);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void try_enter_with_atomic_var(object obj, int millisecondsTimeout, ref bool lockTaken);

	private static void ReliableEnterTimeout(object obj, int timeout, ref bool lockTaken)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (timeout < 0 && timeout != -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout");
		}
		try_enter_with_atomic_var(obj, timeout, ref lockTaken);
	}

	private static void ReliableEnter(object obj, ref bool lockTaken)
	{
		ReliableEnterTimeout(obj, -1, ref lockTaken);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Monitor_test_owner(object obj);

	private static bool IsEnteredNative(object obj)
	{
		return Monitor_test_owner(obj);
	}
}
