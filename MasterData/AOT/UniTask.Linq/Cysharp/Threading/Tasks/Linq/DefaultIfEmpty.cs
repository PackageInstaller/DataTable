using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class DefaultIfEmpty<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _DefaultIfEmpty : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private enum IteratingState : byte
		{
			Empty,
			Iterating,
			Completed
		}

		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly TSource defaultValue;

		private CancellationToken cancellationToken;

		private IteratingState iteratingState;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		public TSource Current { get; private set; }

		public _DefaultIfEmpty(IUniTaskAsyncEnumerable<TSource> source, TSource defaultValue, CancellationToken cancellationToken)
		{
			this.source = source;
			this.defaultValue = defaultValue;
			this.cancellationToken = cancellationToken;
			iteratingState = IteratingState.Empty;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			completionSource.Reset();
			if (iteratingState == IteratingState.Completed)
			{
				return CompletedTasks.False;
			}
			if (enumerator == null)
			{
				enumerator = source.GetAsyncEnumerator(cancellationToken);
			}
			awaiter = enumerator.MoveNextAsync().GetAwaiter();
			if (awaiter.IsCompleted)
			{
				MoveNextCore(this);
			}
			else
			{
				awaiter.SourceOnCompleted(MoveNextCoreDelegate, this);
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void MoveNextCore(object state)
		{
			_DefaultIfEmpty defaultIfEmpty = (_DefaultIfEmpty)state;
			if (defaultIfEmpty.TryGetResult(defaultIfEmpty.awaiter, out var result))
			{
				if (result)
				{
					defaultIfEmpty.iteratingState = IteratingState.Iterating;
					defaultIfEmpty.Current = defaultIfEmpty.enumerator.Current;
					defaultIfEmpty.completionSource.TrySetResult(result: true);
				}
				else if (defaultIfEmpty.iteratingState == IteratingState.Empty)
				{
					defaultIfEmpty.iteratingState = IteratingState.Completed;
					defaultIfEmpty.Current = defaultIfEmpty.defaultValue;
					defaultIfEmpty.completionSource.TrySetResult(result: true);
				}
				else
				{
					defaultIfEmpty.completionSource.TrySetResult(result: false);
				}
			}
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

	private readonly TSource defaultValue;

	public DefaultIfEmpty(IUniTaskAsyncEnumerable<TSource> source, TSource defaultValue)
	{
		this.source = source;
		this.defaultValue = defaultValue;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _DefaultIfEmpty(source, defaultValue, cancellationToken);
	}
}
