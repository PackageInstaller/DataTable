using System;
using TrueSync;
using UnityEngine;

namespace AdventureBehaviour;

public class ComboAttack
{
	internal int lastComboPhaseSwitchFrameCount = -1;

	private AdventureActor _actor;

	private AdventureSkill _skill;

	private bool _autoLookAtTarget;

	private Action _onAnticipationEnd;

	private Action _onRecoveryBegin;

	private Action _onActivationEnd;

	private Action _onComboFinish;

	private Action _onComboLoop;

	private Action _onSendSkillTakeEffect;

	private Action _onInterrupt;

	private Action<string> _onCustomEvent;

	public void BeginAttack(AdventureActor actor, AdventureSkill skill, ComboInputBuffer.ActionKey[] actionKeys, bool flushInputedKeys = false, int skillId = 0, bool forceInterruptAttack = false, bool autoLookAtTarget = false, LogicEntity attackTarget = null, LogicEntity aimTarget = null, TSVector2 aimTargetPosition = default(TSVector2), Action onAnticipationEnd = null, Action onRecoveryBegin = null, Action onComboLoop = null, Action onComboFinish = null, Action onInterrupt = null, Action<string> onCustomEvent = null, Action onActivationEnd = null, bool fadeOutAnim = true, Action onSendSkillTakeEffect = null, bool keyPerfectMatch = false, string actionTag = "")
	{
		actor.activeComboAttack?.Clear();
		actor.activeComboAttack = this;
		if (forceInterruptAttack)
		{
			actor.InterruptAttack(force: true, fadeOutAnim);
		}
		_actor = actor;
		_skill = skill;
		_autoLookAtTarget = autoLookAtTarget;
		_onAnticipationEnd = onAnticipationEnd;
		_onRecoveryBegin = onRecoveryBegin;
		_onActivationEnd = onActivationEnd;
		_onComboFinish = onComboFinish;
		_onComboLoop = onComboLoop;
		_onInterrupt = onInterrupt;
		_onCustomEvent = onCustomEvent;
		_onSendSkillTakeEffect = onSendSkillTakeEffect;
		actor.onAfterAttackComboPhaseChange = (Action<AdventureActor, Combo.Phase>)Delegate.Combine(actor.onAfterAttackComboPhaseChange, new Action<AdventureActor, Combo.Phase>(OnAfterAttackComboPhaseChange));
		actor.onBeforeAttackComboPhaseChange = (Action<AdventureActor, Combo.Phase>)Delegate.Combine(actor.onBeforeAttackComboPhaseChange, new Action<AdventureActor, Combo.Phase>(OnBeforeAttackComboPhaseChange));
		actor.onFeaturePhaseActive = (Action<AdventureActor, int, Combo.FeaturePhase>)Delegate.Combine(actor.onFeaturePhaseActive, new Action<AdventureActor, int, Combo.FeaturePhase>(OnFeaturePhaseActive));
		actor.onAttackCustomEvent = (Action<AdventureActor, Combo.Event>)Delegate.Combine(actor.onAttackCustomEvent, new Action<AdventureActor, Combo.Event>(OnCustomEvent));
		actor.onAttackComboLoop = (Action<AdventureActor>)Delegate.Combine(actor.onAttackComboLoop, new Action<AdventureActor>(OnAttackComboLoop));
		actor.onAttackInterrupted = (Action<AdventureActor>)Delegate.Combine(actor.onAttackInterrupted, new Action<AdventureActor>(OnAttackInterrupted));
		actor.onSendSkillTakeEffect = (Action<AdventureActor>)Delegate.Combine(actor.onSendSkillTakeEffect, new Action<AdventureActor>(OnSendSkillTakeEffect));
		actor.onSendSkillAllowOtherSkillExecute = (Action<AdventureActor, bool>)Delegate.Combine(actor.onSendSkillAllowOtherSkillExecute, new Action<AdventureActor, bool>(OnSendSkillAllowOtherSkillExecute));
		if (attackTarget != null)
		{
			actor.attackTarget = attackTarget;
		}
		actor.shootBehaviour.aimTarget = aimTarget;
		actor.shootBehaviour.aimTargetPosition = aimTargetPosition;
		bool flag = false;
		ComboInputBuffer.InputResult inputResult = ComboInputBuffer.InputResult.Invalid;
		if (actionKeys != null && actionKeys.Length > 0)
		{
			if (flushInputedKeys)
			{
				inputResult = actor.Attack(actionKeys, OnComboFinish, cancelInputIfNotExecute: false, keyPerfectMatch);
				if (inputResult == ComboInputBuffer.InputResult.Accept || inputResult == ComboInputBuffer.InputResult.Execute)
				{
					flag = true;
				}
			}
			else
			{
				for (int i = 0; i < actionKeys.Length; i++)
				{
					inputResult = actor.Attack(actionKeys[i], OnComboFinish);
					if (inputResult == ComboInputBuffer.InputResult.Accept || inputResult == ComboInputBuffer.InputResult.Execute)
					{
						flag = true;
					}
				}
			}
		}
		else
		{
			inputResult = actor.Attack(actionTag, OnComboFinish);
			if (inputResult == ComboInputBuffer.InputResult.Accept || inputResult == ComboInputBuffer.InputResult.Execute)
			{
				flag = true;
			}
		}
		if (flag)
		{
			lastComboPhaseSwitchFrameCount = LockStepManager.frameCount;
			if (_skill != null && actor.attackFSM.currentComboClip != null)
			{
				Combo.FeaturePhase[] featurePhases = actor.attackFSM.currentComboClip.featurePhases;
				if (featurePhases != null && featurePhases.Length > 0)
				{
					_skill.SetCurrentPhaseExecuteConfig(actor.attackFSM.currentComboClip.featurePhases[0].skillPhaseConfig.ExecuteSkillPhaseConfig);
					_skill.SetCurrentPhaseBreakConfig(actor.attackFSM.currentComboClip.featurePhases[0].skillPhaseConfig.BreakSkillPhaseConfig);
				}
			}
			return;
		}
		Clear();
		_onInterrupt?.Invoke();
		string text = actionTag;
		if (actionKeys != null && actionKeys.Length != 0)
		{
			string text2 = "";
			for (int j = 0; j < actionKeys.Length; j++)
			{
				text2 += actionKeys[j];
			}
			text = text2;
		}
		Debug.LogWarning($"comboclip执行失败，输入问题:{text}, actor.name:{actor.name} ,inputResult：{inputResult} ,skillId:{skillId}");
	}

	public void CancelAttack()
	{
		if (_actor != null && _actor.activeComboAttack == this)
		{
			_actor.CancelAttack();
		}
	}

	public void InterruptAttack()
	{
		if (_actor != null && _actor.activeComboAttack == this)
		{
			_actor.InterruptAttack(force: true);
		}
	}

	protected void OnAfterAttackComboPhaseChange(AdventureActor actor, Combo.Phase comboPhase)
	{
		if (actor.activeComboAttack != this)
		{
			return;
		}
		switch (comboPhase)
		{
		case Combo.Phase.Anticipation:
			if (_autoLookAtTarget)
			{
				LookAtTarget(actor);
			}
			break;
		case Combo.Phase.Activation:
			if (lastComboPhaseSwitchFrameCount != LockStepManager.frameCount)
			{
				_onAnticipationEnd?.Invoke();
			}
			break;
		case Combo.Phase.Recovery:
			if (lastComboPhaseSwitchFrameCount != LockStepManager.frameCount)
			{
				_onRecoveryBegin?.Invoke();
			}
			break;
		case Combo.Phase.Anticipation | Combo.Phase.Activation:
			break;
		}
	}

	protected void OnBeforeAttackComboPhaseChange(AdventureActor actor, Combo.Phase comboPhase)
	{
		if (actor.activeComboAttack == this && comboPhase == Combo.Phase.Activation && lastComboPhaseSwitchFrameCount != LockStepManager.frameCount)
		{
			_onActivationEnd?.Invoke();
		}
	}

	protected void OnFeaturePhaseActive(AdventureActor actor, int phaseIndex, Combo.FeaturePhase featurePhase)
	{
		if (actor.activeComboAttack == this && _skill != null)
		{
			_skill.SetCurrentPhaseExecuteConfig(featurePhase.skillPhaseConfig.ExecuteSkillPhaseConfig);
			_skill.SetCurrentPhaseBreakConfig(featurePhase.skillPhaseConfig.BreakSkillPhaseConfig);
		}
	}

	protected void OnCustomEvent(AdventureActor actor, Combo.Event comboEvent)
	{
		if (actor.activeComboAttack == this)
		{
			_onCustomEvent?.Invoke(comboEvent.name);
		}
	}

	protected void OnComboFinish()
	{
		if (_actor != null && _actor.activeComboAttack == this)
		{
			Clear();
			_onComboFinish?.Invoke();
		}
	}

	protected void OnAttackComboLoop(AdventureActor actor)
	{
		if (_actor != null && _actor.activeComboAttack == this)
		{
			_onComboLoop?.Invoke();
			if (_autoLookAtTarget)
			{
				LookAtTarget(actor);
			}
		}
	}

	protected void OnAttackInterrupted(AdventureActor actor)
	{
		if (_actor != null && _actor.activeComboAttack == this)
		{
			Clear();
			_onInterrupt?.Invoke();
		}
	}

	protected void OnSendSkillTakeEffect(AdventureActor actor)
	{
		if (actor.activeComboAttack == this)
		{
			_onSendSkillTakeEffect?.Invoke();
		}
	}

	protected void OnSendSkillAllowOtherSkillExecute(AdventureActor actor, bool allow)
	{
		if (actor.activeComboAttack == this && _skill != null)
		{
			_skill.CanExecuteOtherSkillWhenSemiAutoBattle = allow;
		}
	}

	protected void LookAtTarget(AdventureActor actor)
	{
		LogicEntity logicEntity = ((actor is MonsterAdventureActor) ? actor.monsterTarget : actor.attackTarget);
		if (logicEntity != null)
		{
			actor.LookAt(logicEntity.tsTransform.Position, 0f);
		}
	}

	public void Clear()
	{
		if (_actor != null)
		{
			_actor.activeComboAttack = null;
			AdventureActor actor = _actor;
			actor.onAfterAttackComboPhaseChange = (Action<AdventureActor, Combo.Phase>)Delegate.Remove(actor.onAfterAttackComboPhaseChange, new Action<AdventureActor, Combo.Phase>(OnAfterAttackComboPhaseChange));
			AdventureActor actor2 = _actor;
			actor2.onBeforeAttackComboPhaseChange = (Action<AdventureActor, Combo.Phase>)Delegate.Remove(actor2.onBeforeAttackComboPhaseChange, new Action<AdventureActor, Combo.Phase>(OnBeforeAttackComboPhaseChange));
			AdventureActor actor3 = _actor;
			actor3.onFeaturePhaseActive = (Action<AdventureActor, int, Combo.FeaturePhase>)Delegate.Remove(actor3.onFeaturePhaseActive, new Action<AdventureActor, int, Combo.FeaturePhase>(OnFeaturePhaseActive));
			AdventureActor actor4 = _actor;
			actor4.onAttackCustomEvent = (Action<AdventureActor, Combo.Event>)Delegate.Remove(actor4.onAttackCustomEvent, new Action<AdventureActor, Combo.Event>(OnCustomEvent));
			AdventureActor actor5 = _actor;
			actor5.onAttackComboLoop = (Action<AdventureActor>)Delegate.Remove(actor5.onAttackComboLoop, new Action<AdventureActor>(OnAttackComboLoop));
			AdventureActor actor6 = _actor;
			actor6.onAttackInterrupted = (Action<AdventureActor>)Delegate.Remove(actor6.onAttackInterrupted, new Action<AdventureActor>(OnAttackInterrupted));
			AdventureActor actor7 = _actor;
			actor7.onSendSkillTakeEffect = (Action<AdventureActor>)Delegate.Remove(actor7.onSendSkillTakeEffect, new Action<AdventureActor>(OnSendSkillTakeEffect));
			AdventureActor actor8 = _actor;
			actor8.onSendSkillAllowOtherSkillExecute = (Action<AdventureActor, bool>)Delegate.Remove(actor8.onSendSkillAllowOtherSkillExecute, new Action<AdventureActor, bool>(OnSendSkillAllowOtherSkillExecute));
			_actor = null;
		}
		if (_skill != null)
		{
			_skill = null;
		}
	}
}
