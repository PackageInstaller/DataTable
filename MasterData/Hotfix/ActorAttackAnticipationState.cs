using System;
using UnityEngine;

public class ActorAttackAnticipationState : ActorAttackComboPhaseBaseState
{
	public override int GetStateID()
	{
		return 13;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		_actor._onAfterAttackComboPhaseChange?.Invoke(_actor, Combo.Phase.Anticipation);
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		_fsm.PlayComboClip(_fsm.currentCombo, Combo.Phase.Anticipation);
		_actor.currentAttackTarget = _actor.attackTarget;
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
		if (_fsm.isPlayingLoopCombo)
		{
			if (_actor.lastComboPhaseSwitchFrameCount != LockStepManager.frameCount && _comboNormalizedTime >= 1f)
			{
				_actor._onBeforeAttackComboPhaseChange?.Invoke(_actor, Combo.Phase.Anticipation);
				if (_fsm.GetCurState() != this)
				{
					return;
				}
				_fsm.SwitchState(14);
			}
		}
		else if (_actor.lastComboPhaseSwitchFrameCount != LockStepManager.frameCount && _fsm.currentComboClip.CalcComboPhase(_comboNormalizedTime) != Combo.Phase.Anticipation)
		{
			_actor._onBeforeAttackComboPhaseChange?.Invoke(_actor, Combo.Phase.Anticipation);
			if (_fsm.GetCurState() != this)
			{
				return;
			}
			_fsm.SwitchState(14);
		}
		base.OnLateUpdate();
	}
}
