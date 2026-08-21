using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace GameFramework;

[StructLayout(LayoutKind.Auto)]
public struct GameFrameworkLinkedListRange<T> : IEnumerable<T>, IEnumerable
{
	[StructLayout(LayoutKind.Auto)]
	public struct Enumerator : IEnumerator<T>, IEnumerator, IDisposable
	{
		private readonly GameFrameworkLinkedListRange<T> m_GameFrameworkLinkedListRange;

		private LinkedListNode<T> m_Current;

		private T m_CurrentValue;

		public T Current => m_CurrentValue;

		object IEnumerator.Current => m_CurrentValue;

		internal Enumerator(GameFrameworkLinkedListRange<T> range)
		{
			if (!range.IsValid)
			{
				throw new GameFrameworkException("Range is invalid.");
			}
			m_GameFrameworkLinkedListRange = range;
			m_Current = m_GameFrameworkLinkedListRange.m_First;
			m_CurrentValue = default(T);
		}

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			if (m_Current == null || m_Current == m_GameFrameworkLinkedListRange.m_Terminal)
			{
				return false;
			}
			m_CurrentValue = m_Current.Value;
			m_Current = m_Current.Next;
			return true;
		}

		void IEnumerator.Reset()
		{
			m_Current = m_GameFrameworkLinkedListRange.m_First;
			m_CurrentValue = default(T);
		}
	}

	private readonly LinkedListNode<T> m_First;

	private readonly LinkedListNode<T> m_Terminal;

	public bool IsValid => m_First != null && m_Terminal != null && m_First != m_Terminal;

	public LinkedListNode<T> First => m_First;

	public LinkedListNode<T> Terminal => m_Terminal;

	public int Count
	{
		get
		{
			if (!IsValid)
			{
				return 0;
			}
			int num = 0;
			LinkedListNode<T> linkedListNode = m_First;
			while (linkedListNode != null && linkedListNode != m_Terminal)
			{
				num++;
				linkedListNode = linkedListNode.Next;
			}
			return num;
		}
	}

	public GameFrameworkLinkedListRange(LinkedListNode<T> first, LinkedListNode<T> terminal)
	{
		if (first == null || terminal == null || first == terminal)
		{
			throw new GameFrameworkException("Range is invalid.");
		}
		m_First = first;
		m_Terminal = terminal;
	}

	public bool Contains(T value)
	{
		LinkedListNode<T> linkedListNode = m_First;
		while (linkedListNode != null && linkedListNode != m_Terminal)
		{
			if (linkedListNode.Value.Equals(value))
			{
				return true;
			}
			linkedListNode = linkedListNode.Next;
		}
		return false;
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
