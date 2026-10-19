using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal static class ToHashSet
{
	internal static async UniTask<HashSet<TSource>> ToHashSetAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, IEqualityComparer<TSource> comparer, CancellationToken cancellationToken)
	{
		HashSet<TSource> set = new HashSet<TSource>(comparer);
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		try
		{
			while (await e.MoveNextAsync())
			{
				set.Add(e.Current);
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
		return set;
	}
}
