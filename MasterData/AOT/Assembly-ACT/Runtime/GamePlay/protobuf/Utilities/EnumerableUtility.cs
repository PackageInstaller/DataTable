using System;
using System.Collections.Generic;
using System.Linq;

namespace Runtime.GamePlay.protobuf.Utilities;

public static class EnumerableUtility
{
	public static IEnumerable<TSource> Union<TSource>(this IEnumerable<TSource> first, IEnumerable<TSource> second, Func<TSource, TSource, bool> comparer, Func<TSource, int> hashCode)
	{
		return first.Union(second, new LambdaEqualityComparer<TSource>(comparer, hashCode));
	}
}
