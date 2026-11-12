#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11201;

public class SkillScript_Dodge : SkillAdvancedBase
{
	protected FP _dodgeDuration = 0.3;

	protected FP _dodgeAttackDuration = 0.5;

	protected FP _dodgeDistance = 0.01;

	protected readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected readonly string attackTag_2 = "ChongCi";

	protected readonly string attackTag_6 = "ChongCiSp";

	private static readonly int _transitionRushSkillId = 0;

	private static readonly FP _realDodgeDistance = 3.156516f;

	private static readonly FP _crossDodgeAdditionDistance = 1.5f;

	private static readonly FP _crossDodgeKeepAwayNavmeshEdgeDistance = 0.1f;

	protected Dodge _dodge;

	private bool iDogeAttack;

	private bool iCrossObstacle;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11201 SkillScript_Dodge OnDisable");
		base.OnSkillDisable();
		_dodge?.Interrupte();
		_actor.logicVariable.ToggleLogicTag("iDogeing", value: false);
		_actor.DisableDodgeCrossObstacle();
		CommonUtils.ClearDodgeCrossObstacleMode(_actor);
		Parallel.dodgeSkill = false;
	}

	protected override void OnSkillEnable()
	{
		Parallel.dodgeSkill = true;
		NovaLogger.Debug("_11201 SkillScript_Dodge OnEnable");
		base.OnSkillEnable();
		_actor.logicVariable.GetLogicTagToggle("ChenShaZaDi_Skill");
		_actor.logicVariable.ToggleLogicTag("iDogeing", value: true);
		iCrossObstacle = GetPerk(511213);
		if (iCrossObstacle)
		{
			_actor.EnableDodgeCrossObstacle();
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("_11201 SkillScript_Dodge OnStart");
		if (!(_skill != null))
		{
			return;
		}
		if (iCrossObstacle)
		{
			CommonUtils.CheckAndSetDodgeCrossObstacleMode(_actor, _realDodgeDistance, _crossDodgeAdditionDistance, _crossDodgeKeepAwayNavmeshEdgeDistance);
		}
		iDogeAttack = false;
		if (_actor.logicVariable.GetLogicTagToggle("main_skillEnable_Skill") || _actor.logicVariable.GetLogicTagToggle("main_skillEnable_Skill_7"))
		{
			_actor.logicVariable.ToggleLogicTag("main_skillEnable_Skill_7", value: false);
			_actor.logicVariable.ToggleLogicTag("main_skillEnable_Skill", value: false);
			iDogeAttack = true;
			if (_actor.logicVariable.GetLogicTagToggle("iDogeAttack_plus"))
			{
				_actor.logicVariable.ToggleLogicTag("iDogeAttack_plus", value: false);
				string actionTag = attackTag_6;
				System.Action onActivationEnd = OnActivationEnd;
				System.Action onRecoveryBegin = OnRecoveryBegin;
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, null, onActivationEnd);
			}
			else
			{
				string actionTag2 = attackTag_2;
				System.Action onInterrupt = OnActivationEnd;
				System.Action onComboFinish = OnRecoveryBegin;
				System.Action onRecoveryBegin = OnFinish;
				System.Action onActivationEnd = OnInterrupt;
				BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, onComboFinish, onRecoveryBegin, onActivationEnd, null, onInterrupt);
				FP logicTagValue = _actor.logicVariable.GetLogicTagValue("iDogeAttack");
				_actor.logicVariable.SetLogicTagValue("iDogeAttack", logicTagValue + 1);
			}
		}
		else
		{
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			System.Action onActivationEnd = OnActivationEnd;
			System.Action onRecoveryBegin = OnRecoveryBegin;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			BeginAttack(actionKeys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, null, onActivationEnd);
		}
		if (_dodge == null)
		{
			_dodge = new Dodge();
		}
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		_dodge.Begin(_actor, tSVector, iDogeAttack ? _dodgeAttackDuration : _dodgeDuration, _dodgeDistance, null, comboWithAttack: true);
	}

	protected void OnActivationEnd()
	{
		CommonUtils.ClearDodgeCrossObstacleMode(_actor);
		if (((PlayerAdventureActor)_actor).dodgeButtonHold && !iDogeAttack && !_actor.forbiddenRush)
		{
			int specialSkillId = ((PlayerAdventureActor)_actor).playerAIInfo.SpecialSkillId;
			if (specialSkillId != 0)
			{
				_actor.logicVariable.ToggleLogicTag("DogeSkill", value: false);
				ILRuntimeAPI.CreateSkill(specialSkillId, _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: false);
				OnFinish();
			}
		}
		else if (_actor.logicVariable.GetLogicTagToggle("DogeSkill"))
		{
			PlayerSkillCd logicComponent = _actor.GetLogicComponent<PlayerSkillCd>();
			int currentBindSkillId = logicComponent.GetCurrentBindSkillId(ActionKey.B);
			logicComponent.ResetSkillCD(currentBindSkillId);
			ILRuntimeAPI.CreateSkill(currentBindSkillId, _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End);
			OnFinish();
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
		NovaLogger.Debug("SkillScript_Dodge onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("SkillScript_Dodge onInterrupt");
		OnFinish();
	}
}
