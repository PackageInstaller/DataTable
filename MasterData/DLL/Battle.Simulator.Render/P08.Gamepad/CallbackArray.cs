using System;
using System.Collections.Generic;

namespace P08.Gamepad;

internal class CallbackArray<TDelegate> where TDelegate : Delegate
{
	private bool m_CannotMutateCallbacksArray;

	private List<TDelegate> m_Callbacks;

	private List<TDelegate> m_CallbacksToAdd;

	private List<TDelegate> m_CallbacksToRemove;

	public int length => m_Callbacks.Count;

	public TDelegate this[int index] => m_Callbacks[index];

	public CallbackArray()
	{
		m_CannotMutateCallbacksArray = false;
		m_Callbacks = new List<TDelegate>();
		m_CallbacksToAdd = new List<TDelegate>();
		m_CallbacksToRemove = new List<TDelegate>();
	}

	public void Clear()
	{
		m_Callbacks.Clear();
		m_CallbacksToAdd.Clear();
		m_CallbacksToRemove.Clear();
	}

	public void AddCallback(TDelegate dlg)
	{
		if (m_CannotMutateCallbacksArray)
		{
			if (!m_CallbacksToAdd.Contains(dlg))
			{
				int num = m_CallbacksToRemove.IndexOf(dlg);
				if (num != -1)
				{
					m_CallbacksToRemove.RemoveAt(num);
				}
				m_CallbacksToAdd.Add(dlg);
				m_Callbacks.Remove(dlg);
			}
		}
		else if (!m_Callbacks.Contains(dlg))
		{
			m_Callbacks.Add(dlg);
		}
	}

	public void RemoveCallback(TDelegate dlg)
	{
		if (m_CannotMutateCallbacksArray)
		{
			if (!m_CallbacksToRemove.Contains(dlg))
			{
				int num = m_CallbacksToAdd.IndexOf(dlg);
				if (num != -1)
				{
					m_CallbacksToAdd.RemoveAt(num);
				}
				m_CallbacksToRemove.Add(dlg);
			}
		}
		else
		{
			int num2 = m_Callbacks.IndexOf(dlg);
			if (num2 >= 0)
			{
				m_Callbacks.RemoveAt(num2);
			}
		}
	}

	public void LockForChanges()
	{
		m_CannotMutateCallbacksArray = true;
	}

	public void UnlockForChanges()
	{
		m_CannotMutateCallbacksArray = false;
		for (int i = 0; i < m_CallbacksToRemove.Count; i++)
		{
			RemoveCallback(m_CallbacksToRemove[i]);
		}
		for (int j = 0; j < m_CallbacksToAdd.Count; j++)
		{
			AddCallback(m_CallbacksToAdd[j]);
		}
		m_CallbacksToAdd.Clear();
		m_CallbacksToRemove.Clear();
	}
}
