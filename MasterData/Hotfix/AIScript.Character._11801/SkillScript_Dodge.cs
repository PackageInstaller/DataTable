#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11801;

public class SkillScript_Dodge : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected Dodge _dodge;

	private static readonly FP _dodgeDuration = 0.3;

	private static readonly FP _dodgeDistance = 0.01;

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly FP _realDodgeDistance = 3.9997f;

	private static readonly FP _crossDodgeAdditionDistance = 1.5f;

	private static readonly FP _crossDodgeKeepAwayNavmeshEdgeDistance = 0.1f;

	private readonly int perkId_12 = 511812;

	private bool _isDodgeCrossObstacle;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11801 Skill_Dodge OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		_dodge?.Interrupte();
		if (_isDodgeCrossObstacle)
		{
			_actor.DisableDodgeCrossObstacle();
			CommonUtils.ClearDodgeCrossObstacleMode(_actor);
		}
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11801 Skill_Dodge OnEnable");
		base.OnSkillEnable();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_12, out var _))
		{
			_isDodgeCrossObstacle = true;
			_actor.EnableDodgeCrossObstacle();
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("11801 Skill_Dodge OnStart");
		if (_isDodgeCrossObstacle)
		{
			CommonUtils.CheckAndSetDodgeCrossObstacleMode(_actor, _realDodgeDistance, _crossDodgeAdditionDistance, _crossDodgeKeepAwayNavmeshEdgeDistance);
		}
		ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
		System.Action onActivationEnd = OnActivationEnd;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionKeys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
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

	private void OnActivationEnd()
	{
		if (_isDodgeCrossObstacle)
		{
			CommonUtils.ClearDodgeCrossObstacleMode(_actor);
		}
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

	private void OnFinish()
	{
		NovaLogger.Debug("11801 dodge onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11801 dodge onInterrupt");
		OnFinish();
	}
}
