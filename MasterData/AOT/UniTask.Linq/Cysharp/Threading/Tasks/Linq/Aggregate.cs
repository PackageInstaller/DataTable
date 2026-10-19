using System;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks.Linq;

internal static class Aggregate
{
	internal static async UniTask<TSource> AggregateAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TSource, TSource> accumulator, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			TSource value = e.Current;
			while (await e.MoveNextAsync())
			{
				value = accumulator(value, e.Current);
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

	internal static async UniTask<TAccumulate> AggregateAsync<TSource, TAccumulate>(IUniTaskAsyncEnumerable<TSource> source, TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> accumulator, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TAccumulate result;
		try
		{
			TAccumulate value = seed;
			while (await e.MoveNextAsync())
			{
				value = accumulator(value, e.Current);
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

	internal static async UniTask<TResult> AggregateAsync<TSource, TAccumulate, TResult>(IUniTaskAsyncEnumerable<TSource> source, TAccumulate seed, Func<TAccumulate, TSource, TAccumulate> accumulator, Func<TAccumulate, TResult> resultSelector, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TResult result;
		try
		{
			TAccumulate value = seed;
			while (await e.MoveNextAsync())
			{
				value = accumulator(value, e.Current);
			}
			result = resultSelector(value);
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

	internal static async UniTask<TSource> AggregateAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TSource, UniTask<TSource>> accumulator, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			TSource value = e.Current;
			while (await e.MoveNextAsync())
			{
				value = await accumulator(value, e.Current);
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

	internal static async UniTask<TAccumulate> AggregateAwaitAsync<TSource, TAccumulate>(IUniTaskAsyncEnumerable<TSource> source, TAccumulate seed, Func<TAccumulate, TSource, UniTask<TAccumulate>> accumulator, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TAccumulate result;
		try
		{
			TAccumulate value = seed;
			while (await e.MoveNextAsync())
			{
				value = await accumulator(value, e.Current);
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

	internal static async UniTask<TResult> AggregateAwaitAsync<TSource, TAccumulate, TResult>(IUniTaskAsyncEnumerable<TSource> source, TAccumulate seed, Func<TAccumulate, TSource, UniTask<TAccumulate>> accumulator, Func<TAccumulate, UniTask<TResult>> resultSelector, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TResult result;
		try
		{
			TAccumulate value = seed;
			while (await e.MoveNextAsync())
			{
				value = await accumulator(value, e.Current);
			}
			result = await resultSelector(value);
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

	internal static async UniTask<TSource> AggregateAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TSource, CancellationToken, UniTask<TSource>> accumulator, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			TSource value = e.Current;
			while (await e.MoveNextAsync())
			{
				value = await accumulator(value, e.Current, cancellationToken);
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

	internal static async UniTask<TAccumulate> AggregateAwaitWithCancellationAsync<TSource, TAccumulate>(IUniTaskAsyncEnumerable<TSource> source, TAccumulate seed, Func<TAccumulate, TSource, CancellationToken, UniTask<TAccumulate>> accumulator, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TAccumulate result;
		try
		{
			TAccumulate value = seed;
			while (await e.MoveNextAsync())
			{
				value = await accumulator(value, e.Current, cancellationToken);
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

	internal static async UniTask<TResult> AggregateAwaitWithCancellationAsync<TSource, TAccumulate, TResult>(IUniTaskAsyncEnumerable<TSource> source, TAccumulate seed, Func<TAccumulate, TSource, CancellationToken, UniTask<TAccumulate>> accumulator, Func<TAccumulate, CancellationToken, UniTask<TResult>> resultSelector, CancellationToken cancellationToken)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TResult result;
		try
		{
			TAccumulate value = seed;
			while (await e.MoveNextAsync())
			{
				value = await accumulator(value, e.Current, cancellationToken);
			}
			result = await resultSelector(value, cancellationToken);
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
