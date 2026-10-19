using System;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks.Linq;

internal static class First
{
	public static async UniTask<TSource> FirstAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			if (await e.MoveNextAsync())
			{
				result = e.Current;
			}
			else
			{
				if (!defaultIfEmpty)
				{
					throw Error.NoElements();
				}
				result = default;
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

	public static async UniTask<TSource> FirstAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					TSource current = e.Current;
					if (predicate(current))
					{
						result = current;
						break;
					}
					continue;
				}
				if (defaultIfEmpty)
				{
					result = default;
					break;
				}
				throw Error.NoElements();
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

	public static async UniTask<TSource> FirstAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					TSource v = e.Current;
					if (await predicate(v))
					{
						result = v;
						break;
					}
					continue;
				}
				if (defaultIfEmpty)
				{
					result = default;
					break;
				}
				throw Error.NoElements();
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

	public static async UniTask<TSource> FirstAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					TSource v = e.Current;
					if (await predicate(v, cancellationToken))
					{
						result = v;
						break;
					}
					continue;
				}
				if (defaultIfEmpty)
				{
					result = default;
					break;
				}
				throw Error.NoElements();
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
