using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class WhereInt<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _Where : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, int, bool> predicate;

		private readonly CancellationToken cancellationToken;

		private int state = -1;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private Action moveNextAction;

		private int index;

		public TSource Current { get; private set; }

		public _Where(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, bool> predicate, CancellationToken cancellationToken)
		{
			this.source = source;
			this.predicate = predicate;
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
			while (true)
			{
				try
				{
					switch (state)
					{
					default:
						goto end_IL_0001;
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
						Current = enumerator.Current;
						if (predicate(Current, checked(index++)))
						{
							break;
						}
						state = 0;
						continue;
					}
					end_IL_0001:;
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
			}
			state = 0;
			completionSource.TrySetResult(result: true);
		}

		public UniTask DisposeAsync()
		{
			return enumerator.DisposeAsync();
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, int, bool> predicate;

	public WhereInt(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, bool> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Where(source, predicate, cancellationToken);
	}
}
