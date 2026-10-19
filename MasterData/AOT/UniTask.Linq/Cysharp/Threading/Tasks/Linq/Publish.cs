using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Publish<TSource> : IConnectableUniTaskAsyncEnumerable<TSource>, IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _Publish : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable, ITriggerHandler<TSource>
	{
		private static readonly Action<object> CancelDelegate = OnCanceled;

		private readonly Publish<TSource> parent;

		private CancellationToken cancellationToken;

		private CancellationTokenRegistration cancellationTokenRegistration;

		private bool isDisposed;

		public TSource Current { get; private set; }

		ITriggerHandler<TSource> ITriggerHandler<TSource>.Prev { get; set; }

		ITriggerHandler<TSource> ITriggerHandler<TSource>.Next { get; set; }

		public _Publish(Publish<TSource> parent, CancellationToken cancellationToken)
		{
			if (!cancellationToken.IsCancellationRequested)
			{
				this.parent = parent;
				this.cancellationToken = cancellationToken;
				if (cancellationToken.CanBeCanceled)
				{
					cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext(CancelDelegate, this);
				}
				parent.trigger.Add(this);
			}
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (parent.isCompleted)
			{
				return CompletedTasks.False;
			}
			completionSource.Reset();
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void OnCanceled(object state)
		{
			_Publish publish = (_Publish)state;
			publish.completionSource.TrySetCanceled(publish.cancellationToken);
			publish.DisposeAsync().Forget();
		}

		public UniTask DisposeAsync()
		{
			if (!isDisposed)
			{
				isDisposed = true;
				cancellationTokenRegistration.Dispose();
				parent.trigger.Remove(this);
			}
			return default;
		}

		public void OnNext(TSource value)
		{
			Current = value;
			completionSource.TrySetResult(result: true);
		}

		public void OnCompleted()
		{
			completionSource.TrySetResult(result: false);
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly CancellationTokenSource cancellationTokenSource;

	private TriggerEvent<TSource> trigger;

	private bool isCompleted;

	public Publish(IUniTaskAsyncEnumerable<TSource> source)
	{
		this.source = source;
		cancellationTokenSource = new CancellationTokenSource();
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Publish(this, cancellationToken);
	}
}
