using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal abstract class AsyncEnumeratorAwaitSelectorBase<TSource, TResult, TAwait> : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
{
	private static readonly Action<object> moveNextCallbackDelegate = MoveNextCallBack;

	private static readonly Action<object> setCurrentCallbackDelegate = SetCurrentCallBack;

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	protected CancellationToken cancellationToken;

	private IUniTaskAsyncEnumerator<TSource> enumerator;

	private UniTask<bool>.Awaiter sourceMoveNext;

	private UniTask<TAwait>.Awaiter resultAwaiter;

	protected TSource SourceCurrent { get; private set; }

	public TResult Current { get; protected set; }

	public AsyncEnumeratorAwaitSelectorBase(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
	{
		this.source = source;
		this.cancellationToken = cancellationToken;
	}

	protected abstract UniTask<TAwait> TransformAsync(TSource sourceCurrent);

	protected abstract bool TrySetCurrentCore(TAwait awaitResult, out bool terminateIteration);

	protected (bool waitCallback, bool requireNextIteration) ActionCompleted(bool trySetCurrentResult, out bool moveNextResult)
	{
		if (trySetCurrentResult)
		{
			moveNextResult = true;
			return (waitCallback: false, requireNextIteration: false);
		}
		moveNextResult = false;
		return (waitCallback: false, requireNextIteration: true);
	}

	protected (bool waitCallback, bool requireNextIteration) WaitAwaitCallback(out bool moveNextResult)
	{
		moveNextResult = false;
		return (waitCallback: true, requireNextIteration: false);
	}

	protected (bool waitCallback, bool requireNextIteration) IterateFinished(out bool moveNextResult)
	{
		moveNextResult = false;
		return (waitCallback: false, requireNextIteration: false);
	}

	public UniTask<bool> MoveNextAsync()
	{
		if (enumerator == null)
		{
			enumerator = source.GetAsyncEnumerator(cancellationToken);
		}
		completionSource.Reset();
		SourceMoveNext();
		return new UniTask<bool>(this, completionSource.Version);
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
				var (flag, flag2) = TryMoveNextCore(sourceMoveNext.GetResult(), out result);
				if (flag)
				{
					return;
				}
				if (flag2)
				{
					continue;
				}
				completionSource.TrySetResult(result);
				return;
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				return;
			}
		}
		sourceMoveNext.SourceOnCompleted(moveNextCallbackDelegate, this);
	}

	private (bool waitCallback, bool requireNextIteration) TryMoveNextCore(bool sourceHasCurrent, out bool result)
	{
		if (sourceHasCurrent)
		{
			SourceCurrent = enumerator.Current;
			UniTask<TAwait> taskResult = TransformAsync(SourceCurrent);
			if (UnwarapTask(taskResult, out var result2))
			{
				bool trySetCurrentResult = TrySetCurrentCore(result2, out var terminateIteration);
				if (terminateIteration)
				{
					return IterateFinished(out result);
				}
				return ActionCompleted(trySetCurrentResult, out result);
			}
			return WaitAwaitCallback(out result);
		}
		return IterateFinished(out result);
	}

	protected bool UnwarapTask(UniTask<TAwait> taskResult, out TAwait result)
	{
		resultAwaiter = taskResult.GetAwaiter();
		if (resultAwaiter.IsCompleted)
		{
			result = resultAwaiter.GetResult();
			return true;
		}
		resultAwaiter.SourceOnCompleted(setCurrentCallbackDelegate, this);
		result = default;
		return false;
	}

	private static void MoveNextCallBack(object state)
	{
		AsyncEnumeratorAwaitSelectorBase<TSource, TResult, TAwait> asyncEnumeratorAwaitSelectorBase = (AsyncEnumeratorAwaitSelectorBase<TSource, TResult, TAwait>)state;
		bool result = false;
		try
		{
			var (flag, flag2) = asyncEnumeratorAwaitSelectorBase.TryMoveNextCore(asyncEnumeratorAwaitSelectorBase.sourceMoveNext.GetResult(), out result);
			if (!flag)
			{
				if (flag2)
				{
					asyncEnumeratorAwaitSelectorBase.SourceMoveNext();
				}
				else
				{
					asyncEnumeratorAwaitSelectorBase.completionSource.TrySetResult(result);
				}
			}
		}
		catch (Exception error)
		{
			asyncEnumeratorAwaitSelectorBase.completionSource.TrySetException(error);
		}
	}

	private static void SetCurrentCallBack(object state)
	{
		AsyncEnumeratorAwaitSelectorBase<TSource, TResult, TAwait> asyncEnumeratorAwaitSelectorBase = (AsyncEnumeratorAwaitSelectorBase<TSource, TResult, TAwait>)state;
		bool flag;
		bool terminateIteration;
		try
		{
			TAwait result = asyncEnumeratorAwaitSelectorBase.resultAwaiter.GetResult();
			flag = asyncEnumeratorAwaitSelectorBase.TrySetCurrentCore(result, out terminateIteration);
		}
		catch (Exception error)
		{
			asyncEnumeratorAwaitSelectorBase.completionSource.TrySetException(error);
			return;
		}
		if (asyncEnumeratorAwaitSelectorBase.cancellationToken.IsCancellationRequested)
		{
			asyncEnumeratorAwaitSelectorBase.completionSource.TrySetCanceled(asyncEnumeratorAwaitSelectorBase.cancellationToken);
		}
		else if (flag)
		{
			asyncEnumeratorAwaitSelectorBase.completionSource.TrySetResult(result: true);
		}
		else if (terminateIteration)
		{
			asyncEnumeratorAwaitSelectorBase.completionSource.TrySetResult(result: false);
		}
		else
		{
			asyncEnumeratorAwaitSelectorBase.SourceMoveNext();
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
