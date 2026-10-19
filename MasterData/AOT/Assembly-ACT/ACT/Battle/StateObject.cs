using System.Collections.Generic;

namespace ACT.Battle;

public abstract class StateObject : StateControllerObject
{
	public StateLayer stateLayer { get; protected set; }

	public StateMachine parentStateMachine { get; protected set; }

	public List<StateTransition> transitions { get; protected set; } = new List<StateTransition>();

	public abstract string Name();

	protected void Register()
	{
		bool flag = this is State;
		if (parentStateMachine != null)
		{
			if (flag)
			{
				parentStateMachine.states.Add(this as State);
			}
			else
			{
				parentStateMachine.stateMachines.Add(this as StateMachine);
			}
		}
		if (flag)
		{
			stateLayer.states.Add(this as State);
			stateLayer.stateController.statesDic[Name()] = this as State;
		}
		else
		{
			stateLayer.stateMachines.Add(this as StateMachine);
			stateLayer.stateController.stateMachinesDic[Name()] = this as StateMachine;
		}
	}
}
