using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class ConfigAnimStateMachine
{
	public string name;

	public StateMachineType type;

	[Tooltip("状态子集统一的转出线")]
	public ConfigAnimStateTransition[] transitions;

	[Tooltip("所有state转入内部state的线")]
	public ConfigAnimStateTransition[] anyStateTransitions;

	[Tooltip("自己内部的entry转出的线")]
	public ConfigAnimStateTransition[] entryTransitions;

	[Tooltip("状态子集包含的所有状态节点")]
	public string[] sonStates;

	public string[] sonStateMachines;

	public ConfigAnimStateMachine()
	{
		transitions = new ConfigAnimStateTransition[0];
		anyStateTransitions = new ConfigAnimStateTransition[0];
		entryTransitions = new ConfigAnimStateTransition[0];
		sonStates = new string[0];
		sonStateMachines = new string[0];
	}
}
