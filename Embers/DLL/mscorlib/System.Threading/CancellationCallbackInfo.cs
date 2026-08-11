namespace System.Threading;

internal class CancellationCallbackInfo
{
	internal sealed class WithSyncContext : CancellationCallbackInfo
	{
		internal readonly SynchronizationContext TargetSyncContext;

		internal WithSyncContext(Action<object> callback, object stateForCallback, ExecutionContext targetExecutionContext, CancellationTokenSource cancellationTokenSource, SynchronizationContext targetSyncContext)
			: base(callback, stateForCallback, targetExecutionContext, cancellationTokenSource)
		{
			TargetSyncContext = targetSyncContext;
		}
	}

	internal readonly Action<object> Callback;

	internal readonly object StateForCallback;

	internal readonly ExecutionContext TargetExecutionContext;

	internal readonly CancellationTokenSource CancellationTokenSource;

	private static ContextCallback s_executionContextCallback;

	internal CancellationCallbackInfo(Action<object> callback, object stateForCallback, ExecutionContext targetExecutionContext, CancellationTokenSource cancellationTokenSource)
	{
		Callback = callback;
		StateForCallback = stateForCallback;
		TargetExecutionContext = targetExecutionContext;
		CancellationTokenSource = cancellationTokenSource;
	}

	internal void ExecuteCallback()
	{
		if (TargetExecutionContext != null)
		{
			ContextCallback callback = ExecutionContextCallback;
			ExecutionContext.Run(TargetExecutionContext, callback, this);
		}
		else
		{
			ExecutionContextCallback(this);
		}
	}

	private static void ExecutionContextCallback(object obj)
	{
		CancellationCallbackInfo cancellationCallbackInfo = obj as CancellationCallbackInfo;
		cancellationCallbackInfo.Callback(cancellationCallbackInfo.StateForCallback);
	}
}
