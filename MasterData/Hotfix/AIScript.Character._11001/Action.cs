#define LOG_DEBUG
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._11001;

public class Action : ActorActionBase
{
	protected override void OnActionDisable()
	{
		NovaLogger.Debug("_11001 Action OnDisable");
	}

	protected override void OnActionEnable()
	{
		NovaLogger.Debug("_11001 Action OnEnable");
		_playerSkillCd.ResetSkillCD(ActionKey.B);
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
	}

	public override void OnStart()
	{
		NovaLogger.Debug("_11001 Action OnStart");
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
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	protected override void OnButtonBCancel()
	{
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
		NovaLogger.Debug("_11001 Action OnStop");
		base.OnStop();
	}

	public void OnUpdate()
	{
		if (!(_actor as PlayerAdventureActor).isAssist)
		{
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
			if (_actor.attackTarget != null && _actor.movementState != ActorState.Dash && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor) && _playerSkillCd != null)
			{
				ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			}
		}
	}
}
