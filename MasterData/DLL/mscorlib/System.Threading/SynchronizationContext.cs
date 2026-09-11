using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;

namespace System.Threading;

public class SynchronizationContext
{
	private SynchronizationContextProperties _props;

	private static Type s_cachedPreparedType1;

	private static Type s_cachedPreparedType2;

	private static Type s_cachedPreparedType3;

	private static Type s_cachedPreparedType4;

	private static Type s_cachedPreparedType5;

	public static SynchronizationContext Current => Thread.CurrentThread.GetExecutionContextReader().SynchronizationContext ?? GetThreadLocalContext();

	internal static SynchronizationContext CurrentNoFlow
	{
		[FriendAccessAllowed]
		get
		{
			return Thread.CurrentThread.GetExecutionContextReader().SynchronizationContextNoFlow ?? GetThreadLocalContext();
		}
	}

	internal static SynchronizationContext CurrentExplicit => Current;

	public bool IsWaitNotificationRequired()
	{
		return (_props & SynchronizationContextProperties.RequireWaitNotification) != 0;
	}

	public virtual void Send(SendOrPostCallback d, object state)
	{
		d(state);
	}

	public virtual void Post(SendOrPostCallback d, object state)
	{
		ThreadPool.QueueUserWorkItem(d.Invoke, state);
	}

	public virtual void OperationStarted()
	{
	}

	public virtual void OperationCompleted()
	{
	}

	[PrePrepareMethod]
	[CLSCompliant(false)]
	public virtual int Wait(IntPtr[] waitHandles, bool waitAll, int millisecondsTimeout)
	{
		if (waitHandles == null)
		{
			throw new ArgumentNullException("waitHandles");
		}
		return WaitHelper(waitHandles, waitAll, millisecondsTimeout);
	}

	[CLSCompliant(false)]
	[PrePrepareMethod]
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	protected unsafe static int WaitHelper(IntPtr[] waitHandles, bool waitAll, int millisecondsTimeout)
	{
		fixed (IntPtr* handles = waitHandles)
		{
			return WaitHandle.Wait_internal(handles, waitHandles.Length, waitAll, millisecondsTimeout);
		}
	}

	public static void SetSynchronizationContext(SynchronizationContext syncContext)
	{
		ExecutionContext mutableExecutionContext = Thread.CurrentThread.GetMutableExecutionContext();
		mutableExecutionContext.SynchronizationContext = syncContext;
		mutableExecutionContext.SynchronizationContextNoFlow = syncContext;
	}

	private static SynchronizationContext GetThreadLocalContext()
	{
		SynchronizationContext synchronizationContext = null;
		if (synchronizationContext == null)
		{
			synchronizationContext = OSSpecificSynchronizationContext.Get();
		}
		return synchronizationContext;
	}

	public virtual SynchronizationContext CreateCopy()
	{
		return new SynchronizationContext();
	}
}
