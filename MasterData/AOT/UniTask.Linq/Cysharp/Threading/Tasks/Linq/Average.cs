using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal static class Average
{
	public static async UniTask<double> AverageAsync(IUniTaskAsyncEnumerable<int> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		int sum = 0;
		IUniTaskAsyncEnumerator<int> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					sum += e.Current;
					count++;
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
			return (double)sum / (double)count;
		}
	}

	public static async UniTask<double> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		int sum = 0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					sum += selector(e.Current);
					count++;
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
			return (double)sum / (double)count;
		}
	}

	public static async UniTask<double> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<int>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		int sum = 0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					int num = sum;
					sum = num + await selector(e.Current);
					count++;
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
			return (double)sum / (double)count;
		}
	}

	public static async UniTask<double> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<int>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		int sum = 0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					int num = sum;
					sum = num + await selector(e.Current, cancellationToken);
					count++;
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
			return (double)sum / (double)count;
		}
	}

	public static async UniTask<double> AverageAsync(IUniTaskAsyncEnumerable<long> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		long sum = 0L;
		IUniTaskAsyncEnumerator<long> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					sum += e.Current;
					count++;
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
			return (double)sum / (double)count;
		}
	}

	public static async UniTask<double> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, long> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		long sum = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					sum += selector(e.Current);
					count++;
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
			return (double)sum / (double)count;
		}
	}

	public static async UniTask<double> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<long>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		long sum = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					long num = sum;
					sum = num + await selector(e.Current);
					count++;
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
			return (double)sum / (double)count;
		}
	}

	public static async UniTask<double> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<long>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		long sum = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					long num = sum;
					sum = num + await selector(e.Current, cancellationToken);
					count++;
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
			return (double)sum / (double)count;
		}
	}

	public static async UniTask<float> AverageAsync(IUniTaskAsyncEnumerable<float> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		float sum = 0f;
		IUniTaskAsyncEnumerator<float> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				sum += e.Current;
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
		return sum / (float)count;
	}

	public static async UniTask<float> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, float> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		float sum = 0f;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				sum += selector(e.Current);
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
		return sum / (float)count;
	}

	public static async UniTask<float> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<float>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		float sum = 0f;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				float num = sum;
				sum = num + await selector(e.Current);
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
		return sum / (float)count;
	}

	public static async UniTask<float> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<float>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		float sum = 0f;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				float num = sum;
				sum = num + await selector(e.Current, cancellationToken);
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
		return sum / (float)count;
	}

	public static async UniTask<double> AverageAsync(IUniTaskAsyncEnumerable<double> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		double sum = 0.0;
		IUniTaskAsyncEnumerator<double> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				sum += e.Current;
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
		return sum / (double)count;
	}

	public static async UniTask<double> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, double> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		double sum = 0.0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				sum += selector(e.Current);
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
		return sum / (double)count;
	}

	public static async UniTask<double> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<double>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		double sum = 0.0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				double num = sum;
				sum = num + await selector(e.Current);
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
		return sum / (double)count;
	}

	public static async UniTask<double> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<double>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		double sum = 0.0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				double num = sum;
				sum = num + await selector(e.Current, cancellationToken);
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
		return sum / (double)count;
	}

	public static async UniTask<decimal> AverageAsync(IUniTaskAsyncEnumerable<decimal> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		decimal sum = 0m;
		IUniTaskAsyncEnumerator<decimal> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				sum += e.Current;
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
		return sum / (decimal)count;
	}

	public static async UniTask<decimal> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, decimal> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		decimal sum = 0m;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				sum += selector(e.Current);
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
		return sum / (decimal)count;
	}

	public static async UniTask<decimal> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<decimal>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		decimal sum = 0m;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				decimal num = sum;
				sum = num + await selector(e.Current);
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
		return sum / (decimal)count;
	}

	public static async UniTask<decimal> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<decimal>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		decimal sum = 0m;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				decimal num = sum;
				sum = num + await selector(e.Current, cancellationToken);
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
		return sum / (decimal)count;
	}

	public static async UniTask<double?> AverageAsync(IUniTaskAsyncEnumerable<int?> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		int? sum = 0;
		IUniTaskAsyncEnumerator<int?> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					int? current = e.Current;
					if (current.HasValue)
					{
						sum += current.Value;
						count++;
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
			return (double)sum.Value / (double)count;
		}
	}

	public static async UniTask<double?> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int?> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		int? sum = 0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					int? num = selector(e.Current);
					if (num.HasValue)
					{
						sum += num.Value;
						count++;
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
			return (double)sum.Value / (double)count;
		}
	}

	public static async UniTask<double?> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<int?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		int? sum = 0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					int? num = await selector(e.Current);
					if (num.HasValue)
					{
						sum += num.Value;
						count++;
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
			return (double)sum.Value / (double)count;
		}
	}

	public static async UniTask<double?> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<int?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		int? sum = 0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					int? num = await selector(e.Current, cancellationToken);
					if (num.HasValue)
					{
						sum += num.Value;
						count++;
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
			return (double)sum.Value / (double)count;
		}
	}

	public static async UniTask<double?> AverageAsync(IUniTaskAsyncEnumerable<long?> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		long? sum = 0L;
		IUniTaskAsyncEnumerator<long?> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					long? current = e.Current;
					if (current.HasValue)
					{
						sum += current.Value;
						count++;
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
			return (double)sum.Value / (double)count;
		}
	}

	public static async UniTask<double?> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, long?> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		long? sum = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					long? num = selector(e.Current);
					if (num.HasValue)
					{
						sum += num.Value;
						count++;
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
			return (double)sum.Value / (double)count;
		}
	}

	public static async UniTask<double?> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<long?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		long? sum = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					long? num = await selector(e.Current);
					if (num.HasValue)
					{
						sum += num.Value;
						count++;
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
			return (double)sum.Value / (double)count;
		}
	}

	public static async UniTask<double?> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<long?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		long? sum = 0L;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		checked
		{
			try
			{
				while (await e.MoveNextAsync())
				{
					long? num = await selector(e.Current, cancellationToken);
					if (num.HasValue)
					{
						sum += num.Value;
						count++;
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
			return (double)sum.Value / (double)count;
		}
	}

	public static async UniTask<float?> AverageAsync(IUniTaskAsyncEnumerable<float?> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		float? sum = 0f;
		IUniTaskAsyncEnumerator<float?> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				float? current = e.Current;
				if (current.HasValue)
				{
					sum += current.Value;
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
		return (sum / (float)count).Value;
	}

	public static async UniTask<float?> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, float?> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		float? sum = 0f;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				float? num = selector(e.Current);
				if (num.HasValue)
				{
					sum += num.Value;
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
		return (sum / (float)count).Value;
	}

	public static async UniTask<float?> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<float?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		float? sum = 0f;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				float? num = await selector(e.Current);
				if (num.HasValue)
				{
					sum += num.Value;
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
		return (sum / (float)count).Value;
	}

	public static async UniTask<float?> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<float?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		float? sum = 0f;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				float? num = await selector(e.Current, cancellationToken);
				if (num.HasValue)
				{
					sum += num.Value;
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
		return (sum / (float)count).Value;
	}

	public static async UniTask<double?> AverageAsync(IUniTaskAsyncEnumerable<double?> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		double? sum = 0.0;
		IUniTaskAsyncEnumerator<double?> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				double? current = e.Current;
				if (current.HasValue)
				{
					sum += current.Value;
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
		return sum / (double)count;
	}

	public static async UniTask<double?> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, double?> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		double? sum = 0.0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				double? num = selector(e.Current);
				if (num.HasValue)
				{
					sum += num.Value;
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
		return sum / (double)count;
	}

	public static async UniTask<double?> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<double?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		double? sum = 0.0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				double? num = await selector(e.Current);
				if (num.HasValue)
				{
					sum += num.Value;
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
		return sum / (double)count;
	}

	public static async UniTask<double?> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<double?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		double? sum = 0.0;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				double? num = await selector(e.Current, cancellationToken);
				if (num.HasValue)
				{
					sum += num.Value;
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
		return sum / (double)count;
	}

	public static async UniTask<decimal?> AverageAsync(IUniTaskAsyncEnumerable<decimal?> source, CancellationToken cancellationToken)
	{
		long count = 0L;
		decimal? sum = 0m;
		IUniTaskAsyncEnumerator<decimal?> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				decimal? current = e.Current;
				if (current.HasValue)
				{
					sum += (decimal?)current.Value;
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
		return sum / (decimal?)count;
	}

	public static async UniTask<decimal?> AverageAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, decimal?> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		decimal? sum = 0m;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				decimal? num = selector(e.Current);
				if (num.HasValue)
				{
					sum += (decimal?)num.Value;
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
		return sum / (decimal?)count;
	}

	public static async UniTask<decimal?> AverageAwaitAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<decimal?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		decimal? sum = 0m;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				decimal? num = await selector(e.Current);
				if (num.HasValue)
				{
					sum += (decimal?)num.Value;
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
		return sum / (decimal?)count;
	}

	public static async UniTask<decimal?> AverageAwaitWithCancellationAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<decimal?>> selector, CancellationToken cancellationToken)
	{
		long count = 0L;
		decimal? sum = 0m;
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				decimal? num = await selector(e.Current, cancellationToken);
				if (num.HasValue)
				{
					sum += (decimal?)num.Value;
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
		return sum / (decimal?)count;
	}
}
