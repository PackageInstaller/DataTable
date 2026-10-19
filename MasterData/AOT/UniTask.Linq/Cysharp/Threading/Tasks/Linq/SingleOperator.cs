using System;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks.Linq;

internal static class SingleOperator
{
	public static async UniTask<TSource> SingleAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			if (await e.MoveNextAsync())
			{
				TSource v = e.Current;
				if (await e.MoveNextAsync())
				{
					throw Error.MoreThanOneElement();
				}
				result = v;
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

	public static async UniTask<TSource> SingleAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			TSource value = default;
			bool found = false;
			while (await e.MoveNextAsync())
			{
				TSource current = e.Current;
				if (predicate(current))
				{
					if (found)
					{
						throw Error.MoreThanOneElement();
					}
					found = true;
					value = current;
				}
			}
			if (!(found | defaultIfEmpty))
			{
				throw Error.NoElements();
			}
			result = value;
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

	public static async UniTask<TSource> SingleAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			TSource value = default;
			bool found = false;
			while (await e.MoveNextAsync())
			{
				TSource v = e.Current;
				if (await predicate(v))
				{
					if (found)
					{
						throw Error.MoreThanOneElement();
					}
					found = true;
					value = v;
				}
			}
			if (!(found | defaultIfEmpty))
			{
				throw Error.NoElements();
			}
			result = value;
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

	public static async UniTask<TSource> SingleAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			TSource value = default;
			bool found = false;
			while (await e.MoveNextAsync())
			{
				TSource v = e.Current;
				if (await predicate(v, cancellationToken))
				{
					if (found)
					{
						throw Error.MoreThanOneElement();
					}
					found = true;
					value = v;
				}
			}
			if (!(found | defaultIfEmpty))
			{
				throw Error.NoElements();
			}
			result = value;
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
