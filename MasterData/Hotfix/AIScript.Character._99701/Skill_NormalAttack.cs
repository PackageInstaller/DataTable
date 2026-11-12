#define LOG_DEBUG
using System;
using System.Runtime.CompilerServices;
using AdventureBehaviour;

namespace AIScript.Character._99701;

public class Skill_NormalAttack : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_99701 Skill_NormalAttack OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_99701 Skill_NormalAttack OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		//IL_007a: Field data (rva=0x4a0) could not be found in any section!
		//IL_007a: Field data (rva=0x4a0) could not be found in any section!
		NovaLogger.Debug("_99701 Skill_NormalAttack OnStart");
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
			ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
			if (_actor.buffComponent.CheckBuffByBuffID(99701))
			{
				ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
				RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._02433989DC22CF3B439520872116A54CD7D45A171AC418FB24BC2594D82FD250));
				array = array2;
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			ComboInputBuffer.ActionKey[] actionKeys = array;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
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
		if (_actor.attackTarget == null && _comboAttack != null)
		{
			_comboAttack.CancelAttack();
		}
	}
}
