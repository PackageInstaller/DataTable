namespace System.Threading;

internal sealed class QueueUserWorkItemCallback : IThreadPoolWorkItem
{
	private WaitCallback callback;

	private ExecutionContext context;

	private object state;

	internal static ContextCallback ccb = WaitCallback_Context;

	internal QueueUserWorkItemCallback(WaitCallback waitCallback, object stateObj, bool compressStack, ref StackCrawlMark stackMark)
	{
		callback = waitCallback;
		state = stateObj;
		if (compressStack && !ExecutionContext.IsFlowSuppressed())
		{
			context = ExecutionContext.Capture(ref stackMark, ExecutionContext.CaptureOptions.IgnoreSyncCtx | ExecutionContext.CaptureOptions.OptimizeDefaultCase);
		}
	}

	void IThreadPoolWorkItem.ExecuteWorkItem()
	{
		if (context == null)
		{
			WaitCallback waitCallback = callback;
			callback = null;
			waitCallback(state);
		}
		else
		{
			ExecutionContext.Run(context, ccb, this, preserveSyncCtx: true);
		}
	}

	void IThreadPoolWorkItem.MarkAborted(ThreadAbortException tae)
	{
	}

	private static void WaitCallback_Context(object state)
	{
		QueueUserWorkItemCallback queueUserWorkItemCallback = (QueueUserWorkItemCallback)state;
		queueUserWorkItemCallback.callback(queueUserWorkItemCallback.state);
	}
}
