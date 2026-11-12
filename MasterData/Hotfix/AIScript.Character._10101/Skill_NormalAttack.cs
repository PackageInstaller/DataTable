#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10101;

public class Skill_NormalAttack : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_10101 Skill_NormalAttack OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_10101 Skill_NormalAttack OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_10101 Skill_NormalAttack OnStart");
		if (!(_skill != null))
		{
			return;
		}
		SetSkillPhaseConfig(SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null);
		if (_actor.attackTarget != null)
		{
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[4];
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
		else
		{
			OnInterrupt();
		}
	}

	protected void OnRecoveryBegin()
	{
		NovaLogger.Debug("Skill1 onRecoveryBegin:");
	}

	protected void OnCustomEvent(string eventName)
	{
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("Skill1 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("Skill1 onInterrupt");
		OnFinish();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			_canNormSkillDistance = fP <= CommonUtils.GetAttackRange(_actor);
		}
		if ((_actor.attackTarget == null || !_canNormSkillDistance) && _comboAttack != null)
		{
			_comboAttack.CancelAttack();
		}
	}
}
