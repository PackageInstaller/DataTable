using System;

namespace ACT.Battle.Configs;

[Serializable]
public class ConfigAnimState
{
	public string name;

	public MotionState stateType;

	public StateTag tag;

	public ConfigAnimStateTransition[] transitions;

	public ConfigAnimState()
	{
		transitions = new ConfigAnimStateTransition[0];
	}
}
