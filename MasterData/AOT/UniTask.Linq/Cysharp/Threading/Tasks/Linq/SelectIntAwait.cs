using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SelectIntAwait<TSource, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _SelectAwait : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, int, UniTask<TResult>> selector;

		private readonly CancellationToken cancellationToken;

		private int state = -1;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private UniTask<TResult>.Awaiter awaiter2;

		private Action moveNextAction;

		private int index;

		public TResult Current { get; private set; }

		public _SelectAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, UniTask<TResult>> selector, CancellationToken cancellationToken)
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
					goto case 1;
				case 1:
					if (awaiter.GetResult())
					{
						awaiter2 = selector(enumerator.Current, checked(index++)).GetAwaiter();
						if (!awaiter2.IsCompleted)
						{
							state = 2;
							awaiter2.UnsafeOnCompleted(moveNextAction);
							return;
						}
						break;
					}
					goto end_IL_0000;
				case 2:
					break;
				}
				Current = awaiter2.GetResult();
				goto IL_012e;
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
			IL_012e:
			state = 0;
			completionSource.TrySetResult(result: true);
		}

		public UniTask DisposeAsync()
		{
			return enumerator.DisposeAsync();
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, int, UniTask<TResult>> selector;

	public SelectIntAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, UniTask<TResult>> selector)
	{
		this.source = source;
		this.selector = selector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SelectAwait(source, selector, cancellationToken);
	}
}
