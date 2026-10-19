using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class AppendPrepend<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _AppendPrepend : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private enum State : byte
		{
			None,
			RequirePrepend,
			RequireAppend,
			Completed
		}

		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly TSource element;

		private CancellationToken cancellationToken;

		private State state;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		public TSource Current { get; private set; }

		public _AppendPrepend(IUniTaskAsyncEnumerable<TSource> source, TSource element, bool append, CancellationToken cancellationToken)
		{
			this.source = source;
			this.element = element;
			state = ((!append) ? State.RequirePrepend : State.RequireAppend);
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			completionSource.Reset();
			if (enumerator == null)
			{
				if (state == State.RequirePrepend)
				{
					Current = element;
					state = State.None;
					return CompletedTasks.True;
				}
				enumerator = source.GetAsyncEnumerator(cancellationToken);
			}
			if (state == State.Completed)
			{
				return CompletedTasks.False;
			}
			awaiter = enumerator.MoveNextAsync().GetAwaiter();
			if (awaiter.IsCompleted)
			{
				MoveNextCoreDelegate(this);
			}
			else
			{
				awaiter.SourceOnCompleted(MoveNextCoreDelegate, this);
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void MoveNextCore(object state)
		{
			_AppendPrepend appendPrepend = (_AppendPrepend)state;
			if (appendPrepend.TryGetResult(appendPrepend.awaiter, out var result))
			{
				if (result)
				{
					appendPrepend.Current = appendPrepend.enumerator.Current;
					appendPrepend.completionSource.TrySetResult(result: true);
				}
				else if (appendPrepend.state == State.RequireAppend)
				{
					appendPrepend.state = State.Completed;
					appendPrepend.Current = appendPrepend.element;
					appendPrepend.completionSource.TrySetResult(result: true);
				}
				else
				{
					appendPrepend.state = State.Completed;
					appendPrepend.completionSource.TrySetResult(result: false);
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

	private readonly TSource element;

	private readonly bool append;

	public AppendPrepend(IUniTaskAsyncEnumerable<TSource> source, TSource element, bool append)
	{
		this.source = source;
		this.element = element;
		this.append = append;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _AppendPrepend(source, element, append, cancellationToken);
	}
}
