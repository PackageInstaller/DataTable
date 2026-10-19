using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal static class LongCount
{
	internal static async UniTask<long> LongCountAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				count = checked(count + 1);
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
		return count;
	}

	internal static async UniTask<long> LongCountAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate, CancellationToken cancellationToken)
	{
		long count = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				if (predicate(e.Current))
				{
					count = checked(count + 1);
				}
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
		return count;
	}

	internal static async UniTask<long> LongCountAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate, CancellationToken cancellationToken)
	{
		long count = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				if (await predicate(e.Current))
				{
					count = checked(count + 1);
				}
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
		return count;
	}

	internal static async UniTask<long> LongCountAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate, CancellationToken cancellationToken)
	{
		long count = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				if (await predicate(e.Current, cancellationToken))
				{
					count = checked(count + 1);
				}
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
		return count;
	}
}
