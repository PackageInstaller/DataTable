using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class DistinctUntilChanged<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _DistinctUntilChanged : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly IEqualityComparer<TSource> comparer;

		private readonly CancellationToken cancellationToken;

		private int state = -1;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private Action moveNextAction;

		public TSource Current { get; private set; }

		public _DistinctUntilChanged(IUniTaskAsyncEnumerable<TSource> source, IEqualityComparer<TSource> comparer, CancellationToken cancellationToken)
		{
			this.source = source;
			this.comparer = comparer;
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
						awaiter = enumerator.MoveNextAsync().GetAwaiter();
						if (!awaiter.IsCompleted)
						{
							state = -3;
							awaiter.UnsafeOnCompleted(moveNextAction);
							return;
						}
						goto case -3;
					case -3:
						if (awaiter.GetResult())
						{
							Current = enumerator.Current;
							goto end_IL_0001_2;
						}
						goto end_IL_0001;
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
					case -2:
						goto end_IL_0001;
					}
					if (awaiter.GetResult())
					{
						TSource current = enumerator.Current;
						if (!comparer.Equals(Current, current))
						{
							Current = current;
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
				continue;
				end_IL_0001_2:
				break;
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

	private readonly IEqualityComparer<TSource> comparer;

	public DistinctUntilChanged(IUniTaskAsyncEnumerable<TSource> source, IEqualityComparer<TSource> comparer)
	{
		this.source = source;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _DistinctUntilChanged(source, comparer, cancellationToken);
	}
}
internal sealed class DistinctUntilChanged<TSource, TKey> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _DistinctUntilChanged : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, TKey> keySelector;

		private readonly IEqualityComparer<TKey> comparer;

		private readonly CancellationToken cancellationToken;

		private int state = -1;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private Action moveNextAction;

		private TKey prev;

		public TSource Current { get; private set; }

		public _DistinctUntilChanged(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TKey> keySelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
		{
			this.source = source;
			this.keySelector = keySelector;
			this.comparer = comparer;
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
						awaiter = enumerator.MoveNextAsync().GetAwaiter();
						if (!awaiter.IsCompleted)
						{
							state = -3;
							awaiter.UnsafeOnCompleted(moveNextAction);
							return;
						}
						goto case -3;
					case -3:
						if (awaiter.GetResult())
						{
							Current = enumerator.Current;
							goto end_IL_0001_2;
						}
						goto end_IL_0001;
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
					case -2:
						goto end_IL_0001;
					}
					if (awaiter.GetResult())
					{
						TSource current = enumerator.Current;
						TKey y = keySelector(current);
						if (!comparer.Equals(prev, y))
						{
							prev = y;
							Current = current;
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
				continue;
				end_IL_0001_2:
				break;
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

	private readonly Func<TSource, TKey> keySelector;

	private readonly IEqualityComparer<TKey> comparer;

	public DistinctUntilChanged(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TKey> keySelector, IEqualityComparer<TKey> comparer)
	{
		this.source = source;
		this.keySelector = keySelector;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _DistinctUntilChanged(source, keySelector, comparer, cancellationToken);
	}
}
