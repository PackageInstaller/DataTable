using System.Collections;
using System.Collections.Generic;

namespace System.Linq;

internal abstract class OrderedEnumerable<TElement> : IOrderedEnumerable<TElement>, IEnumerable<TElement>, IEnumerable
{
	internal IEnumerable<TElement> source;

	public IEnumerator<TElement> GetEnumerator()
	{
		Buffer<TElement> buffer = new Buffer<TElement>(source);
		if (buffer.count > 0)
		{
			EnumerableSorter<TElement> enumerableSorter = GetEnumerableSorter(null);
			int[] map = enumerableSorter.Sort(buffer.items, buffer.count);
			for (int i = 0; i < buffer.count; i++)
			{
				yield return buffer.items[map[i]];
			}
		}
	}

	internal abstract EnumerableSorter<TElement> GetEnumerableSorter(EnumerableSorter<TElement> next);

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	IOrderedEnumerable<TElement> IOrderedEnumerable<TElement>.CreateOrderedEnumerable<TKey>(Func<TElement, TKey> keySelector, IComparer<TKey> comparer, bool descending)
	{
		return new OrderedEnumerable<TElement, TKey>(source, keySelector, comparer, descending)
		{
			parent = this
		};
	}
}
internal class OrderedEnumerable<TElement, TKey> : OrderedEnumerable<TElement>
{
	internal OrderedEnumerable<TElement> parent;

	internal Func<TElement, TKey> keySelector;

	internal IComparer<TKey> comparer;

	internal bool descending;

	internal OrderedEnumerable(IEnumerable<TElement> source, Func<TElement, TKey> keySelector, IComparer<TKey> comparer, bool descending)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (keySelector == null)
		{
			throw Error.ArgumentNull("keySelector");
		}
		base.source = source;
		parent = null;
		this.keySelector = keySelector;
		IComparer<TKey> obj;
		if (comparer == null)
		{
			IComparer<TKey> comparer2 = Comparer<TKey>.Default;
			obj = comparer2;
		}
		else
		{
			obj = comparer;
		}
		this.comparer = obj;
		this.descending = descending;
	}

	internal override EnumerableSorter<TElement> GetEnumerableSorter(EnumerableSorter<TElement> next)
	{
		EnumerableSorter<TElement> enumerableSorter = new EnumerableSorter<TElement, TKey>(keySelector, comparer, descending, next);
		if (parent != null)
		{
			enumerableSorter = parent.GetEnumerableSorter(enumerableSorter);
		}
		return enumerableSorter;
	}
}
