using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public class MergedCollection<T> : IMergedCollection<T>, ICollection<T>, IEnumerable<T>, IEnumerable
{
	private readonly Dictionary<Type, ICollection<T>> collections;

	public int Count
	{
		get
		{
			int num = 0;
			foreach (ICollection<T> value in collections.Values)
			{
				num += value.Count;
			}
			return num;
		}
	}

	public bool IsReadOnly => false;

	public MergedCollection()
	{
		collections = new Dictionary<Type, ICollection<T>>();
	}

	public void Include<TI>(ICollection<TI> collection) where TI : T
	{
		collections.Add(typeof(TI), new VariantCollection<T, TI>(collection));
	}

	public bool Includes<TI>() where TI : T
	{
		return Includes(typeof(TI));
	}

	public bool Includes(Type implementationType)
	{
		return GetCollectionForType(implementationType, throwOnFail: false) != null;
	}

	public ICollection<TI> ForType<TI>() where TI : T
	{
		return ((VariantCollection<T, TI>)GetCollectionForType(typeof(TI))).implementation;
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public IEnumerator<T> GetEnumerator()
	{
		foreach (ICollection<T> value in collections.Values)
		{
			foreach (T item in value)
			{
				yield return item;
			}
		}
	}

	private ICollection<T> GetCollectionForItem(T item)
	{
		Ensure.That("item").IsNotNull(item);
		return GetCollectionForType(item.GetType());
	}

	private ICollection<T> GetCollectionForType(Type type, bool throwOnFail = true)
	{
		if (collections.ContainsKey(type))
		{
			return collections[type];
		}
		foreach (KeyValuePair<Type, ICollection<T>> collection in collections)
		{
			if (collection.Key.IsAssignableFrom(type))
			{
				return collection.Value;
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
		return GetCollectionForItem(item).Contains(item);
	}

	public virtual void Add(T item)
	{
		GetCollectionForItem(item).Add(item);
	}

	public virtual void Clear()
	{
		foreach (ICollection<T> value in collections.Values)
		{
			value.Clear();
		}
	}

	public virtual bool Remove(T item)
	{
		return GetCollectionForItem(item).Remove(item);
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
		foreach (ICollection<T> value in collections.Values)
		{
			value.CopyTo(array, arrayIndex + num);
			num += value.Count;
		}
	}
}
