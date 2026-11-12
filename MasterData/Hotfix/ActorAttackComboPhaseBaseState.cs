using System;
using TrueSync;
using UnityEngine;

public abstract class ActorAttackComboPhaseBaseState : ActorStateBase<ActorAttackFSM>
{
	protected FP _comboNormalizedTime;

	private bool _sendSkillTakeEffectEnd;

	private bool _sendSkillAllowOtherSkillExecuteEnd;

	public FP ComboNormalizedTime => _comboNormalizedTime;

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		OnReset(onComplete, onLeave);
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		_sendSkillTakeEffectEnd = false;
		_sendSkillAllowOtherSkillExecuteEnd = false;
		_actor.lastComboPhaseSwitchFrameCount = LockStepManager.frameCount;
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
	}

	public override void OnUpdate()
	{
		FP logicDeltaTime = _actor.LogicDeltaTime;
		_fsm._comboTimer += logicDeltaTime;
		_comboNormalizedTime = _fsm.CalcComboClipNormalizedTime();
		_fsm.UpdateRootMotion(_comboNormalizedTime);
		_fsm.TriggerEvents(_comboNormalizedTime);
		if (_fsm.currentComboClip == null)
		{
			return;
		}
		if (_fsm.currentComboClip.sendSkillTakeEffect && !_sendSkillTakeEffectEnd && _comboNormalizedTime >= _fsm.currentComboClip.skillTakeEffectNormalizedTime)
		{
			_actor.onSendSkillTakeEffect?.Invoke(_actor);
			_sendSkillTakeEffectEnd = true;
		}
		if (_fsm.currentComboClip.sendSkillAllowOtherSkillExecute && !_sendSkillAllowOtherSkillExecuteEnd && _comboNormalizedTime >= _fsm.currentComboClip.skillAllowOtherSkillExecuteNormalizedTime)
		{
			_actor.onSendSkillAllowOtherSkillExecute?.Invoke(_actor, arg2: true);
			_sendSkillAllowOtherSkillExecuteEnd = true;
		}
		if (_fsm.currentComboClip.changeCurrentAttackTargetCfgs.Count > 0)
		{
			for (int i = 0; i < _fsm.currentComboClip.changeCurrentAttackTargetCfgs.Count; i++)
			{
				ChangeCurrentAttackTargetCfg changeCurrentAttackTargetCfg = _fsm.currentComboClip.changeCurrentAttackTargetCfgs.get_Item(i);
				if (_comboNormalizedTime >= changeCurrentAttackTargetCfg.normalizedTime && _fsm.currentComboClip.changeCurrentAttackTargetTriggerDict.TryGetValue(i, out var value) && !value)
				{
					_fsm.currentComboClip.changeCurrentAttackTargetTriggerDict.set_Item(i, true);
					_actor.currentAttackTarget = _actor.attackTarget;
					_actor.enableChangeCurrentAttackTarget = true;
				}
			}
		}
		if (_fsm.currentCombo.useExitTime && _fsm.currentComboClip.useExitTime && _comboNormalizedTime >= _fsm.currentComboClip.canExitNormalizedTime)
		{
			_actor.comboTriggerExitTime = true;
		}
	}

	public virtual void OnLateUpdate()
	{
		_fsm.UpdateFeaturePhase(_comboNormalizedTime);
	}
}
