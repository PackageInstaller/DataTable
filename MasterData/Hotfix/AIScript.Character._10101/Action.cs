#define LOG_DEBUG
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10101;

public class Action : ActorActionBase
{
	protected PlayerSkillCd _skillManage;

	protected override void OnActionDisable()
	{
		NovaLogger.Debug("_10101 Action OnDisable");
		_skillManage = null;
	}

	protected override void OnActionEnable()
	{
		NovaLogger.Debug("_10101 Action OnEnable");
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
	}

	public override void OnStart()
	{
		NovaLogger.Debug("_10101 Action OnStart");
		base.OnStart();
	}

	protected override void OnButtonAPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
		}
	}

	protected override void OnButtonAClickOrCancel()
	{
	}

	protected override void OnButtonBPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			_actor.logicVariable.ToggleLogicTag("holdSkill", value: true);
		}
	}

	protected override void OnButtonBCancel()
	{
		_actor.logicVariable.ToggleLogicTag("holdSkill", value: false);
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
		NovaLogger.Debug("_10101 Action OnStop");
		base.OnStop();
	}

	public virtual void OnUpdate()
	{
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
		if (_actor.attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			_canNormSkillDistance = fP <= CommonUtils.GetAttackRange(_actor);
			if (_canNormSkillDistance && _skillManage != null)
			{
				ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			}
		}
		if (!((PlayerAdventureActor)_actor).dodgeButtonHold)
		{
			bool flag = false;
			if (_actor.attackTarget != null && !flag)
			{
				_actor.AimAtTarget(_actor.attackTarget);
			}
			else if (!_actor.isPlayingAttackCombo)
			{
				_actor.CancelAiming();
			}
		}
		else
		{
			_actor.CancelAiming();
		}
	}
}
