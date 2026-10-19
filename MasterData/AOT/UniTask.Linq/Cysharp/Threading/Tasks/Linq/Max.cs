using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks.Linq;

internal static class Max
{
	public static async UniTask<TSource> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
	{
		TSource value = default;
		Comparer<TSource> comparer = Comparer<TSource>.Default;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				return value;
			}
			value = e.Current;
			while (await e.MoveNextAsync())
			{
				TSource current = e.Current;
				if (comparer.Compare(value, current) < 0)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<TResult> MaxAsync<TSource, TResult>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TResult> selector, CancellationToken cancellationToken)
	{
		TResult value = default;
		Comparer<TResult> comparer = Comparer<TResult>.Default;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				return value;
			}
			value = selector(e.Current);
			while (await e.MoveNextAsync())
			{
				TResult val = selector(e.Current);
				if (comparer.Compare(value, val) < 0)
				{
					value = val;
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
		return value;
	}

	public static async UniTask<TResult> MaxAwaitAsync<TSource, TResult>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<TResult>> selector, CancellationToken cancellationToken)
	{
		TResult value = default;
		Comparer<TResult> comparer = Comparer<TResult>.Default;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				return value;
			}
			value = await selector(e.Current);
			while (await e.MoveNextAsync())
			{
				TResult val = await selector(e.Current);
				if (comparer.Compare(value, val) < 0)
				{
					value = val;
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
		return value;
	}

	public static async UniTask<TResult> MaxAwaitWithCancellationAsync<TSource, TResult>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<TResult>> selector, CancellationToken cancellationToken)
	{
		TResult value = default;
		Comparer<TResult> comparer = Comparer<TResult>.Default;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				return value;
			}
			value = await selector(e.Current, cancellationToken);
			while (await e.MoveNextAsync())
			{
				TResult val = await selector(e.Current, cancellationToken);
				if (comparer.Compare(value, val) < 0)
				{
					value = val;
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
		return value;
	}

	public static async UniTask<int> MaxAsync(IUniTaskAsyncEnumerable<int> source, CancellationToken cancellationToken)
	{
		int value = 0;
		IUniTaskAsyncEnumerator<int> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = e.Current;
			while (await e.MoveNextAsync())
			{
				int current = e.Current;
				if (value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<int> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int> selector, CancellationToken cancellationToken)
	{
		int value = 0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = selector(e.Current);
			while (await e.MoveNextAsync())
			{
				int num = selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<int> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<int>> selector, CancellationToken cancellationToken)
	{
		int value = 0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current);
			while (await e.MoveNextAsync())
			{
				int num = await selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<int> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<int>> selector, CancellationToken cancellationToken)
	{
		int value = 0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current, cancellationToken);
			while (await e.MoveNextAsync())
			{
				int num = await selector(e.Current, cancellationToken);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<long> MaxAsync(IUniTaskAsyncEnumerable<long> source, CancellationToken cancellationToken)
	{
		long value = 0L;
		IUniTaskAsyncEnumerator<long> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = e.Current;
			while (await e.MoveNextAsync())
			{
				long current = e.Current;
				if (value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<long> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, long> selector, CancellationToken cancellationToken)
	{
		long value = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = selector(e.Current);
			while (await e.MoveNextAsync())
			{
				long num = selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<long> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<long>> selector, CancellationToken cancellationToken)
	{
		long value = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current);
			while (await e.MoveNextAsync())
			{
				long num = await selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<long> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<long>> selector, CancellationToken cancellationToken)
	{
		long value = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current, cancellationToken);
			while (await e.MoveNextAsync())
			{
				long num = await selector(e.Current, cancellationToken);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<float> MaxAsync(IUniTaskAsyncEnumerable<float> source, CancellationToken cancellationToken)
	{
		float value = 0f;
		IUniTaskAsyncEnumerator<float> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = e.Current;
			while (await e.MoveNextAsync())
			{
				float current = e.Current;
				if (value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<float> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, float> selector, CancellationToken cancellationToken)
	{
		float value = 0f;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = selector(e.Current);
			while (await e.MoveNextAsync())
			{
				float num = selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<float> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<float>> selector, CancellationToken cancellationToken)
	{
		float value = 0f;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current);
			while (await e.MoveNextAsync())
			{
				float num = await selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<float> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<float>> selector, CancellationToken cancellationToken)
	{
		float value = 0f;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current, cancellationToken);
			while (await e.MoveNextAsync())
			{
				float num = await selector(e.Current, cancellationToken);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<double> MaxAsync(IUniTaskAsyncEnumerable<double> source, CancellationToken cancellationToken)
	{
		double value = 0.0;
		IUniTaskAsyncEnumerator<double> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = e.Current;
			while (await e.MoveNextAsync())
			{
				double current = e.Current;
				if (value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<double> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, double> selector, CancellationToken cancellationToken)
	{
		double value = 0.0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = selector(e.Current);
			while (await e.MoveNextAsync())
			{
				double num = selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<double> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<double>> selector, CancellationToken cancellationToken)
	{
		double value = 0.0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current);
			while (await e.MoveNextAsync())
			{
				double num = await selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<double> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<double>> selector, CancellationToken cancellationToken)
	{
		double value = 0.0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current, cancellationToken);
			while (await e.MoveNextAsync())
			{
				double num = await selector(e.Current, cancellationToken);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<decimal> MaxAsync(IUniTaskAsyncEnumerable<decimal> source, CancellationToken cancellationToken)
	{
		decimal value = 0m;
		IUniTaskAsyncEnumerator<decimal> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = e.Current;
			while (await e.MoveNextAsync())
			{
				decimal current = e.Current;
				if (value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<decimal> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, decimal> selector, CancellationToken cancellationToken)
	{
		decimal value = 0m;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = selector(e.Current);
			while (await e.MoveNextAsync())
			{
				decimal num = selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<decimal> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<decimal>> selector, CancellationToken cancellationToken)
	{
		decimal value = 0m;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current);
			while (await e.MoveNextAsync())
			{
				decimal num = await selector(e.Current);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<decimal> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<decimal>> selector, CancellationToken cancellationToken)
	{
		decimal value = 0m;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			if (!(await e.MoveNextAsync()))
			{
				throw Error.NoElements();
			}
			value = await selector(e.Current, cancellationToken);
			while (await e.MoveNextAsync())
			{
				decimal num = await selector(e.Current, cancellationToken);
				if (value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<int?> MaxAsync(IUniTaskAsyncEnumerable<int?> source, CancellationToken cancellationToken)
	{
		int? value = null;
		IUniTaskAsyncEnumerator<int?> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = e.Current;
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				int? current = e.Current;
				if (current.HasValue && value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<int?> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int?> selector, CancellationToken cancellationToken)
	{
		int? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				int? num = selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<int?> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<int?>> selector, CancellationToken cancellationToken)
	{
		int? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				int? num = await selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<int?> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<int?>> selector, CancellationToken cancellationToken)
	{
		int? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current, cancellationToken);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				int? num = await selector(e.Current, cancellationToken);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<long?> MaxAsync(IUniTaskAsyncEnumerable<long?> source, CancellationToken cancellationToken)
	{
		long? value = null;
		IUniTaskAsyncEnumerator<long?> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = e.Current;
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				long? current = e.Current;
				if (current.HasValue && value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<long?> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, long?> selector, CancellationToken cancellationToken)
	{
		long? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				long? num = selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<long?> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<long?>> selector, CancellationToken cancellationToken)
	{
		long? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				long? num = await selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<long?> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<long?>> selector, CancellationToken cancellationToken)
	{
		long? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current, cancellationToken);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				long? num = await selector(e.Current, cancellationToken);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<float?> MaxAsync(IUniTaskAsyncEnumerable<float?> source, CancellationToken cancellationToken)
	{
		float? value = null;
		IUniTaskAsyncEnumerator<float?> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = e.Current;
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				float? current = e.Current;
				if (current.HasValue && value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<float?> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, float?> selector, CancellationToken cancellationToken)
	{
		float? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				float? num = selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<float?> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<float?>> selector, CancellationToken cancellationToken)
	{
		float? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				float? num = await selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<float?> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<float?>> selector, CancellationToken cancellationToken)
	{
		float? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current, cancellationToken);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				float? num = await selector(e.Current, cancellationToken);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<double?> MaxAsync(IUniTaskAsyncEnumerable<double?> source, CancellationToken cancellationToken)
	{
		double? value = null;
		IUniTaskAsyncEnumerator<double?> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = e.Current;
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				double? current = e.Current;
				if (current.HasValue && value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<double?> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, double?> selector, CancellationToken cancellationToken)
	{
		double? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				double? num = selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<double?> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<double?>> selector, CancellationToken cancellationToken)
	{
		double? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				double? num = await selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<double?> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<double?>> selector, CancellationToken cancellationToken)
	{
		double? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current, cancellationToken);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				double? num = await selector(e.Current, cancellationToken);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<decimal?> MaxAsync(IUniTaskAsyncEnumerable<decimal?> source, CancellationToken cancellationToken)
	{
		decimal? value = null;
		IUniTaskAsyncEnumerator<decimal?> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = e.Current;
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				decimal? current = e.Current;
				if (current.HasValue && value < current)
				{
					value = current;
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
		return value;
	}

	public static async UniTask<decimal?> MaxAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, decimal?> selector, CancellationToken cancellationToken)
	{
		decimal? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				decimal? num = selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<decimal?> MaxAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<decimal?>> selector, CancellationToken cancellationToken)
	{
		decimal? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				decimal? num = await selector(e.Current);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}

	public static async UniTask<decimal?> MaxAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<decimal?>> selector, CancellationToken cancellationToken)
	{
		decimal? value = null;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			do
			{
				if (await e.MoveNextAsync())
				{
					value = await selector(e.Current, cancellationToken);
					continue;
				}
				return null;
			}
			while (!value.HasValue);
			while (await e.MoveNextAsync())
			{
				decimal? num = await selector(e.Current, cancellationToken);
				if (num.HasValue && value < num)
				{
					value = num;
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
		return value;
	}
}
