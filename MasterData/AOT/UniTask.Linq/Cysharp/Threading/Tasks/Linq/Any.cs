using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal static class Any
{
	internal static async UniTask<bool> AnyAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		bool result;
		try
		{
			result = ((await e.MoveNextAsync()) ? true : false);
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

	internal static async UniTask<bool> AnyAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		bool result;
		try
		{
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					if (predicate(e.Current))
					{
						result = true;
						break;
					}
					continue;
				}
				result = false;
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

	internal static async UniTask<bool> AnyAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		bool result;
		try
		{
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					if (await predicate(e.Current))
					{
						result = true;
						break;
					}
					continue;
				}
				result = false;
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

	internal static async UniTask<bool> AnyAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		bool result;
		try
		{
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					if (await predicate(e.Current, cancellationToken))
					{
						result = true;
						break;
					}
					continue;
				}
				result = false;
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
