#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11001;

public class SkillScript_Dodge : SkillAdvancedBase
{
	protected FP _dodgeDuration = 0.3;

	protected FP _dodgeDistance = 0.01;

	protected readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly FP _realDodgeDistance = 4.233f;

	private static readonly FP _crossDodgeAdditionDistance = 1.5f;

	private static readonly FP _crossDodgeKeepAwayNavmeshEdgeDistance = 0.1f;

	private static readonly int _transitionRushSkillId = 0;

	protected Dodge _dodge;

	private bool iCrossObstacle;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11001 SkillScript_Dodge OnDisable");
		base.OnSkillDisable();
		_dodge?.Interrupte();
		_actor.DisableDodgeCrossObstacle();
		CommonUtils.ClearDodgeCrossObstacleMode(_actor);
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11001 SkillScript_Dodge OnEnable");
		base.OnSkillEnable();
		if (GetPerk(511013))
		{
			_actor.buffComponent.AddBuff(11051311, _actor);
		}
		iCrossObstacle = GetPerk(511012);
		if (iCrossObstacle)
		{
			_actor.EnableDodgeCrossObstacle();
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("_11001 SkillScript_Dodge OnStart");
		if (_skill != null)
		{
			if (iCrossObstacle)
			{
				CommonUtils.CheckAndSetDodgeCrossObstacleMode(_actor, _realDodgeDistance, _crossDodgeAdditionDistance, _crossDodgeKeepAwayNavmeshEdgeDistance);
			}
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
		CommonUtils.ClearDodgeCrossObstacleMode(_actor);
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
		NovaLogger.Debug("_11001SkillScript_Dodge onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_11001SkillScript_Dodge onInterrupt");
		OnFinish();
	}
}
