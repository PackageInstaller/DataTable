using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript;

public class SkillAdvancedBase : AIBase
{
	protected bool _isDisableByLostControl;

	private bool _isReceiveSkillTakeEffect;

	private ComboAttack _comboAttack;

	private AimTarget _aim;

	public ComboAttack comboAttack => _comboAttack;

	public void OnEnable()
	{
		_actor = _skill.actor;
		_isDisableByLostControl = false;
		_isReceiveSkillTakeEffect = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		OnSkillEnable();
	}

	public void OnDisable()
	{
		ILRuntimeAPI.ClearComboAttack(_comboAttack);
		if (_actor is PlayerAdventureActor && _skill.checkCdRestore && !_isReceiveSkillTakeEffect)
		{
			ILRuntimeAPI.ReturnSkillResumeTime(_skill.skillId, _actor);
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		CancelLockDirection();
		OnSkillDisable();
	}

	protected virtual void OnSkillDisable()
	{
	}

	protected virtual void OnSkillEnable()
	{
	}

	protected virtual void OnActorDied(IEvent evt)
	{
		if (_actor != null && _actor == (evt as AdventureActorDiedEvent).actor)
		{
			_skill?.Clear();
		}
	}

	protected virtual void OnActorLostControl(IEvent evt)
	{
		if (_actor != null && _actor == (evt as AdventureActorLostControlEvent).actor)
		{
			_isDisableByLostControl = true;
			_skill?.Clear();
		}
	}

	protected virtual void OnActorBeControlled(IEvent evt)
	{
		if (_actor != null && _actor == (evt as AdventureActorBeControlledEvent).actor)
		{
			_isDisableByLostControl = true;
			_skill?.Clear();
		}
	}

	protected virtual void OnReceiveAttack(IEvent evt)
	{
	}

	protected virtual void OnReceiveDamage(IEvent evt)
	{
	}

	protected IEnumerator Finish(FP waitSeconds)
	{
		if (waitSeconds > 0)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitSeconds));
		}
		_skill?.Clear();
	}

	protected void SetSkillPhaseConfig(SkillPhaseFeatureFlag executeConfigFlag, List<int> executeConfigSkillIds, SkillPhaseFeatureFlag breakConfigFlag, List<int> breakConfigSkillIds)
	{
		if (_skill != null)
		{
			_skill.SetCurrentPhaseExecuteConfig(new SkillPhaseConfig
			{
				skillPhaseFeatureFlag = executeConfigFlag,
				skillIds = executeConfigSkillIds
			});
			_skill.SetCurrentPhaseBreakConfig(new SkillPhaseConfig
			{
				skillPhaseFeatureFlag = breakConfigFlag,
				skillIds = breakConfigSkillIds
			});
		}
	}

	protected RequestComboAttack BeginAttack(ComboInputBuffer.ActionKey key, bool flushInputedKeys = false, bool forceInterruptAttack = false, bool autoLookAtTarget = false, LogicEntity attackTarget = null, LogicEntity aimTarget = null, TSVector2 aimTargetPosition = default(TSVector2), Action onAnticipationEnd = null, Action onRecoveryBegin = null, Action onComboFinish = null, Action onInterrupt = null, Action<string> onCustomEvent = null, Action onActivationEnd = null, bool fadeOutAnim = false, Action onComboLoop = null, bool recoveryBeginCheckCdStart = true)
	{
		ComboInputBuffer.ActionKey[] keys = new ComboInputBuffer.ActionKey[1] { key };
		return BeginAttack(keys, "", flushInputedKeys, forceInterruptAttack, autoLookAtTarget, attackTarget, aimTarget, aimTargetPosition, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd, fadeOutAnim, onComboLoop, recoveryBeginCheckCdStart);
	}

	protected RequestComboAttack BeginAttack(ComboInputBuffer.ActionKey[] keys, bool flushInputedKeys = false, bool forceInterruptAttack = false, bool autoLookAtTarget = false, LogicEntity attackTarget = null, LogicEntity aimTarget = null, TSVector2 aimTargetPosition = default(TSVector2), Action onAnticipationEnd = null, Action onRecoveryBegin = null, Action onComboFinish = null, Action onInterrupt = null, Action<string> onCustomEvent = null, Action onActivationEnd = null, bool fadeOutAnim = false, Action onComboLoop = null, bool recoveryBeginCheckCdStart = true)
	{
		return BeginAttack(keys, "", flushInputedKeys, forceInterruptAttack, autoLookAtTarget, attackTarget, aimTarget, aimTargetPosition, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd, fadeOutAnim, onComboLoop, recoveryBeginCheckCdStart);
	}

	protected RequestComboAttack BeginAttack(string actionTag, bool flushInputedKeys = false, bool forceInterruptAttack = false, bool autoLookAtTarget = false, LogicEntity attackTarget = null, LogicEntity aimTarget = null, TSVector2 aimTargetPosition = default(TSVector2), Action onAnticipationEnd = null, Action onRecoveryBegin = null, Action onComboFinish = null, Action onInterrupt = null, Action<string> onCustomEvent = null, Action onActivationEnd = null, bool fadeOutAnim = false, Action onComboLoop = null, bool recoveryBeginCheckCdStart = true)
	{
		return BeginAttack(null, actionTag, flushInputedKeys, forceInterruptAttack, autoLookAtTarget, attackTarget, aimTarget, aimTargetPosition, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd, fadeOutAnim, onComboLoop, recoveryBeginCheckCdStart);
	}

	private RequestComboAttack BeginAttack(ComboInputBuffer.ActionKey[] keys, string actionTag, bool flushInputedKeys = false, bool forceInterruptAttack = false, bool autoLookAtTarget = false, LogicEntity attackTarget = null, LogicEntity aimTarget = null, TSVector2 aimTargetPosition = default(TSVector2), Action onAnticipationEnd = null, Action onRecoveryBegin = null, Action onComboFinish = null, Action onInterrupt = null, Action<string> onCustomEvent = null, Action onActivationEnd = null, bool fadeOutAnim = false, Action onComboLoop = null, bool recoveryBeginCheckCdStart = true)
	{
		RequestComboAttack requestComboAttack = new RequestComboAttack();
		_skill.isActivationEnd = false;
		ILRuntimeAPI.BeginComboAttack(ref _comboAttack, _actor, _skill, keys, flushInputedKeys, (_skill != null) ? _skill.skillId : 0, forceInterruptAttack, autoLookAtTarget, attackTarget, aimTarget, aimTargetPosition, () =>
		{
			requestComboAttack.isAnticipationEnd = true;
			onAnticipationEnd?.Invoke();
		}, () =>
		{
			requestComboAttack.isRecoveryBegin = true;
			if (recoveryBeginCheckCdStart && _skill.CountdownTiming == SkillCountdownTiming.End)
			{
				_skill.SetResumeTime();
			}
			onRecoveryBegin?.Invoke();
			_skill.isActivationEnd = false;
		}, () =>
		{
			onComboLoop?.Invoke();
		}, () =>
		{
			requestComboAttack.isComboFinish = true;
			onComboFinish?.Invoke();
		}, () =>
		{
			requestComboAttack.isComboFinish = true;
			onInterrupt?.Invoke();
		}, (string eventName) =>
		{
			onCustomEvent?.Invoke(eventName);
		}, () =>
		{
			requestComboAttack.isActivationEnd = true;
			onActivationEnd?.Invoke();
			_skill.isActivationEnd = true;
			if (_skill.isDodgeSkill)
			{
				(_actor as PlayerAdventureActor)?.dodgeSkillActivationEndEvent?.Invoke();
			}
		}, fadeOutAnim, () =>
		{
			_isReceiveSkillTakeEffect = true;
		}, keyPerfectMatch: false, actionTag);
		return requestComboAttack;
	}

	public void BeginTurn(FP turnTime, Action onComplete = null, Action onInterrupted = null)
	{
		if (turnTime < 0.2)
		{
			onComplete?.Invoke();
		}
		else if (turnTime >= 0.2 && turnTime < 0.4)
		{
			Action onComboFinish = onComplete;
			BeginAttack(ComboInputBuffer.ActionKey.U, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish);
		}
		else if (turnTime >= 0.4 && turnTime < 0.6)
		{
			Action onComboFinish = onComplete;
			BeginAttack(ComboInputBuffer.ActionKey.V, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish);
		}
		else if (turnTime >= 0.6 && turnTime < 0.8)
		{
			Action onComboFinish = onComplete;
			BeginAttack(ComboInputBuffer.ActionKey.W, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish);
		}
		else
		{
			Action onComboFinish = onComplete;
			BeginAttack(ComboInputBuffer.ActionKey.X, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish);
		}
	}

	protected void LockDirection(TSVector2 direction = default(TSVector2))
	{
		if (_aim == null)
		{
			_aim = new AimTarget();
		}
		if (direction != default(TSVector2))
		{
			_aim.Aim(_actor, null, direction);
		}
		else if (_actor.attackTarget != null)
		{
			_aim.Aim(_actor, _actor.attackTarget as AdventureActor);
		}
	}

	protected void CancelLockDirection()
	{
		_aim?.Cancel();
		_aim?.Clear();
	}

	protected void DefaultLookAt(bool useInputDirectionFirst = false, bool useSemiAutoBattleMode = false)
	{
		if (_actor.aimMode != AdventureActor.AimMode.Forward)
		{
			return;
		}
		if (useSemiAutoBattleMode && ModuleController<AdventureModuleController>.Instance.SemiAutoBattle)
		{
			if (_actor.attackTarget != null)
			{
				_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
			}
			return;
		}
		TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (useInputDirectionFirst && movementInputDirection != TSVector2.zero)
		{
			_actor.LookAtDir(movementInputDirection, 0);
		}
		else if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
	}
}
