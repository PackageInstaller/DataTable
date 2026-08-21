using System;
using System.Collections;
using System.Collections.Generic;

namespace GameFramework;

public class GameFrameworkLinkedList<T> : ICollection<T>, IEnumerable<T>, IEnumerable, ICollection
{
	public struct Enumerator : IEnumerator<T>, IEnumerator, IDisposable
	{
		private LinkedList<T>.Enumerator m_Enumerator;

		public T Current => m_Enumerator.Current;

		object IEnumerator.Current => m_Enumerator.Current;

		internal Enumerator(LinkedList<T> linkedList)
		{
			m_Enumerator = linkedList.GetEnumerator();
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

	private readonly LinkedList<T> m_LinkedList;

	private readonly Queue<LinkedListNode<T>> m_CachedNodes;

	public int Count => m_LinkedList.Count;

	public int CachedNodeCount => m_CachedNodes.Count;

	public LinkedListNode<T> First => m_LinkedList.First;

	public LinkedListNode<T> Last => m_LinkedList.Last;

	public bool IsReadOnly => ((ICollection<T>)m_LinkedList).IsReadOnly;

	public object SyncRoot => ((ICollection)m_LinkedList).SyncRoot;

	public bool IsSynchronized => ((ICollection)m_LinkedList).IsSynchronized;

	public GameFrameworkLinkedList()
	{
		m_LinkedList = new LinkedList<T>();
		m_CachedNodes = new Queue<LinkedListNode<T>>();
	}

	public void Add(T value)
	{
		AddLast(value);
	}

	public LinkedListNode<T> AddAfter(LinkedListNode<T> node, T value)
	{
		LinkedListNode<T> linkedListNode = AcquireNode(value);
		m_LinkedList.AddAfter(node, linkedListNode);
		return linkedListNode;
	}

	public void AddAfter(LinkedListNode<T> node, LinkedListNode<T> newNode)
	{
		m_LinkedList.AddAfter(node, newNode);
	}

	public LinkedListNode<T> AddBefore(LinkedListNode<T> node, T value)
	{
		LinkedListNode<T> linkedListNode = AcquireNode(value);
		m_LinkedList.AddBefore(node, linkedListNode);
		return linkedListNode;
	}

	public void AddBefore(LinkedListNode<T> node, LinkedListNode<T> newNode)
	{
		m_LinkedList.AddBefore(node, newNode);
	}

	public LinkedListNode<T> AddFirst(T value)
	{
		LinkedListNode<T> linkedListNode = AcquireNode(value);
		m_LinkedList.AddFirst(linkedListNode);
		return linkedListNode;
	}

	public void AddFirst(LinkedListNode<T> node)
	{
		m_LinkedList.AddFirst(node);
	}

	public LinkedListNode<T> AddLast(T value)
	{
		LinkedListNode<T> linkedListNode = AcquireNode(value);
		m_LinkedList.AddLast(linkedListNode);
		return linkedListNode;
	}

	public void AddLast(LinkedListNode<T> node)
	{
		m_LinkedList.AddLast(node);
	}

	public void Clear()
	{
		for (LinkedListNode<T> linkedListNode = m_LinkedList.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
		{
			ReleaseNode(linkedListNode);
		}
		m_LinkedList.Clear();
	}

	public void ClearCachedNodes()
	{
		m_CachedNodes.Clear();
	}

	public bool Contains(T value)
	{
		return m_LinkedList.Contains(value);
	}

	public void CopyTo(T[] array, int index)
	{
		m_LinkedList.CopyTo(array, index);
	}

	public void CopyTo(Array array, int index)
	{
		((ICollection)m_LinkedList).CopyTo(array, index);
	}

	public LinkedListNode<T> Find(T value)
	{
		return m_LinkedList.Find(value);
	}

	public LinkedListNode<T> FindLast(T value)
	{
		return m_LinkedList.FindLast(value);
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(m_LinkedList);
	}

	public bool Remove(T value)
	{
		LinkedListNode<T> linkedListNode = m_LinkedList.Find(value);
		if (linkedListNode != null)
		{
			m_LinkedList.Remove(linkedListNode);
			ReleaseNode(linkedListNode);
			return true;
		}
		return false;
	}

	public void Remove(LinkedListNode<T> node)
	{
		m_LinkedList.Remove(node);
		ReleaseNode(node);
	}

	public void RemoveFirst()
	{
		LinkedListNode<T> first = m_LinkedList.First;
		if (first == null)
		{
			throw new Exception("First is invalid.");
		}
		m_LinkedList.RemoveFirst();
		ReleaseNode(first);
	}

	public void RemoveLast()
	{
		LinkedListNode<T> last = m_LinkedList.Last;
		if (last == null)
		{
			throw new Exception("Last is invalid.");
		}
		m_LinkedList.RemoveLast();
		ReleaseNode(last);
	}

	private LinkedListNode<T> AcquireNode(T value)
	{
		LinkedListNode<T> linkedListNode = null;
		if (m_CachedNodes.Count > 0)
		{
			linkedListNode = m_CachedNodes.Dequeue();
			linkedListNode.Value = value;
		}
		else
		{
			linkedListNode = new LinkedListNode<T>(value);
		}
		return linkedListNode;
	}

	private void ReleaseNode(LinkedListNode<T> node)
	{
		node.Value = default(T);
		m_CachedNodes.Enqueue(node);
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
