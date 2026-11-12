using System;
using TrueSync;
using UnityEngine;

public class ActorNonAttackState : ActorStateBase<ActorAttackFSM>
{
	public override int GetStateID()
	{
		return 12;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		OnReset(onComplete, onLeave);
		if (_actor._onAfterAttackComboPhaseChange != null)
		{
			_actor._onAfterAttackComboPhaseChange(_actor, Combo.Phase.None);
		}
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		_fsm.ResetCombo();
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
	}

	public override void OnUpdate()
	{
		if (_fsm.isPlayingActionAnimation)
		{
			UpdateActionAnimation();
		}
	}

	protected void UpdateActionAnimation()
	{
		FP logicDeltaTime = _actor.LogicDeltaTime;
		_fsm._comboTimer += logicDeltaTime;
		FP fP = _fsm.CalcComboClipNormalizedTime();
		_fsm.UpdateRootMotion(fP);
		_fsm.TriggerEvents(fP, onlyTriggerEffectEvents: true);
		if (_fsm.currentComboClip.CalcComboPhase(fP) == Combo.Phase.None)
		{
			_fsm.FinishActionAnimation();
		}
	}
}
