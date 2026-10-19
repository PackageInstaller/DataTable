using System;

namespace UnityEngine.InputSystem.Utilities;

internal struct CallbackArray<TDelegate> where TDelegate : Delegate
{
	private bool m_CannotMutateCallbacksArray;

	private InlinedArray<TDelegate> m_Callbacks;

	private InlinedArray<TDelegate> m_CallbacksToAdd;

	private InlinedArray<TDelegate> m_CallbacksToRemove;

	public int length => m_Callbacks.length;

	public TDelegate this[int index] => m_Callbacks[index];

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
					m_CallbacksToRemove.RemoveAtByMovingTailWithCapacity(num);
				}
				m_CallbacksToAdd.AppendWithCapacity(dlg);
			}
		}
		else if (!m_Callbacks.Contains(dlg))
		{
			m_Callbacks.AppendWithCapacity(dlg, 4);
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
					m_CallbacksToAdd.RemoveAtByMovingTailWithCapacity(num);
				}
				m_CallbacksToRemove.AppendWithCapacity(dlg);
			}
		}
		else
		{
			int num2 = m_Callbacks.IndexOf(dlg);
			if (num2 >= 0)
			{
				m_Callbacks.RemoveAtWithCapacity(num2);
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
		for (int i = 0; i < m_CallbacksToRemove.length; i++)
		{
			RemoveCallback(m_CallbacksToRemove[i]);
		}
		for (int j = 0; j < m_CallbacksToAdd.length; j++)
		{
			AddCallback(m_CallbacksToAdd[j]);
		}
		m_CallbacksToAdd.Clear();
		m_CallbacksToRemove.Clear();
	}
}
