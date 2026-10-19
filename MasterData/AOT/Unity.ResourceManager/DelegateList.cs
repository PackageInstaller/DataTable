using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.ResourceManagement.Util;

internal class DelegateList<T>
{
	private Func<Action<T>, LinkedListNode<Action<T>>> m_acquireFunc;

	private Action<LinkedListNode<Action<T>>> m_releaseFunc;

	private LinkedList<Action<T>> m_callbacks;

	private bool m_invoking;

	public int Count
	{
		get
		{
			if (m_callbacks != null)
			{
				return m_callbacks.Count;
			}
			return 0;
		}
	}

	public DelegateList(Func<Action<T>, LinkedListNode<Action<T>>> acquireFunc, Action<LinkedListNode<Action<T>>> releaseFunc)
	{
		if (acquireFunc == null)
		{
			throw new ArgumentNullException("acquireFunc");
		}
		if (releaseFunc == null)
		{
			throw new ArgumentNullException("releaseFunc");
		}
		m_acquireFunc = acquireFunc;
		m_releaseFunc = releaseFunc;
	}

	public void Add(Action<T> action)
	{
		LinkedListNode<Action<T>> node = m_acquireFunc(action);
		if (m_callbacks == null)
		{
			m_callbacks = new LinkedList<Action<T>>();
		}
		m_callbacks.AddLast(node);
	}

	public void Remove(Action<T> action)
	{
		if (m_callbacks == null)
		{
			return;
		}
		for (LinkedListNode<Action<T>> linkedListNode = m_callbacks.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
		{
			if (linkedListNode.Value == action)
			{
				if (m_invoking)
				{
					linkedListNode.Value = null;
					break;
				}
				m_callbacks.Remove(linkedListNode);
				m_releaseFunc(linkedListNode);
				break;
			}
		}
	}

	public void Invoke(T res)
	{
		if (m_callbacks == null)
		{
			return;
		}
		m_invoking = true;
		for (LinkedListNode<Action<T>> linkedListNode = m_callbacks.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
		{
			if (linkedListNode.Value != null)
			{
				try
				{
					linkedListNode.Value(res);
				}
				catch (Exception exception)
				{
					Debug.LogException(exception);
				}
			}
		}
		m_invoking = false;
		LinkedListNode<Action<T>> linkedListNode2 = m_callbacks.First;
		while (linkedListNode2 != null)
		{
			LinkedListNode<Action<T>> next = linkedListNode2.Next;
			if (linkedListNode2.Value == null)
			{
				m_callbacks.Remove(linkedListNode2);
				m_releaseFunc(linkedListNode2);
			}
			linkedListNode2 = next;
		}
	}

	public void Clear()
	{
		if (m_callbacks != null)
		{
			LinkedListNode<Action<T>> linkedListNode = m_callbacks.First;
			while (linkedListNode != null)
			{
				LinkedListNode<Action<T>> next = linkedListNode.Next;
				m_callbacks.Remove(linkedListNode);
				m_releaseFunc(linkedListNode);
				linkedListNode = next;
			}
		}
	}

	public static DelegateList<T> CreateWithGlobalCache()
	{
		if (!GlobalLinkedListNodeCache<Action<T>>.CacheExists)
		{
			GlobalLinkedListNodeCache<Action<T>>.SetCacheSize(32);
		}
		return new DelegateList<T>(GlobalLinkedListNodeCache<Action<T>>.Acquire, GlobalLinkedListNodeCache<Action<T>>.Release);
	}
}
