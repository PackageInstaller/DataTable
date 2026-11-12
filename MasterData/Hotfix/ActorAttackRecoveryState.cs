using System;
using UnityEngine;

public class ActorAttackRecoveryState : ActorAttackComboPhaseBaseState
{
	public override int GetStateID()
	{
		return 15;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		_actor._onAfterAttackComboPhaseChange?.Invoke(_actor, Combo.Phase.Recovery);
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		if (_fsm.isPlayingLoopCombo)
		{
			_fsm.PlayComboClip(_fsm.currentCombo, Combo.Phase.Recovery);
		}
		base.OnReset(onComplete, onLeave);
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		base.OnLeave(nextState);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (_fsm.GetCurState() != this)
		{
			return;
		}
		if (_actor.lastComboPhaseSwitchFrameCount != LockStepManager.frameCount && _fsm.currentComboClip.CalcComboPhase(_comboNormalizedTime) == Combo.Phase.None)
		{
			_actor._onBeforeAttackComboPhaseChange?.Invoke(_actor, Combo.Phase.Recovery);
			if (_fsm.GetCurState() != this)
			{
				return;
			}
			_fsm.FinishCombo();
		}
		base.OnLateUpdate();
	}
}
