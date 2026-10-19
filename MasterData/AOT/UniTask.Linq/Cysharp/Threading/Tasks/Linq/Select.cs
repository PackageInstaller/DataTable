using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Select<TSource, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _Select : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, TResult> selector;

		private readonly CancellationToken cancellationToken;

		private int state = -1;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private Action moveNextAction;

		public TResult Current { get; private set; }

		public _Select(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TResult> selector, CancellationToken cancellationToken)
		{
			this.source = source;
			this.selector = selector;
			this.cancellationToken = cancellationToken;
			moveNextAction = MoveNext;
		}

		public UniTask<bool> MoveNextAsync()
		{
			if (state == -2)
			{
				return default;
			}
			completionSource.Reset();
			MoveNext();
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void MoveNext()
		{
			try
			{
				switch (state)
				{
				default:
					goto end_IL_0000;
				case -1:
					enumerator = source.GetAsyncEnumerator(cancellationToken);
					goto case 0;
				case 0:
					awaiter = enumerator.MoveNextAsync().GetAwaiter();
					if (!awaiter.IsCompleted)
					{
						state = 1;
						awaiter.UnsafeOnCompleted(moveNextAction);
						return;
					}
					break;
				case 1:
					break;
				}
				if (awaiter.GetResult())
				{
					Current = selector(enumerator.Current);
					goto IL_00d2;
				}
				end_IL_0000:;
			}
			catch (Exception error)
			{
				state = -2;
				completionSource.TrySetException(error);
				return;
			}
			state = -2;
			completionSource.TrySetResult(result: false);
			return;
			IL_00d2:
			state = 0;
			completionSource.TrySetResult(result: true);
		}

		public UniTask DisposeAsync()
		{
			return enumerator.DisposeAsync();
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, TResult> selector;

	public Select(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TResult> selector)
	{
		this.source = source;
		this.selector = selector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Select(source, selector, cancellationToken);
	}
}
