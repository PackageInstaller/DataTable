using System;

namespace ACT.MissionSystem;

public class MissionFSMState_Normal : MissionFSMState
{
	private Action m_OnEnter;

	private Action m_OnExit;

	public MissionFSMState_Normal(Action onEnter, Action onExit)
	{
		m_OnEnter = onEnter;
		m_OnExit = onExit;
	}

	protected override void OnEnter()
	{
		m_OnEnter?.Invoke();
	}

	protected override void OnExit()
	{
		m_OnExit?.Invoke();
	}
}
