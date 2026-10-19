using System;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks.Linq;

internal static class Last
{
	public static async UniTask<TSource> LastAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			TSource value = default;
			if (await e.MoveNextAsync())
			{
				value = e.Current;
				while (await e.MoveNextAsync())
				{
					value = e.Current;
				}
				result = value;
			}
			else
			{
				if (!defaultIfEmpty)
				{
					throw Error.NoElements();
				}
				result = value;
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

	public static async UniTask<TSource> LastAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate, CancellationToken cancellationToken, bool defaultIfEmpty)
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
					found = true;
					value = current;
				}
			}
			if (defaultIfEmpty)
			{
				result = value;
			}
			else
			{
				if (!found)
				{
					throw Error.NoElements();
				}
				result = value;
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

	public static async UniTask<TSource> LastAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate, CancellationToken cancellationToken, bool defaultIfEmpty)
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
					found = true;
					value = v;
				}
			}
			if (defaultIfEmpty)
			{
				result = value;
			}
			else
			{
				if (!found)
				{
					throw Error.NoElements();
				}
				result = value;
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

	public static async UniTask<TSource> LastAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate, CancellationToken cancellationToken, bool defaultIfEmpty)
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
					found = true;
					value = v;
				}
			}
			if (defaultIfEmpty)
			{
				result = value;
			}
			else
			{
				if (!found)
				{
					throw Error.NoElements();
				}
				result = value;
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
