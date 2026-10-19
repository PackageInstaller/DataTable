using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class ToUniTaskAsyncEnumerableObservable<T> : IUniTaskAsyncEnumerable<T>
{
	private class _ToUniTaskAsyncEnumerableObservable : MoveNextSource, IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable, IObserver<T>
	{
		private static readonly Action<object> OnCanceledDelegate = OnCanceled;

		private readonly IObservable<T> source;

		private CancellationToken cancellationToken;

		private bool useCachedCurrent;

		private T current;

		private bool subscribeCompleted;

		private readonly Queue<T> queuedResult;

		private Exception error;

		private IDisposable subscription;

		private CancellationTokenRegistration cancellationTokenRegistration;

		public T Current
		{
			get
			{
				if (useCachedCurrent)
				{
					return current;
				}
				lock (queuedResult)
				{
					if (queuedResult.Count != 0)
					{
						current = queuedResult.Dequeue();
						useCachedCurrent = true;
						return current;
					}
					return default;
				}
			}
		}

		public _ToUniTaskAsyncEnumerableObservable(IObservable<T> source, CancellationToken cancellationToken)
		{
			this.source = source;
			this.cancellationToken = cancellationToken;
			queuedResult = new Queue<T>();
			if (cancellationToken.CanBeCanceled)
			{
				cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(OnCanceledDelegate, this);
			}
		}

		public UniTask<bool> MoveNextAsync()
		{
			lock (queuedResult)
			{
				useCachedCurrent = false;
				if (cancellationToken.IsCancellationRequested)
				{
					return UniTask.FromCanceled<bool>(cancellationToken);
				}
				if (subscription == null)
				{
					subscription = source.Subscribe(this);
				}
				if (error != null)
				{
					return UniTask.FromException<bool>(error);
				}
				if (queuedResult.Count != 0)
				{
					return CompletedTasks.True;
				}
				if (subscribeCompleted)
				{
					return CompletedTasks.False;
				}
				completionSource.Reset();
				return new UniTask<bool>(this, completionSource.Version);
			}
		}

		public UniTask DisposeAsync()
		{
			subscription.Dispose();
			cancellationTokenRegistration.Dispose();
			completionSource.Reset();
			return default;
		}

		public void OnCompleted()
		{
			lock (queuedResult)
			{
				subscribeCompleted = true;
				completionSource.TrySetResult(result: false);
			}
		}

		public void OnError(Exception error)
		{
			lock (queuedResult)
			{
				this.error = error;
				completionSource.TrySetException(error);
			}
		}

		public void OnNext(T value)
		{
			lock (queuedResult)
			{
				queuedResult.Enqueue(value);
				completionSource.TrySetResult(result: true);
			}
		}

		private static void OnCanceled(object state)
		{
			_ToUniTaskAsyncEnumerableObservable toUniTaskAsyncEnumerableObservable = (_ToUniTaskAsyncEnumerableObservable)state;
			lock (toUniTaskAsyncEnumerableObservable.queuedResult)
			{
				toUniTaskAsyncEnumerableObservable.completionSource.TrySetCanceled(toUniTaskAsyncEnumerableObservable.cancellationToken);
			}
		}
	}

	private readonly IObservable<T> source;

	public ToUniTaskAsyncEnumerableObservable(IObservable<T> source)
	{
		this.source = source;
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _ToUniTaskAsyncEnumerableObservable(source, cancellationToken);
	}
}
