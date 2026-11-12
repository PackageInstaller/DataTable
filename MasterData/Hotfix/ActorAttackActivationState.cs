using System;
using UnityEngine;

public class ActorAttackActivationState : ActorAttackComboPhaseBaseState
{
	public override int GetStateID()
	{
		return 14;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		_actor._onAfterAttackComboPhaseChange?.Invoke(_actor, Combo.Phase.Activation);
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		if (_fsm.isPlayingLoopCombo)
		{
			_fsm.PlayComboClip(_fsm.currentCombo, Combo.Phase.Activation);
			_actor.currentAttackTarget = _actor.attackTarget;
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
		if (_fsm.isPlayingLoopCombo)
		{
			if (_actor.lastComboPhaseSwitchFrameCount != LockStepManager.frameCount)
			{
				Combo combo = _fsm.SelectCombo();
				if (combo != null && combo != _fsm.currentCombo)
				{
					_actor._onBeforeAttackComboPhaseChange?.Invoke(_actor, Combo.Phase.Activation);
					if (_fsm.GetCurState() != this)
					{
						return;
					}
					_fsm.PlayCombo(combo);
				}
				else if (_comboNormalizedTime >= 1f)
				{
					_actor._onAttackComboLoop?.Invoke(_actor);
					if (_fsm.GetCurState() != this)
					{
						return;
					}
					_fsm.PlayComboClip(_fsm.currentCombo, Combo.Phase.Activation, phaseLooping: true);
					_actor.currentAttackTarget = _actor.attackTarget;
				}
			}
		}
		else if (_actor.lastComboPhaseSwitchFrameCount != LockStepManager.frameCount && _fsm.currentComboClip.CalcComboPhase(_comboNormalizedTime) != Combo.Phase.Activation)
		{
			_actor._onBeforeAttackComboPhaseChange?.Invoke(_actor, Combo.Phase.Activation);
			if (_fsm.GetCurState() != this)
			{
				return;
			}
			Combo combo2 = _fsm.SelectCombo();
			if (combo2 != null)
			{
				if (!_fsm.isPlayingActionAnimation)
				{
					_actor.animatorController.onStopActionAnimation?.Invoke(_fsm.currentComboClip.animationClip, _fsm.currentComboClip.actionAnimType);
				}
				_fsm.PlayCombo(combo2);
			}
			else
			{
				_fsm.SwitchState(15);
			}
		}
		base.OnLateUpdate();
	}
}
