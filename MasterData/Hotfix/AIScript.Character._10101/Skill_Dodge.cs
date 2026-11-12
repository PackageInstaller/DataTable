#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10101;

public class Skill_Dodge : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected Dodge _dodge;

	protected FP _dodgeDuration = 0.5;

	protected FP _dodgeDistance = 4.5;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_10101 Skill_Dodge OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		_dodge?.Interrupte();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_10101 Skill_Dodge OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_10101 Skill_Dodge OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Ultimate, null);
			TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (movementInputDirection != TSVector2.zero)
			{
				_actor.ForceChangeDirection(movementInputDirection);
			}
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };
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
			System.Action onInterrupt = OnInterrupt;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, null, onComboFinish, onInterrupt);
			if (_dodge == null)
			{
				_dodge = new Dodge();
			}
			TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (tSVector == TSVector2.zero)
			{
				tSVector = _actor.tsTransform.Forward.normalized;
			}
			_dodge.Begin(_actor, tSVector, _dodgeDuration, _dodgeDistance, null, comboWithAttack: true);
		}
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnRecoveryBegin()
	{
		NovaLogger.Debug("_10101 OnRecoveryBegin");
		OnFinish();
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_10101 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_10101 onInterrupt");
		OnFinish();
	}
}
