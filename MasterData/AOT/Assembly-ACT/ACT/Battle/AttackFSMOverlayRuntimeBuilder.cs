using System.Collections.Generic;
using ACT.Battle.Configs;

namespace ACT.Battle;

public static class AttackFSMOverlayRuntimeBuilder
{
	public static void Apply(StateAttackController controller, ConfigAttackFSMOverlay overlay)
	{
		if (overlay == null)
		{
			return;
		}
		if (overlay.stateOverrides != null)
		{
			for (int i = 0; i < overlay.stateOverrides.Length; i++)
			{
				ConfigAnimState configAnimState = overlay.stateOverrides[i];
				State state = controller.statesDic[configAnimState.name];
				ReplaceTransitions(state, state.transitions, configAnimState.transitions, controller);
			}
		}
		if (overlay.stateMachineOverrides != null)
		{
			for (int j = 0; j < overlay.stateMachineOverrides.Length; j++)
			{
				ConfigAnimStateMachine configAnimStateMachine = overlay.stateMachineOverrides[j];
				StateMachine stateMachine = controller.stateMachinesDic[configAnimStateMachine.name];
				ReplaceTransitions(stateMachine, stateMachine.transitions, configAnimStateMachine.transitions, controller);
				ReplaceTransitions(stateMachine, stateMachine.anyStateTransitions, configAnimStateMachine.anyStateTransitions, controller);
				ReplaceTransitions(stateMachine, stateMachine.entryTransitions, configAnimStateMachine.entryTransitions, controller);
			}
		}
		if (overlay.fromTransitionOverrides != null)
		{
			for (int k = 0; k < overlay.fromTransitionOverrides.Length; k++)
			{
				FromMotionTransition fromMotionTransition = overlay.fromTransitionOverrides[k];
				StateFromTransition stateFromTransition = FindFromTransition(controller.fromTransitions, fromMotionTransition.name);
				ReplaceTransitions(stateFromTransition.origin, stateFromTransition.transitions, fromMotionTransition.trans, controller);
			}
		}
		controller.RebuildAnyStateTransitionCache();
	}

	private static StateFromTransition FindFromTransition(List<StateFromTransition> fromTransitions, string name)
	{
		for (int i = 0; i < fromTransitions.Count; i++)
		{
			if (fromTransitions[i].value.name == name)
			{
				return fromTransitions[i];
			}
		}
		return null;
	}

	private static void ReplaceTransitions(StateObject origin, List<StateTransition> runtimeTransitions, ConfigAnimStateTransition[] configTransitions, StateAttackController controller)
	{
		runtimeTransitions.Clear();
		foreach (ConfigAnimStateTransition configAnimStateTransition in configTransitions)
		{
			runtimeTransitions.Add(configAnimStateTransition.toStateMachine ? new StateTransition(origin, configAnimStateTransition, controller.stateMachinesDic) : new StateTransition(origin, configAnimStateTransition, controller.statesDic));
		}
	}
}
