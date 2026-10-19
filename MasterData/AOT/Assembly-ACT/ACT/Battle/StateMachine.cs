using System.Collections.Generic;
using System.Text;
using ACT.Battle.Configs;
using ACT.Utility;
using UnityEngine;

namespace ACT.Battle;

public class StateMachine : StateObject, IStateSet, INode<ConfigAnimStateMachine>
{
	public ConfigAnimStateMachine value { get; protected set; }

	public List<StateObject> childrenStateObjects { get; protected set; } = new List<StateObject>();

	public List<StateTransition> anyStateTransitions { get; protected set; } = new List<StateTransition>();

	public List<StateTransition> entryTransitions { get; protected set; } = new List<StateTransition>();

	public List<State> states { get; protected set; } = new List<State>();

	public List<StateMachine> stateMachines { get; protected set; } = new List<StateMachine>();

	public StateMachine()
	{
	}

	public StateMachine(StateLayer stateLayer, StateMachine parentStateMachine, ConfigAnimStateMachine config)
	{
		base.stateLayer = stateLayer;
		base.parentStateMachine = parentStateMachine;
		value = config;
		string[] sonStates = value.sonStates;
		foreach (string text in sonStates)
		{
			if (!stateLayer.stateController.value.states.TryGetConfigByName(text, out var config2, out var index) && LuminApplication.LogEnabled)
			{
				Debug.LogError("配置 " + stateLayer.stateController.value.name + " 里, 状态机 " + config.name + " 的子状态 " + text + " 不存在");
			}
			State item = new State(stateLayer, this, config2, index);
			childrenStateObjects.Add(item);
		}
		sonStates = value.sonStateMachines;
		foreach (string text2 in sonStates)
		{
			if (!stateLayer.stateController.value.stateMachines.TryGetConfigByName(text2, out var config3) && LuminApplication.LogEnabled)
			{
				Debug.LogError("配置 " + stateLayer.stateController.value.name + " 里, 状态机 " + config.name + " 的子状态机 " + text2 + " 不存在");
			}
			StateMachine item2 = new StateMachine(stateLayer, this, config3);
			childrenStateObjects.Add(item2);
		}
		Register();
	}

	public override string Name()
	{
		return value.name;
	}

	public override string ToString(int padLeft = 0)
	{
		StringBuilder stringBuilder = new StringBuilder(PadLeft(padLeft) + "[" + GetType().Name + "]" + value.name);
		foreach (StateObject childrenStateObject in childrenStateObjects)
		{
			stringBuilder.Append("\n" + childrenStateObject.ToString(padLeft + 3));
		}
		stringBuilder.Append("\n" + PadLeft(padLeft + 3) + "\t\t\ttransitions:");
		foreach (StateTransition transition in transitions)
		{
			stringBuilder.Append("\n" + transition.ToString(padLeft + 3));
		}
		stringBuilder.Append("\n" + PadLeft(padLeft + 3) + "\t\t\tanyStateTransitions:");
		foreach (StateTransition anyStateTransition in anyStateTransitions)
		{
			stringBuilder.Append("\n" + anyStateTransition.ToString(padLeft + 3));
		}
		stringBuilder.Append("\n" + PadLeft(padLeft + 3) + "\t\t\tentryTransitions:");
		foreach (StateTransition entryTransition in entryTransitions)
		{
			stringBuilder.Append("\n" + entryTransition.ToString(padLeft + 3));
		}
		return stringBuilder.ToString();
	}

	public override string ToString()
	{
		return "[sm:" + Name() + "]";
	}
}
