using System;
using System.Threading;
using UnityEngine.Events;

namespace Cysharp.Threading.Tasks;

public class UnityEventHandlerAsyncEnumerable : IUniTaskAsyncEnumerable<AsyncUnit>
{
	private class UnityEventHandlerAsyncEnumerator : MoveNextSource, IUniTaskAsyncEnumerator<AsyncUnit>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> cancel1 = OnCanceled1;

		private static readonly Action<object> cancel2 = OnCanceled2;

		private readonly UnityEvent unityEvent;

		private CancellationToken cancellationToken1;

		private CancellationToken cancellationToken2;

		private UnityAction unityAction;

		private CancellationTokenRegistration registration1;

		private CancellationTokenRegistration registration2;

		private bool isDisposed;

		public AsyncUnit Current => default(AsyncUnit);

		public UnityEventHandlerAsyncEnumerator(UnityEvent unityEvent, CancellationToken cancellationToken1, CancellationToken cancellationToken2)
		{
			this.unityEvent = unityEvent;
			this.cancellationToken1 = cancellationToken1;
			this.cancellationToken2 = cancellationToken2;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken1.ThrowIfCancellationRequested();
			cancellationToken2.ThrowIfCancellationRequested();
			completionSource.Reset();
			if (unityAction == null)
			{
				unityAction = Invoke;
				unityEvent.AddListener(unityAction);
				if (cancellationToken1.CanBeCanceled)
				{
					registration1 = cancellationToken1.RegisterWithoutCaptureExecutionContext(cancel1, this);
				}
				if (cancellationToken2.CanBeCanceled)
				{
					registration2 = cancellationToken2.RegisterWithoutCaptureExecutionContext(cancel2, this);
				}
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void Invoke()
		{
			completionSource.TrySetResult(result: true);
		}

		private static void OnCanceled1(object state)
		{
			UnityEventHandlerAsyncEnumerator unityEventHandlerAsyncEnumerator = (UnityEventHandlerAsyncEnumerator)state;
			try
			{
				unityEventHandlerAsyncEnumerator.completionSource.TrySetCanceled(unityEventHandlerAsyncEnumerator.cancellationToken1);
			}
			finally
			{
				unityEventHandlerAsyncEnumerator.DisposeAsync().Forget();
			}
		}

		private static void OnCanceled2(object state)
		{
			UnityEventHandlerAsyncEnumerator unityEventHandlerAsyncEnumerator = (UnityEventHandlerAsyncEnumerator)state;
			try
			{
				unityEventHandlerAsyncEnumerator.completionSource.TrySetCanceled(unityEventHandlerAsyncEnumerator.cancellationToken2);
			}
			finally
			{
				unityEventHandlerAsyncEnumerator.DisposeAsync().Forget();
			}
		}

		public UniTask DisposeAsync()
		{
			if (!isDisposed)
			{
				isDisposed = true;
				registration1.Dispose();
				registration2.Dispose();
				unityEvent.RemoveListener(unityAction);
				completionSource.TrySetCanceled();
			}
			return default(UniTask);
		}
	}

	private readonly UnityEvent unityEvent;

	private readonly CancellationToken cancellationToken1;

	public UnityEventHandlerAsyncEnumerable(UnityEvent unityEvent, CancellationToken cancellationToken)
	{
		this.unityEvent = unityEvent;
		cancellationToken1 = cancellationToken;
	}

	public IUniTaskAsyncEnumerator<AsyncUnit> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (cancellationToken1 == cancellationToken)
		{
			return new UnityEventHandlerAsyncEnumerator(unityEvent, cancellationToken1, CancellationToken.None);
		}
		return new UnityEventHandlerAsyncEnumerator(unityEvent, cancellationToken1, cancellationToken);
	}
}
public class UnityEventHandlerAsyncEnumerable<T> : IUniTaskAsyncEnumerable<T>
{
	private class UnityEventHandlerAsyncEnumerator : MoveNextSource, IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> cancel1 = OnCanceled1;

		private static readonly Action<object> cancel2 = OnCanceled2;

		private readonly UnityEvent<T> unityEvent;

		private CancellationToken cancellationToken1;

		private CancellationToken cancellationToken2;

		private UnityAction<T> unityAction;

		private CancellationTokenRegistration registration1;

		private CancellationTokenRegistration registration2;

		private bool isDisposed;

		public T Current { get; private set; }

		public UnityEventHandlerAsyncEnumerator(UnityEvent<T> unityEvent, CancellationToken cancellationToken1, CancellationToken cancellationToken2)
		{
			this.unityEvent = unityEvent;
			this.cancellationToken1 = cancellationToken1;
			this.cancellationToken2 = cancellationToken2;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken1.ThrowIfCancellationRequested();
			cancellationToken2.ThrowIfCancellationRequested();
			completionSource.Reset();
			if (unityAction == null)
			{
				unityAction = Invoke;
				unityEvent.AddListener(unityAction);
				if (cancellationToken1.CanBeCanceled)
				{
					registration1 = cancellationToken1.RegisterWithoutCaptureExecutionContext(cancel1, this);
				}
				if (cancellationToken2.CanBeCanceled)
				{
					registration2 = cancellationToken2.RegisterWithoutCaptureExecutionContext(cancel2, this);
				}
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void Invoke(T value)
		{
			Current = value;
			completionSource.TrySetResult(result: true);
		}

		private static void OnCanceled1(object state)
		{
			UnityEventHandlerAsyncEnumerator unityEventHandlerAsyncEnumerator = (UnityEventHandlerAsyncEnumerator)state;
			try
			{
				unityEventHandlerAsyncEnumerator.completionSource.TrySetCanceled(unityEventHandlerAsyncEnumerator.cancellationToken1);
			}
			finally
			{
				unityEventHandlerAsyncEnumerator.DisposeAsync().Forget();
			}
		}

		private static void OnCanceled2(object state)
		{
			UnityEventHandlerAsyncEnumerator unityEventHandlerAsyncEnumerator = (UnityEventHandlerAsyncEnumerator)state;
			try
			{
				unityEventHandlerAsyncEnumerator.completionSource.TrySetCanceled(unityEventHandlerAsyncEnumerator.cancellationToken2);
			}
			finally
			{
				unityEventHandlerAsyncEnumerator.DisposeAsync().Forget();
			}
		}

		public UniTask DisposeAsync()
		{
			if (!isDisposed)
			{
				isDisposed = true;
				registration1.Dispose();
				registration2.Dispose();
				if (unityEvent is IDisposable disposable)
				{
					disposable.Dispose();
				}
				unityEvent.RemoveListener(unityAction);
				completionSource.TrySetCanceled();
			}
			return default(UniTask);
		}
	}

	private readonly UnityEvent<T> unityEvent;

	private readonly CancellationToken cancellationToken1;

	public UnityEventHandlerAsyncEnumerable(UnityEvent<T> unityEvent, CancellationToken cancellationToken)
	{
		this.unityEvent = unityEvent;
		cancellationToken1 = cancellationToken;
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (cancellationToken1 == cancellationToken)
		{
			return new UnityEventHandlerAsyncEnumerator(unityEvent, cancellationToken1, CancellationToken.None);
		}
		return new UnityEventHandlerAsyncEnumerator(unityEvent, cancellationToken1, cancellationToken);
	}
}
