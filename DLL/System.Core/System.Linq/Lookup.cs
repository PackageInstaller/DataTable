using System.Collections;
using System.Collections.Generic;

namespace System.Linq;

public class Lookup<TKey, TElement> : IEnumerable<IGrouping<TKey, TElement>>, IEnumerable, ILookup<TKey, TElement>
{
	internal class Grouping : IGrouping<TKey, TElement>, IEnumerable<TElement>, IEnumerable, IList<TElement>, ICollection<TElement>
	{
		internal TKey key;

		internal int hashCode;

		internal TElement[] elements;

		internal int count;

		internal Grouping hashNext;

		internal Grouping next;

		public TKey Key => key;

		int ICollection<TElement>.Count => count;

		bool ICollection<TElement>.IsReadOnly => true;

		TElement IList<TElement>.this[int index]
		{
			get
			{
				if (index < 0 || index >= count)
				{
					throw Error.ArgumentOutOfRange("index");
				}
				return elements[index];
			}
			set
			{
				throw Error.NotSupported();
			}
		}

		internal void Add(TElement element)
		{
			if (elements.Length == count)
			{
				Array.Resize(ref elements, checked(count * 2));
			}
			elements[count] = element;
			count++;
		}

		public IEnumerator<TElement> GetEnumerator()
		{
			for (int i = 0; i < count; i++)
			{
				yield return elements[i];
			}
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}

		void ICollection<TElement>.Add(TElement item)
		{
			throw Error.NotSupported();
		}

		void ICollection<TElement>.Clear()
		{
			throw Error.NotSupported();
		}

		bool ICollection<TElement>.Contains(TElement item)
		{
			return Array.IndexOf(elements, item, 0, count) >= 0;
		}

		void ICollection<TElement>.CopyTo(TElement[] array, int arrayIndex)
		{
			Array.Copy(elements, 0, array, arrayIndex, count);
		}

		bool ICollection<TElement>.Remove(TElement item)
		{
			throw Error.NotSupported();
		}

		int IList<TElement>.IndexOf(TElement item)
		{
			return Array.IndexOf(elements, item, 0, count);
		}

		void IList<TElement>.Insert(int index, TElement item)
		{
			throw Error.NotSupported();
		}

		void IList<TElement>.RemoveAt(int index)
		{
			throw Error.NotSupported();
		}
	}

	private IEqualityComparer<TKey> comparer;

	private Grouping[] groupings;

	private Grouping lastGrouping;

	private int count;

	public int Count => count;

	public IEnumerable<TElement> this[TKey key]
	{
		get
		{
			Grouping grouping = GetGrouping(key, create: false);
			if (grouping != null)
			{
				return grouping;
			}
			return EmptyEnumerable<TElement>.Instance;
		}
	}

	internal static Lookup<TKey, TElement> Create<TSource>(IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, IEqualityComparer<TKey> comparer)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (keySelector == null)
		{
			throw Error.ArgumentNull("keySelector");
		}
		if (elementSelector == null)
		{
			throw Error.ArgumentNull("elementSelector");
		}
		Lookup<TKey, TElement> lookup = new Lookup<TKey, TElement>(comparer);
		foreach (TSource item in source)
		{
			lookup.GetGrouping(keySelector(item), create: true).Add(elementSelector(item));
		}
		return lookup;
	}

	internal static Lookup<TKey, TElement> CreateForJoin(IEnumerable<TElement> source, Func<TElement, TKey> keySelector, IEqualityComparer<TKey> comparer)
	{
		Lookup<TKey, TElement> lookup = new Lookup<TKey, TElement>(comparer);
		foreach (TElement item in source)
		{
			TKey val = keySelector(item);
			if (val != null)
			{
				lookup.GetGrouping(val, create: true).Add(item);
			}
		}
		return lookup;
	}

	private Lookup(IEqualityComparer<TKey> comparer)
	{
		if (comparer == null)
		{
			comparer = EqualityComparer<TKey>.Default;
		}
		this.comparer = comparer;
		groupings = new Grouping[7];
	}

	public IEnumerator<IGrouping<TKey, TElement>> GetEnumerator()
	{
		Grouping g = lastGrouping;
		if (g != null)
		{
			do
			{
				g = g.next;
				yield return g;
			}
			while (g != lastGrouping);
		}
	}

	public IEnumerable<TResult> ApplyResultSelector<TResult>(Func<TKey, IEnumerable<TElement>, TResult> resultSelector)
	{
		Grouping g = lastGrouping;
		if (g == null)
		{
			yield break;
		}
		do
		{
			g = g.next;
			if (g.count != g.elements.Length)
			{
				Array.Resize(ref g.elements, g.count);
			}
			yield return resultSelector(g.key, g.elements);
		}
		while (g != lastGrouping);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	internal int InternalGetHashCode(TKey key)
	{
		if (key != null)
		{
			return comparer.GetHashCode(key) & 0x7FFFFFFF;
		}
		return 0;
	}

	internal Grouping GetGrouping(TKey key, bool create)
	{
		int num = InternalGetHashCode(key);
		for (Grouping grouping = groupings[num % groupings.Length]; grouping != null; grouping = grouping.hashNext)
		{
			if (grouping.hashCode == num && comparer.Equals(grouping.key, key))
			{
				return grouping;
			}
		}
		if (create)
		{
			if (count == groupings.Length)
			{
				Resize();
			}
			int num2 = num % groupings.Length;
			Grouping grouping2 = new Grouping();
			grouping2.key = key;
			grouping2.hashCode = num;
			grouping2.elements = new TElement[1];
			grouping2.hashNext = groupings[num2];
			groupings[num2] = grouping2;
			if (lastGrouping == null)
			{
				grouping2.next = grouping2;
			}
			else
			{
				grouping2.next = lastGrouping.next;
				lastGrouping.next = grouping2;
			}
			lastGrouping = grouping2;
			count++;
			return grouping2;
		}
		return null;
	}

	private void Resize()
	{
		int num = checked(count * 2 + 1);
		Grouping[] array = new Grouping[num];
		Grouping next = lastGrouping;
		do
		{
			next = next.next;
			int num2 = next.hashCode % num;
			next.hashNext = array[num2];
			array[num2] = next;
		}
		while (next != lastGrouping);
		groupings = array;
	}
}
