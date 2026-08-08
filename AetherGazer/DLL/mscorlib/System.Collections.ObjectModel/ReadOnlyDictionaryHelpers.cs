using System.Collections.Generic;

namespace System.Collections.ObjectModel;

internal static class ReadOnlyDictionaryHelpers
{
	internal static void CopyToNonGenericICollectionHelper<T>(ICollection<T> collection, Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.");
		}
		if (array.GetLowerBound(0) != 0)
		{
			throw new ArgumentException("The lower bound of target array must be zero.");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (array.Length - index < collection.Count)
		{
			throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
		}
		if (collection is ICollection collection2)
		{
			collection2.CopyTo(array, index);
			return;
		}
		if (array is T[] array2)
		{
			collection.CopyTo(array2, index);
			return;
		}
		if (!(array is object[] array3))
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.");
		}
		try
		{
			foreach (T item in collection)
			{
				array3[index++] = item;
			}
		}
		catch (ArrayTypeMismatchException)
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.");
		}
	}
}
