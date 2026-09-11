using System.Collections.Generic;
using System.Runtime.ConstrainedExecution;

namespace System.Diagnostics.Contracts;

public static class Contract
{
	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public static bool ForAll<T>(IEnumerable<T> collection, Predicate<T> predicate)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		if (predicate == null)
		{
			throw new ArgumentNullException("predicate");
		}
		foreach (T item in collection)
		{
			if (!predicate(item))
			{
				return false;
			}
		}
		return true;
	}
}
