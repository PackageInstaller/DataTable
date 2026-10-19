using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Concat<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _Concat : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private enum IteratingState
		{
			IteratingFirst,
			IteratingSecond,
			Complete
		}

		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> first;

		private readonly IUniTaskAsyncEnumerable<TSource> second;

		private CancellationToken cancellationToken;

		private IteratingState iteratingState;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		public TSource Current { get; private set; }

		public _Concat(IUniTaskAsyncEnumerable<TSource> first, IUniTaskAsyncEnumerable<TSource> second, CancellationToken cancellationToken)
		{
			this.first = first;
			this.second = second;
			this.cancellationToken = cancellationToken;
			iteratingState = IteratingState.IteratingFirst;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (iteratingState == IteratingState.Complete)
			{
				return CompletedTasks.False;
			}
			completionSource.Reset();
			StartIterate();
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void StartIterate()
		{
			if (enumerator == null)
			{
				if (iteratingState == IteratingState.IteratingFirst)
				{
					enumerator = first.GetAsyncEnumerator(cancellationToken);
				}
				else if (iteratingState == IteratingState.IteratingSecond)
				{
					enumerator = second.GetAsyncEnumerator(cancellationToken);
				}
			}
			try
			{
				awaiter = enumerator.MoveNextAsync().GetAwaiter();
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				return;
			}
			if (awaiter.IsCompleted)
			{
				MoveNextCoreDelegate(this);
			}
			else
			{
				awaiter.SourceOnCompleted(MoveNextCoreDelegate, this);
			}
		}

		private static void MoveNextCore(object state)
		{
			_Concat concat = (_Concat)state;
			if (concat.TryGetResult(concat.awaiter, out var result))
			{
				if (result)
				{
					concat.Current = concat.enumerator.Current;
					concat.completionSource.TrySetResult(result: true);
				}
				else if (concat.iteratingState == IteratingState.IteratingFirst)
				{
					concat.RunSecondAfterDisposeAsync().Forget();
				}
				else
				{
					concat.iteratingState = IteratingState.Complete;
					concat.completionSource.TrySetResult(result: false);
				}
			}
		}

		private async UniTaskVoid RunSecondAfterDisposeAsync()
		{
			try
			{
				await enumerator.DisposeAsync();
				enumerator = null;
				awaiter = default;
				iteratingState = IteratingState.IteratingSecond;
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
			}
			StartIterate();
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

	private readonly IUniTaskAsyncEnumerable<TSource> first;

	private readonly IUniTaskAsyncEnumerable<TSource> second;

	public Concat(IUniTaskAsyncEnumerable<TSource> first, IUniTaskAsyncEnumerable<TSource> second)
	{
		this.first = first;
		this.second = second;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Concat(first, second, cancellationToken);
	}
}
