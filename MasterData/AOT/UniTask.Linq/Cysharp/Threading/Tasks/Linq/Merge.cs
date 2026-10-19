using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Merge<T> : IUniTaskAsyncEnumerable<T>
{
	private enum MergeSourceState
	{
		Pending,
		Running,
		Completed
	}

	private sealed class _Merge : MoveNextSource, IUniTaskAsyncEnumerator<T>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> GetResultAtAction = GetResultAt;

		private readonly int length;

		private readonly IUniTaskAsyncEnumerator<T>[] enumerators;

		private readonly MergeSourceState[] states;

		private readonly Queue<(T, Exception, bool)> queuedResult = new Queue<(T, Exception, bool)>();

		private readonly CancellationToken cancellationToken;

		private int moveNextCompleted;

		public T Current { get; private set; }

		public _Merge(IUniTaskAsyncEnumerable<T>[] sources, CancellationToken cancellationToken)
		{
			this.cancellationToken = cancellationToken;
			length = sources.Length;
			states = ArrayPool<MergeSourceState>.Shared.Rent(length);
			enumerators = ArrayPool<IUniTaskAsyncEnumerator<T>>.Shared.Rent(length);
			for (int i = 0; i < length; i++)
			{
				enumerators[i] = sources[i].GetAsyncEnumerator(cancellationToken);
				states[i] = MergeSourceState.Pending;
			}
		}

		public UniTask<bool> MoveNextAsync()
		{
			CancellationToken cancellationToken = this.cancellationToken;
			cancellationToken.ThrowIfCancellationRequested();
			completionSource.Reset();
			Interlocked.Exchange(ref moveNextCompleted, 0);
			if (HasQueuedResult() && Interlocked.CompareExchange(ref moveNextCompleted, 1, 0) == 0)
			{
				(T, Exception, bool) tuple;
				lock (states)
				{
					tuple = queuedResult.Dequeue();
				}
				var (current, ex, result) = tuple;
				if (ex != null)
				{
					completionSource.TrySetException(ex);
				}
				else
				{
					Current = current;
					completionSource.TrySetResult(result);
				}
				return new UniTask<bool>(this, completionSource.Version);
			}
			for (int i = 0; i < length; i++)
			{
				lock (states)
				{
					if (states[i] == MergeSourceState.Pending)
					{
						states[i] = MergeSourceState.Running;
						goto IL_00fe;
					}
				}
				continue;
				IL_00fe:
				UniTask<bool>.Awaiter awaiter = enumerators[i].MoveNextAsync().GetAwaiter();
				if (awaiter.IsCompleted)
				{
					GetResultAt(i, awaiter);
				}
				else
				{
					awaiter.SourceOnCompleted(GetResultAtAction, StateTuple.Create(this, i, awaiter));
				}
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		public async UniTask DisposeAsync()
		{
			for (int i = 0; i < length; i++)
			{
				await enumerators[i].DisposeAsync();
			}
			ArrayPool<MergeSourceState>.Shared.Return(states, clearArray: true);
			ArrayPool<IUniTaskAsyncEnumerator<T>>.Shared.Return(enumerators, clearArray: true);
		}

		private static void GetResultAt(object state)
		{
			using StateTuple<_Merge, int, UniTask<bool>.Awaiter> stateTuple = (StateTuple<_Merge, int, UniTask<bool>.Awaiter>)state;
			stateTuple.Item1.GetResultAt(stateTuple.Item2, stateTuple.Item3);
		}

		private void GetResultAt(int index, UniTask<bool>.Awaiter awaiter)
		{
			bool result;
			try
			{
				result = awaiter.GetResult();
			}
			catch (Exception ex)
			{
				if (Interlocked.CompareExchange(ref moveNextCompleted, 1, 0) == 0)
				{
					completionSource.TrySetException(ex);
					return;
				}
				lock (states)
				{
					queuedResult.Enqueue((default, ex, false));
					return;
				}
			}
			bool flag;
			lock (states)
			{
				states[index] = ((!result) ? MergeSourceState.Completed : MergeSourceState.Pending);
				flag = !result && IsCompletedAll();
			}
			if (!(result | flag))
			{
				return;
			}
			if (Interlocked.CompareExchange(ref moveNextCompleted, 1, 0) == 0)
			{
				Current = enumerators[index].Current;
				completionSource.TrySetResult(!flag);
				return;
			}
			lock (states)
			{
				queuedResult.Enqueue((enumerators[index].Current, null, !flag));
			}
		}

		private bool HasQueuedResult()
		{
			lock (states)
			{
				return queuedResult.Count > 0;
			}
		}

		private bool IsCompletedAll()
		{
			lock (states)
			{
				for (int i = 0; i < length; i++)
				{
					if (states[i] != MergeSourceState.Completed)
					{
						return false;
					}
				}
			}
			return true;
		}
	}

	private readonly IUniTaskAsyncEnumerable<T>[] sources;

	public Merge(IUniTaskAsyncEnumerable<T>[] sources)
	{
		if (sources.Length == 0)
		{
			Error.ThrowArgumentException("No source async enumerable to merge");
		}
		this.sources = sources;
	}

	public IUniTaskAsyncEnumerator<T> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Merge(sources, cancellationToken);
	}
}
