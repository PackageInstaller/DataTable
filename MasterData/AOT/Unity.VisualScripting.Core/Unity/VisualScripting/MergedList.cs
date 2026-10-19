using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public class MergedList<T> : IMergedCollection<T>, ICollection<T>, IEnumerable<T>, IEnumerable
{
	public struct Enumerator : IEnumerator<T>, IEnumerator, IDisposable
	{
		private Dictionary<Type, IList<T>>.Enumerator listsEnumerator;

		private T currentItem;

		private IList<T> currentList;

		private int indexInCurrentList;

		private bool exceeded;

		public T Current => currentItem;

		object IEnumerator.Current
		{
			get
			{
				if (exceeded)
				{
					throw new InvalidOperationException();
				}
				return Current;
			}
		}

		public Enumerator(MergedList<T> merged)
		{
			this = default;
			listsEnumerator = merged.lists.GetEnumerator();
		}

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			if (currentList == null)
			{
				if (!listsEnumerator.MoveNext())
				{
					currentItem = default;
					exceeded = true;
					return false;
				}
				currentList = listsEnumerator.Current.Value;
				if (currentList == null)
				{
					throw new InvalidOperationException("Merged sub list is null.");
				}
			}
			if (indexInCurrentList < currentList.Count)
			{
				currentItem = currentList[indexInCurrentList];
				indexInCurrentList++;
				return true;
			}
			while (listsEnumerator.MoveNext())
			{
				currentList = listsEnumerator.Current.Value;
				indexInCurrentList = 0;
				if (currentList == null)
				{
					throw new InvalidOperationException("Merged sub list is null.");
				}
				if (indexInCurrentList < currentList.Count)
				{
					currentItem = currentList[indexInCurrentList];
					indexInCurrentList++;
					return true;
				}
			}
			currentItem = default;
			exceeded = true;
			return false;
		}

		void IEnumerator.Reset()
		{
			throw new InvalidOperationException();
		}
	}

	protected readonly Dictionary<Type, IList<T>> lists;

	public int Count
	{
		get
		{
			int num = 0;
			foreach (KeyValuePair<Type, IList<T>> list in lists)
			{
				num += list.Value.Count;
			}
			return num;
		}
	}

	public bool IsReadOnly => false;

	public MergedList()
	{
		lists = new Dictionary<Type, IList<T>>();
	}

	public virtual void Include<TI>(IList<TI> list) where TI : T
	{
		lists.Add(typeof(TI), new VariantList<T, TI>(list));
	}

	public bool Includes<TI>() where TI : T
	{
		return Includes(typeof(TI));
	}

	public bool Includes(Type elementType)
	{
		return GetListForType(elementType, throwOnFail: false) != null;
	}

	public IList<TI> ForType<TI>() where TI : T
	{
		return ((VariantList<T, TI>)GetListForType(typeof(TI))).implementation;
	}

	protected IList<T> GetListForItem(T item)
	{
		Ensure.That("item").IsNotNull(item);
		return GetListForType(item.GetType());
	}

	protected IList<T> GetListForType(Type type, bool throwOnFail = true)
	{
		if (lists.ContainsKey(type))
		{
			return lists[type];
		}
		foreach (KeyValuePair<Type, IList<T>> list in lists)
		{
			if (list.Key.IsAssignableFrom(type))
			{
				return list.Value;
			}
		}
		if (throwOnFail)
		{
			throw new InvalidOperationException($"No sub-collection available for type '{type}'.");
		}
		return null;
	}

	public bool Contains(T item)
	{
		return GetListForItem(item).Contains(item);
	}

	public virtual void Add(T item)
	{
		GetListForItem(item).Add(item);
	}

	public virtual void Clear()
	{
		foreach (KeyValuePair<Type, IList<T>> list in lists)
		{
			list.Value.Clear();
		}
	}

	public virtual bool Remove(T item)
	{
		return GetListForItem(item).Remove(item);
	}

	public void CopyTo(T[] array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (arrayIndex < 0)
		{
			throw new ArgumentOutOfRangeException("arrayIndex");
		}
		if (array.Length - arrayIndex < Count)
		{
			throw new ArgumentException();
		}
		int num = 0;
		foreach (KeyValuePair<Type, IList<T>> list in lists)
		{
			IList<T> value = list.Value;
			value.CopyTo(array, arrayIndex + num);
			num += value.Count;
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return GetEnumerator();
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}
}
