using System;
using System.Collections;
using TrueSync;
using UnityEngine;

public class PlayerActionState : ActorActionState
{
	protected bool _movementHasInput;

	protected TSVector2 _movementInputVector;

	protected TSVector2 _movementInputDirection;

	protected Combo.Phase _curComboPhase;

	protected ActorSearchTarget search;

	protected ActorSkillManage skillManage;

	private PlayerAdventureActor _playerActor;

	private bool _isReloadDelayTimeEnd;

	private bool _isReloadDelaying;

	private CoroutineNode _reloadDelayTimeCoroutine;

	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		if (search == null)
		{
			search = _actor?.actorSearchTargetInfo;
		}
		if (skillManage == null)
		{
			skillManage = _actor?.actorSkillManage;
		}
		AdventureActor actor = _actor;
		actor.onBeforeAttackComboPhaseChange = (Action<AdventureActor, Combo.Phase>)Delegate.Combine(actor.onBeforeAttackComboPhaseChange, new Action<AdventureActor, Combo.Phase>(ComboStateCallback));
		_playerActor = _actor as PlayerAdventureActor;
	}

	public override void OnLeave(IBehaviourState<GameObject> nextState)
	{
		base.OnLeave(nextState);
		AdventureActor actor = _actor;
		actor.onBeforeAttackComboPhaseChange = (Action<AdventureActor, Combo.Phase>)Delegate.Remove(actor.onBeforeAttackComboPhaseChange, new Action<AdventureActor, Combo.Phase>(ComboStateCallback));
		_isReloadDelaying = false;
		_isReloadDelayTimeEnd = false;
		if (_reloadDelayTimeCoroutine != null)
		{
			_actor.StopLogicCoroutine(_reloadDelayTimeCoroutine);
			_reloadDelayTimeCoroutine = null;
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (!(_actor == null))
		{
			SearchTargetControl();
			MoveControl();
			ReloadControl();
		}
	}

	private void SearchTargetControl()
	{
		if (!_actor.disableMove && _movementHasInput)
		{
			switch (_playerActor.searchType)
			{
			case PlayerActorSearchType.Range:
				search.EnableVisionLogic();
				search.EnableHearingLogic();
				break;
			case PlayerActorSearchType.Melee:
				search.EnableVisionLogic();
				search.EnableHearingLogic(enable: false);
				break;
			}
		}
		else
		{
			switch (_playerActor.searchType)
			{
			case PlayerActorSearchType.Range:
				search.EnableVisionLogic();
				search.EnableHearingLogic();
				break;
			case PlayerActorSearchType.Melee:
				search.EnableVisionLogic(enable: false);
				search.EnableHearingLogic();
				break;
			}
		}
		if (_actor.movementState == ActorState.Dodge || _actor.isInteractive)
		{
			search.EnableVisionLogic(enable: false);
			search.EnableHearingLogic(enable: false);
		}
	}

	private void MoveControl()
	{
		if (_playerActor.moveControlType == PlayerActorMoveType.Range)
		{
			if (_actor.specialDodgeMode || (_actor.movementState != ActorState.StandBy && _actor.movementState != ActorState.Move))
			{
				return;
			}
			if (!_movementHasInput)
			{
				if (_actor.actorInfo.fastSpeedMode)
				{
					_actor.Run(_actor.tsTransform.Forward.normalized);
				}
				else if (!_actor.isCharm && !_actor.isTerror && _actor._movementFSM.moveMode == ActorMoveState.MoveMode.MoveByDirection)
				{
					_actor.StandBy();
				}
			}
			else if (!_actor.disableMove && skillManage.CheckIsMovable())
			{
				if (((PlayerAdventureActor)_actor).dodgeButtonHold)
				{
					_actor.Run(_movementInputDirection);
				}
				else if (_actor.actorSkillManage.HaveRunningSkill() || _actor.aimMode != AdventureActor.AimMode.Forward)
				{
					_actor.Walk(_movementInputDirection);
				}
				else
				{
					_actor.Run(_movementInputDirection);
				}
			}
			else if (!_actor.isCharm && !_actor.isTerror && _actor.movementState == ActorState.Move)
			{
				_actor.StandBy();
			}
		}
		else
		{
			if (_playerActor.moveControlType != PlayerActorMoveType.Melee)
			{
				return;
			}
			if (!_actor.disableMove && _movementHasInput)
			{
				if (skillManage.CheckIsMovable())
				{
					if (null == _actor.attackTarget)
					{
						_actor.InterruptAttack(force: false, fadeOutAnim: true, interruptReload: false);
					}
					_actor.Run(_movementInputDirection);
				}
				else if (_actor.movementState == ActorState.Move)
				{
					_actor.StandBy();
				}
			}
			else if (_actor.movementState == ActorState.StandBy || _actor.movementState == ActorState.Move)
			{
				if (_actor.actorInfo.fastSpeedMode)
				{
					_actor.Run(_actor.tsTransform.Forward.normalized);
				}
				else if (!_actor.isCharm && !_actor.isTerror && _actor._movementFSM.moveMode == ActorMoveState.MoveMode.MoveByDirection)
				{
					_actor.StandBy();
				}
			}
		}
	}

	private void ReloadControl()
	{
		if (!_playerActor.enableReload || _actor.ammoInfo == null || _actor.ammoInfo.ammoCount == _actor.ammoInfo.ammoCountMax || _actor.shootBehaviour.isReloadingAmmo)
		{
			return;
		}
		if (_actor.ammoInfo.forceReloadAmmo)
		{
			_actor.shootBehaviour.ReloadAmmo();
		}
		else
		{
			if (_isReloadDelaying && _actor.ammoInfo.ammoCount > 0)
			{
				return;
			}
			if (_actor.attackTarget == null && _actor.ammoInfo.ammoCount > 0 && !_isReloadDelayTimeEnd)
			{
				_reloadDelayTimeCoroutine = _actor.StartLogicCoroutine(ReloadDelay());
			}
			else if (!((PlayerAdventureActor)_actor).dodgeButtonHold && !_actor.isPlayingAttackCombo && (!(_actor.attackTarget != null) || _actor.ammoInfo.ammoCount <= 0))
			{
				_actor.shootBehaviour.ReloadAmmo();
				_isReloadDelaying = false;
				_isReloadDelayTimeEnd = false;
				if (_reloadDelayTimeCoroutine != null)
				{
					_actor.StopLogicCoroutine(_reloadDelayTimeCoroutine);
					_reloadDelayTimeCoroutine = null;
				}
			}
		}
	}

	private IEnumerator ReloadDelay()
	{
		_isReloadDelaying = true;
		_isReloadDelayTimeEnd = false;
		FP waitTime = 0;
		while (true)
		{
			waitTime += _actor.LogicDeltaTime;
			if (waitTime >= AdventureModuleController.Config.reloadDelayTime)
			{
				break;
			}
			yield return null;
		}
		_isReloadDelaying = false;
		_isReloadDelayTimeEnd = true;
	}

	protected virtual void ComboStateCallback(AdventureActor actor, Combo.Phase phase)
	{
		_curComboPhase = phase;
	}

	public override void OnMovementInput(bool movementHasInput, TSVector2 movementInputVector, TSVector2 movementInputDirection)
	{
		_movementHasInput = movementHasInput;
		_movementInputVector = movementInputVector;
		_movementInputDirection = movementInputDirection;
	}
}
