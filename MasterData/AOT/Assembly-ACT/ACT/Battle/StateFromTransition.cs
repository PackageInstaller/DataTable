using System.Collections.Generic;
using System.Text;
using ACT.Battle.Configs;

namespace ACT.Battle;

public class StateFromTransition : StateControllerObject, INode<FromMotionTransition>
{
	public StateObject origin { get; protected set; }

	public FromMotionTransition value { get; protected set; }

	public List<StateTransition> transitions { get; protected set; } = new List<StateTransition>();

	public StateFromTransition(StateController fromStateController, FromMotionTransition config, Dictionary<string, State> statesDic, Dictionary<string, StateMachine> stateMachinesDic)
	{
		if (config.fromStateMachine)
		{
			origin = fromStateController.stateMachinesDic[config.stateName];
		}
		else
		{
			origin = fromStateController.statesDic[config.stateName];
		}
		value = config;
		ConfigAnimStateTransition[] trans = value.trans;
		foreach (ConfigAnimStateTransition configAnimStateTransition in trans)
		{
			if (configAnimStateTransition.toStateMachine)
			{
				transitions.Add(new StateTransition(origin, configAnimStateTransition, stateMachinesDic));
			}
			else
			{
				transitions.Add(new StateTransition(origin, configAnimStateTransition, statesDic));
			}
		}
	}

	public override string ToString(int padLeft = 0)
	{
		StringBuilder stringBuilder = new StringBuilder(PadLeft(padLeft) + "[" + GetType().Name + "]" + value.name + " from:" + ((origin is State) ? (origin as State).value.name : (origin as StateMachine).value.name));
		foreach (StateTransition transition in transitions)
		{
			stringBuilder.Append("\n" + transition.ToString(padLeft + 3));
		}
		return stringBuilder.ToString();
	}
}
