using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace GameFramework;

public sealed class GameFrameworkMultiDictionary<TKey, TValue> : IEnumerable<KeyValuePair<TKey, GameFrameworkLinkedListRange<TValue>>>, IEnumerable
{
	[StructLayout(LayoutKind.Auto)]
	public struct Enumerator : IEnumerator<KeyValuePair<TKey, GameFrameworkLinkedListRange<TValue>>>, IEnumerator, IDisposable
	{
		private Dictionary<TKey, GameFrameworkLinkedListRange<TValue>>.Enumerator m_Enumerator;

		public KeyValuePair<TKey, GameFrameworkLinkedListRange<TValue>> Current => m_Enumerator.Current;

		object IEnumerator.Current => m_Enumerator.Current;

		internal Enumerator(Dictionary<TKey, GameFrameworkLinkedListRange<TValue>> dictionary)
		{
			if (dictionary == null)
			{
				throw new GameFrameworkException("Dictionary is invalid.");
			}
			m_Enumerator = dictionary.GetEnumerator();
		}

		public void Dispose()
		{
			m_Enumerator.Dispose();
		}

		public bool MoveNext()
		{
			return m_Enumerator.MoveNext();
		}

		void IEnumerator.Reset()
		{
			((IEnumerator)m_Enumerator).Reset();
		}
	}

	private readonly GameFrameworkLinkedList<TValue> m_LinkedList;

	private readonly Dictionary<TKey, GameFrameworkLinkedListRange<TValue>> m_Dictionary;

	public int Count => m_Dictionary.Count;

	public GameFrameworkLinkedListRange<TValue> this[TKey key]
	{
		get
		{
			GameFrameworkLinkedListRange<TValue> value = default(GameFrameworkLinkedListRange<TValue>);
			m_Dictionary.TryGetValue(key, out value);
			return value;
		}
	}

	public GameFrameworkMultiDictionary()
	{
		m_LinkedList = new GameFrameworkLinkedList<TValue>();
		m_Dictionary = new Dictionary<TKey, GameFrameworkLinkedListRange<TValue>>();
	}

	public void Clear()
	{
		m_Dictionary.Clear();
		m_LinkedList.Clear();
	}

	public bool Contains(TKey key)
	{
		return m_Dictionary.ContainsKey(key);
	}

	public bool Contains(TKey key, TValue value)
	{
		GameFrameworkLinkedListRange<TValue> value2 = default(GameFrameworkLinkedListRange<TValue>);
		if (m_Dictionary.TryGetValue(key, out value2))
		{
			return value2.Contains(value);
		}
		return false;
	}

	public bool TryGetValue(TKey key, out GameFrameworkLinkedListRange<TValue> range)
	{
		return m_Dictionary.TryGetValue(key, out range);
	}

	public void Add(TKey key, TValue value)
	{
		GameFrameworkLinkedListRange<TValue> value2 = default(GameFrameworkLinkedListRange<TValue>);
		if (m_Dictionary.TryGetValue(key, out value2))
		{
			m_LinkedList.AddBefore(value2.Terminal, value);
			return;
		}
		LinkedListNode<TValue> first = m_LinkedList.AddLast(value);
		LinkedListNode<TValue> terminal = m_LinkedList.AddLast(default(TValue));
		m_Dictionary.Add(key, new GameFrameworkLinkedListRange<TValue>(first, terminal));
	}

	public bool Remove(TKey key, TValue value)
	{
		GameFrameworkLinkedListRange<TValue> value2 = default(GameFrameworkLinkedListRange<TValue>);
		if (m_Dictionary.TryGetValue(key, out value2))
		{
			LinkedListNode<TValue> linkedListNode = value2.First;
			while (linkedListNode != null && linkedListNode != value2.Terminal)
			{
				if (linkedListNode.Value.Equals(value))
				{
					if (linkedListNode == value2.First)
					{
						LinkedListNode<TValue> next = linkedListNode.Next;
						if (next == value2.Terminal)
						{
							m_LinkedList.Remove(next);
							m_Dictionary.Remove(key);
						}
						else
						{
							m_Dictionary[key] = new GameFrameworkLinkedListRange<TValue>(next, value2.Terminal);
						}
					}
					m_LinkedList.Remove(linkedListNode);
					return true;
				}
				linkedListNode = linkedListNode.Next;
			}
		}
		return false;
	}

	public bool RemoveAll(TKey key)
	{
		GameFrameworkLinkedListRange<TValue> value = default(GameFrameworkLinkedListRange<TValue>);
		if (m_Dictionary.TryGetValue(key, out value))
		{
			m_Dictionary.Remove(key);
			LinkedListNode<TValue> linkedListNode = value.First;
			while (linkedListNode != null)
			{
				LinkedListNode<TValue> linkedListNode2 = ((linkedListNode != value.Terminal) ? linkedListNode.Next : null);
				m_LinkedList.Remove(linkedListNode);
				linkedListNode = linkedListNode2;
			}
			return true;
		}
		return false;
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(m_Dictionary);
	}

	IEnumerator<KeyValuePair<TKey, GameFrameworkLinkedListRange<TValue>>> IEnumerable<KeyValuePair<TKey, GameFrameworkLinkedListRange<TValue>>>.GetEnumerator()
	{
		return GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
