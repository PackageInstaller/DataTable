using System;

namespace ACT.Battle.Configs;

[Serializable]
public class ConfigAttackFSMOverlay
{
	public ConfigAnimParameter[] additionalParameters;

	public ConfigAnimState[] stateOverrides;

	public ConfigAnimStateMachine[] stateMachineOverrides;

	public FromMotionTransition[] fromTransitionOverrides;

	public ConfigAttackFSMOverlay()
	{
		additionalParameters = new ConfigAnimParameter[0];
		stateOverrides = new ConfigAnimState[0];
		stateMachineOverrides = new ConfigAnimStateMachine[0];
		fromTransitionOverrides = new FromMotionTransition[0];
	}
}
