using System;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks.Linq;

internal static class ToArray
{
	internal static async UniTask<TSource[]> ToArrayAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
	{
		ArrayPool<TSource> pool = ArrayPool<TSource>.Shared;
		TSource[] array = pool.Rent(16);
		TSource[] result = null;
		IUniTaskAsyncEnumerator<TSource> e = null;
		try
		{
			e = source.GetAsyncEnumerator(cancellationToken);
			int i = 0;
			while (await e.MoveNextAsync())
			{
				ArrayPoolUtil.EnsureCapacity(ref array, i, pool);
				array[i++] = e.Current;
			}
			if (i == 0)
			{
				result = Array.Empty<TSource>();
			}
			else
			{
				result = new TSource[i];
				Array.Copy(array, result, i);
			}
		}
		finally
		{
			pool.Return(array, !RuntimeHelpersAbstraction.IsWellKnownNoReferenceContainsType<TSource>());
			if (e != null)
			{
				await e.DisposeAsync();
			}
		}
		return result;
	}
}
