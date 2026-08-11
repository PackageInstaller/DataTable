using System;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public static class CancellationTokenExtensions
{
	private static readonly Action<object> cancellationTokenCallback = Callback;

	private static readonly Action<object> disposeCallback = DisposeCallback;

	public static CancellationToken ToCancellationToken(this UniTask task)
	{
		CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
		ToCancellationTokenCore(task, cancellationTokenSource).Forget();
		return cancellationTokenSource.Token;
	}

	public static CancellationToken ToCancellationToken(this UniTask task, CancellationToken linkToken)
	{
		if (linkToken.IsCancellationRequested)
		{
			return linkToken;
		}
		if (!linkToken.CanBeCanceled)
		{
			return task.ToCancellationToken();
		}
		CancellationTokenSource cancellationTokenSource = CancellationTokenSource.CreateLinkedTokenSource(linkToken);
		ToCancellationTokenCore(task, cancellationTokenSource).Forget();
		return cancellationTokenSource.Token;
	}

	public static CancellationToken ToCancellationToken<T>(this UniTask<T> task)
	{
		return task.AsUniTask().ToCancellationToken();
	}

	public static CancellationToken ToCancellationToken<T>(this UniTask<T> task, CancellationToken linkToken)
	{
		return task.AsUniTask().ToCancellationToken(linkToken);
	}

	private static async UniTaskVoid ToCancellationTokenCore(UniTask task, CancellationTokenSource cts)
	{
		try
		{
			await task;
		}
		catch (Exception ex)
		{
			UniTaskScheduler.PublishUnobservedTaskException(ex);
		}
		cts.Cancel();
		cts.Dispose();
	}

	public static (UniTask, CancellationTokenRegistration) ToUniTask(this CancellationToken cancellationToken)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return (UniTask.FromCanceled(cancellationToken), default(CancellationTokenRegistration));
		}
		UniTaskCompletionSource uniTaskCompletionSource = new UniTaskCompletionSource();
		return (uniTaskCompletionSource.Task, cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationTokenCallback, uniTaskCompletionSource));
	}

	private static void Callback(object state)
	{
		((UniTaskCompletionSource)state).TrySetResult();
	}

	public static CancellationTokenAwaitable WaitUntilCanceled(this CancellationToken cancellationToken)
	{
		return new CancellationTokenAwaitable(cancellationToken);
	}

	public static CancellationTokenRegistration RegisterWithoutCaptureExecutionContext(this CancellationToken cancellationToken, Action callback)
	{
		bool flag = false;
		if (!ExecutionContext.IsFlowSuppressed())
		{
			ExecutionContext.SuppressFlow();
			flag = true;
		}
		try
		{
			return cancellationToken.Register(callback, useSynchronizationContext: false);
		}
		finally
		{
			if (flag)
			{
				ExecutionContext.RestoreFlow();
			}
		}
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

	public static CancellationTokenRegistration AddTo(this IDisposable disposable, CancellationToken cancellationToken)
	{
		return cancellationToken.RegisterWithoutCaptureExecutionContext(disposeCallback, disposable);
	}

	private static void DisposeCallback(object state)
	{
		((IDisposable)state).Dispose();
	}
}
