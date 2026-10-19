using System;
using System.Collections.Generic;

namespace ACT.MissionSystem;

public class MissionFSM
{
	private int m_CurrentStateID;

	private MissionFSMState m_CurrentState;

	private Dictionary<int, MissionFSMState> m_States = new Dictionary<int, MissionFSMState>();

	public MissionFSM()
	{
		m_CurrentStateID = int.MinValue;
		m_CurrentState = null;
	}

	public void RegisterState(int stateId, MissionFSMState state)
	{
		if (stateId == int.MinValue)
		{
			throw new ArgumentException("stateId cannot be int.MinValue");
		}
		m_States.Add(stateId, state);
	}

	public void ChangeState(int newState)
	{
		if (m_CurrentStateID != newState)
		{
			m_CurrentState?.Exit();
			m_CurrentState = null;
			m_CurrentStateID = int.MinValue;
			if (m_States.TryGetValue(newState, out m_CurrentState))
			{
				m_CurrentState?.Enter();
				m_CurrentStateID = newState;
			}
		}
	}
}
