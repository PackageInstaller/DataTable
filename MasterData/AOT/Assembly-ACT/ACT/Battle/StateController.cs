using System.Collections.Generic;
using System.Text;
using ACT.Battle.Configs;

namespace ACT.Battle;

public class StateController : StateControllerObject, INode<ConfigMotionStateMachine>
{
	public Dictionary<string, State> statesDic;

	public Dictionary<string, StateMachine> stateMachinesDic;

	private Dictionary<string, List<StateTransition>> anyStateTransitionsByParameterName = new Dictionary<string, List<StateTransition>>();

	public ConfigMotionStateMachine value { get; protected set; }

	public List<StateLayer> childrenStateLayers { get; protected set; } = new List<StateLayer>();

	public StateController(ConfigMotionStateMachine config)
	{
		value = config;
		statesDic = new Dictionary<string, State>();
		stateMachinesDic = new Dictionary<string, StateMachine>();
		ConfigAnimLayer[] layers = config.layers;
		foreach (ConfigAnimLayer config2 in layers)
		{
			childrenStateLayers.Add(new StateLayer(this, config2, statesDic, stateMachinesDic));
		}
		RebuildAnyStateTransitionCache();
	}

	public bool CheckAnyStateTransitions(string v, out List<StateTransition> transitions)
	{
		return anyStateTransitionsByParameterName.TryGetValue(v, out transitions);
	}

	internal void RebuildAnyStateTransitionCache()
	{
		anyStateTransitionsByParameterName.Clear();
		foreach (KeyValuePair<string, StateMachine> item in stateMachinesDic)
		{
			foreach (StateTransition anyStateTransition in item.Value.anyStateTransitions)
			{
				ConfigAnimCondition[] conditions = anyStateTransition.value.conditions;
				for (int i = 0; i < conditions.Length; i++)
				{
					ConfigAnimCondition configAnimCondition = conditions[i];
					if (!anyStateTransitionsByParameterName.ContainsKey(configAnimCondition.parameter))
					{
						anyStateTransitionsByParameterName.Add(configAnimCondition.parameter, new List<StateTransition> { anyStateTransition });
					}
					else if (!anyStateTransitionsByParameterName[configAnimCondition.parameter].Contains(anyStateTransition))
					{
						anyStateTransitionsByParameterName[configAnimCondition.parameter].Add(anyStateTransition);
					}
				}
			}
		}
	}

	public override string ToString(int padLeft = 0)
	{
		StringBuilder stringBuilder = new StringBuilder(PadLeft(padLeft) + "[" + GetType().Name + "]" + value.name);
		foreach (StateLayer childrenStateLayer in childrenStateLayers)
		{
			stringBuilder.Append("\n" + childrenStateLayer.ToString(padLeft + 3));
		}
		return stringBuilder.ToString();
	}
}
