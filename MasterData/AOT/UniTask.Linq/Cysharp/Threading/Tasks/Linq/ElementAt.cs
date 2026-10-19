using System;
using System.Threading;
using Cysharp.Threading.Tasks.Internal;

namespace Cysharp.Threading.Tasks.Linq;

internal static class ElementAt
{
	public static async UniTask<TSource> ElementAtAsync<TSource>(IUniTaskAsyncEnumerable<TSource> source, int index, CancellationToken cancellationToken, bool defaultIfEmpty)
	{
		IUniTaskAsyncEnumerator<TSource> e = source.GetAsyncEnumerator(cancellationToken);
		TSource result;
		try
		{
			int i = 0;
			while (true)
			{
				if (await e.MoveNextAsync())
				{
					if (i++ == index)
					{
						result = e.Current;
						break;
					}
					continue;
				}
				if (defaultIfEmpty)
				{
					result = default;
					break;
				}
				throw Error.ArgumentOutOfRange("index");
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
