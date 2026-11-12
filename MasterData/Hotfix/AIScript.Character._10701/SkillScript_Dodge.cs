#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10701;

public class SkillScript_Dodge : SkillAdvancedBase
{
	protected FP _dodgeDuration = 0.32;

	protected FP _dodgeDistance = 4;

	protected readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly int _transitionRushSkillId;

	protected Dodge _dodge;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_10701 SkillScript_Dodge OnDisable");
		base.OnSkillDisable();
		_dodge?.Interrupte();
		Parallel.dodgeSkill = false;
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_10701 SkillScript_Dodge OnEnable");
		base.OnSkillEnable();
		Parallel.dodgeSkill = true;
	}

	public void OnStart()
	{
		NovaLogger.Debug("_10701 SkillScript_Dodge OnStart");
		if (_skill != null)
		{
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			System.Action onActivationEnd = OnActivationEnd;
			System.Action onRecoveryBegin = OnRecoveryBegin;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			BeginAttack(actionKeys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, null, onActivationEnd);
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
		else if (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput() && _transitionRushSkillId != 0)
		{
			ILRuntimeAPI.CreateSkill(_transitionRushSkillId, _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: false);
			OnFinish();
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
		NovaLogger.Debug("_10701SkillScript_Dodge onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_10701SkillScript_Dodge onInterrupt");
		OnFinish();
	}
}
