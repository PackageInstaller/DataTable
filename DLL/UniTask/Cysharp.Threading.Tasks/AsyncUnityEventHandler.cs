using System;
using System.Threading;
using UnityEngine.Events;

namespace Cysharp.Threading.Tasks;

public class AsyncUnityEventHandler : IUniTaskSource, IDisposable, IAsyncClickEventHandler
{
	private static Action<object> cancellationCallback = CancellationCallback;

	private readonly UnityAction action;

	private readonly UnityEvent unityEvent;

	private CancellationToken cancellationToken;

	private CancellationTokenRegistration registration;

	private bool isDisposed;

	private bool callOnce;

	private UniTaskCompletionSourceCore<AsyncUnit> core;

	public AsyncUnityEventHandler(UnityEvent unityEvent, CancellationToken cancellationToken, bool callOnce)
	{
		this.cancellationToken = cancellationToken;
		if (cancellationToken.IsCancellationRequested)
		{
			isDisposed = true;
			return;
		}
		action = Invoke;
		this.unityEvent = unityEvent;
		this.callOnce = callOnce;
		unityEvent.AddListener(action);
		if (cancellationToken.CanBeCanceled)
		{
			registration = cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationCallback, this);
		}
	}

	public UniTask OnInvokeAsync()
	{
		core.Reset();
		if (isDisposed)
		{
			core.TrySetCanceled(cancellationToken);
		}
		return new UniTask(this, core.Version);
	}

	private void Invoke()
	{
		core.TrySetResult(AsyncUnit.Default);
	}

	private static void CancellationCallback(object state)
	{
		((AsyncUnityEventHandler)state).Dispose();
	}

	public void Dispose()
	{
		if (!isDisposed)
		{
			isDisposed = true;
			registration.Dispose();
			if (unityEvent != null)
			{
				unityEvent.RemoveListener(action);
			}
			core.TrySetCanceled(cancellationToken);
		}
	}

	UniTask IAsyncClickEventHandler.OnClickAsync()
	{
		return OnInvokeAsync();
	}

	void IUniTaskSource.GetResult(short token)
	{
		try
		{
			core.GetResult(token);
		}
		finally
		{
			if (callOnce)
			{
				Dispose();
			}
		}
	}

	UniTaskStatus IUniTaskSource.GetStatus(short token)
	{
		return core.GetStatus(token);
	}

	UniTaskStatus IUniTaskSource.UnsafeGetStatus()
	{
		return core.UnsafeGetStatus();
	}

	void IUniTaskSource.OnCompleted(Action<object> continuation, object state, short token)
	{
		core.OnCompleted(continuation, state, token);
	}
}
public class AsyncUnityEventHandler<T> : IUniTaskSource<T>, IUniTaskSource, IDisposable, IAsyncValueChangedEventHandler<T>, IAsyncEndEditEventHandler<T>, IAsyncEndTextSelectionEventHandler<T>, IAsyncTextSelectionEventHandler<T>, IAsyncDeselectEventHandler<T>, IAsyncSelectEventHandler<T>, IAsyncSubmitEventHandler<T>
{
	private static Action<object> cancellationCallback = CancellationCallback;

	private readonly UnityAction<T> action;

	private readonly UnityEvent<T> unityEvent;

	private CancellationToken cancellationToken;

	private CancellationTokenRegistration registration;

	private bool isDisposed;

	private bool callOnce;

	private UniTaskCompletionSourceCore<T> core;

	public AsyncUnityEventHandler(UnityEvent<T> unityEvent, CancellationToken cancellationToken, bool callOnce)
	{
		this.cancellationToken = cancellationToken;
		if (cancellationToken.IsCancellationRequested)
		{
			isDisposed = true;
			return;
		}
		action = Invoke;
		this.unityEvent = unityEvent;
		this.callOnce = callOnce;
		unityEvent.AddListener(action);
		if (cancellationToken.CanBeCanceled)
		{
			registration = cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationCallback, this);
		}
	}

	public UniTask<T> OnInvokeAsync()
	{
		core.Reset();
		if (isDisposed)
		{
			core.TrySetCanceled(cancellationToken);
		}
		return new UniTask<T>(this, core.Version);
	}

	private void Invoke(T result)
	{
		core.TrySetResult(result);
	}

	private static void CancellationCallback(object state)
	{
		((AsyncUnityEventHandler<T>)state).Dispose();
	}

	public void Dispose()
	{
		if (isDisposed)
		{
			return;
		}
		isDisposed = true;
		registration.Dispose();
		if (unityEvent != null)
		{
			if (unityEvent is IDisposable disposable)
			{
				disposable.Dispose();
			}
			unityEvent.RemoveListener(action);
		}
		core.TrySetCanceled();
	}

	UniTask<T> IAsyncValueChangedEventHandler<T>.OnValueChangedAsync()
	{
		return OnInvokeAsync();
	}

	UniTask<T> IAsyncEndEditEventHandler<T>.OnEndEditAsync()
	{
		return OnInvokeAsync();
	}

	UniTask<T> IAsyncEndTextSelectionEventHandler<T>.OnEndTextSelectionAsync()
	{
		return OnInvokeAsync();
	}

	UniTask<T> IAsyncTextSelectionEventHandler<T>.OnTextSelectionAsync()
	{
		return OnInvokeAsync();
	}

	UniTask<T> IAsyncDeselectEventHandler<T>.OnDeselectAsync()
	{
		return OnInvokeAsync();
	}

	UniTask<T> IAsyncSelectEventHandler<T>.OnSelectAsync()
	{
		return OnInvokeAsync();
	}

	UniTask<T> IAsyncSubmitEventHandler<T>.OnSubmitAsync()
	{
		return OnInvokeAsync();
	}

	T IUniTaskSource<T>.GetResult(short token)
	{
		try
		{
			return core.GetResult(token);
		}
		finally
		{
			if (callOnce)
			{
				Dispose();
			}
		}
	}

	void IUniTaskSource.GetResult(short token)
	{
		((IUniTaskSource<T>)this).GetResult(token);
	}

	UniTaskStatus IUniTaskSource.GetStatus(short token)
	{
		return core.GetStatus(token);
	}

	UniTaskStatus IUniTaskSource.UnsafeGetStatus()
	{
		return core.UnsafeGetStatus();
	}

	void IUniTaskSource.OnCompleted(Action<object> continuation, object state, short token)
	{
		core.OnCompleted(continuation, state, token);
	}
}
