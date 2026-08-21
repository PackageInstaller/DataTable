using System.Collections.Generic;

namespace System.Linq;

internal struct Buffer<TElement>
{
	internal TElement[] items;

	internal int count;

	internal Buffer(IEnumerable<TElement> source)
	{
		TElement[] array = null;
		int num = 0;
		if (source is ICollection<TElement> collection)
		{
			num = collection.Count;
			if (num > 0)
			{
				array = new TElement[num];
				collection.CopyTo(array, 0);
			}
		}
		else
		{
			foreach (TElement item in source)
			{
				if (array == null)
				{
					array = new TElement[4];
				}
				else if (array.Length == num)
				{
					TElement[] array2 = new TElement[checked(num * 2)];
					Array.Copy(array, 0, array2, 0, num);
					array = array2;
				}
				array[num] = item;
				num++;
			}
		}
		items = array;
		count = num;
	}

	internal TElement[] ToArray()
	{
		if (count == 0)
		{
			return new TElement[0];
		}
		if (items.Length == count)
		{
			return items;
		}
		TElement[] array = new TElement[count];
		Array.Copy(items, 0, array, 0, count);
		return array;
	}
}
