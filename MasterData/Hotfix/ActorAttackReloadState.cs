using System;
using TrueSync;
using UnityEngine;

public class ActorAttackReloadState : ActorStateBase<ActorAttackFSM>
{
	protected Action _onComplete;

	protected bool _reloadCompleted;

	public override int GetStateID()
	{
		return 16;
	}

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		OnReset(onComplete, onLeave);
	}

	public override void OnReset(Action onComplete = null, Action onLeave = null)
	{
		_onComplete = onComplete;
		_reloadCompleted = false;
		_actor.shootBehaviour.reloadAmmoProgress = 0f;
		_fsm.PlayActionAnimation(_actor.shootBehaviour.reloadAnimClip);
		AdventureActorBeginReload adventureActorBeginReload = AdventureActorBeginReload.Generate();
		adventureActorBeginReload.sender = _actor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorBeginReload);
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		if (!_reloadCompleted)
		{
			_actor.shootBehaviour.reloadAmmoProgress = 0f;
			_fsm.StopActionAnimation(fadeOutAnim: false);
			AdventureActorFailReload adventureActorFailReload = AdventureActorFailReload.Generate();
			adventureActorFailReload.sender = _actor;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorFailReload);
		}
	}

	public override void OnUpdate()
	{
		FP logicDeltaTime = _actor.LogicDeltaTime;
		_fsm._comboTimer += logicDeltaTime;
		FP fP = _fsm.CalcComboClipNormalizedTime();
		_fsm.TriggerEvents(fP, onlyTriggerEffectEvents: true);
		FP fP2 = _fsm.currentComboClip.playSpeed * _fsm._comboPlaySpeedMultiplier;
		FP fP3 = _fsm.currentComboClip.GetComboPhaseAnimationLength(Combo.Phase.Anticipation) / fP2;
		FP fP4 = ((!(fP3 > 0)) ? ((FP)1) : (_fsm._comboTimer / fP3));
		_actor.shootBehaviour.reloadAmmoProgress = TSMath.Clamp01(fP4);
		if (fP4 >= 1 && !_reloadCompleted)
		{
			ReloadComplete();
		}
		Combo.Phase phase = _fsm.currentComboClip.CalcComboPhase(fP);
		if (phase == Combo.Phase.Recovery || phase == Combo.Phase.None)
		{
			_fsm.SwitchState(12);
			AdventureActorEndReload adventureActorEndReload = AdventureActorEndReload.Generate();
			adventureActorEndReload.sender = _actor;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorEndReload);
			if (_onComplete != null)
			{
				_onComplete();
			}
		}
	}

	protected void ReloadComplete()
	{
		_reloadCompleted = true;
		_actor.ReloadComplete();
		_actor.ammoInfo.forceReloadAmmo = false;
		AdventureActorFinishReload adventureActorFinishReload = AdventureActorFinishReload.Generate();
		adventureActorFinishReload.sender = _actor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorFinishReload);
	}
}
