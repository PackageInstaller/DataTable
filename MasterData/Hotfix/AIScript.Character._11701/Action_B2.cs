#define LOG_DEBUG
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._11701;

public class Action_B2 : ActorActionBase
{
	protected PlayerSkillCd _skillManage;

	protected override void OnActionDisable()
	{
		NovaLogger.Debug("_11701 Action_2 OnDisable");
		_skillManage = null;
	}

	protected override void OnActionEnable()
	{
		NovaLogger.Debug("_11701 Action_2 OnEnable");
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
	}

	public override void OnStart()
	{
		NovaLogger.Debug("_11701 Action_2 OnStart");
		base.OnStart();
	}

	protected override void OnButtonAPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
		}
	}

	protected override void OnButtonBPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	protected override void OnButtonDPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	public override void OnStop()
	{
		NovaLogger.Debug("_11701 Action_2 OnStop");
		base.OnStop();
	}

	public void OnUpdate()
	{
		bool useInputDirection = true;
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection);
		if (_actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor) && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
		if (!((PlayerAdventureActor)_actor).dodgeButtonHold)
		{
			if (_actor.attackTarget != null && _actor.movementState != ActorState.Dash)
			{
				_actor.AimAtTarget(_actor.attackTarget);
			}
			else
			{
				_actor.CancelAiming();
			}
		}
	}
}
