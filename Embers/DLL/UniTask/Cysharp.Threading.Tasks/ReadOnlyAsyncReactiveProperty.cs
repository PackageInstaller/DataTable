using System;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public class ReadOnlyAsyncReactiveProperty<T> : IReadOnlyAsyncReactiveProperty<T>, IUniTaskAsyncEnumerable<T>, IDisposable
{
	private sealed class WaitAsyncSource : IUniTaskSource<T>, IUniTaskSource, ITriggerHandler<T>, ITaskPoolNode<WaitAsyncSource>
	{
		private static Action<object> cancellationCallback;

		private static TaskPool<WaitAsyncSource> pool;

		private WaitAsyncSource nextNode;

		private ReadOnlyAsyncReactiveProperty<T> parent;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private UniTaskCompletionSourceCore<T> core;

		ref WaitAsyncSource ITaskPoolNode<WaitAsyncSource>.NextNode => ref nextNode;

		ITriggerHandler<T> ITriggerHandler<T>.Prev { get; set; }

		ITriggerHandler<T> ITriggerHandler<T>.Next { get; set; }

		static WaitAsyncSource()
		{
			cancellationCallback = CancellationCallback;
			TaskPool.RegisterSizeGetter(typeof(WaitAsyncSource), () => pool.Size);
		}

		private WaitAsyncSource()
		{
		}

		public static IUniTaskSource<T> Create(ReadOnlyAsyncReactiveProperty<T> parent, CancellationToken cancellationToken, out short token)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				return AutoResetUniTaskCompletionSource<T>.CreateFromCanceled(cancellationToken, out token);
			}
			if (!pool.TryPop(out var result))
			{
				result = new WaitAsyncSource();
			}
			result.parent = parent;
			result.cancellationToken = cancellationToken;
			if (cancellationToken.CanBeCanceled)
			{
				result.cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationCallback, result);
			}
			result.parent.triggerEvent.Add(result);
			token = result.core.Version;
			return result;
		}

		private bool TryReturn()
		{
			core.Reset();
			cancellationTokenRegistration.Dispose();
			cancellationTokenRegistration = default(CancellationTokenRegistration);
			parent.triggerEvent.Remove(this);
			parent = null;
			cancellationToken = default(CancellationToken);
			return pool.TryPush(this);
		}

		private static void CancellationCallback(object state)
		{
			WaitAsyncSource obj = (WaitAsyncSource)state;
			obj.OnCanceled(obj.cancellationToken);
		}

		public T GetResult(short token)
		{
			try
			{
				return core.GetResult(token);
			}
			finally
			{
				TryReturn();
			}
		}

		void IUniTaskSource.GetResult(short token)
		{
			GetResult(token);
		}

		public void OnCompleted(Action<object> continuation, object state, short token)
		{
			core.OnCompleted(continuation, state, token);
		}

		public UniTaskStatus GetStatus(short token)
		{
			return core.GetStatus(token);
		}

		public UniTaskStatus UnsafeGetStatus()
		{
			return core.UnsafeGetStatus();
		}

		public void OnCanceled(CancellationToken cancellationToken)
		{
			core.TrySetCanceled(cancellationToken);
		}

		public void OnCompleted()
		{
			core.TrySetCanceled(CancellationToken.None);
		}

		public void OnError(Exception ex)
		{
			core.TrySetException(ex);
		}

		public void OnNext(T value)
		{
			core.TrySetResult(value);
		}
	}

	private sealed class WithoutCurrentEnumerable : IUniTaskAsyncEnumerable<T>
	{
		private readonly ReadOnlyAsyncReactiveProperty<T> parent;

		public WithoutCurrentEnumerable(ReadOnlyAsyncReactiveProperty<T> parent)
		{
			this.parent = parent;
		}

		public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
		{
			return new Enumerator(parent, cancellationToken, publishCurrentValue: false);
		}
	}

	private sealed class Enumerator : MoveNextSource, IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable, ITriggerHandler<T>
	{
		private static Action<object> cancellationCallback = CancellationCallback;

		private readonly ReadOnlyAsyncReactiveProperty<T> parent;

		private readonly CancellationToken cancellationToken;

		private readonly CancellationTokenRegistration cancellationTokenRegistration;

		private T value;

		private bool isDisposed;

		private bool firstCall;

		public T Current => value;

		ITriggerHandler<T> ITriggerHandler<T>.Prev { get; set; }

		ITriggerHandler<T> ITriggerHandler<T>.Next { get; set; }

		public Enumerator(ReadOnlyAsyncReactiveProperty<T> parent, CancellationToken cancellationToken, bool publishCurrentValue)
		{
			this.parent = parent;
			this.cancellationToken = cancellationToken;
			firstCall = publishCurrentValue;
			parent.triggerEvent.Add(this);
			if (cancellationToken.CanBeCanceled)
			{
				cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationCallback, this);
			}
		}

		public UniTask<bool> MoveNextAsync()
		{
			if (firstCall)
			{
				firstCall = false;
				value = parent.Value;
				return CompletedTasks.True;
			}
			completionSource.Reset();
			return new UniTask<bool>(this, completionSource.Version);
		}

		public UniTask DisposeAsync()
		{
			if (!isDisposed)
			{
				isDisposed = true;
				completionSource.TrySetCanceled(cancellationToken);
				parent.triggerEvent.Remove(this);
			}
			return default(UniTask);
		}

		public void OnNext(T value)
		{
			this.value = value;
			completionSource.TrySetResult(result: true);
		}

		public void OnCanceled(CancellationToken cancellationToken)
		{
			DisposeAsync().Forget();
		}

		public void OnCompleted()
		{
			completionSource.TrySetResult(result: false);
		}

		public void OnError(Exception ex)
		{
			completionSource.TrySetException(ex);
		}

		private static void CancellationCallback(object state)
		{
			((Enumerator)state).DisposeAsync().Forget();
		}
	}

	private TriggerEvent<T> triggerEvent;

	private T latestValue;

	private IUniTaskAsyncEnumerator<T> enumerator;

	private static bool isValueType;

	public T Value => latestValue;

	public ReadOnlyAsyncReactiveProperty(T initialValue, IUniTaskAsyncEnumerable<T> source, CancellationToken cancellationToken)
	{
		latestValue = initialValue;
		ConsumeEnumerator(source, cancellationToken).Forget();
	}

	public ReadOnlyAsyncReactiveProperty(IUniTaskAsyncEnumerable<T> source, CancellationToken cancellationToken)
	{
		ConsumeEnumerator(source, cancellationToken).Forget();
	}

	private async UniTaskVoid ConsumeEnumerator(IUniTaskAsyncEnumerable<T> source, CancellationToken cancellationToken)
	{
		enumerator = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await enumerator.MoveNextAsync())
			{
				T result = (latestValue = enumerator.Current);
				triggerEvent.SetResult(result);
			}
		}
		finally
		{
			await enumerator.DisposeAsync();
			enumerator = null;
		}
	}

	public IUniTaskAsyncEnumerable<T> WithoutCurrent()
	{
		return new WithoutCurrentEnumerable(this);
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken)
	{
		return new Enumerator(this, cancellationToken, publishCurrentValue: true);
	}

	public void Dispose()
	{
		if (enumerator != null)
		{
			enumerator.DisposeAsync().Forget();
		}
		triggerEvent.SetCompleted();
	}

	public static implicit operator T(ReadOnlyAsyncReactiveProperty<T> value)
	{
		return value.Value;
	}

	public override string ToString()
	{
		if (isValueType)
		{
			return latestValue.ToString();
		}
		return latestValue?.ToString();
	}

	public UniTask<T> WaitAsync(CancellationToken cancellationToken = default(CancellationToken))
	{
		short token;
		return new UniTask<T>(WaitAsyncSource.Create(this, cancellationToken, out token), token);
	}

	static ReadOnlyAsyncReactiveProperty()
	{
		isValueType = typeof(T).IsValueType;
	}
}
