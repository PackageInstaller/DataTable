using System.Collections.Generic;

namespace System.IO;

internal static class MonoLinqHelper
{
	public static T[] ToArray<T>(this IEnumerable<T> source)
	{
		return EnumerableHelpers.ToArray(source);
	}
}
