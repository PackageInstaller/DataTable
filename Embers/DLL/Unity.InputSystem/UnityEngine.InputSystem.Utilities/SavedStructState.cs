using System;

namespace UnityEngine.InputSystem.Utilities;

internal sealed class SavedStructState<T> : ISavedState where T : struct
{
	public delegate void TypedRestore(ref T state);

	private T m_State;

	private TypedRestore m_RestoreAction;

	private Action m_StaticDisposeCurrentState;

	internal SavedStructState(ref T state, TypedRestore restoreAction, Action staticDisposeCurrentState = null)
	{
		m_State = state;
		m_RestoreAction = restoreAction;
		m_StaticDisposeCurrentState = staticDisposeCurrentState;
	}

	public void StaticDisposeCurrentState()
	{
		if (m_StaticDisposeCurrentState != null)
		{
			m_StaticDisposeCurrentState();
			m_StaticDisposeCurrentState = null;
		}
	}

	public void RestoreSavedState()
	{
		m_RestoreAction(ref m_State);
		m_RestoreAction = null;
	}
}
