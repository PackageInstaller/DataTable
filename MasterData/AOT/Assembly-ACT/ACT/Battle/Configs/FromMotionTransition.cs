using System;

namespace ACT.Battle.Configs;

[Serializable]
public class FromMotionTransition
{
	public string name;

	public bool fromStateMachine;

	public string stateName;

	public ConfigAnimStateTransition[] trans;
}
