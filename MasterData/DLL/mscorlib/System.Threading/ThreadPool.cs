using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;

namespace System.Threading;

public static class ThreadPool
{
	internal static bool IsThreadPoolThread => Thread.CurrentThread.IsThreadPoolThread;

	public static bool SetMaxThreads(int workerThreads, int completionPortThreads)
	{
		return SetMaxThreadsNative(workerThreads, completionPortThreads);
	}

	public static void GetMaxThreads(out int workerThreads, out int completionPortThreads)
	{
		GetMaxThreadsNative(out workerThreads, out completionPortThreads);
	}

	public static bool SetMinThreads(int workerThreads, int completionPortThreads)
	{
		return SetMinThreadsNative(workerThreads, completionPortThreads);
	}

	public static void GetMinThreads(out int workerThreads, out int completionPortThreads)
	{
		GetMinThreadsNative(out workerThreads, out completionPortThreads);
	}

	public static void GetAvailableThreads(out int workerThreads, out int completionPortThreads)
	{
		GetAvailableThreadsNative(out workerThreads, out completionPortThreads);
	}

	[MethodImpl((MethodImplOptions)8)]
	[CLSCompliant(false)]
	public static RegisteredWaitHandle RegisterWaitForSingleObject(WaitHandle waitObject, WaitOrTimerCallback callBack, object state, uint millisecondsTimeOutInterval, bool executeOnlyOnce)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RegisterWaitForSingleObject(waitObject, callBack, state, millisecondsTimeOutInterval, executeOnlyOnce, ref stackMark, compressStack: true);
	}

	[MethodImpl((MethodImplOptions)8)]
	[CLSCompliant(false)]
	public static RegisteredWaitHandle UnsafeRegisterWaitForSingleObject(WaitHandle waitObject, WaitOrTimerCallback callBack, object state, uint millisecondsTimeOutInterval, bool executeOnlyOnce)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RegisterWaitForSingleObject(waitObject, callBack, state, millisecondsTimeOutInterval, executeOnlyOnce, ref stackMark, compressStack: false);
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
	public static RegisteredWaitHandle UnsafeRegisterWaitForSingleObject(WaitHandle waitObject, WaitOrTimerCallback callBack, object state, int millisecondsTimeOutInterval, bool executeOnlyOnce)
	{
		if (millisecondsTimeOutInterval < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeOutInterval", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RegisterWaitForSingleObject(waitObject, callBack, state, (millisecondsTimeOutInterval == -1) ? uint.MaxValue : ((uint)millisecondsTimeOutInterval), executeOnlyOnce, ref stackMark, compressStack: false);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static RegisteredWaitHandle RegisterWaitForSingleObject(WaitHandle waitObject, WaitOrTimerCallback callBack, object state, long millisecondsTimeOutInterval, bool executeOnlyOnce)
	{
		if (millisecondsTimeOutInterval < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeOutInterval", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RegisterWaitForSingleObject(waitObject, callBack, state, (uint)((millisecondsTimeOutInterval == -1) ? uint.MaxValue : millisecondsTimeOutInterval), executeOnlyOnce, ref stackMark, compressStack: true);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static RegisteredWaitHandle UnsafeRegisterWaitForSingleObject(WaitHandle waitObject, WaitOrTimerCallback callBack, object state, long millisecondsTimeOutInterval, bool executeOnlyOnce)
	{
		if (millisecondsTimeOutInterval < -1)
		{
			throw new ArgumentOutOfRangeException("millisecondsTimeOutInterval", Environment.GetResourceString("Number must be either non-negative and less than or equal to Int32.MaxValue or -1."));
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return RegisterWaitForSingleObject(waitObject, callBack, state, (uint)((millisecondsTimeOutInterval == -1) ? uint.MaxValue : millisecondsTimeOutInterval), executeOnlyOnce, ref stackMark, compressStack: false);
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
	public static RegisteredWaitHandle UnsafeRegisterWaitForSingleObject(WaitHandle waitObject, WaitOrTimerCallback callBack, object state, TimeSpan timeout, bool executeOnlyOnce)
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
		return RegisterWaitForSingleObject(waitObject, callBack, state, (uint)num, executeOnlyOnce, ref stackMark, compressStack: false);
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

	public static bool UnsafeQueueUserWorkItem<TState>(Action<TState> callBack, TState state, bool preferLocal)
	{
		if (callBack == null)
		{
			throw new ArgumentNullException("callBack");
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return QueueUserWorkItemHelper(delegate(object x)
		{
			callBack((TState)x);
		}, state, ref stackMark, compressStack: false, !preferLocal);
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

	internal static IEnumerable<IThreadPoolWorkItem> GetQueuedWorkItems()
	{
		return EnumerateQueuedWorkItems(ThreadPoolWorkQueue.allThreadQueues.Current, ThreadPoolGlobals.workQueue.queueTail);
	}

	internal static IEnumerable<IThreadPoolWorkItem> EnumerateQueuedWorkItems(ThreadPoolWorkQueue.WorkStealingQueue[] wsQueues, ThreadPoolWorkQueue.QueueSegment globalQueueTail)
	{
		if (wsQueues != null)
		{
			foreach (ThreadPoolWorkQueue.WorkStealingQueue workStealingQueue in wsQueues)
			{
				if (workStealingQueue == null || workStealingQueue.m_array == null)
				{
					continue;
				}
				IThreadPoolWorkItem[] items = workStealingQueue.m_array;
				foreach (IThreadPoolWorkItem threadPoolWorkItem in items)
				{
					if (threadPoolWorkItem != null)
					{
						yield return threadPoolWorkItem;
					}
				}
			}
		}
		if (globalQueueTail == null)
		{
			yield break;
		}
		for (ThreadPoolWorkQueue.QueueSegment segment = globalQueueTail; segment != null; segment = segment.Next)
		{
			IThreadPoolWorkItem[] items = segment.nodes;
			foreach (IThreadPoolWorkItem threadPoolWorkItem2 in items)
			{
				if (threadPoolWorkItem2 != null)
				{
					yield return threadPoolWorkItem2;
				}
			}
		}
	}

	internal static IEnumerable<IThreadPoolWorkItem> GetLocallyQueuedWorkItems()
	{
		return EnumerateQueuedWorkItems(new ThreadPoolWorkQueue.WorkStealingQueue[1] { ThreadPoolWorkQueueThreadLocals.threadLocals.workStealingQueue }, null);
	}

	internal static IEnumerable<IThreadPoolWorkItem> GetGloballyQueuedWorkItems()
	{
		return EnumerateQueuedWorkItems(null, ThreadPoolGlobals.workQueue.queueTail);
	}

	private static object[] ToObjectArray(IEnumerable<IThreadPoolWorkItem> workitems)
	{
		int num = 0;
		foreach (IThreadPoolWorkItem workitem in workitems)
		{
			_ = workitem;
			num++;
		}
		object[] array = new object[num];
		num = 0;
		foreach (IThreadPoolWorkItem workitem2 in workitems)
		{
			if (num < array.Length)
			{
				array[num] = workitem2;
			}
			num++;
		}
		return array;
	}

	internal static object[] GetQueuedWorkItemsForDebugger()
	{
		return ToObjectArray(GetQueuedWorkItems());
	}

	internal static object[] GetGloballyQueuedWorkItemsForDebugger()
	{
		return ToObjectArray(GetGloballyQueuedWorkItems());
	}

	internal static object[] GetLocallyQueuedWorkItemsForDebugger()
	{
		return ToObjectArray(GetLocallyQueuedWorkItems());
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool RequestWorkerThread();

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern bool PostQueuedCompletionStatus(NativeOverlapped* overlapped);

	[CLSCompliant(false)]
	public unsafe static bool UnsafeQueueNativeOverlapped(NativeOverlapped* overlapped)
	{
		throw new NotImplementedException("");
	}

	private static void EnsureVMInitialized()
	{
		if (!ThreadPoolGlobals.vmTpInitialized)
		{
			InitializeVMTp(ref ThreadPoolGlobals.enableWorkerTracking);
			ThreadPoolGlobals.vmTpInitialized = true;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool SetMinThreadsNative(int workerThreads, int completionPortThreads);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool SetMaxThreadsNative(int workerThreads, int completionPortThreads);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetMinThreadsNative(out int workerThreads, out int completionPortThreads);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetMaxThreadsNative(out int workerThreads, out int completionPortThreads);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetAvailableThreadsNative(out int workerThreads, out int completionPortThreads);

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

	internal static bool IsThreadPoolHosted()
	{
		return false;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InitializeVMTp(ref bool enableWorkerTracking);

	[Obsolete("ThreadPool.BindHandle(IntPtr) has been deprecated.  Please use ThreadPool.BindHandle(SafeHandle) instead.", false)]
	public static bool BindHandle(IntPtr osHandle)
	{
		return BindIOCompletionCallbackNative(osHandle);
	}

	public static bool BindHandle(SafeHandle osHandle)
	{
		if (osHandle == null)
		{
			throw new ArgumentNullException("osHandle");
		}
		bool flag = false;
		bool success = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			osHandle.DangerousAddRef(ref success);
			return BindIOCompletionCallbackNative(osHandle.DangerousGetHandle());
		}
		finally
		{
			if (success)
			{
				osHandle.DangerousRelease();
			}
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	private static bool BindIOCompletionCallbackNative(IntPtr fileHandle)
	{
		return true;
	}
}
