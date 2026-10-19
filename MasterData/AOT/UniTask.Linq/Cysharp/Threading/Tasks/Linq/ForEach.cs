using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal static class ForEach
{
	public static async UniTask ForEachAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Action<TSource> action, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				action(e.Current);
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
	}

	public static async UniTask ForEachAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Action<TSource, int> action, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			int index = 0;
			while (await e.MoveNextAsync())
			{
				action(e.Current, checked(index++));
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
	}

	public static async UniTask ForEachAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask> action, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				await action(e.Current);
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
	}

	public static async UniTask ForEachAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, UniTask> action, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			int index = 0;
			while (await e.MoveNextAsync())
			{
				await action(e.Current, checked(index++));
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
	}

	public static async UniTask ForEachAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask> action, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				await action(e.Current, cancellationToken);
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
	}

	public static async UniTask ForEachAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, CancellationToken, UniTask> action, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			int index = 0;
			while (await e.MoveNextAsync())
			{
				await action(e.Current, checked(index++), cancellationToken);
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
	}
}
