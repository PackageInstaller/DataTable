using System;
using System.Collections.Generic;
using System.Text;
using ACT.Battle.Configs;
using UnityEngine;

namespace ACT.Battle;

public class StateTransition : StateControllerObject, INode<ConfigAnimStateTransition>
{
	public StateObject origin { get; protected set; }

	public StateObject destination { get; set; }

	public ConfigAnimStateTransition value { get; protected set; }

	public StateTransition(StateObject origin, ConfigAnimStateTransition config, Dictionary<string, State> statesDic)
	{
		this.origin = origin;
		try
		{
			if (!string.IsNullOrEmpty(config.stateName))
			{
				destination = statesDic[config.stateName];
			}
		}
		catch (Exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(origin.Name() + " 转到 不存在的状态 " + config.stateName);
			}
			destination = null;
			throw;
		}
		value = config;
	}

	public StateTransition(StateObject origin, ConfigAnimStateTransition config, Dictionary<string, StateMachine> stateMachinesDic)
	{
		this.origin = origin;
		try
		{
			if (!string.IsNullOrEmpty(config.stateName))
			{
				destination = stateMachinesDic[config.stateName];
			}
		}
		catch (Exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(origin.Name() + " 转到 不存在的状态机 " + config.stateName);
			}
			destination = null;
		}
		value = config;
	}

	public override string ToString(int padLeft = 0)
	{
		if (destination == null)
		{
			return PadLeft(padLeft) + "[" + GetType().Name + "]exit";
		}
		StringBuilder stringBuilder = new StringBuilder();
		if (value.conditions.Length != 0)
		{
			stringBuilder.Append("\n" + PadLeft(padLeft + 3) + "\t\t\tparameter:");
			ConfigAnimCondition[] conditions = value.conditions;
			for (int i = 0; i < conditions.Length; i++)
			{
				ConfigAnimCondition configAnimCondition = conditions[i];
				stringBuilder.Append("\n" + PadLeft(padLeft + 3) + "\t\t\t" + configAnimCondition.parameter);
			}
		}
		return PadLeft(padLeft) + "[" + GetType().Name + "] {to:" + ((destination is State) ? (destination as State).value.name : (destination as StateMachine).value.name) + "}" + stringBuilder;
	}

	public override string ToString()
	{
		return $"{origin}->{destination}";
	}
}
