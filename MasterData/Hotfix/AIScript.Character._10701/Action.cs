#define LOG_DEBUG
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._10701;

public class Action : ActorActionBase
{
	protected override void OnActionDisable()
	{
		NovaLogger.Debug("_10701 Action OnDisable");
	}

	protected override void OnActionEnable()
	{
		NovaLogger.Debug("_10701 Action OnEnable");
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
	}

	public override void OnStart()
	{
		NovaLogger.Debug("_10701 Action OnStart");
		base.OnStart();
	}

	protected override void OnButtonAPress()
	{
		if (_actor.logicVariable != null && _playerSkillCd != null)
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
		}
	}

	protected override void OnButtonAClickOrCancel()
	{
	}

	protected override void OnButtonBPress()
	{
		if (_actor.logicVariable != null && _playerSkillCd != null)
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End);
			_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: true);
		}
	}

	protected override void OnButtonBCancel()
	{
		_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: false);
	}

	protected override void OnButtonDPress()
	{
		if (_actor.logicVariable != null && _playerSkillCd != null)
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	public override void OnStop()
	{
		NovaLogger.Debug("_10701 Action OnStop");
		base.OnStop();
	}

	public void OnUpdate()
	{
		if (!(_actor as PlayerAdventureActor).isAssist)
		{
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
			if (_actor.attackTarget != null && !_player.dodgeButtonHold && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
			{
				ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			}
		}
	}
}
