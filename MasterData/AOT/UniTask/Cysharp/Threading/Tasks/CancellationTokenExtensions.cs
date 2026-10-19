using System;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public static class CancellationTokenExtensions
{
	private static readonly Action<object> cancellationTokenCallback = Callback;

	private static readonly Action<object> disposeCallback = DisposeCallback;

	private static void Callback(object state)
	{
		((UniTaskCompletionSource)state).TrySetResult();
	}

	public static CancellationTokenRegistration RegisterWithoutCaptureExecutionContext(this CancellationToken cancellationToken, Action<object> callback, object state)
	{
		bool flag = false;
		if (!ExecutionContext.IsFlowSuppressed())
		{
			ExecutionContext.SuppressFlow();
			flag = true;
		}
		try
		{
			return cancellationToken.Register(callback, state, useSynchronizationContext: false);
		}
		finally
		{
			if (flag)
			{
				ExecutionContext.RestoreFlow();
			}
		}
	}

	private static void DisposeCallback(object state)
	{
		((IDisposable)state).Dispose();
	}
}
