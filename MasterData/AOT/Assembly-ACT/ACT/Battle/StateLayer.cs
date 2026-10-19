using System.Collections.Generic;
using System.Text;
using ACT.Battle.Configs;
using ACT.Utility;
using UnityEngine;

namespace ACT.Battle;

public class StateLayer : StateControllerObject, IStateSet, INode<ConfigAnimLayer>
{
	public StateController stateController { get; protected set; }

	public ConfigAnimLayer value { get; protected set; }

	public StateMachine stateMachine { get; protected set; }

	public List<State> states { get; protected set; } = new List<State>();

	public List<StateMachine> stateMachines { get; protected set; } = new List<StateMachine>();

	public StateLayer(StateController stateController, ConfigAnimLayer config, Dictionary<string, State> statesDic, Dictionary<string, StateMachine> stateMachinesDic)
	{
		this.stateController = stateController;
		value = config;
		if (!stateController.value.stateMachines.TryGetConfigByName(value.defaultMachine, out var config2))
		{
			Debug.LogError("配置 " + stateController.value.name + " 里, 层 " + config.name + " 的默认状态机 " + value.defaultMachine + " 不存在");
		}
		stateMachine = new StateMachine(this, null, config2);
		stateMachinesDic[config2.name] = stateMachine;
		foreach (State state in states)
		{
			ConfigAnimStateTransition[] transitions = state.value.transitions;
			foreach (ConfigAnimStateTransition configAnimStateTransition in transitions)
			{
				if (configAnimStateTransition.toStateMachine)
				{
					state.transitions.Add(new StateTransition(state, configAnimStateTransition, stateMachinesDic));
				}
				else
				{
					state.transitions.Add(new StateTransition(state, configAnimStateTransition, statesDic));
				}
			}
		}
		foreach (StateMachine stateMachine in stateMachines)
		{
			ConfigAnimStateTransition[] transitions = stateMachine.value.transitions;
			foreach (ConfigAnimStateTransition configAnimStateTransition2 in transitions)
			{
				if (configAnimStateTransition2.toStateMachine)
				{
					stateMachine.transitions.Add(new StateTransition(stateMachine, configAnimStateTransition2, stateMachinesDic));
				}
				else
				{
					stateMachine.transitions.Add(new StateTransition(stateMachine, configAnimStateTransition2, statesDic));
				}
			}
			transitions = stateMachine.value.anyStateTransitions;
			foreach (ConfigAnimStateTransition configAnimStateTransition3 in transitions)
			{
				if (configAnimStateTransition3.toStateMachine)
				{
					stateMachine.anyStateTransitions.Add(new StateTransition(stateMachine, configAnimStateTransition3, stateMachinesDic));
				}
				else
				{
					stateMachine.anyStateTransitions.Add(new StateTransition(stateMachine, configAnimStateTransition3, statesDic));
				}
			}
			transitions = stateMachine.value.entryTransitions;
			foreach (ConfigAnimStateTransition configAnimStateTransition4 in transitions)
			{
				if (configAnimStateTransition4.toStateMachine)
				{
					stateMachine.entryTransitions.Add(new StateTransition(stateMachine, configAnimStateTransition4, stateMachinesDic));
				}
				else
				{
					stateMachine.entryTransitions.Add(new StateTransition(stateMachine, configAnimStateTransition4, statesDic));
				}
			}
		}
	}

	public override string ToString(int padLeft = 0)
	{
		StringBuilder stringBuilder = new StringBuilder(PadLeft(padLeft) + "[" + GetType().Name + "]" + value.name);
		stringBuilder.Append("\n" + stateMachine.ToString(padLeft + 3));
		return stringBuilder.ToString();
	}

	public ConfigAnimLayer ToConfig()
	{
		value.defaultMachine = stateMachine.Name();
		return value;
	}
}
