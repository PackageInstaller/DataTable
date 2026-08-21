using System.Runtime.CompilerServices;

namespace System.Threading;

public static class ThreadPool
{
	internal static bool IsThreadPoolThread => Thread.CurrentThread.IsThreadPoolThread;

	public static void GetMaxThreads(out int workerThreads, out int completionPortThreads)
	{
		GetMaxThreadsNative(out workerThreads, out completionPortThreads);
	}

	private static RegisteredWaitHandle RegisterWaitForSingleObject(WaitHandle waitObject, WaitOrTimerCallback callBack, object state, uint millisecondsTimeOutInterval, bool executeOnlyOnce, ref StackCrawlMark stackMark, bool compressStack)
	{
		if (waitObject == null)
		{
			throw new ArgumentNullException("waitObject");
		}
		if (callBack == null)
		{
			throw new ArgumentNullException("callBack");
		}
		if (millisecondsTimeOutInterval != uint.MaxValue && millisecondsTimeOutInterval > int.MaxValue)
		{
			throw new NotSupportedException("Timeout is too big. Maximum is Int32.MaxValue");
		}
		RegisteredWaitHandle registeredWaitHandle = new RegisteredWaitHandle(waitObject, callBack, state, new TimeSpan(0, 0, 0, 0, (int)millisecondsTimeOutInterval), executeOnlyOnce);
		if (compressStack)
		{
			QueueUserWorkItem(registeredWaitHandle.Wait, null);
		}
		else
		{
			UnsafeQueueUserWorkItem(registeredWaitHandle.Wait, null);
		}
		return registeredWaitHandle;
	}

	[MethodImpl((MethodImplOptions)8)]
	public static RegisteredWaitHandle RegisterWaitForSingleObject(WaitHandle waitObject, WaitOrTimerCallback callBack, object state, int millisecondsTimeOutInterval, bool executeOnlyOnce)
	{
		if (millisecondsTimeOutInterval < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeOutInterval", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RegisterWaitForSingleObject(waitObject, callBack, state, (millisecondsTimeOutInterval == -1) ? uint.MaxValue : ((uint)millisecondsTimeOutInterval), executeOnlyOnce, ref stackMark, compressStack: true);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static RegisteredWaitHandle RegisterWaitForSingleObject(WaitHandle waitObject, WaitOrTimerCallback callBack, object state, TimeSpan timeout, bool executeOnlyOnce)
	{
		long num = (long)timeout.TotalMilliseconds;
		if (num < -1)
		{
			throw new ArgumentOutOfRangeException("timeout", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		if (num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("timeout", Environment.GetResourceString("Argument must be less than or equal to 2^31 - 1 milliseconds."));
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RegisterWaitForSingleObject(waitObject, callBack, state, (uint)num, executeOnlyOnce, ref stackMark, compressStack: true);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static bool QueueUserWorkItem(WaitCallback callBack, object state)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return QueueUserWorkItemHelper(callBack, state, ref stackMark, compressStack: true);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static bool QueueUserWorkItem(WaitCallback callBack)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return QueueUserWorkItemHelper(callBack, null, ref stackMark, compressStack: true);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static bool UnsafeQueueUserWorkItem(WaitCallback callBack, object state)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return QueueUserWorkItemHelper(callBack, state, ref stackMark, compressStack: false);
	}

	public static bool QueueUserWorkItem<TState>(Action<TState> callBack, TState state, bool preferLocal)
	{
		if (callBack == null)
		{
			throw new ArgumentNullException("callBack");
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return QueueUserWorkItemHelper(delegate(object x)
		{
			callBack((TState)x);
		}, state, ref stackMark, compressStack: true, !preferLocal);
	}

	private static bool QueueUserWorkItemHelper(WaitCallback callBack, object state, ref StackCrawlMark stackMark, bool compressStack, bool forceGlobal = true)
	{
		bool flag = true;
		if (callBack != null)
		{
			EnsureVMInitialized();
			try
			{
			}
			finally
			{
				QueueUserWorkItemCallback callback = new QueueUserWorkItemCallback(callBack, state, compressStack, ref stackMark);
				ThreadPoolGlobals.workQueue.Enqueue(callback, forceGlobal);
				flag = true;
			}
			return flag;
		}
		throw new ArgumentNullException("WaitCallback");
	}

	internal static void UnsafeQueueCustomWorkItem(IThreadPoolWorkItem workItem, bool forceGlobal)
	{
		EnsureVMInitialized();
		try
		{
		}
		finally
		{
			ThreadPoolGlobals.workQueue.Enqueue(workItem, forceGlobal);
		}
	}

	internal static bool TryPopCustomWorkItem(IThreadPoolWorkItem workItem)
	{
		if (!ThreadPoolGlobals.vmTpInitialized)
		{
			return false;
		}
		return ThreadPoolGlobals.workQueue.LocalFindAndPop(workItem);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool RequestWorkerThread();

	private static void EnsureVMInitialized()
	{
		if (!ThreadPoolGlobals.vmTpInitialized)
		{
			InitializeVMTp(ref ThreadPoolGlobals.enableWorkerTracking);
			ThreadPoolGlobals.vmTpInitialized = true;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetMaxThreadsNative(out int workerThreads, out int completionPortThreads);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool NotifyWorkItemComplete();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void ReportThreadStatus(bool isWorking);

	internal static void NotifyWorkItemProgress()
	{
		EnsureVMInitialized();
		NotifyWorkItemProgressNative();
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void NotifyWorkItemProgressNative();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void NotifyWorkItemQueued();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InitializeVMTp(ref bool enableWorkerTracking);
}
