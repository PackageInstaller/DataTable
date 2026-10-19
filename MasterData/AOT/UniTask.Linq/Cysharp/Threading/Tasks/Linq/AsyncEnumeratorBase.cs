using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal abstract class AsyncEnumeratorBase<TSource, TResult> : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
{
	private static readonly Action<object> moveNextCallbackDelegate = MoveNextCallBack;

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	protected CancellationToken cancellationToken;

	private IUniTaskAsyncEnumerator<TSource> enumerator;

	private UniTask<bool>.Awaiter sourceMoveNext;

	protected TSource SourceCurrent => enumerator.Current;

	public TResult Current { get; protected set; }

	public AsyncEnumeratorBase(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
	{
		this.source = source;
		this.cancellationToken = cancellationToken;
	}

	protected abstract bool TryMoveNextCore(bool sourceHasCurrent, out bool result);

	public UniTask<bool> MoveNextAsync()
	{
		if (enumerator == null)
		{
			enumerator = source.GetAsyncEnumerator(cancellationToken);
		}
		completionSource.Reset();
		if (!OnFirstIteration())
		{
			SourceMoveNext();
		}
		return new UniTask<bool>(this, completionSource.Version);
	}

	protected virtual bool OnFirstIteration()
	{
		return false;
	}

	protected void SourceMoveNext()
	{
		while (true)
		{
			sourceMoveNext = enumerator.MoveNextAsync().GetAwaiter();
			if (!sourceMoveNext.IsCompleted)
			{
				break;
			}
			bool result = false;
			try
			{
				if (!TryMoveNextCore(sourceMoveNext.GetResult(), out result))
				{
					continue;
				}
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				return;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				completionSource.TrySetCanceled(cancellationToken);
			}
			else
			{
				completionSource.TrySetResult(result);
			}
			return;
		}
		sourceMoveNext.SourceOnCompleted(moveNextCallbackDelegate, this);
	}

	private static void MoveNextCallBack(object state)
	{
		AsyncEnumeratorBase<TSource, TResult> asyncEnumeratorBase = (AsyncEnumeratorBase<TSource, TResult>)state;
		bool result;
		try
		{
			if (!asyncEnumeratorBase.TryMoveNextCore(asyncEnumeratorBase.sourceMoveNext.GetResult(), out result))
			{
				asyncEnumeratorBase.SourceMoveNext();
				return;
			}
		}
		catch (Exception error)
		{
			asyncEnumeratorBase.completionSource.TrySetException(error);
			return;
		}
		if (asyncEnumeratorBase.cancellationToken.IsCancellationRequested)
		{
			asyncEnumeratorBase.completionSource.TrySetCanceled(asyncEnumeratorBase.cancellationToken);
		}
		else
		{
			asyncEnumeratorBase.completionSource.TrySetResult(result);
		}
	}

	public virtual UniTask DisposeAsync()
	{
		if (enumerator != null)
		{
			return enumerator.DisposeAsync();
		}
		return default;
	}
}
