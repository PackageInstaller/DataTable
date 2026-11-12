#define LOG_DEBUG
using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_Dodge : SkillAdvancedBase
{
	private ComboAttack _comboAttack;

	private Dash _dash;

	private CoroutineNode _waitForCoroutine;

	private readonly FP speed = 2;

	private readonly FP distance = 1.2;

	private readonly FP _angleLimit = 12;

	private readonly FP _waitTime = 0.3;

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11701 Skill_Dodge OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		if (_dash != null)
		{
			_dash.Clear();
			_dash = null;
		}
		if (_waitForCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitForCoroutine);
			_waitForCoroutine = null;
		}
		_actor.DisableInvincible();
		_actor.ResumeMovementBlock();
		_actor.DisableImmuneControl();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11701 Skill_Dodge OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_11701 Skill_Dodge OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.Skill1 | SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Ultimate, null);
			TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (movementInputDirection != TSVector2.zero)
			{
				_actor.ForceChangeDirection(movementInputDirection);
			}
			_waitForCoroutine = _actor.StartLogicCoroutine(WaitForCoroutine());
			_actor.PauseMovementBlock();
			_actor.EnableImmuneControl();
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onActivationEnd = OnActivationEnd;
			System.Action onRecoveryBegin = OnRecoveryBegin;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, null, onComboFinish, onInterrupt, null, onActivationEnd);
			ToDash();
		}
	}

	protected IEnumerator WaitForCoroutine()
	{
		_actor.EnableInvincible();
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_waitTime));
		_actor.DisableInvincible();
		_waitForCoroutine = null;
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
		_dash.BeginDash(_actor, tSVector, speed, distance, _angleLimit, null, null, null, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
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

	protected void OnRecoveryBegin()
	{
		NovaLogger.Debug("Skill1 onRecoveryBegin:");
		_actor.DisableInvincible();
		_actor.ResumeMovementBlock();
		_actor.DisableImmuneControl();
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("Skill1 onFinish");
		_dash?.Interrupte();
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("Skill1 onInterrupt");
		OnFinish();
	}

	public void OnUpdate()
	{
		if (_actor.movementState == ActorState.Dash && _dash != null)
		{
			TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (tSVector == TSVector2.zero)
			{
				tSVector = _actor.tsTransform.Forward.normalized;
			}
			_dash._direction = tSVector;
		}
	}
}
