using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using Microsoft.Win32.SafeHandles;

namespace System.Threading;

[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public abstract class WaitHandle : MarshalByRefObject, IDisposable
{
	internal enum OpenExistingResult
	{
		Success,
		NameNotFound,
		PathNotFound,
		NameInvalid
	}

	public const int WaitTimeout = 258;

	private const int MAX_WAITHANDLES = 64;

	private IntPtr waitHandle;

	internal volatile SafeWaitHandle safeWaitHandle;

	internal bool hasThreadAffinity;

	private const int WAIT_OBJECT_0 = 0;

	private const int WAIT_ABANDONED = 128;

	private const int WAIT_FAILED = int.MaxValue;

	private const int ERROR_TOO_MANY_POSTS = 298;

	private const int ERROR_NOT_OWNED_BY_CALLER = 299;

	protected static readonly IntPtr InvalidHandle = (IntPtr)(-1);

	internal const int MaxWaitHandles = 64;

	[Obsolete("Use the SafeWaitHandle property instead.")]
	public virtual IntPtr Handle
	{
		get
		{
			if (safeWaitHandle != null)
			{
				return safeWaitHandle.DangerousGetHandle();
			}
			return InvalidHandle;
		}
		set
		{
			if (value == InvalidHandle)
			{
				if (safeWaitHandle != null)
				{
					safeWaitHandle.SetHandleAsInvalid();
					safeWaitHandle = null;
				}
			}
			else
			{
				safeWaitHandle = new SafeWaitHandle(value, ownsHandle: true);
			}
			waitHandle = value;
		}
	}

	public SafeWaitHandle SafeWaitHandle
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
		get
		{
			if (safeWaitHandle == null)
			{
				safeWaitHandle = new SafeWaitHandle(InvalidHandle, ownsHandle: false);
			}
			return safeWaitHandle;
		}
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		set
		{
			RuntimeHelpers.PrepareConstrainedRegions();
			try
			{
			}
			finally
			{
				if (value == null)
				{
					safeWaitHandle = null;
					waitHandle = InvalidHandle;
				}
				else
				{
					safeWaitHandle = value;
					waitHandle = safeWaitHandle.DangerousGetHandle();
				}
			}
		}
	}

	protected WaitHandle()
	{
		Init();
	}

	private void Init()
	{
		safeWaitHandle = null;
		waitHandle = InvalidHandle;
		hasThreadAffinity = false;
	}

	internal void SetHandleInternal(SafeWaitHandle handle)
	{
		safeWaitHandle = handle;
		waitHandle = handle.DangerousGetHandle();
	}

	public virtual bool WaitOne(int millisecondsTimeout, bool exitContext)
	{
		if (millisecondsTimeout < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		return WaitOne((long)millisecondsTimeout, exitContext);
	}

	public virtual bool WaitOne(TimeSpan timeout, bool exitContext)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (-1 > num || int.MaxValue < num)
		{
			throw new ArgumentOutOfRangeException("timeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		return WaitOne(num, exitContext);
	}

	public virtual bool WaitOne()
	{
		return WaitOne(-1, exitContext: false);
	}

	public virtual bool WaitOne(int millisecondsTimeout)
	{
		return WaitOne(millisecondsTimeout, exitContext: false);
	}

	public virtual bool WaitOne(TimeSpan timeout)
	{
		return WaitOne(timeout, exitContext: false);
	}

	private bool WaitOne(long timeout, bool exitContext)
	{
		return InternalWaitOne(safeWaitHandle, timeout, hasThreadAffinity, exitContext);
	}

	internal static bool InternalWaitOne(SafeHandle waitableSafeHandle, long millisecondsTimeout, bool hasThreadAffinity, bool exitContext)
	{
		if (waitableSafeHandle == null)
		{
			throw new ObjectDisposedException(null, Environment.GetResourceString("Cannot access a disposed object."));
		}
		int num = WaitOneNative(waitableSafeHandle, (uint)millisecondsTimeout, hasThreadAffinity, exitContext);
		if (num == 128)
		{
			ThrowAbandonedMutexException();
		}
		if (num != 258)
		{
			return num != int.MaxValue;
		}
		return false;
	}

	internal bool WaitOneWithoutFAS()
	{
		if (safeWaitHandle == null)
		{
			throw new ObjectDisposedException(null, Environment.GetResourceString("Cannot access a disposed object."));
		}
		long num = -1L;
		int num2 = WaitOneNative(safeWaitHandle, (uint)num, hasThreadAffinity, exitContext: false);
		if (num2 == 128)
		{
			ThrowAbandonedMutexException();
		}
		if (num2 != 258)
		{
			return num2 != int.MaxValue;
		}
		return false;
	}

	public static bool WaitAll(WaitHandle[] waitHandles, int millisecondsTimeout, bool exitContext)
	{
		if (waitHandles == null)
		{
			throw new ArgumentNullException(Environment.GetResourceString("The waitHandles parameter cannot be null."));
		}
		if (waitHandles.Length == 0)
		{
			throw new ArgumentNullException(Environment.GetResourceString("Waithandle array may not be empty."));
		}
		if (waitHandles.Length > 64)
		{
			throw new NotSupportedException(Environment.GetResourceString("The number of WaitHandles must be less than or equal to 64."));
		}
		if (-1 > millisecondsTimeout)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		WaitHandle[] array = new WaitHandle[waitHandles.Length];
		for (int i = 0; i < waitHandles.Length; i++)
		{
			WaitHandle waitHandle = waitHandles[i];
			if (waitHandle == null)
			{
				throw new ArgumentNullException(Environment.GetResourceString("At least one element in the specified array was null."));
			}
			array[i] = waitHandle;
		}
		int num = WaitMultiple(array, millisecondsTimeout, exitContext, WaitAll: true);
		if (128 <= num && 128 + array.Length > num)
		{
			ThrowAbandonedMutexException();
		}
		GC.KeepAlive(array);
		if (num != 258)
		{
			return num != int.MaxValue;
		}
		return false;
	}

	public static bool WaitAll(WaitHandle[] waitHandles, TimeSpan timeout, bool exitContext)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (-1 > num || int.MaxValue < num)
		{
			throw new ArgumentOutOfRangeException("timeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		return WaitAll(waitHandles, (int)num, exitContext);
	}

	public static bool WaitAll(WaitHandle[] waitHandles)
	{
		return WaitAll(waitHandles, -1, exitContext: true);
	}

	public static bool WaitAll(WaitHandle[] waitHandles, int millisecondsTimeout)
	{
		return WaitAll(waitHandles, millisecondsTimeout, exitContext: true);
	}

	public static bool WaitAll(WaitHandle[] waitHandles, TimeSpan timeout)
	{
		return WaitAll(waitHandles, timeout, exitContext: true);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static int WaitAny(WaitHandle[] waitHandles, int millisecondsTimeout, bool exitContext)
	{
		if (waitHandles == null)
		{
			throw new ArgumentNullException(Environment.GetResourceString("The waitHandles parameter cannot be null."));
		}
		if (waitHandles.Length == 0)
		{
			throw new ArgumentException(Environment.GetResourceString("Waithandle array may not be empty."));
		}
		if (64 < waitHandles.Length)
		{
			throw new NotSupportedException(Environment.GetResourceString("The number of WaitHandles must be less than or equal to 64."));
		}
		if (-1 > millisecondsTimeout)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		WaitHandle[] array = new WaitHandle[waitHandles.Length];
		for (int i = 0; i < waitHandles.Length; i++)
		{
			WaitHandle waitHandle = waitHandles[i];
			if (waitHandle == null)
			{
				throw new ArgumentNullException(Environment.GetResourceString("At least one element in the specified array was null."));
			}
			array[i] = waitHandle;
		}
		int num = WaitMultiple(array, millisecondsTimeout, exitContext, WaitAll: false);
		if (128 <= num && 128 + array.Length > num)
		{
			int num2 = num - 128;
			if (0 <= num2 && num2 < array.Length)
			{
				ThrowAbandonedMutexException(num2, array[num2]);
			}
			else
			{
				ThrowAbandonedMutexException();
			}
		}
		GC.KeepAlive(array);
		return num;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static int WaitAny(WaitHandle[] waitHandles, TimeSpan timeout, bool exitContext)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (-1 > num || int.MaxValue < num)
		{
			throw new ArgumentOutOfRangeException("timeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		return WaitAny(waitHandles, (int)num, exitContext);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static int WaitAny(WaitHandle[] waitHandles, TimeSpan timeout)
	{
		return WaitAny(waitHandles, timeout, exitContext: true);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static int WaitAny(WaitHandle[] waitHandles)
	{
		return WaitAny(waitHandles, -1, exitContext: true);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static int WaitAny(WaitHandle[] waitHandles, int millisecondsTimeout)
	{
		return WaitAny(waitHandles, millisecondsTimeout, exitContext: true);
	}

	public static bool SignalAndWait(WaitHandle toSignal, WaitHandle toWaitOn)
	{
		return SignalAndWait(toSignal, toWaitOn, -1, exitContext: false);
	}

	public static bool SignalAndWait(WaitHandle toSignal, WaitHandle toWaitOn, TimeSpan timeout, bool exitContext)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (-1 > num || int.MaxValue < num)
		{
			throw new ArgumentOutOfRangeException("timeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		return SignalAndWait(toSignal, toWaitOn, (int)num, exitContext);
	}

	public static bool SignalAndWait(WaitHandle toSignal, WaitHandle toWaitOn, int millisecondsTimeout, bool exitContext)
	{
		if (toSignal == null)
		{
			throw new ArgumentNullException("toSignal");
		}
		if (toWaitOn == null)
		{
			throw new ArgumentNullException("toWaitOn");
		}
		if (-1 > millisecondsTimeout)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		int num = SignalAndWaitOne(toSignal.safeWaitHandle, toWaitOn.safeWaitHandle, millisecondsTimeout, toWaitOn.hasThreadAffinity, exitContext);
		if (int.MaxValue != num && toSignal.hasThreadAffinity)
		{
			Thread.EndCriticalRegion();
			Thread.EndThreadAffinity();
		}
		if (128 == num)
		{
			ThrowAbandonedMutexException();
		}
		if (298 == num)
		{
			throw new InvalidOperationException(Environment.GetResourceString("The WaitHandle cannot be signaled because it would exceed its maximum count."));
		}
		if (299 == num)
		{
			throw new ApplicationException("Attempt to release mutex not owned by caller");
		}
		if (num == 0)
		{
			return true;
		}
		return false;
	}

	private static void ThrowAbandonedMutexException()
	{
		throw new AbandonedMutexException();
	}

	private static void ThrowAbandonedMutexException(int location, WaitHandle handle)
	{
		throw new AbandonedMutexException(location, handle);
	}

	public virtual void Close()
	{
		Dispose(explicitDisposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool explicitDisposing)
	{
		if (safeWaitHandle != null)
		{
			safeWaitHandle.Close();
		}
	}

	public void Dispose()
	{
		Dispose(explicitDisposing: true);
		GC.SuppressFinalize(this);
	}

	private unsafe static int WaitOneNative(SafeHandle waitableSafeHandle, uint millisecondsTimeout, bool hasThreadAffinity, bool exitContext)
	{
		bool success = false;
		SynchronizationContext current = SynchronizationContext.Current;
		try
		{
			waitableSafeHandle.DangerousAddRef(ref success);
			if (current != null && current.IsWaitNotificationRequired())
			{
				return current.Wait(new IntPtr[1] { waitableSafeHandle.DangerousGetHandle() }, waitAll: false, (int)millisecondsTimeout);
			}
			IntPtr intPtr = waitableSafeHandle.DangerousGetHandle();
			return Wait_internal(&intPtr, 1, waitAll: false, (int)millisecondsTimeout);
		}
		finally
		{
			if (success)
			{
				waitableSafeHandle.DangerousRelease();
			}
		}
	}

	private unsafe static int WaitMultiple(WaitHandle[] waitHandles, int millisecondsTimeout, bool exitContext, bool WaitAll)
	{
		if (waitHandles.Length > 64)
		{
			return int.MaxValue;
		}
		int num = -1;
		SynchronizationContext current = SynchronizationContext.Current;
		try
		{
			for (int i = 0; i < waitHandles.Length; i++)
			{
				try
				{
				}
				finally
				{
					bool success = false;
					waitHandles[i].SafeWaitHandle.DangerousAddRef(ref success);
					num = i;
				}
			}
			if (current != null && current.IsWaitNotificationRequired())
			{
				IntPtr[] array = new IntPtr[waitHandles.Length];
				for (int j = 0; j < waitHandles.Length; j++)
				{
					array[j] = waitHandles[j].SafeWaitHandle.DangerousGetHandle();
				}
				return current.Wait(array, waitAll: false, millisecondsTimeout);
			}
			IntPtr* ptr = stackalloc IntPtr[waitHandles.Length];
			for (int k = 0; k < waitHandles.Length; k++)
			{
				ptr[k] = waitHandles[k].SafeWaitHandle.DangerousGetHandle();
			}
			return Wait_internal(ptr, waitHandles.Length, WaitAll, millisecondsTimeout);
		}
		finally
		{
			for (int num2 = num; num2 >= 0; num2--)
			{
				waitHandles[num2].SafeWaitHandle.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern int Wait_internal(IntPtr* handles, int numHandles, bool waitAll, int ms);

	private static int SignalAndWaitOne(SafeWaitHandle waitHandleToSignal, SafeWaitHandle waitHandleToWaitOn, int millisecondsTimeout, bool hasThreadAffinity, bool exitContext)
	{
		bool success = false;
		bool success2 = false;
		try
		{
			waitHandleToSignal.DangerousAddRef(ref success);
			waitHandleToWaitOn.DangerousAddRef(ref success2);
			return SignalAndWait_Internal(waitHandleToSignal.DangerousGetHandle(), waitHandleToWaitOn.DangerousGetHandle(), millisecondsTimeout);
		}
		finally
		{
			if (success)
			{
				waitHandleToSignal.DangerousRelease();
			}
			if (success2)
			{
				waitHandleToWaitOn.DangerousRelease();
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int SignalAndWait_Internal(IntPtr toSignal, IntPtr toWaitOn, int ms);

	internal static int ToTimeoutMilliseconds(TimeSpan timeout)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (num < -1 || num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("timeout", "Number must be either non-negative and less than or equal to Int32.MaxValue or -1.");
		}
		return (int)num;
	}
}
