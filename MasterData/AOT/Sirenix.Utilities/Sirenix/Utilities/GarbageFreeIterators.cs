using System;
using System.Collections.Generic;

namespace Sirenix.Utilities;

public static class GarbageFreeIterators
{
	public struct ListIterator<T> : IDisposable
	{
		private bool isNull;

		private List<T> list;

		private List<T>.Enumerator enumerator;

		public T Current => enumerator.Current;

		public ListIterator(List<T> list)
		{
			isNull = list == null;
			if (isNull)
			{
				this.list = null;
				enumerator = default;
			}
			else
			{
				this.list = list;
				enumerator = this.list.GetEnumerator();
			}
		}

		public ListIterator<T> GetEnumerator()
		{
			return this;
		}

		public bool MoveNext()
		{
			if (isNull)
			{
				return false;
			}
			return enumerator.MoveNext();
		}

		public void Dispose()
		{
			enumerator.Dispose();
		}
	}

	public struct HashsetIterator<T> : IDisposable
	{
		private bool isNull;

		private HashSet<T> hashset;

		private HashSet<T>.Enumerator enumerator;

		public T Current => enumerator.Current;

		public HashsetIterator(HashSet<T> hashset)
		{
			isNull = hashset == null;
			if (isNull)
			{
				this.hashset = null;
				enumerator = default;
			}
			else
			{
				this.hashset = hashset;
				enumerator = this.hashset.GetEnumerator();
			}
		}

		public HashsetIterator<T> GetEnumerator()
		{
			return this;
		}

		public bool MoveNext()
		{
			if (isNull)
			{
				return false;
			}
			return enumerator.MoveNext();
		}

		public void Dispose()
		{
			enumerator.Dispose();
		}
	}

	public struct DictionaryIterator<T1, T2> : IDisposable
	{
		private Dictionary<T1, T2> dictionary;

		private Dictionary<T1, T2>.Enumerator enumerator;

		private bool isNull;

		public KeyValuePair<T1, T2> Current => enumerator.Current;

		public DictionaryIterator(Dictionary<T1, T2> dictionary)
		{
			isNull = dictionary == null;
			if (isNull)
			{
				this.dictionary = null;
				enumerator = default;
			}
			else
			{
				this.dictionary = dictionary;
				enumerator = this.dictionary.GetEnumerator();
			}
		}

		public DictionaryIterator<T1, T2> GetEnumerator()
		{
			return this;
		}

		public bool MoveNext()
		{
			if (isNull)
			{
				return false;
			}
			return enumerator.MoveNext();
		}

		public void Dispose()
		{
			enumerator.Dispose();
		}
	}

	public struct DictionaryValueIterator<T1, T2> : IDisposable
	{
		private Dictionary<T1, T2> dictionary;

		private Dictionary<T1, T2>.Enumerator enumerator;

		private bool isNull;

		public T2 Current => enumerator.Current.Value;

		public DictionaryValueIterator(Dictionary<T1, T2> dictionary)
		{
			isNull = dictionary == null;
			if (isNull)
			{
				this.dictionary = null;
				enumerator = default;
			}
			else
			{
				this.dictionary = dictionary;
				enumerator = this.dictionary.GetEnumerator();
			}
		}

		public DictionaryValueIterator<T1, T2> GetEnumerator()
		{
			return this;
		}

		public bool MoveNext()
		{
			if (isNull)
			{
				return false;
			}
			return enumerator.MoveNext();
		}

		public void Dispose()
		{
			enumerator.Dispose();
		}
	}

	public static ListIterator<T> GFIterator<T>(this List<T> list)
	{
		return new ListIterator<T>(list);
	}

	public static DictionaryIterator<T1, T2> GFIterator<T1, T2>(this Dictionary<T1, T2> dictionary)
	{
		return new DictionaryIterator<T1, T2>(dictionary);
	}

	public static DictionaryValueIterator<T1, T2> GFValueIterator<T1, T2>(this Dictionary<T1, T2> dictionary)
	{
		return new DictionaryValueIterator<T1, T2>(dictionary);
	}

	public static HashsetIterator<T> GFIterator<T>(this HashSet<T> hashset)
	{
		return new HashsetIterator<T>(hashset);
	}
}
