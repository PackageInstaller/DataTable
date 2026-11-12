#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12001;

public class SkillScript_Dodge : SkillAdvancedBase
{
	protected readonly FP _dodgeDuration = 0.4;

	protected readonly FP _dodgeDistance = 0.01;

	protected readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected ComboAttack _comboAttack;

	protected Dodge _dodge;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_12001 Skill_Dodge OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		_dodge?.Interrupte();
		Parallel.dodgeSkill = false;
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_12001 Skill_Dodge OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_12001 Skill_Dodge OnStart");
		if (_skill != null)
		{
			Parallel.dodgeSkill = true;
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			int skillId = _skill.skillId;
			System.Action onActivationEnd = OnActivationEnd;
			System.Action onRecoveryBegin = OnRecoveryBegin;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, onRecoveryBegin, null, onComboFinish, onInterrupt, null, onActivationEnd);
			if (_dodge == null)
			{
				_dodge = new Dodge();
			}
			if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
			{
				_actor.CancelAiming();
			}
			TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (tSVector == TSVector2.zero)
			{
				tSVector = _actor.tsTransform.Forward.normalized;
			}
			_dodge.Begin(_actor, tSVector, _dodgeDuration, _dodgeDistance, null, comboWithAttack: true);
		}
	}

	protected void OnActivationEnd()
	{
		if (((PlayerAdventureActor)_actor).dodgeButtonHold && !_actor.forbiddenRush)
		{
			int specialSkillId = ((PlayerAdventureActor)_actor).playerAIInfo.SpecialSkillId;
			if (specialSkillId != 0)
			{
				ILRuntimeAPI.CreateSkill(specialSkillId, _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: false);
				OnFinish();
			}
		}
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnRecoveryBegin()
	{
		Parallel.dodgeSkill = false;
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("12001 Skill_Dodge onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("12001 Skill_Dodge onInterrupt");
		OnFinish();
	}
}
