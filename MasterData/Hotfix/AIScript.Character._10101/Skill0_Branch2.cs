#define LOG_DEBUG
using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10101;

public class Skill0_Branch2 : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected CoroutineNode _waitForCoroutine;

	protected FP _waitTime = 10;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_10101 Skill0 OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		if (_waitForCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForCoroutine);
			_waitForCoroutine = null;
		}
		_actor.movementMode = AdventureActor.MovementMode.Run;
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_10101 Skill0 OnEnable");
		base.OnSkillEnable();
	}

	public virtual void OnStart()
	{
		NovaLogger.Debug("_10101 Skill0 OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null);
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };
			_actor.movementMode = AdventureActor.MovementMode.Walk;
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onAnticipationEnd = OnAnticipationEnd;
			System.Action onRecoveryBegin = OnRecoveryBegin;
			System.Action onComboFinish = OnFinish;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, null, onComboFinish);
			_waitForCoroutine = _actor.StartLogicCoroutine(WaitForCoroutine());
		}
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnRecoveryBegin()
	{
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("Skill1 onFinish_10101");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("Skill1 onInterrupt_10101");
		OnFinish();
	}

	protected IEnumerator WaitForCoroutine()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_waitTime));
		_comboAttack?.CancelAttack();
		_waitForCoroutine = null;
	}

	public void OnUpdate()
	{
		if (_comboAttack != null && !_actor.logicVariable.GetLogicTagToggle("holdSkill"))
		{
			_comboAttack.CancelAttack();
		}
	}
}
