using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Do<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _Do : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Action<TSource> onNext;

		private readonly Action<Exception> onError;

		private readonly Action onCompleted;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		public TSource Current { get; private set; }

		public _Do(IUniTaskAsyncEnumerable<TSource> source, Action<TSource> onNext, Action<Exception> onError, Action onCompleted, CancellationToken cancellationToken)
		{
			this.source = source;
			this.onNext = onNext;
			this.onError = onError;
			this.onCompleted = onCompleted;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			completionSource.Reset();
			bool flag = false;
			try
			{
				if (enumerator == null)
				{
					enumerator = source.GetAsyncEnumerator(cancellationToken);
				}
				awaiter = enumerator.MoveNextAsync().GetAwaiter();
				flag = awaiter.IsCompleted;
			}
			catch (Exception ex)
			{
				CallTrySetExceptionAfterNotification(ex);
				return new UniTask<bool>(this, completionSource.Version);
			}
			if (flag)
			{
				MoveNextCore(this);
			}
			else
			{
				awaiter.SourceOnCompleted(MoveNextCoreDelegate, this);
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void CallTrySetExceptionAfterNotification(Exception ex)
		{
			if (onError != null)
			{
				try
				{
					onError(ex);
				}
				catch (Exception error)
				{
					completionSource.TrySetException(error);
					return;
				}
			}
			completionSource.TrySetException(ex);
		}

		private bool TryGetResultWithNotification<T>(UniTask<T>.Awaiter awaiter, out T result)
		{
			try
			{
				result = awaiter.GetResult();
				return true;
			}
			catch (Exception ex)
			{
				CallTrySetExceptionAfterNotification(ex);
				result = default;
				return false;
			}
		}

		private static void MoveNextCore(object state)
		{
			_Do obj = (_Do)state;
			if (!obj.TryGetResultWithNotification(obj.awaiter, out var result))
			{
				return;
			}
			if (result)
			{
				TSource current = obj.enumerator.Current;
				if (obj.onNext != null)
				{
					try
					{
						obj.onNext(current);
					}
					catch (Exception ex)
					{
						obj.CallTrySetExceptionAfterNotification(ex);
					}
				}
				obj.Current = current;
				obj.completionSource.TrySetResult(result: true);
				return;
			}
			if (obj.onCompleted != null)
			{
				try
				{
					obj.onCompleted();
				}
				catch (Exception ex2)
				{
					obj.CallTrySetExceptionAfterNotification(ex2);
					return;
				}
			}
			obj.completionSource.TrySetResult(result: false);
		}

		public UniTask DisposeAsync()
		{
			if (enumerator != null)
			{
				return enumerator.DisposeAsync();
			}
			return default;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Action<TSource> onNext;

	private readonly Action<Exception> onError;

	private readonly Action onCompleted;

	public Do(IUniTaskAsyncEnumerable<TSource> source, Action<TSource> onNext, Action<Exception> onError, Action onCompleted)
	{
		this.source = source;
		this.onNext = onNext;
		this.onError = onError;
		this.onCompleted = onCompleted;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Do(source, onNext, onError, onCompleted, cancellationToken);
	}
}
