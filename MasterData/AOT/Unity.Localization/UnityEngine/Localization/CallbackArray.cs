using System;
using System.Collections.Generic;
using UnityEngine.Pool;

namespace UnityEngine.Localization;

internal struct CallbackArray<TDelegate> where TDelegate : Delegate
{
	private const int k_AllocationIncrement = 5;

	private TDelegate m_SingleDelegate;

	private TDelegate[] m_MultipleDelegates;

	private List<TDelegate> m_AddCallbacks;

	private List<TDelegate> m_RemoveCallbacks;

	private int m_Length;

	private bool m_CannotMutateCallbacksArray;

	private bool m_MutatedDuringCallback;

	public TDelegate SingleDelegate => m_SingleDelegate;

	public TDelegate[] MultiDelegates => m_MultipleDelegates;

	public int Length => m_Length;

	public void Add(TDelegate callback, int capacityIncrement = 5)
	{
		if (callback == null)
		{
			return;
		}
		if (m_CannotMutateCallbacksArray)
		{
			if (m_AddCallbacks == null)
			{
				m_AddCallbacks = CollectionPool<List<TDelegate>, TDelegate>.Get();
			}
			m_AddCallbacks.Add(callback);
			m_MutatedDuringCallback = true;
			return;
		}
		if (m_Length == 0)
		{
			m_SingleDelegate = callback;
		}
		else if (m_Length == 1)
		{
			m_MultipleDelegates = new TDelegate[capacityIncrement];
			m_MultipleDelegates[0] = m_SingleDelegate;
			m_MultipleDelegates[1] = callback;
			m_SingleDelegate = null;
		}
		else
		{
			if (m_MultipleDelegates.Length == m_Length)
			{
				Array.Resize(ref m_MultipleDelegates, m_Length + capacityIncrement);
			}
			m_MultipleDelegates[m_Length] = callback;
		}
		m_Length++;
	}

	public void RemoveByMovingTail(TDelegate callback)
	{
		if (callback == null)
		{
			return;
		}
		if (m_CannotMutateCallbacksArray)
		{
			if (m_RemoveCallbacks == null)
			{
				m_RemoveCallbacks = CollectionPool<List<TDelegate>, TDelegate>.Get();
			}
			m_RemoveCallbacks.Add(callback);
			m_MutatedDuringCallback = true;
			return;
		}
		if (m_Length <= 1)
		{
			if (object.Equals(m_SingleDelegate, callback))
			{
				m_SingleDelegate = null;
				m_Length = 0;
			}
			return;
		}
		for (int i = 0; i < m_Length; i++)
		{
			if (object.Equals(m_MultipleDelegates[i], callback))
			{
				m_MultipleDelegates[i] = m_MultipleDelegates[m_Length - 1];
				m_Length--;
				break;
			}
		}
		if (m_Length == 1)
		{
			m_SingleDelegate = m_MultipleDelegates[0];
			m_MultipleDelegates = null;
		}
	}

	public void LockForChanges()
	{
		m_CannotMutateCallbacksArray = true;
	}

	public void UnlockForChanges()
	{
		m_CannotMutateCallbacksArray = false;
		if (!m_MutatedDuringCallback)
		{
			return;
		}
		if (m_AddCallbacks != null)
		{
			foreach (TDelegate addCallback in m_AddCallbacks)
			{
				Add(addCallback);
			}
			CollectionPool<List<TDelegate>, TDelegate>.Release(m_AddCallbacks);
			m_AddCallbacks = null;
		}
		if (m_RemoveCallbacks != null)
		{
			foreach (TDelegate removeCallback in m_RemoveCallbacks)
			{
				RemoveByMovingTail(removeCallback);
			}
			CollectionPool<List<TDelegate>, TDelegate>.Release(m_RemoveCallbacks);
			m_RemoveCallbacks = null;
		}
		m_MutatedDuringCallback = true;
	}
}
