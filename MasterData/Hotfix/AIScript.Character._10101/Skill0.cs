#define LOG_DEBUG
using System;
using AdventureBehaviour;

namespace AIScript.Character._10101;

public class Skill0 : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_10101 Skill0 OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
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
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };
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
}
