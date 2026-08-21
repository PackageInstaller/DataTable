using System;
using System.Collections;
using System.Collections.Generic;

namespace UnityEngine.InputSystem.Utilities;

internal struct OneOrMore<TValue, TList> : IReadOnlyList<TValue>, IEnumerable<TValue>, IEnumerable, IReadOnlyCollection<TValue> where TList : IReadOnlyList<TValue>
{
	private class Enumerator : IEnumerator<TValue>, IEnumerator, IDisposable
	{
		internal int m_Index = -1;

		internal OneOrMore<TValue, TList> m_List;

		public TValue Current => m_List[m_Index];

		object IEnumerator.Current => Current;

		public bool MoveNext()
		{
			m_Index++;
			if (m_Index >= m_List.Count)
			{
				return false;
			}
			return true;
		}

		public void Reset()
		{
			m_Index = -1;
		}

		public void Dispose()
		{
		}
	}

	private readonly bool m_IsSingle;

	private readonly TValue m_Single;

	private readonly TList m_Multiple;

	public int Count
	{
		get
		{
			if (!m_IsSingle)
			{
				return m_Multiple.Count;
			}
			return 1;
		}
	}

	public TValue this[int index]
	{
		get
		{
			if (!m_IsSingle)
			{
				return m_Multiple[index];
			}
			if (index < 0 || index > 1)
			{
				throw new ArgumentOutOfRangeException("index");
			}
			return m_Single;
		}
	}

	public OneOrMore(TValue single)
	{
		m_IsSingle = true;
		m_Single = single;
		m_Multiple = default(TList);
	}

	public OneOrMore(TList multiple)
	{
		m_IsSingle = false;
		m_Single = default(TValue);
		m_Multiple = multiple;
	}

	public static implicit operator OneOrMore<TValue, TList>(TValue single)
	{
		return new OneOrMore<TValue, TList>(single);
	}

	public static implicit operator OneOrMore<TValue, TList>(TList multiple)
	{
		return new OneOrMore<TValue, TList>(multiple);
	}

	public IEnumerator<TValue> GetEnumerator()
	{
		return new Enumerator
		{
			m_List = this
		};
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
