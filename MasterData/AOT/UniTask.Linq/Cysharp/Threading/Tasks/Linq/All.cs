using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal static class All
{
	internal static async UniTask<bool> AllAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		bool result;
		try
		{
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					if (!predicate(e.Current))
					{
						result = false;
						break;
					}
					continue;
				}
				result = true;
				break;
			}
		}
		finally
		{
			IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
			if (asyncDisposable != null)
			{
				await asyncDisposable.DisposeAsync();
			}
		}
		return result;
	}

	internal static async UniTask<bool> AllAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		bool result;
		try
		{
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					if (!(await predicate(e.Current)))
					{
						result = false;
						break;
					}
					continue;
				}
				result = true;
				break;
			}
		}
		finally
		{
			IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
			if (asyncDisposable != null)
			{
				await asyncDisposable.DisposeAsync();
			}
		}
		return result;
	}

	internal static async UniTask<bool> AllAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		bool result;
		try
		{
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					if (!(await predicate(e.Current, cancellationToken)))
					{
						result = false;
						break;
					}
					continue;
				}
				result = true;
				break;
			}
		}
		finally
		{
			IAsyncDisposable asyncDisposable = e as IAsyncDisposable;
			if (asyncDisposable != null)
			{
				await asyncDisposable.DisposeAsync();
			}
		}
		return result;
	}
}
