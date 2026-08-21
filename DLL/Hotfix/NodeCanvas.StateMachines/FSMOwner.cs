using NodeCanvas.Framework;
using UnityEngine;

namespace NodeCanvas.StateMachines;

[AddComponentMenu("NodeCanvas/FSM Owner")]
public class FSMOwner : GraphOwner<FSM>
{
	public string currentRootStateName
	{
		get
		{
			if (!(base.behaviour != null))
			{
				return null;
			}
			return base.behaviour.currentStateName;
		}
	}

	public string previousRootStateName
	{
		get
		{
			if (!(base.behaviour != null))
			{
				return null;
			}
			return base.behaviour.previousStateName;
		}
	}

	public string currentDeepStateName => GetCurrentState()?.name;

	public string previousDeepStateName => GetPreviousState()?.name;

	public IState GetCurrentState(bool includeSubFSMs = true)
	{
		if (base.behaviour == null)
		{
			return null;
		}
		FSMState fSMState = base.behaviour.currentState;
		if (includeSubFSMs)
		{
			while (fSMState is NestedFSMState)
			{
				NestedFSMState nestedFSMState = (NestedFSMState)fSMState;
				fSMState = ((nestedFSMState.currentInstance != null) ? nestedFSMState.currentInstance.currentState : null);
			}
		}
		return fSMState;
	}

	public IState GetPreviousState(bool includeSubFSMs = true)
	{
		if (base.behaviour == null)
		{
			return null;
		}
		FSMState fSMState = base.behaviour.currentState;
		FSMState result = base.behaviour.previousState;
		if (includeSubFSMs)
		{
			while (fSMState is NestedFSMState)
			{
				NestedFSMState nestedFSMState = (NestedFSMState)fSMState;
				fSMState = ((nestedFSMState.currentInstance != null) ? nestedFSMState.currentInstance.currentState : null);
				result = ((nestedFSMState.currentInstance != null) ? nestedFSMState.currentInstance.previousState : null);
			}
		}
		return result;
	}

	public IState TriggerState(string stateName)
	{
		return TriggerState(stateName, FSM.TransitionCallMode.Normal);
	}

	public IState TriggerState(string stateName, FSM.TransitionCallMode callMode)
	{
		if (base.behaviour != null)
		{
			return base.behaviour.TriggerState(stateName, callMode);
		}
		return null;
	}

	public string[] GetStateNames()
	{
		if (base.behaviour != null)
		{
			return base.behaviour.GetStateNames();
		}
		return null;
	}
}
