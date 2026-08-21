using System.Collections.Generic;

namespace MemoryPack.Internal;

internal static class EnumerableExtensions
{
	public static bool TryGetNonEnumeratedCountEx<T>(this IEnumerable<T> value, out int count)
	{
		count = 0;
		if (value is ICollection<T> collection)
		{
			count = collection.Count;
			return true;
		}
		if (value is IReadOnlyCollection<T> readOnlyCollection)
		{
			count = readOnlyCollection.Count;
			return true;
		}
		return false;
	}
}
