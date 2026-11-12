#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._99701;

public class Skill0 : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected Dash _dash;

	protected FP speed = 20;

	protected FP distance = 5;

	protected FP _angleLimit = 9;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_99701 Skill_Dodge OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		if (_dash != null)
		{
			_dash.Clear();
			_dash = null;
		}
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_99701 Skill_Dodge OnEnable");
		base.OnSkillEnable();
	}

	public virtual void OnStart()
	{
		NovaLogger.Debug("_99701 Skill_Dodge OnStart");
		if (_skill != null)
		{
			TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (movementInputDirection != TSVector2.zero)
			{
				_actor.ForceChangeDirection(movementInputDirection);
			}
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null);
			ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };
			if (_actor.buffComponent.CheckBuffByBuffID(99701))
			{
				array = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };
			}
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			ComboInputBuffer.ActionKey[] actionKeys = array;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onAnticipationEnd = OnAnticipationEnd;
			System.Action onRecoveryBegin = OnRecoveryBegin;
			System.Action onComboFinish = OnFinish;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, null, onComboFinish);
			ToDash();
		}
	}

	protected void ToDash()
	{
		if (_dash == null)
		{
			_dash = new Dash();
		}
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		_dash.BeginDash(_actor, tSVector, speed, distance, _angleLimit, OnCompleted, OnCompleted, OnCompleted, comboWithAttack: true);
	}

	protected void OnCompleted()
	{
		_comboAttack.CancelAttack();
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnRecoveryBegin()
	{
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("Skill1 onFinish_99701");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("Skill1 onInterrupt_99701");
		OnFinish();
	}
}
