#define LOG_DEBUG
using System;
using AdventureBehaviour;

namespace AIScript.Character._99701;

public class Skill_Ultra : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected PlayTimeline _playTimeline;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_99701 Skill_Ultra OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_99701 Skill_Ultra OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_99701 Skill_Ultra OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			if (_playTimeline == null)
			{
				_playTimeline = new PlayTimeline();
			}
			_playTimeline.Play(_actor, () =>
			{
				ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };
				ComboAttack comboAttack = _comboAttack;
				AdventureActor actor = _actor;
				AdventureSkill skill = _skill;
				int skillId = ((_skill != null) ? _skill.skillId : 0);
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				Action<string> onCustomEvent = OnCustomEvent;
				comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
			}, () =>
			{
				ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };
				ComboAttack comboAttack = _comboAttack;
				AdventureActor actor = _actor;
				AdventureSkill skill = _skill;
				int skillId = ((_skill != null) ? _skill.skillId : 0);
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				Action<string> onCustomEvent = OnCustomEvent;
				comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
			});
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_99701 Skill_Ultra onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_99701 Skill_Ultra OnInterrupt");
		_skill.Clear();
	}

	protected void OnCustomEvent(string eventName)
	{
	}
}
